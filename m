From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Make rebase save ORIG_HEAD if using current branch
Date: Tue, 06 May 2008 08:32:02 +0200
Message-ID: <481FFB62.9090804@viscovery.net>
References: <20080506051920.GA9165@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue May 06 08:33:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtGjT-0001VX-L4
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 08:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbYEFGcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 02:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbYEFGcJ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 02:32:09 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:25620 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbYEFGcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 02:32:09 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JtGiZ-0002Vb-1e; Tue, 06 May 2008 08:32:05 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A54236B7; Tue,  6 May 2008 08:32:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080506051920.GA9165@Hermes.local>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81334>

Brian Gernhardt schrieb:
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 9b13b83..8d54d9f 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -342,6 +342,7 @@ case "$#" in
>  		branch_name=HEAD ;# detached
>  	fi
>  	branch=$(git rev-parse --verify "${branch_name}^0") || exit
> +	echo "$branch" > "$GIT_DIR/ORIG_HEAD"

1. You should be using 'git update-ref' here, I think.
2. You should detect errors.
3. Should ORIG_HEAD better be set at the end of the rebase, not at the
beginning? Because if the rebase stops for some reason, and then you do a
'git reset', you'll have overwritten the ORIG_HEAD that you have set here.

-- Hannes
