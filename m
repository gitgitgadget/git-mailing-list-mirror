From: Petr Baudis <pasky@ucw.cz>
Subject: Broken adding of cache entries
Date: Sat, 7 May 2005 17:28:50 +0200
Message-ID: <20050507152849.GD9495@pasky.ji.cz>
References: <1115408460.32065.37.camel@localhost.localdomain> <20050506231447.GG32629@pasky.ji.cz> <1115421933.32065.111.camel@localhost.localdomain> <20050506233003.GJ32629@pasky.ji.cz> <1115423450.32065.138.camel@localhost.localdomain> <20050507001409.GP32629@pasky.ji.cz> <1115431767.32065.182.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sat May 07 17:22:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUR8A-00023v-37
	for gcvg-git@gmane.org; Sat, 07 May 2005 17:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVEGP26 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 11:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVEGP26
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 11:28:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63422 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261333AbVEGP24 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 May 2005 11:28:56 -0400
Received: (qmail 24528 invoked by uid 2001); 7 May 2005 15:28:50 -0000
To: Kay Sievers <kay.sievers@vrfy.org>
Content-Disposition: inline
In-Reply-To: <1115431767.32065.182.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 07, 2005 at 04:09:27AM CEST, I got a letter
where Kay Sievers <kay.sievers@vrfy.org> told me that...
..snip..
> Look what funny thing you can do:
>   kay@mam:~/public_html/pub/scm/funny-tree$ git-ls-tree HEAD
>   100644  blob    b1a17ba136936531b72571844a773fe938b85ad4        entry
>   040000  tree    eba6ba02f18176500019755ad58c0bdfead16c47        entry
> 
> Add a file to the cache, replace it with a directory, add that to the
> cache and then write the tree and you have two entries with the same
> name. :)

Duh. Well, what could be the reasonwhy cache_name_compare() cares about
flags at all? Can you _ever_ have two same-named entries? Junio, what do
you think about something like this?

Index: read-cache.c
===================================================================
--- e47e2a558a85b33e0652233f78aa1ca8a959685b/read-cache.c  (mode:100644)
+++ uncommitted/read-cache.c  (mode:100644)
@@ -68,10 +68,6 @@
 		return -1;
 	if (len1 > len2)
 		return 1;
-	if (flags1 < flags2)
-		return -1;
-	if (flags1 > flags2)
-		return 1;
 	return 0;
 }
 


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
