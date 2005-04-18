From: Steven Cole <elenstev@mesatop.com>
Subject: Re: [PATCH] Add help details to git help command.
Date: Mon, 18 Apr 2005 10:59:46 -0600
Message-ID: <4263E782.6040608@mesatop.com>
References: <200504172242.26326.elenstev@mesatop.com> <20050418102412.GJ1461@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 18:57:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNZXS-0001vi-2l
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 18:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVDRQ7z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 12:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVDRQ7y
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 12:59:54 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:28054 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262131AbVDRQ7u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 12:59:50 -0400
Received: from w-mail.lanl.gov (w-mail.lanl.gov [128.165.4.47])
	by mailwasher-b.lanl.gov (8.12.11/8.12.11/(ccn-5)) with ESMTP id j3IGxmFm026983
	for <git@vger.kernel.org>; Mon, 18 Apr 2005 10:59:49 -0600
Received: from [128.165.67.197] (spc7.esa.lanl.gov [128.165.67.197])
	by w-mail.lanl.gov (8.12.11/8.12.11/(ccn-5)) with ESMTP id j3IGxki7013739;
	Mon, 18 Apr 2005 10:59:47 -0600
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050418102412.GJ1461@pasky.ji.cz>
X-PMX-Version: 4.7.0.111621
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> Dear diary, on Mon, Apr 18, 2005 at 06:42:26AM CEST, I got a letter
> where Steven Cole <elenstev@mesatop.com> told me that...
[snippage]
> 
>>This patch will provide the comment lines in the shell script associated
>>with the command, cleaned up a bit for presentation.
>>
>>BUGS: This will also print any comments in the entire file, which may
>>not be desired.  If a command name and shell script filename
>>do not follow the usual convention, this won't work, e.g. ci for commit.
> 
> 
> Hey, those BUGS are the only slightly non-trivial thing on the whole
> thing! I could do this patch myself... ;-) Also, you don't want to print
> the first newline and the Copyright notices.
> 

Fixed extra vertical whitespace, Copyright notice problems, and issue
with git help ci.

Here's a better version.  Didn't fix the more interesting bugs, as I'm
pressed for time (aren't we all).  Perhaps someone can polish this up.

Anyway, I think it's pretty useful in its present form.

Thanks,
Steven

---------

This patch will provide the comment lines in the shell script associated
with the command, cleaned up a bit for presentation.

BUGS: This will also print any comments in the entire file, which may
not be desired.  If a command name and shell script filename
do not follow the usual convention, this won't work.

git: b648169640025bd68d1b27a0fcc85b65d85e4440
--- git
+++ git	2005-04-18 10:34:17.000000000 -0600
@@ -19,6 +19,11 @@


  help () {
+
+command=$1
+scriptfile=git$command.sh
+
+if [ ! $command ]; then
  	cat <<__END__
  The GIT scripted toolkit  $(gitversion.sh)

@@ -48,7 +53,10 @@
  	track		[RNAME]
  	version

+Additional help is available with: git help COMMAND
+
  Note that these expressions can be used interchangably as "ID"s:
+
  	empty string (current HEAD)
  	local (the local branch if tracking a remote one)
  	remote name (as registered with git addremote)
@@ -57,6 +65,14 @@
  	commit object hash (as returned by commit-id)
  	tree object hash (accepted only by some commands)
  __END__
+fi
+if [ $scriptfile = "gitci.sh" ]; then
+	scriptfile="gitcommit.sh"
+fi
+if [ ! $scriptfile = "git.sh" ]; then
+	grep ^# $scriptfile | grep -v "!/bin" | grep -v "(c)" \
+	| cut -c 2- | grep ^.
+fi
  }



