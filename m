From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH] git-p4: Fix checkout bug when using --import-local.
Date: Thu, 28 Aug 2008 09:29:06 +0200
Message-ID: <200808280929.07898.simon@lst.de>
References: <1219876572-24736-1-git-send-email-torarvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 09:30:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYbxT-0005Op-34
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 09:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962AbYH1H3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 03:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753112AbYH1H3O
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 03:29:14 -0400
Received: from hoat.troll.no ([62.70.27.150]:37631 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874AbYH1H3O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 03:29:14 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id AF314209F0;
	Thu, 28 Aug 2008 09:29:08 +0200 (CEST)
Received: from rhea.localnet (rhea.troll.no [10.3.4.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 9E22020792;
	Thu, 28 Aug 2008 09:29:08 +0200 (CEST)
User-Agent: KMail/1.10.0 (Linux/2.6.24-18-generic; KDE/4.1.0; x86_64; ; )
In-Reply-To: <1219876572-24736-1-git-send-email-torarvid@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 28 August 2008 00:36:12 Tor Arvid Lund wrote:
> When this option is passed to git p4 clone, the checkout at the end would
> previously fail. This patch fixes it by optionally creating the master
> branch from refs/heads/p4/master, which is the correct one for this option.
>
> Signed-off-by: Tor Arvid Lund <torarvid@gmail.com>

Good catch :)

Acked-By: Simon Hausmann <simon@lst.de>



Simon

>  contrib/fast-import/git-p4 |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 46136d4..c4b8b4c 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -1733,8 +1733,12 @@ class P4Clone(P4Sync):
>          if not P4Sync.run(self, depotPaths):
>              return False
>          if self.branch != "master":
> -            if gitBranchExists("refs/remotes/p4/master"):
> -                system("git branch master refs/remotes/p4/master")
> +            if self.importIntoRemotes:
> +                masterbranch = "refs/remotes/p4/master"
> +            else:
> +                masterbranch = "refs/heads/p4/master"
> +            if gitBranchExists(masterbranch):
> +                system("git branch master %s" % masterbranch)
>                  system("git checkout -f")
>              else:
>                  print "Could not detect main branch. No checkout/master
> branch created."
