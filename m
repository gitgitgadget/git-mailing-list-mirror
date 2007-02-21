From: Bart Trojanowski <bart@jukie.net>
Subject: Re: [PATCH 1.5.0.1.37] fix git-remote inconsistent about use of dots in remote names
Date: Wed, 21 Feb 2007 03:54:22 -0500
Message-ID: <20070221085422.GF23952@jukie.net>
References: <20070221083042.GE23952@jukie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 21 09:54:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJnF6-0002XE-Aq
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 09:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161133AbXBUIyZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 03:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161139AbXBUIyZ
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 03:54:25 -0500
Received: from bart.ott.istop.com ([66.11.172.99]:38399 "EHLO jukie.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161136AbXBUIyY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Feb 2007 03:54:24 -0500
Received: from tau.jukie.net ([10.10.10.211]:47509)
	by jukie.net with esmtp (Exim 4.50)
	id 1HJnF1-0007Tl-Bh
	for git@vger.kernel.org; Wed, 21 Feb 2007 03:54:23 -0500
Received: by tau.jukie.net (Postfix, from userid 1000)
	id 3B70EA74E90; Wed, 21 Feb 2007 03:54:22 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070221083042.GE23952@jukie.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40289>

After testing some more I noticed that I broke git-remote show.

> --- a/git-remote.perl
> +++ b/git-remote.perl
> @@ -67,7 +67,7 @@ sub list_remote {
>  		$git->command(qw(config --get-regexp), '^remote\.');
>  	};
>  	for (@remotes) {
> -		if (/^remote\.([^.]*)\.(\S*)\s+(.*)$/) {
> +		if (/^remote\.(.+)\.url\s+(.*)$/) {

The patch bellow seems to be better.

-Bart

>From 9cb44ff2d1d395491cde8c3d5787b35c93c4ad12 Mon Sep 17 00:00:00 2001
From: Bart Trojanowski <bart@jukie.net>
Date: Wed, 21 Feb 2007 03:54:17 -0500
Subject: [PATCH] allow git-remote to parse out names with periods in them

Signed-off-by: Bart Trojanowski <bart@jukie.net>
---
 git-remote.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index 6e473ec..6087a9d 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -67,7 +67,7 @@ sub list_remote {
 		$git->command(qw(config --get-regexp), '^remote\.');
 	};
 	for (@remotes) {
-		if (/^remote\.([^.]*)\.(\S*)\s+(.*)$/) {
+		if (/^remote\.(.+)\.([^.]+)\s+(.*)$/) {
 			add_remote_config(\%seen, $1, $2, $3);
 		}
 	}
-- 
1.5.0.1.37.g1e592-dirty
