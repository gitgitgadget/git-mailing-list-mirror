From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Have tests and programs understand paths containing spaces
Date: Wed, 23 Apr 2008 09:13:04 +0200
Message-ID: <480EE180.1050202@viscovery.net>
References: <20080422212801.GB20417@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Arjen Laarhoven <arjen@yaph.org>
X-From: git-owner@vger.kernel.org Wed Apr 23 09:14:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoZB1-0000yZ-EC
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 09:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbYDWHNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 03:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbYDWHNN
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 03:13:13 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:65044 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbYDWHNM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 03:13:12 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JoZA9-00041i-7d; Wed, 23 Apr 2008 09:13:08 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DE5EA6D9; Wed, 23 Apr 2008 09:13:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080422212801.GB20417@regex.yaph.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80193>

Arjen Laarhoven schrieb:
> A lot of tests and some core programs didn't work when used in a path
> containing whitespace.  Correct the quoting of all affected programs to
> fix this.

Please separate fixes of core programs/scripts from fixes of the tests
(because the former have a much higher chance of being accepted).

But see these threads first:

http://thread.gmane.org/gmane.comp.version-control.git/60544
http://thread.gmane.org/gmane.comp.version-control.git/79057


Here a few comments:

> +GIT_DIR="$PWD/.git"
> +GIT_SVN_DIR="$GIT_DIR/svn/git-svn"
> +SVN_TREE="$GIT_SVN_DIR/svn-tree"
> +svnrepo="$PWD/svnrepo"

These are unnecessary: RHS of an assignment does not undergo word splitting.

> -test_expect_success "checkout from svn" "svn co $svnrepo '$SVN_TREE'"
> +test_expect_success "checkout from svn" "svn co '$svnrepo' '$SVN_TREE'"

> -	git diff help $SVN_TREE/exec-2.sh"
> +	git diff help '$SVN_TREE'/exec-2.sh"

These changes protect *only* against space-in-name, but not
random-special-character-in-name. The proper fix is to change the quoting from

  test_expect_success "..." "... $svnrepo ..."

to

  test_expect_success '...' '... "$svnrepo" ...'

-- Hannes
