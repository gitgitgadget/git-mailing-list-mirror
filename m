From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-submodule: remove unnecessary exits when calling
 resolve_relative_url
Date: Thu, 25 Sep 2008 14:19:42 +0200
Message-ID: <48DB81DE.6070600@viscovery.net>
References: <200809221808.31730.johan@herland.net> <17c3c33dd7aa6803d7ac046f3e4dc0d5bb4c7234.1222341013.git.davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, johan@herland.net,
	spearce@spearce.org, mlevedahl@gmail.com
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 14:21:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kipq6-0006qL-C9
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 14:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038AbYIYMTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 08:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753031AbYIYMTt
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 08:19:49 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:38261 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbYIYMTs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 08:19:48 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kipos-0006tn-Sv; Thu, 25 Sep 2008 14:19:43 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 93ECE54D; Thu, 25 Sep 2008 14:19:42 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <17c3c33dd7aa6803d7ac046f3e4dc0d5bb4c7234.1222341013.git.davvid@gmail.com>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96755>

David Aguilar schrieb:
> resolve_relative_url calls die() when no remote url exists so these calls to
> exit can be removed.
...
> @@ -155,7 +155,7 @@ cmd_add()
>  	case "$repo" in
>  	./*|../*)
>  		# dereference source url relative to parent's url
> -		realrepo=$(resolve_relative_url "$repo") || exit
> +		realrepo=$(resolve_relative_url "$repo")
>  		;;

Did you test it? The command inside $(...) is run in its own sub-process,
therefore, the die() does not exit the caller, just the sub-process, and
the || exit *is* required.

BTW, I think that || exit is sufficient; you don't need to add another
error message - the one that resolve_relative_url() prints is sufficient.

-- Hannes
