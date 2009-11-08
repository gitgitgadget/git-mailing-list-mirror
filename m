From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Show usage string for 'git http-push -h'
Date: Sun, 8 Nov 2009 01:26:04 -0600
Message-ID: <20091108072604.GA21367@progeny.tock>
References: <20080125173149.GA10287@edna.gwendoline.at>
 <20091108071152.GA20741@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 08 08:16:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N720g-0000JT-IT
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 08:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbZKHHQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 02:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbZKHHQP
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 02:16:15 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:47809 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbZKHHQO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 02:16:14 -0500
Received: by yxe17 with SMTP id 17so1892162yxe.33
        for <git@vger.kernel.org>; Sat, 07 Nov 2009 23:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9QBsB6xUladrGeQ8hOgLGpMuPwDYgh+9eqhgXMftUt4=;
        b=Ser/Ge95/6UVYZeinrZ0A2E1RJCV/Z9E34NUAmnhixwD6i9CZ1h3bYgSpzr9rLcEvD
         ahK/X24X1ypUVD3ZU7uqyqm7Ys1hRF84K+GIjiZucODxtWb1QrG5MCQvP9R00zLUE0m+
         xZDEf2Vmp45h+HTV1kH6oriK5OLK6G4sGb98E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rjb8zlpxzND0j9/E4qxAjlRtB5jce1pZTw/h+K/K4bxavvwJ9O8nU3b6nEdbpsGKXE
         cPJ7Gu/wYlOsbeM/COa9LEcQbRBBrd5aBcUG9o6C3ozxQuxUEFxV1bosgw2mx0ZKioNC
         ajIBfcPJQE5mOSI/YlV64HZnNvJFnavDwxzNc=
Received: by 10.151.25.21 with SMTP id c21mr10992312ybj.23.1257664579761;
        Sat, 07 Nov 2009 23:16:19 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm855752gxk.12.2009.11.07.23.16.18
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 07 Nov 2009 23:16:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091108071152.GA20741@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132387>

git http-push already knows how to dump usage if it is given no
options, but it interprets '-h' as the URL to a remote repository:

$ git http-push -h
error: Cannot access URL -h/, return code 6

Dump usage on -h, instead.  Humans wanting to pass the URL -h/ to
curl for some reason can use 'git http-push -h/' explicitly.
Scripts expecting to access an HTTP repository at URL '-h' will
break, though.

Cc: Tay Ray Chuan <rctay89@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:
> Some commands
> do not show usage with '-h' and have been left unchanged.

Like this one.  Full list of non-builtin commands in C like this:
http-push, fast-import, imap-send, remote-curl, show-index.

 http-push.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/http-push.c b/http-push.c
index 00e83dc..2e0782a 100644
--- a/http-push.c
+++ b/http-push.c
@@ -13,8 +13,8 @@
 
 #include <expat.h>
 
-static const char http_push_usage[] =
-"git http-push [--all] [--dry-run] [--force] [--verbose] <remote> [<head>...]\n";
+static const char http_push_usage[] = "git http-push "
+"[-h] [--all] [--dry-run] [--force] [--verbose] <remote> [<head>...]\n";
 
 #ifndef XML_STATUS_OK
 enum XML_Status {
@@ -1792,6 +1792,11 @@ int main(int argc, char **argv)
 
 	git_extract_argv0_path(argv[0]);
 
+	if (argc == 2 && !strcmp(argv[1], "-h")) {
+		fprintf(stderr, "usage: %s\n", http_push_usage);
+		return 0;
+	}
+
 	setup_git_directory();
 
 	repo = xcalloc(sizeof(*repo), 1);
-- 
1.6.5.2
