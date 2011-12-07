From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 15/15] t3040 (subprojects-basic): modernize style
Date: Wed, 7 Dec 2011 16:21:26 -0600
Message-ID: <20111207222126.GF2911@elie.hsd1.il.comcast.net>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com>
 <1323286611-4806-16-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 23:21:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYPru-0000I2-P2
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 23:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758471Ab1LGWVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 17:21:33 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36780 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757752Ab1LGWVc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 17:21:32 -0500
Received: by yenm11 with SMTP id m11so529159yen.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 14:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/jDlqg6uBUr+zSqvsq+HTdliUcfKkt8SN3w9lUGVrZo=;
        b=WYexUMpmNVmy6T1Ql+n5heiWPpXuDHJETW+uizOZmaa6aQfJEYlB6glE7iYDLVR7Uf
         q1vSWGCKsooXyMcJRuhzAZAmIW7tZSBRnykiPb/ZL3VIwdtDdXXZr7pJk4wkng20gEmo
         4Eaf5sNLIElHnjclFNnybSuEHNhH5quEyt8fI=
Received: by 10.236.197.97 with SMTP id s61mr467992yhn.57.1323296492108;
        Wed, 07 Dec 2011 14:21:32 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id f17sm8572446ang.20.2011.12.07.14.21.30
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 14:21:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323286611-4806-16-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186511>

Ramkumar Ramachandra wrote:

> Put the opening quote starting each test on the same line as the
> test_expect_* invocation.  While at it:
[...]
> - Use <<\-EOF in preference to <<EOF to save readers the trouble of
>   looking for variable interpolations.

I think you mean <<-\EOF. :)

[...]
> - Chain commands with &&.  Breaks in a test assertion's && chain can
>   potentially hide failures from earlier commands in the chain.
>
> - Use test_expect_code() in preference to checking the exit status of
>   various statements by hand.

I guess these two are the motivation?

> Inspired-by: Jonathan Nieder <jrnieder@gmail.com>

Oh, dear.

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
[...]
> --- a/t/t3040-subprojects-basic.sh
> +++ b/t/t3040-subprojects-basic.sh
> @@ -3,81 +3,81 @@
>  test_description='Basic subproject functionality'
>  . ./test-lib.sh
>  
> -test_expect_success 'Super project creation' \
> -    ': >Makefile &&
> -    git add Makefile &&
> -    git commit -m "Superproject created"'
> -
> -
> -cat >expected <<EOF
[...]

It would be easier to read if each preimage test assertion were next to
the corresponding postimage test assertion.  Does "git diff --patience"
do better?

> -test_expect_success 'Super project creation' \
> -    ': >Makefile &&
> -    git add Makefile &&
> -    git commit -m "Superproject created"'
> -
> -
> +test_expect_success 'setup: create superproject' '
> +	: >Makefile &&
> +	git add Makefile &&
> +	git commit -m "Superproject created"
> +'
> +

Ok, makes sense.

> -cat >expected <<EOF
> -:000000 160000 00000... A	sub1
> -:000000 160000 00000... A	sub2
> -EOF
> -test_expect_success 'create subprojects' \
> -    'mkdir sub1 &&
> -    ( cd sub1 && git init && : >Makefile && git add * &&
> -    git commit -q -m "subproject 1" ) &&
> +test_expect_success 'setup: create subprojects' '
> +	mkdir sub1 &&
> +	( cd sub1 && git init && : >Makefile && git add * &&
> +	git commit -q -m "subproject 1" ) &&

If cleaning up the style anyway, I would write this as

	mkdir sub1 &&
	(
		cd sub1 &&
		git init &&
		>Makefile &&
		git add Makefile &&
		git commit -m "subproject 1"
	)

Or

	mkdir sub1 &&
	(
		cd sub1 &&
		git init &&
		test_commit subproject-1 Makefile
	)

But leaving it alone like you did is probably better. ;-)

[...]
> -    git diff-tree --abbrev=5 HEAD^ HEAD |cut -d" " -f-3,5- >current &&
> -    test_cmp expected current'
> -
> -git branch save HEAD
> -
> +	git diff-tree --abbrev=5 HEAD^ HEAD |cut -d" " -f-3,5- >current &&
> +	git branch save HEAD &&
> +	cat >expected <<-\EOF &&
> +	:000000 160000 00000... A	sub1
> +	:000000 160000 00000... A	sub2
> +	EOF
> +	test_cmp expected current
> +'
> +

At first I wondered if "git branch save HEAD" is logically part of the
same test.  After all, it's just meant as a baseline for use by later
tests.

After thinking about it for a few seconds, though, that's exactly what
this test is about.  Maybe it would have been clearer if the two setup
tests were combined into one (but please don't take this advice too
seriously; I'm just musing).

> -test_expect_success 'check if fsck ignores the subprojects' \
> -    'git fsck --full'
> +test_expect_success 'check if fsck ignores the subprojects' '
> +	git fsck --full
> +'

Does this test imply that one of the subprojects is broken somehow?

> -
> -test_expect_success 'check if commit in a subproject detected' \
> -    '( cd sub1 &&
> -    echo "all:" >>Makefile &&
> -    echo "	true" >>Makefile &&
> -    git commit -q -a -m "make all" ) && {
> -        git diff-files --exit-code
> -	test $? = 1
> -    }'
> +
> +test_expect_success 'check if commit in a subproject detected' '
> +	( cd sub1 &&
> +	echo "all:" >>Makefile &&
> +	echo "	true" >>Makefile &&
> +	git commit -q -a -m "make all" ) &&
> +	test_expect_code 1 git diff-files --exit-code
> +'

Nice.  Style again: I'd be tempted to reformat as

	(
		cd sub1 &&
		echo "all:" >>Makefile &&
		...
	) &&
	test_expect_code 1 git diff-files --exit-code

to make the subshell scope a little clearer, but exercising restraint
like you did may be better.

[...]
>  
>  # the index must contain the object name the HEAD of the
>  # subproject sub1 was at the point "save"
> -test_expect_success 'checkout in superproject' \
> -    'git checkout save &&
> -    git diff-index --exit-code --raw --cached save -- sub1'
> +test_expect_success 'checkout in superproject' '
> +	git checkout save &&
> +	git diff-index --exit-code --raw --cached save -- sub1
> +'

Thanks much.  The result really is a little easier on the eyes, and
the changes look safe.
