From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Improved submodule merge support
Date: Tue, 18 Dec 2007 20:21:56 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712182018190.23902@racer.site>
References: <20071218195028.GA25510@pvv.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 21:23:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4iyb-0001FG-0D
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 21:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739AbXLRUWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 15:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753490AbXLRUWR
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 15:22:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:37504 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754739AbXLRUWO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 15:22:14 -0500
Received: (qmail invoked by alias); 18 Dec 2007 20:22:12 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 18 Dec 2007 21:22:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18WunF3Y2sWGomEnniI8QypAERQlVadsgE2O7lUL3
	hOzjk6F3dGCOS+
X-X-Sender: gene099@racer.site
In-Reply-To: <20071218195028.GA25510@pvv.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68803>

Hi,

On Tue, 18 Dec 2007, Finn Arne Gangstad wrote:

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 2a58dad..33ccc40 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1463,10 +1467,13 @@ static int process_entry(const char *path, struct stage_data *entry,
>  		mfi = merge_file(&o, &a, &b,
>  				 branch1, branch2);
>  
> +		clean_merge = mfi.clean;
>  		if (mfi.clean)
>  			update_file(1, mfi.sha, mfi.mode, path);
> +		else if (S_ISGITLINK(mfi.mode))
> +			output(1, "CONFLICT (submodule): Merge conflict in %s "
> +			       "- needs %s", path, sha1_to_hex(b.sha1));
>  		else {
> -			clean_merge = 0;
>  			output(1, "CONFLICT (%s): Merge conflict in %s",
>  					reason, path);
>  

It took me a little while to find that the unilateral assignment to 
clean_merge does not break things.  But as it was only set to 1 at the 
beginning of the function, and no loops are involved, this change is 
correct.

Ciao,
Dscho
