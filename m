From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] builtin/apply: exit when parse_binary() fails
Date: Wed, 16 Mar 2016 21:19:21 +0100
Message-ID: <CAP8UFD2OxW0nDfm6P4qXkJb2BORg_r=4ZS_cVtv16YnA115w9A@mail.gmail.com>
References: <1458156675-26109-1-git-send-email-chriscool@tuxfamily.org>
	<xmqqshzq438s.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 21:19:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agHut-00062l-57
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 21:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbcCPUT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 16:19:28 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36564 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966847AbcCPUTX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 16:19:23 -0400
Received: by mail-lb0-f181.google.com with SMTP id qe11so1306239lbc.3
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 13:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=I8ZME9ArNg46ahNF/6xSxDfBEkvhWV8wHjaZ0xUk1h8=;
        b=ETIJUvBgGakk4awr1yE08+pijszHwxNTLVPjxGdpBCFpsWpGzXXOC4Jio/e5KgBwvL
         Po380EQR4A/lltKjBkK3J4jq90agbMLoHWZkMmWS4riijmfgJrLd6VDrJgIEFaMN/Ych
         dSBYxDweGl0ZwCkPFqG15Q7y0qivXvqUobJcX6orKsVC2h/F5rZLdkSNJxS3ujIP4Czs
         xzzsvutcok3Lp1ZsJgiUuSmRTgjwC8U7sfFO6y8B5GON100CLiJKrL7T3KzeZpGzDsbb
         PjlJ+1owFDD1RCZ1I/T96BlAWeBONQld8LUG3bpRitxEuW3oybcHxKRxks2Wn0D0cJx9
         whsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=I8ZME9ArNg46ahNF/6xSxDfBEkvhWV8wHjaZ0xUk1h8=;
        b=b18zwW/WFYYa7szVev86ZlSrnroMi95G8SD61voJWQoQbmxXZYbMt3vD7yPsfrRZ90
         cUdkdXYEm9O3jLCQs1HwkLTqA+Egy9LpRL2ohPAaIDW0bTz6b2/QN2stF5AIncqPunPq
         goNxWDmAhuQQTP5XpAMLH6kGfr/Z7S+ywsP/u/3Fag3PPQPWBJk02sSLgvDQ3Q5OHmdp
         gdB7GbCtI5VV7ilLGjQOCmc7seC6UD6daYCI7niLRUIYTtTiJBJkVGTzTJu+8lwj2UvO
         L5sr8SakUAaujxhrjDQWzHinvn21ursiJLA8CHyedF9tqS8JwYCJoTp3EMCnOTynB5+O
         uOfg==
X-Gm-Message-State: AD7BkJK8E9eAKjzuvOvGl895Nm3ZBc5cHatHLsKO0PlIulJKpiww5mg68CBgtzE+hJs9qF+NFo226t7Fdyf55Q==
X-Received: by 10.112.163.201 with SMTP id yk9mr2200683lbb.100.1458159561645;
 Wed, 16 Mar 2016 13:19:21 -0700 (PDT)
Received: by 10.25.137.130 with HTTP; Wed, 16 Mar 2016 13:19:21 -0700 (PDT)
In-Reply-To: <xmqqshzq438s.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289030>

On Wed, Mar 16, 2016 at 8:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> In parse_binary() there is:
>>
>>       forward = parse_binary_hunk(&buffer, &size, &status, &used);
>>       if (!forward && !status)
>>               /* there has to be one hunk (forward hunk) */
>>               return error(_("unrecognized binary patch at line %d"), linenr-1);
>>
>> so parse_binary() can return -1, because that's what error() returns.
>>
>> Also parse_binary_hunk() sets "status" to -1 in case of error and
>> parse_binary() does "if (status) return status;".
>
> All of the above sounds sensible, and your follow-up patch expects
> parse_chunk() to return -1 on failure--it is a bit sad that you make
> parse_chunk() to directly call exit(2).  In the spirit of eventually
> libifying this codepath, shouldn't we be turning existing die() to
> an error return, instead of introducing more calls to exit(2)?

Yeah, I found these little bugs when working on libifying these
functions. So I agree that it is sad to introduce an exit() call now
and I am ok to make parse_chunk() return -1 instead.

I will resend with that change.

Thanks,
Christian.
