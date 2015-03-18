From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [v3 PATCH 2/2] reset: add tests for git reset -
Date: Wed, 18 Mar 2015 17:54:16 +0100
Message-ID: <vpqh9ticklj.fsf@anie.imag.fr>
References: <1426667709-26698-1-git-send-email-dyoucme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Sundararajan R <dyoucme@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 17:54:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYHEm-0005s7-0I
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 17:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbbCRQy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 12:54:27 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36518 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbbCRQy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 12:54:26 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t2IGsEHv012570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Mar 2015 17:54:14 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t2IGsG0N017216;
	Wed, 18 Mar 2015 17:54:16 +0100
In-Reply-To: <1426667709-26698-1-git-send-email-dyoucme@gmail.com>
	(Sundararajan R.'s message of "Wed, 18 Mar 2015 14:05:09 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 18 Mar 2015 17:54:14 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t2IGsEHv012570
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1427302456.96408@tL1DADx02GfxGoPEQMhwiQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265742>

Sundararajan R <dyoucme@gmail.com> writes:

> Subject: [v3 PATCH 2/2] reset: add tests for git reset -

This should be [PATCH v3 2/2].

"git send-email -v2" can do this for you.

Sundararajan R <dyoucme@gmail.com> writes:

> +test_expect_success 'reset - with no @{-1} branch and file named - should succeed' '
> +	test_when_finished rm -rf new &&
> +	>expected &&
> +	git init new &&
> +	(
> +		cd new &&
> +		echo "Hello" >- &&
> +		git add - &&
> +		git reset - >../actual 
> +	) &&
> +	test_cmp expected actual
> +'

test_must_be_empty actual would be easier to read than ">expected ...
test_cmp expected" IMHO.

> +test_expect_success 'reset - with @{-1} branch and no file named - should succeed' '
> +	test_when_finished rm -rf new &&
> +	git init new &&
> +	(
> +		cd new &&
> +		echo "Hey" >new_file &&
> +		git add new_file &&
> +		git commit -m "first_commit" &&
> +		git checkout -b new_branch &&
> +		>new_file &&
> +		git add new_file &&
> +		git reset - &&
> +		git status -uno >actual &&
> +		git add new_file &&
> +		git reset @{-1} &&
> +		git status -uno >expected &&
> +		test_cmp actual expected 
> +	)
> +'

Better use "git status --porcelain" here as its format is meant to be
stable and unambiguous. The non-porcelain should work two because you're
comparing the output on two identical states, but who knows.

With or without my suggested change, the series looks good to me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
