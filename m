From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/26] mailinfo: always pass "line" as an argument
Date: Wed, 14 Oct 2015 13:27:22 -0700
Message-ID: <xmqq37xd8ac5.fsf@gitster.mtv.corp.google.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
	<1444778207-859-7-git-send-email-gitster@pobox.com>
	<CAGZ79kaTPGCzKooBjhk2+=njagFfFir6d5C40zpscuoweQgyiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 22:27:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSe2-000887-Qq
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605AbbJNU10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:27:26 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34555 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964AbbJNU1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:27:24 -0400
Received: by payp3 with SMTP id p3so15795264pay.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=D2/qUZkMGLQaKwLPsMUr8boiDSmbK/Q9cNdauHUdiqk=;
        b=G96ZDU68O3yp/IO4Wc4Cz2P/GgQObkcaGzJdVuagp5HNfjMiteIwi/hIRxHLjfxweJ
         bug3bs4nHdtq9IIqqtrn0SGLyRNRPP2eU7PXl6ZTGUqJ23zdcajzkERB09ta49Acfe76
         0acB7K4A4FmuzDU5X7rSFSYjtERLkFMdGnZTWHL4p9SlMqn+Uyw7DkFYrEyb7MpRTXul
         NEAXsmPbU5mbLA4r7WpGhc55HM+KY1+rRlOfZjhaWXBJh44iHDGCP893t+k2DhzB792/
         BC2/hMjjv3uYnh9pwQuiden4fUbU+ZXbHncvx07ixv1UTRLtMep9wxGyIL2WGWWatgCf
         dhcQ==
X-Received: by 10.68.107.133 with SMTP id hc5mr5561887pbb.5.1444854444322;
        Wed, 14 Oct 2015 13:27:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id d13sm11245122pbu.20.2015.10.14.13.27.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:27:23 -0700 (PDT)
In-Reply-To: <CAGZ79kaTPGCzKooBjhk2+=njagFfFir6d5C40zpscuoweQgyiA@mail.gmail.com>
	(Stefan Beller's message of "Wed, 14 Oct 2015 13:22:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279591>

Stefan Beller <sbeller@google.com> writes:

>> @@ -1019,10 +1019,10 @@ static int mailinfo(FILE *in, FILE *out, const char *msg, const char *patch)
>>         ungetc(peek, in);
>>
>>         /* process the email header */
>> -       while (read_one_header_line(&line, fin))
>> -               check_header(&line, p_hdr_data, 1);
>> +       while (read_one_header_line(&line_global, fin))
>> +               check_header(&line_global, p_hdr_data, 1);
>
> This is the only function to use line_global if I see correctly.
> The function is called only once, so no need to preserve state
> outside the function. Would it make sense to remove line_global
> completely and have a local variable in this function instead?

That is exactly the step that comes after it does, but if you squash
06 and 07 into one patch (i.e. take diff between the state after 05
and after 07), that realization will not easily come (well, at least
it didn't come to me and I wasn't convinced that the conversion is
correct myself until I split 06 and 07 into two separate steps).
