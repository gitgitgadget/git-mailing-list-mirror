From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 1/2] sendemail: teach git-send-email to list aliases
Date: Tue, 17 Nov 2015 08:27:18 -0800
Message-ID: <CA+P7+xp5x+WhQ418aDEHdVv=GWvEpzsvOGbKpNMZ8ko5xcFr8w@mail.gmail.com>
References: <1447618940-27446-1-git-send-email-jacob.e.keller@intel.com>
 <CAPig+cQ929oAZqQM+X68x3PVQ-opwdi3VzjcQTUsaCfVK3411g@mail.gmail.com>
 <1447717227.23262.10.camel@intel.com> <CAPig+cSMW2UmTzuyvBFpcpr4tF1FRdxHUPH4+wS3vrZSP9AzJA@mail.gmail.com>
 <1447719035.23262.17.camel@intel.com> <20151117072049.GA25414@flurp.local> <20151117132644.Horde.0sLxtm6pFWvFfyP7Yzukk0F@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Lee Marlow <lee.marlow@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Nov 17 17:27:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zyj6h-0006aX-SP
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 17:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198AbbKQQ1l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Nov 2015 11:27:41 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:34464 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbbKQQ1i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Nov 2015 11:27:38 -0500
Received: by ioir85 with SMTP id r85so23928048ioi.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 08:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5eCNCmUnJ/ahz578fXm1udHYswM6CPED1KRoSZ/PD4g=;
        b=Q1j/8r8TtTVg2TuI0XsyWvVQHDeUXK3QJ5+1rXSS2fUyNpo8FuXZlL02ACmuxA3y/w
         ur7siyrpo2+4raRq8aX873x3qrWhtS7qIG0cIfuHSiasxqaz5rVPkv59wcrT0SPYlHR2
         1zdLYNzUO0M+9niOwQDN3BtCrD36UV/UEHpyxCLzJBIl5hhb5VnqTZ+bPYQyD3M/OOBv
         q4BLjacyUeZRMTXrigxJZ7sQXmcvh5CdH6x5NUaF7yowbomdu6jyVOylkkxnVj6tWhu4
         xIH5E8T08qepkVrofuvXYNJdB7+w/Juf1XOzGUzt4kXzu/UguplELYId0DBu8cEevOBg
         UuOQ==
X-Received: by 10.107.136.39 with SMTP id k39mr47319473iod.0.1447777657718;
 Tue, 17 Nov 2015 08:27:37 -0800 (PST)
Received: by 10.107.19.227 with HTTP; Tue, 17 Nov 2015 08:27:18 -0800 (PST)
In-Reply-To: <20151117132644.Horde.0sLxtm6pFWvFfyP7Yzukk0F@webmail.informatik.kit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281412>

On Tue, Nov 17, 2015 at 4:26 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
>
> Quoting Eric Sunshine <sunshine@sunshineco.com>:
>
>> On Tue, Nov 17, 2015 at 12:10:35AM +0000, Keller, Jacob E wrote:
>>>
>>> On Mon, 2015-11-16 at 18:50 -0500, Eric Sunshine wrote:
>>> > It should be possible to extract the alias within the shell itsel=
f
>>> > without a separate process. For instance:
>>> >
>>> >     read alias rest
>>> >
>>> > will leave the first token in $alias and the remainder of the lin=
e in
>>> > $rest, and it's all done within the shell process.
>
>
> Actually, putting this read in a while loop and feeding 'git send-ema=
il's
> output into that does fork() a subshell:
>

Yea, I realized this. One extra subshell isn't a big deal but if we
can eliminate that it is good.

>   $ echo "outside: $BASH_SUBSHELL" |while read line ; do echo "$line
> inside: $BASH_SUBSHELL" ; done
>   outside: 0  inside: 1
>
>>> I'll look into this :)
>>
>>
>> My reason for asking is concern about scripts possibly breaking if
>> someone comes along and wants to "fix" --dump-aliases to also dump
>> the alias expansions. One possibility is just to punt today and say
>> that when that feature is needed in the future, then that someone ca=
n
>> add a --verbose option to complement --dump-aliases which would emit
>> the alias expansions as well. One nice thing about punting at this
>> point is that we don't (today) have to define a format for the outpu=
t
>> of the expansions.
>
>
> I think we should cross the bridge when we get to it.

Agreed.

>
> However, we could still be nice to that brave soul who might want to =
cross
> it in the future, and since at this point we are interested in listin=
g only
> alias names, perhaps we should not appropriate the broader '--dump-al=
ias'
> option, but go with the more specific '--dump-alias-names' instead.
>

Disagree. I think the best approach for expanding --dump-aliases
output is turning it into a keyword-option argument such as:

--dump-aliases=3Dformat

and we can say "historic reasons the format is always names only",
then we can extend the support that way. I don't really think that
"--dump-alias-names" is nice since then we'd need separate option if
this ever does change, and it's rather long if it never changes.

I suspect it won't be something people need either.

Regards,
Jake

>
> G=C3=A1bor
>
