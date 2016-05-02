From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 04/10] shell helpers usage: always send help to stderr
Date: Mon, 2 May 2016 16:44:41 -0700
Message-ID: <CAGZ79ka7uPxLKVU7Dn-4yHyN1BMgeG33_7LJDShF3UVjrT2fgQ@mail.gmail.com>
References: <1461976845-18228-1-git-send-email-sbeller@google.com>
	<1461976845-18228-5-git-send-email-sbeller@google.com>
	<xmqqtwigox9x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 01:44:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axNWA-00052O-V5
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 01:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbcEBXon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 19:44:43 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:37486 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932362AbcEBXom (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 19:44:42 -0400
Received: by mail-ig0-f178.google.com with SMTP id s8so6569543ign.0
        for <git@vger.kernel.org>; Mon, 02 May 2016 16:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=1Y/isWqwJBS8+PNO/frPs61qP6nXFIUhqnSXHYussCE=;
        b=TCBpEBRJotua4qIN6rGp43d0Ld2xEMq3nPHbmas4kquvu4EgXhWanEVC5vqHgdVQHJ
         /Z5Ko3aRfr90tw18qvRV5aT1WeQH35sRUgBHVznUGr+GVqgsHMECQezNDu8Wr1o29h04
         0bmZNU5jdQUa04i3QrKFG76y0iv2mFaLiAHrgokHiEbGus9RTItHMYVtzlUN4ZqSOLh/
         06wF3WkkUnrDNF6rKdH462LzJtkBBs4DvfBaeZNXIurqTpCfgqPR+SoigTn3tau1bjoX
         64QFLZ52WRfa0LkezPFOC3wRJ19sq4INUxd/6gYHxypm6fhPolasDlSCIf9+9MParQuO
         uHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=1Y/isWqwJBS8+PNO/frPs61qP6nXFIUhqnSXHYussCE=;
        b=WIGADb8Of2lE7XwQNiItC92DT1vt/t1Iskh95/uePSXQupFgMSKBliEl3D9RDtViVg
         Gbem68cxzT+nVqOm8bI0mvJEZWGXdUACmRL8jHXK2ZqylYp8UCliEiaWQzUtKTs3Pozy
         tLsXX64adFReomlfwErmGD0va8vB36FeZoAUWKMRTKOycms6o0GQsXqi+3JhkSruBN9n
         VcQTJkQCNsJ8amA1gZKDp99XSftAkYwo/OsATiu6FMrfn5RPHpeniWPk3YYZ1snpwr5j
         Zu+Y4ODuR/lX89UfqKzygNJXf1umjagXnLApI0XZmeUycn2fev36ftWw+As2IdxAsvFx
         NTSg==
X-Gm-Message-State: AOPr4FVeei/Gfh58a/2NWoEM12RT/FehqMtA7ae7oOqKr4Ku67yz52UMhofCAx6FK20vMlrlXRejoKO9tUYV7GyX
X-Received: by 10.50.29.45 with SMTP id g13mr23497981igh.93.1462232681276;
 Mon, 02 May 2016 16:44:41 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 2 May 2016 16:44:41 -0700 (PDT)
In-Reply-To: <xmqqtwigox9x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293305>

On Mon, May 2, 2016 at 4:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> `git submodule asdf` would trigger displaying the usage of the submodule
>> command on stderr, however `git submodule -h` would display the usage on
>> stdout. Unify displaying help for shell commands on stderr.
>
> The primary output from "git cmd --help" is the usage message.  It
> is debatable why it should go to the standard error output when it
> is the primary thing the user asked for.

I had written some lengthy arguments, but when I wanted to back up
with data and facts, the first search result[1] convinced me this is
a bad patch as when a user asks for help specifically, they want it
to easily be piped, i.e.

    git --help |grep pull

instead of

    git --help 2>&1 |grep pull

So I'll drop this patch.
Thanks,
Stefan

[1] http://www.jstorimer.com/blogs/workingwithcode/7766119-when-to-use-stderr-instead-of-stdout

>
>
>
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  git-sh-setup.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
>> index c48139a..5c02446 100644
>> --- a/git-sh-setup.sh
>> +++ b/git-sh-setup.sh
>> @@ -65,7 +65,7 @@ say () {
>>
>>  if test -n "$OPTIONS_SPEC"; then
>>       usage() {
>> -             "$0" -h
>> +             "$0" -h 1>&2
>>               exit 1
>>       }
