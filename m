From: Alex Riesen <raa.lkml@gmail.com>
Subject: ls-files and read-tree need core.filemode
Date: Tue, 8 Nov 2005 09:23:37 +0100
Message-ID: <81b0412b0511080023k1384dc26j944e9a07987be436@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_468_26793567.1131438217496"
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Nov 08 09:24:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZOla-0003x1-7e
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 09:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVKHIXj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 03:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVKHIXj
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 03:23:39 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:9788 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932377AbVKHIXi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 03:23:38 -0500
Received: by nproxy.gmail.com with SMTP id q29so143746nfc
        for <git@vger.kernel.org>; Tue, 08 Nov 2005 00:23:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=FqKyyFWM7+oQCMIGE2iz63PvVIiQ+GCdJ1gvHnibU4Lvvx2a0Oy6oVvU9hsKYN7292beMdAXvQASawjBwGYN6Awi4/XLQ8lX5IluzlB+hgh9vhwE8IUNoMg7DfseeZUovfzwJMoAfmL9wzaqjgUInU6oeXsDrxku4wOvjUmbhJo=
Received: by 10.48.226.12 with SMTP id y12mr1824357nfg;
        Tue, 08 Nov 2005 00:23:37 -0800 (PST)
Received: by 10.48.247.3 with HTTP; Tue, 8 Nov 2005 00:23:37 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11315>

------=_Part_468_26793567.1131438217496
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

ls-files.c and read-tree.c miss the default configuration, in
particular the filemode=3Dfalse part.
The recent +x bit flip made me notice that, because git-merge refused
to merge anything saying that git-pull.sh is not up to date.

As usual, sorry for attachments.

------=_Part_468_26793567.1131438217496
Content-Type: application/xxxxx; name=ls-files-filemode.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ls-files-filemode.patch"


    ls-files needs default config to ignore filemode on cygwin

diff --git a/ls-files.c b/ls-files.c
--- a/ls-files.c
+++ b/ls-files.c
@@ -569,10 +569,11 @@ int main(int argc, const char **argv)
 	argv0 = *argv;
 
 	prefix = setup_git_directory();
 	if (prefix)
 		prefix_offset = strlen(prefix);
+	git_config(git_default_config);
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
 		if (!strcmp(arg, "--")) {

------=_Part_468_26793567.1131438217496
Content-Type: application/xxxxx; name=read-tree-filemode.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="read-tree-filemode.patch"


    read-tree needs default config to ignore filemode on cygwin

diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -632,10 +632,12 @@ int main(int argc, char **argv)
 
 	newfd = hold_index_file_for_update(&cache_file, get_index_file());
 	if (newfd < 0)
 		die("unable to create new cachefile");
 
+	git_config(git_default_config);
+
 	merge = 0;
 	reset = 0;
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 

------=_Part_468_26793567.1131438217496--
