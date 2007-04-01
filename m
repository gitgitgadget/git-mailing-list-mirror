From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-add has gone lstat() mad
Date: Sun, 1 Apr 2007 09:25:24 +0100
Message-ID: <200704010925.26590.andyparkins@gmail.com>
References: <200703302055.13619.andyparkins@gmail.com> <Pine.LNX.4.64.0703302020510.6730@woody.linux-foundation.org> <7vy7ld3p33.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 01 10:28:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXvQM-0005vM-12
	for gcvg-git@gmane.org; Sun, 01 Apr 2007 10:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbXDAI2T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Apr 2007 04:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbXDAI2T
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Apr 2007 04:28:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:54571 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932224AbXDAI2S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2007 04:28:18 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1242547uga
        for <git@vger.kernel.org>; Sun, 01 Apr 2007 01:28:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dwilKZPXBASUDojtdxgpbyHYk+B1w5U9YRh0HtX9mdvSOHd4V72sHmvqmWlQ/h5TMg1pPsANqF+Vwx3O4VfcMuKDQMKgEUyEX3v1JoP3nOn5dQZg4rf2XPQwRSe25kGSGBK+NkFaJPZd1tkfPSkVWAfVxuNooVQPUIIkPfgtm34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ir8JRkFp4hiT+vMB6NDOuQj2fpHwEH+p3KJHNxd+4lD0tWrUFrI0ZvwXaKOvicIKe+CA0P8DZgCsx6KGwBPhRkCAKkHXVFqR+4lXEYGvLzKDdZYCuJHfpX7/ThDLAgND07XQ/8265I7jjhga0yE3kPL5tgYGzI7FN00HILR13ds=
Received: by 10.67.115.11 with SMTP id s11mr3338398ugm.1175416096867;
        Sun, 01 Apr 2007 01:28:16 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 32sm5379224ugf.2007.04.01.01.28.15;
        Sun, 01 Apr 2007 01:28:16 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7vy7ld3p33.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43586>

On Sunday 2007, April 01, Junio C Hamano wrote:

> But I like this patch better.  We need to look at .gitignore to
> warn about adding ignored files, so we cannot just stuff what
> are found to dir without checking if they are ignored.

I needed the following needed on top of current pu:

diff --git a/unpack-trees.c b/unpack-trees.c
index fa36495..d4f7589 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -521,7 +521,7 @@ static void verify_clean_subdirectory(const char *path, const char *action,
 	memset(&d, 0, sizeof(d));
 	if (o->dir)
 		d.exclude_per_dir = o->dir->exclude_per_dir;
-	i = read_directory(&d, path, pathbuf, namelen+1);
+	i = read_directory(&d, path, pathbuf, namelen+1, NULL);
 	if (i)
 		die("Updating '%s' would lose untracked files in it",
 		    path);
