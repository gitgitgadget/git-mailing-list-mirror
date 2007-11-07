From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add missing inside_work_tree setting in setup_git_directory_gently
Date: Wed, 07 Nov 2007 12:42:57 -0800
Message-ID: <7vve8daisu.fsf@gitster.siamese.dyndns.org>
References: <20071103100323.GA25305@laptop> <20071103131806.GA25109@laptop>
	<7vir4ivdcr.fsf@gitster.siamese.dyndns.org>
	<20071104070307.GA26071@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 21:44:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IprlD-0005mh-QG
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 21:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756185AbXKGUnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 15:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755165AbXKGUnG
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 15:43:06 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:43785 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756185AbXKGUnE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 15:43:04 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 208552F9;
	Wed,  7 Nov 2007 15:43:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 894BC933A5;
	Wed,  7 Nov 2007 15:43:21 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63855>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sat, Nov 03, 2007 at 09:33:40PM -0700, Junio C Hamano wrote:
>> 
>> Please add automated test script for this, thanks.
>
> Thank you for reminding.  I tried to put a test in
> t1501-worktree.sh and found out core.worktree can override
> inside_work_tree previously set by setup_git_directory_gently(),
> activating the worktree code in setup_git_directory() again.
>
> This made me think setup_git_directory_gently() should use
> get_git_work_tree() instead. But then git_work_tree_cfg may not be
> initialized when get_git_work_tree() is called (starting from
> setup_git_directory(), git_work_tree_cfg is initialized in
> check_repository_format_version(), which is called _after_
> setup_git_directory_gently()).
>
> The interaction between these variables and functions is really beyond
> my knowledge. Johannes, can you have a look at this? In theory the
> following test should pass:
>
> diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
> index 7ee3820..bdb7720 100755
> --- a/t/t1501-worktree.sh
> +++ b/t/t1501-worktree.sh
> @@ -103,6 +103,11 @@ test_expect_success 'repo finds its work tree from work tree, too' '
>  	 test sub/dir/tracked = "$(git ls-files)")
>  '
>  
> +test_expect_success 'Try a command from subdir in worktree' '
> +	(cd repo.git/work/sub &&
> +	GIT_DIR=../.. GIT_WORK_TREE=.. git blame dir/tracked)
> +'
> +
>  test_expect_success '_gently() groks relative GIT_DIR & GIT_WORK_TREE' '
>  	cd repo.git/work/sub/dir &&
>  	GIT_DIR=../../.. GIT_WORK_TREE=../.. GIT_PAGER= \

I am wondering what happened to this thread...
