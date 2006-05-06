From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config: if mtime (or size) of the config file changed
 since last read, reread it
Date: Sun, 7 May 2006 01:45:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605070144530.7578@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0605070125010.6597@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun May 07 01:45:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcWSm-0002g0-DE
	for gcvg-git@gmane.org; Sun, 07 May 2006 01:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWEFXpY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 19:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWEFXpY
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 19:45:24 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:30177 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750940AbWEFXpX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 19:45:23 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 6E5D11EB5
	for <git@vger.kernel.org>; Sun,  7 May 2006 01:45:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 6330D1E3D
	for <git@vger.kernel.org>; Sun,  7 May 2006 01:45:22 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 474781E02
	for <git@vger.kernel.org>; Sun,  7 May 2006 01:45:22 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0605070125010.6597@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19684>

Hi,

sorry: bad patch. This is needed on top.

diff --git a/config.c b/config.c
index 6765186..452b587 100644
--- a/config.c
+++ b/config.c
@@ -261,6 +261,10 @@ int git_config_from_file(config_fn_t fn,
 	config_offset = 0;
 
 	in_fd = open(filename, O_RDONLY);
+	if (in_fd < 0 && ENOENT != errno )
+		die("opening %s: %s", config_file_name,
+				strerror(errno));
+
 	fstat(in_fd, &st);
 
 	if (contents) {
@@ -288,9 +292,6 @@ int git_config_from_file(config_fn_t fn,
 	} else {
 		contents = NULL;
 		config_length = 0;
-		if (in_fd < 0 && ENOENT != errno )
-			die("opening %s: %s", config_file_name,
-					strerror(errno));
 	}
 
 	return ret;
