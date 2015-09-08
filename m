From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] filter-branch: add passed/remaining seconds on progress
Date: Tue, 8 Sep 2015 13:59:17 -0400
Message-ID: <CAPig+cS7ObsWjqbLytCKp1PGF+224TYhC734dNa_HXYQ7p+GgQ@mail.gmail.com>
References: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
	<1441633928-18035-1-git-send-email-bernat@primeranks.net>
	<CAPig+cRRMUhWwxAgVHKpMMne7XiOuYGTi_zgQMB=A+XNGUzLqQ@mail.gmail.com>
	<xmqqsi6o95r7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?R8OhYm9yIEJlcm7DoXQ=?= <bernat@primeranks.net>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Mikael Magnusson <mikachu@gmail.com>, cbailey32@bloomberg.net,
	Lee.Carver@servicenow.com, Michael Witten <mfwitten@gmail.com>,
	Gabor Bernat <gabor.bernat@gravityrd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 19:59:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZNB3-0004dG-Bp
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 19:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406AbbIHR7U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2015 13:59:20 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:33969 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbbIHR7T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Sep 2015 13:59:19 -0400
Received: by ykdg206 with SMTP id g206so130671529ykd.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2015 10:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=YrOkSMG20kHMqfJxiecjCbEenDrD0J0pzqpXVfl90uQ=;
        b=zgBrLFxsn/r87sC6tfiBTNJhCNPB1CHSswUdaOjKXC/V/zj+An16/o/3I47Af99+nw
         nI8c4AE+2OoJQm9TePOn4w1bABUwiCuSHUCb7fOuP90RYDwpzubusabTUJhbnThU0XpD
         FsLrXUN14rNB8Qe6+C7ktI+b+ovdTLeWAjD91lDdh0bZboLlE8j1y/ljmwlC4sYxkgUZ
         zZD2uDIAhSd6KVyj7BePaasGZDzw9mW6Zn0b4VvFe6RT48UrVmx9mfCUXzdtzIZnaNIW
         AMkjRK4sUkNZqMuLBKIwbo0uV8MPRkaAYG7OsG2Zj918Q1HYv1bGtrJ/zQkMnGZxa1yV
         XBdQ==
X-Received: by 10.170.119.140 with SMTP id l134mr30564949ykb.69.1441735157921;
 Tue, 08 Sep 2015 10:59:17 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Tue, 8 Sep 2015 10:59:17 -0700 (PDT)
In-Reply-To: <xmqqsi6o95r7.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: wNDnusSeXev61SPZLV4w0XzoVAw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277508>

On Tue, Sep 8, 2015 at 1:32 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> On Mon, Sep 7, 2015 at 9:52 AM, G=C3=A1bor Bern=C3=A1t <bernat@prime=
ranks.net> wrote:
>>...
>>>  # Rewrite the commits
>>> +report_progress ()
>>> +{
>>> +if test -n "$progress"
>>> +then
>>
>> Indent code within the function...
>
> Also git_filter_branch__commit_count is now used only inside this
> function, so it is easier to follow to increment it here.

Make sense.

>>> +printf "\rRewrite $commit ($git_filter_branch__commit_count/$commi=
ts)$progress"
>>
>> The "\r" causes this status line to be overwritten each time through=
,
>> and since the processed commit count always increases, we know that
>> the original (without ETA) will never leave junk at the end of the
>> line. However, with estimated seconds also being displayed, does thi=
s
>> still hold?
>
> Good point.
> Perhaps like this squashed in?
>
> -printf "\rRewrite $commit ($git_filter_branch__commit_count/$commits=
)$progress"
> +       printf "\rRewrite $commit ($git_filter_branch__commit_count/$=
commits)$progress            "

Yes, for an expedient "fix", this is what I had in mind, although I
would also have added an equal number of backspaces (\b) following the
spaces, as a minor aesthetic improvement.
