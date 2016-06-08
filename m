From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 4/6] send-email: create email parser subroutine
Date: Wed, 8 Jun 2016 16:13:04 -0400
Message-ID: <CAPig+cQ5OKFTA8pEge=0e2RMT3ghmat-szw73aO_3WVW1=eAFQ@mail.gmail.com>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160608130142.29879-1-samuel.groot@grenoble-inp.org> <20160608130142.29879-5-samuel.groot@grenoble-inp.org>
 <xmqq8tyfmuk4.fsf@gitster.mtv.corp.google.com> <CAPig+cTO+-aATxyNBt2HtctH_ofgqEc8ik3OLSN+THVgu6dhKQ@mail.gmail.com>
 <fb7795c4-60db-94b3-a584-8fadd0440773@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	tom.russello@grenoble-inp.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>, aaron@schrab.com,
	Eric Wong <e@80x24.org>
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 22:13:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAjqi-0007vc-EN
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 22:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162226AbcFHUNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 16:13:08 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33448 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630AbcFHUNG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 16:13:06 -0400
Received: by mail-io0-f195.google.com with SMTP id 5so2641472ioy.0
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 13:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/y0+qeqlSRtumCD23Aj3PDew0e0wkt0FKLFa2+gwuSQ=;
        b=RNaUGGBzAIa/vnowcIdTArKc6NYkuYNrHJMN513EzkcMH4jTQXdy66/aEG6YLIStIu
         OLhBOxwq3/V8MCeZXY0zGyGbXOFhz1K2K90IFcr/JhbsIV7Jh6auXXf5VX2Ge8ALKbQ5
         Ii3/jqqIAujyIKhgOetBIB4mWhVD8qt+d18MfkXp5CbM5cDwz7dt8xSaR45MQar0FWBk
         5qDtq+mdVOChjqerage0VXPb0R3E5sDx0896uXLLTmOnnfuTWDxlmRk1Znsfn4k8OEtD
         lBOKEPU2IsnPHFtIUuWI4pnxwdePuVP+VQzSB4rTQnoCo6OqjoPbI8e0+1rJKQQq3rwC
         zxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/y0+qeqlSRtumCD23Aj3PDew0e0wkt0FKLFa2+gwuSQ=;
        b=NYoGGLJQXt6yXAKFKuBhijIsz9fpY1+pF3i7Z1vh0YK41WK8N0Gns1dd46mAhOBM7X
         tDtXEsxSk6mAZW0FyL/4aknYVyAZO18FV1Pcn5GJaEcC0V10NeNqqCUPvBdJTRlWEt3/
         MtLmFyKfjzxwb1j7RG4nEaqM48pT2a5/XqVAFnARXQzSlbSfV62zSnWfDP1FfCsGilIr
         WI4RruQbpRvriJxL+DeDguUGK1IidHkzGbqudwI+vJSP9x+Z1vIIvrPsMx/8HN+0d9ae
         RFWNv0fWHrD/bz4PwIsl572GApt94PQ3bP3DbHK9mv10wbZWYDQcMN5BkOlRvAfMBabe
         q6/A==
X-Gm-Message-State: ALyK8tIJ2gdhunlW7s/vgam8x49T6Hf9m7/BGGJOYX1JsBmFnrebGiS+bQ1xrfiAhZKIwJc6mxXouONhojkrdQ==
X-Received: by 10.107.197.194 with SMTP id v185mr4171979iof.34.1465416784912;
 Wed, 08 Jun 2016 13:13:04 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Wed, 8 Jun 2016 13:13:04 -0700 (PDT)
In-Reply-To: <fb7795c4-60db-94b3-a584-8fadd0440773@grenoble-inp.org>
X-Google-Sender-Auth: m93I8CppPsMsvo0e6_Bz--Fv-eE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296849>

On Wed, Jun 8, 2016 at 3:30 PM, Samuel GROOT
<samuel.groot@grenoble-inp.org> wrote:
> On 06/08/2016 08:12 PM, Eric Sunshine wrote:
>> On Wed, Jun 8, 2016 at 1:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>>> The pattern is not anchored at the right end of the string;
>>> intended?  Is it worth worrying about a lone '\r'?
>>
>> Thanks, I think you covered pretty much everything I was going to say.
>> I'd just add that if the matching is going to be kept loose like this
>> (rather than anchoring it), then s/[\r\n]+//g might be easier to read,
>> but it's a minor point.
>
> Indeed s/[\r\n]+//g is way better, it works even if there's a CR in the
> middle of the line.

An embedded CR probably shouldn't happen, but I'm not convinced that
folding it out is a good idea. I would think that you'd want to
preserve the header's value verbatim. If anything, I'd expect to see
the regex tightened to:

    s/\r?\n$//;

Alternately, consider using 'chop' or 'chomp'.
