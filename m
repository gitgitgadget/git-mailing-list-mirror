From: Steven Cole <elenstev@mesatop.com>
Subject: Re: cogito cg-update fails
Date: Mon, 2 May 2005 21:57:07 -0600
Message-ID: <200505022157.07800.elenstev@mesatop.com>
References: <1115090374.6030.50.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 05:55:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSoVU-0001zn-6z
	for gcvg-git@gmane.org; Tue, 03 May 2005 05:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVECEBu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 00:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVECEBu
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 00:01:50 -0400
Received: from nacho.zianet.com ([216.234.192.105]:14604 "HELO
	nacho.zianet.com") by vger.kernel.org with SMTP id S261362AbVECEBq
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 May 2005 00:01:46 -0400
Received: (qmail 42412 invoked from network); 3 May 2005 04:01:45 -0000
Received: from 216-31-65-216.zianet.com (216.31.65.216)
  by 0 with SMTP; 3 May 2005 04:01:45 -0000
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
User-Agent: KMail/1.6.1
In-Reply-To: <1115090374.6030.50.camel@gaston>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Monday 02 May 2005 09:19 pm, Benjamin Herrenschmidt wrote:
> Hi Folks !
> 
> I have something weird happening with cogito. What I did is:
> 
>  - d/l & install 0.8 archive
>  - cg-init <rync path>
>  - built & install that, removed 0.8 files
>  - a bit later: cg-update origin to check for new stuffs
> 
> The last one fails with:
> 
> benh@pogo:~/cogito$ cg-update origin
> MOTD:
> MOTD:   .../.. stripped kernel.org legal blurb
> 
> receiving file list ... done
> .git/refs/heads/origin
> 
> sent 119 bytes  received 857 bytes  390.40 bytes/sec
> total size is 41  speedup is 0.04
> rsync: link_stat "/home/benh/cogito/origin/objects/." failed: No such file or directory (2)
> building file list ... done
> rsync error: some files could not be transferred (code 23) at main.c(702)
> 
> sent 17 bytes  received 20 bytes  74.00 bytes/sec
> total size is 0  speedup is 0.00
> cg-pull: objects pull failed
> 
> So it looks like it's trying to rsync to a bogus destination ...
> 
> Ben.
> 

Yeah, I got exactly the same behavior a little while ago, but thanks
to www.kernel.org/git, I saw that the problem had been found and fixed.

I had an older backup copy of all the cogito scripts, so I used that to update.

I believe the fix is this patch:

===== cd7a12e5d569d59a04823114c275a83d65b9f37e vs 437167273f77c0d5f039280d158b43324a79f820 =====
--- a/cg-pull
+++ b/cg-pull
@@ -48,7 +48,7 @@ fetch_rsync () {
 }
 
 pull_rsync () {
-	fetch_rsync -s -u -d "$1/objects" ".git/objects"
+	fetch_rsync -s -u -d "$2/objects" ".git/objects"
 }
 
 
Hope this helps,
Steven
