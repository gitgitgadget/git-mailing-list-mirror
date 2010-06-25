From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH v2] t4027,4041: Use test -s to test for an empty file
Date: Fri, 25 Jun 2010 11:26:57 -0500
Message-ID: <kqdYVAmM2c4O6wIC09b253C3JjQEYA9TmnkBdBwGP2ZY3QpzeGjLcA@cipher.nrlssc.navy.mil>
References: <201006242134.54081.j6t@kdbg.org> <1277410231-12326-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 18:27:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSBkT-0008WC-Rr
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 18:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182Ab0FYQ1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 12:27:20 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36015 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932132Ab0FYQ1U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 12:27:20 -0400
Received: by mail.nrlssc.navy.mil id o5PGQwHt000478; Fri, 25 Jun 2010 11:26:58 -0500
In-Reply-To: <1277410231-12326-1-git-send-email-brian@gernhardtsoftware.com>
X-OriginalArrivalTime: 25 Jun 2010 16:26:57.0795 (UTC) FILETIME=[3B46AD30:01CB1483]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149695>

On 06/24/2010 03:10 PM, Brian Gernhardt wrote:
> The tests had used a mixture of 'echo -n' (which is non-portable) and
> either test_cmp or diff to check if a file is empty.  The much easier
> and portable method to check for an empty file is '! test -s'
> 
> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> ---
> 
>  Johannes Sixt wrote:
>  > Shouldn't you replace these by
>  >
>  >	! test -s actual2 &&
> 
>  Yes, you're right.  I was just trying to get the tests to run and didn't really pay attention to what it was trying to do.


Ditto.  But uh...


> diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
> index f44b906..db9b64d 100755
> --- a/t/t4041-diff-submodule-option.sh
> +++ b/t/t4041-diff-submodule-option.sh
> @@ -207,17 +207,17 @@ EOF
>  
>  test_expect_success 'submodule contains untracked content (untracked ignored)' "
>  	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
> -	echo -n '' | diff actual -
> +	! test -s actual -
                        ^^^
I don't think we need the trailing dash on these.

>  "
>  
>  test_expect_success 'submodule contains untracked content (dirty ignored)' "
>  	git diff-index -p --ignore-submodules=dirty --submodule=log HEAD >actual &&
> -	echo -n '' | diff actual -
> +	! test -s actual -
>  "
>  
>  test_expect_success 'submodule contains untracked content (all ignored)' "
>  	git diff-index -p --ignore-submodules=all --submodule=log HEAD >actual &&
> -	echo -n '' | diff actual -
> +	! test -s actual -
>  "
>  
>  test_expect_success 'submodule contains untracked and modifed content' "
> @@ -240,13 +240,13 @@ EOF
>  test_expect_success 'submodule contains untracked and modifed content (dirty ignored)' "
>  	echo new > sm1/foo6 &&
>  	git diff-index -p --ignore-submodules=dirty --submodule=log HEAD >actual &&
> -	echo -n '' | diff actual -
> +	! test -s actual -
>  "
>  
>  test_expect_success 'submodule contains untracked and modifed content (all ignored)' "
>  	echo new > sm1/foo6 &&
>  	git diff-index -p --ignore-submodules --submodule=log HEAD >actual &&
> -	echo -n '' | diff actual -
> +	! test -s actual -
>  "
>  
>  test_expect_success 'submodule contains modifed content' "
> @@ -295,7 +295,7 @@ EOF
>  
>  test_expect_success 'modified submodule contains untracked content (all ignored)' "
>  	git diff-index -p --ignore-submodules=all --submodule=log HEAD >actual &&
> -	echo -n '' | diff actual -
> +	! test -s actual -
>  "
>  
>  test_expect_success 'modified submodule contains untracked and modifed content' "
> @@ -331,7 +331,7 @@ EOF
>  test_expect_success 'modified submodule contains untracked and modifed content (all ignored)' "
>  	echo modification >> sm1/foo6 &&
>  	git diff-index -p --ignore-submodules --submodule=log HEAD >actual &&
> -	echo -n '' | diff actual -
> +	! test -s actual -
>  "
>  
>  test_expect_success 'modified submodule contains modifed content' "
