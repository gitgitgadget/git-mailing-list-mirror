From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Be more careful with objects directory permissions on
   clone
Date: Mon, 05 May 2008 11:01:36 +0200
Message-ID: <481ECCF0.6080308@viscovery.net>
References: <alpine.BSO.1.10.0805041234570.5819@zrgural.vwaro.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark Hills <mark@pogo.org.uk>
X-From: git-owner@vger.kernel.org Mon May 05 11:02:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jswaa-0002O4-7g
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 11:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909AbYEEJBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 05:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755862AbYEEJBi
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 05:01:38 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:25837 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755614AbYEEJBh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 05:01:37 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JswZk-0007sE-0z; Mon, 05 May 2008 11:01:36 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C00D26D9; Mon,  5 May 2008 11:01:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.BSO.1.10.0805041234570.5819@zrgural.vwaro.pbz>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81250>

Mark Hills schrieb:
> Honour the setgid and umask when re-creating the objects directory
> at the destination.
> 
> cpio in copy-pass mode aims to copy file permissions which causes this
> problem and cannot be disabled. Be explicit by copying the directory
> structure first, honouring the permissions at the destination, then copy
> the files with their existing read-only permissions.
...
>          cd "$repo" &&
> -        find objects -depth -print | cpio $cpio_quiet_flag -pumd$l
> "$GIT_DIR/" || \
> +        # Create dirs using umask and permissions and destination
> +        find objects -type d -print | (cd "$GIT_DIR" && xargs mkdir -p) &&
> +        # Copy 0444 permissions on files
> +        find objects -type f -print | cpio $cpio_quiet_flag -pumd$l
> "$GIT_DIR/" || \

Wouldn't that be better:

	find objects ! -type d -print | cpio ...

?

-- Hannes
