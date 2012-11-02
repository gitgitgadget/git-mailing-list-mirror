From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 04/14] Add new simplified git-remote-testgit
Date: Fri, 2 Nov 2012 17:16:18 +0100
Message-ID: <CAMP44s38oBadxCew+mWzQJG1o1g++Pi4G50FuHzRO-c1sAk53Q@mail.gmail.com>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
	<1351821738-17526-5-git-send-email-felipe.contreras@gmail.com>
	<5093D0DD.3050801@gmail.com>
	<CAMP44s0n_O-7j329WyTxsWgVbCV2mEAnPG-WQeWBFdmHdfOjnQ@mail.gmail.com>
	<5093EEB4.3040402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 17:16:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUJv5-0000cb-U7
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 17:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757175Ab2KBQQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 12:16:19 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:58540 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953Ab2KBQQS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 12:16:18 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so3798575oag.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 09:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5PSPQObpUlrPvnhO5X9XW3baCeDsPtvH48HI6SLFMY8=;
        b=N1JUmQl3agmcGyISK7pVxutbU0UEe+jTn2ys6SXuik/d4/r94Ck5GfI5ggxQFNhiUV
         Q6emStMBfWM1b8tIhXh6B0D0+liVRuAJsT87REYrtTgcVKKiTJsqhrIygCj2QjDCB7Us
         DheWqMxUAx6JTyZIrDIou7e5IV8EK/mzYVw6zTPEyjD0g30tM+I4wQbFt26/aWtSVS4Q
         OwCLmr/kvjqCb/DpTu63OgsA6VUWv2E24p8S8obOHkIdrGFIASfJGpkbrSnk9Sy4aOJ0
         CL2I39BOaGqlslNi0FratuwrBm2EhQReO+Q59ToHmmwIcfovXVaRKNNaC0WLykH0irdG
         s9eg==
Received: by 10.60.31.241 with SMTP id d17mr1727327oei.107.1351872978028; Fri,
 02 Nov 2012 09:16:18 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Fri, 2 Nov 2012 09:16:18 -0700 (PDT)
In-Reply-To: <5093EEB4.3040402@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208959>

On Fri, Nov 2, 2012 at 5:03 PM, Stefano Lattarini
<stefano.lattarini@gmail.com> wrote:
> On 11/02/2012 04:42 PM, Felipe Contreras wrote:

>> What happens when you call this with:
>>
>>  ./script "alias with spaces"
>>
> '$alias' will correctly expand to "alias with spaces".  Try out:
>
>   $ sh -c 'alias=$1; echo "$alias"' dummy '1   2*3'
>   1   2*3
>
> This works consistently with every known shell (even non-POSIX
> relics like Solaris /bin/sh).

All right.

>> _If_ we want this as POSIX, yeah.
>>
> Why don't we?  Why add an extra requirement for a test that
>
>  1. can be easily written in POSIX shell, and
>  2. tests a feature that doesn't require bash to work (unless
>     I'm sorely mistaken, that is)?
>
> Honest question.  But of course, if the Git active contributors
> deem the extra requirement (which is not an invasive one, given
> how often bash is installed even on non-Linux systems) acceptable
> in order to have the test case simpler and clearer, feel free to
> disregard all my observations in this thread.

Because the code will be more complicated. Most of the changes
required are relatively small, so it's not a big issue, but I would
like to see how you replace the code that uses associative arrays. I
don't know know of a clean, simple way to do it in POSIX. If you can
find one, I don't see any strong reason to use bash.

>>>> +while read line; do
>>>> +    case "$line" in
>>>>
>>> Useless double quoting (my previous observation about Git coding
>>> guidelines applies here as well, of course).
>>
>> What if line has multiple spaces?
>>
> Still no problem, as in the case of the 'alias=$1' assignment before:
>
>   $ sh -c 'case $1 in *x"  "x*) echo ok;; *) exit 1;; esac' dummy 'x  x'
>   ok

All right.

>>>> +        echo "feature import-marks=$gitmarks"
>>>> +        echo "feature export-marks=$gitmarks"
>>>> +        git fast-export --use-done-feature --{import,export}-marks="$testgitmarks" $refs | \
>>>>
>>> Better avoid the tricky {foo,bar} bashism:
>>>
>>>     git fast-export --use-done-feature \
>>>                     --import-marks="$testgitmarks" \
>>>                     --export-marks="$testgitmarks" \
>>>                     $refs | \
>>
>> If that's what we want, yeah.
>>
> Honestly, I find my longer-and-more-explicit version clearer, even
> if you can assume bash for your script.  But that's a matter of
> personal preference (sorry for not stating that right away), so
> feel free to ignore it if you decide to keep the bash requirement
> in the end.

And I prefer the other form. I fact, I would prefer if both tools
simply had a --marks option set both, and didn't require the file to
be created beforehand. I've _never_ seen a situation where separate
marks for import and export made sense. But that's off-topic.

If you find a way to replace the associative arrays code, I have no
trouble in switching this to the POSIX version.

Cheers.

-- 
Felipe Contreras
