From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] lib-git-svn.sh: Fix quoting issues with paths
 containing shell metacharacters
Date: Tue, 08 Apr 2008 23:50:35 -0700
Message-ID: <7v63urcyis.fsf@gitster.siamese.dyndns.org>
References: <cover.1207702130.git.bdonlan@fushizen.net>
 <1207704604-30393-1-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-2-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-3-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-4-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-5-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-6-git-send-email-bdonlan@fushizen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com
To: Bryan Donlan <bdonlan@fushizen.net>
X-From: git-owner@vger.kernel.org Wed Apr 09 08:51:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjU9l-0002Ri-Ni
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 08:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbYDIGuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 02:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbYDIGuu
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 02:50:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48954 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbYDIGut (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 02:50:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D4472135FB;
	Wed,  9 Apr 2008 02:50:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EF3DE135F9; Wed,  9 Apr 2008 02:50:41 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79079>

Bryan Donlan <bdonlan@fushizen.net> writes:

> Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
> ---
>  t/lib-git-svn.sh |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
> index 9decd2e..1b37ba8 100644
> --- a/t/lib-git-svn.sh
> +++ b/t/lib-git-svn.sh
> @@ -7,9 +7,9 @@ then
>  	exit
>  fi
>  
> -GIT_DIR=$PWD/.git
> -GIT_SVN_DIR=$GIT_DIR/svn/git-svn
> -SVN_TREE=$GIT_SVN_DIR/svn-tree
> +GIT_DIR="$PWD/.git"
> +GIT_SVN_DIR="$GIT_DIR/svn/git-svn"
> +SVN_TREE="$GIT_SVN_DIR/svn-tree"

Same comment as the one for [1/8].

>  
>  svn >/dev/null 2>&1
>  if test $? -ne 1
> @@ -19,13 +19,14 @@ then
>      exit
>  fi
>  
> -svnrepo=$PWD/svnrepo
> +svnrepo="$PWD/svnrepo"
> +export svnrepo

Likewise, except "export" is a good way to propagate it down.

>  perl -w -e "
>  use SVN::Core;
>  use SVN::Repos;
>  \$SVN::Core::VERSION gt '1.1.0' or exit(42);
> -system(qw/svnadmin create --fs-type fsfs/, '$svnrepo') == 0 or exit(41);
> +system(qw/svnadmin create --fs-type fsfs/, \$ENV{svnrepo}) == 0 or exit(41);
>  " >&3 2>&4
>  x=$?
>  if test $x -ne 0
