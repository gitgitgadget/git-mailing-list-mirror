From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config: mmap() the contents of the config file
Date: Sun, 7 May 2006 13:40:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605071339320.2528@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0605070103270.26358@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun May 07 13:40:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FchdC-0004nC-BW
	for gcvg-git@gmane.org; Sun, 07 May 2006 13:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWEGLky (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 07:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWEGLky
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 07:40:54 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:32404 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932131AbWEGLky (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 07:40:54 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 1D5572011;
	Sun,  7 May 2006 13:40:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 122741FBD;
	Sun,  7 May 2006 13:40:53 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id E98E81C6A;
	Sun,  7 May 2006 13:40:52 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
In-Reply-To: <Pine.LNX.4.63.0605070103270.26358@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19701>

Hi,

On Sun, 7 May 2006, Johannes Schindelin wrote:

> This makes it possible to rewrite the config without accessing the config
> file twice.

Since commit c2b9e699, this is needed, too:

diff --git a/config.c b/config.c
index 59006fa..30effe3 100644
--- a/config.c
+++ b/config.c
@@ -362,7 +362,7 @@ static int store_aux(const char* key, co
 		} else if (strrchr(key, '.') - key == store.baselen &&
 			      !strncmp(key, store.key, store.baselen)) {
 					store.state = SECTION_SEEN;
-					store.offset[store.seen] = ftell(config_file);
+					store.offset[store.seen] = config_offset;
 		}
 	}
 	return 0;
-- 
1.3.2.g4e38b-dirty
