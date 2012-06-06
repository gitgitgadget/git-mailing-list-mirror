From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/3] Tests file for git-remote-mediawiki
Date: Wed, 06 Jun 2012 22:18:14 +0200
Message-ID: <vpqobow8a9l.fsf@bauges.imag.fr>
References: <4FCE07A5.9020001@ensimag.imag.fr>
	<1338902756-4162-1-git-send-email-simon.cathebras@ensimag.imag.fr>
	<1338902756-4162-3-git-send-email-simon.cathebras@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, charles.roussel@ensimag.imag.fr,
	Guillaume.Sasdy@ensimag.imag.fr, Julien.Khayat@ensimag.imag.fr,
	Simon.Perrat@ensimag.imag.fr, peff@peff.net, gitster@pobox.com,
	Charles Roussel <charles.roussel@ensimag.fr>
To: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 06 22:18:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScMgb-0003tJ-Iw
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 22:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757513Ab2FFUS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 16:18:29 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44517 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753333Ab2FFUS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 16:18:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q56K9QFE009873
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 6 Jun 2012 22:09:26 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1ScMgJ-0001I6-7c; Wed, 06 Jun 2012 22:18:15 +0200
In-Reply-To: <1338902756-4162-3-git-send-email-simon.cathebras@ensimag.imag.fr>
	(Simon Cathebras's message of "Tue, 5 Jun 2012 15:25:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 06 Jun 2012 22:09:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q56K9QFE009873
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339618171.17384@CFRI6seZ8QB8keVy+8iNCg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199349>

Simon Cathebras <simon.cathebras@ensimag.imag.fr> writes:

> From: Charles Roussel <charles.roussel@ensimag.fr>
>
> Those scripts test the functions of git-remote-mediawiki.
> t9360: test cases for git clone. Including tests of cloning just a category, just a precise set of page and a classical use of clone on the whole wiki.

Avoid long lines in code and commit messages (80 columns max)

> In addition, this file provide now some fonction du manipulate sections on wiki.

s/du/to/

> t9361: test cases for git pull (add page, edit page, delete page) and git push (add file, edit file, delete file).

When commis messages start looking like an enumeration, it usually means
that either you read the GNU recommandation for ChangeLogs too much, or
that you should split your commit (not mandatory here I think, but short
patches are easier to review).

> +# tests for git-remote-mediawiki
> +
> +test_description='Test the Git Mediawiki remote helper: git clone'

Why do you need a comment if you have the test_description right below?

> +if [ ! -f /$GIT_BUILD_DIR/git-remote-mediawiki ];

Why / in front of $GIT_BUILD_DIR/ ?

> +        test_expect_code 0 ls mw_dir | wc -l | grep 1 &&
> +        test_expect_code 0 test -e mw_dir/Main_Page.mw &&

Why "test_expect_code 0"? You already have && right?

Doesn't a directory containing 10 files pass the tests?

You probably want a helper function test_contains_N_files <dir> <N> that
does test `ls mw_dir | wc -l` -eq 1 as you did below, but may give a
diagnosis when the test fails.

> +test_expect_success 'git clone only create Main_Page.mw with a wiki with no other pages ' '
> +        wiki_reset &&
> +        wiki_editpage foo "this page must be delete before the clone" false &&

s/delete/deleted/

> +	git_diff_directories mw_dir ref_page &&

functions in tests are usually prefixed with test_ instead.

> +# clone a wiki after a page has been added then edited once
> +# check that the content is correct

It's not sufficient. You should check also that the history is correct.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
