From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/6] match-trees: kill off remaining -Wuninitialized warning
Date: Wed, 16 Mar 2011 06:36:29 -0500
Message-ID: <20110316113629.GC15739@elie>
References: <20110316024959.GA24932@elie>
 <7vfwqnabbi.fsf@alter.siamese.dyndns.org>
 <4D807E66.40504@viscovery.net>
 <20110316094639.GA8180@elie>
 <4D8088C1.5050901@viscovery.net>
 <20110316105709.GC8277@elie>
 <20110316113540.GB15739@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 12:36:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzp1s-00018D-4J
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 12:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708Ab1CPLgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 07:36:35 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49126 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab1CPLge (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 07:36:34 -0400
Received: by gxk21 with SMTP id 21so610604gxk.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 04:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OO4/JenVMN5WDmpmTr+HYMDCDCuwYsnNq1reso5fSu4=;
        b=BdVjbwgr868t3ue6nJhRvGMObsxUiQAtRHKoz0XJPJrpiCU/FBapbHbr3AMDEEJUpw
         3bGa2CD9qxEO7kpIf67dIrjSJHb1hljMOzGaL6cJ4zBkFjSPI8Pa40dmidYVaMjbnVTK
         WPEEfiRkgP+YktYfkpV5H1YpIVPEW5W0Huje8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gK6cppIZoTLFZo2BVQfwujl/E2bKHzdUUrVDWjlVBGBA5cLe/aBqR/YowJ1/pUWvI/
         ELHZ008vk+uS4II4BAmRtxroj6dEok7DEzBXO9RXWEe6cd6CJX3gQtwoTJnnuwKP37wp
         3bOb7PTDZ0LKI9FnB2iKeKVwYQLEG2zqZSoOs=
Received: by 10.90.138.5 with SMTP id l5mr1210892agd.137.1300275393546;
        Wed, 16 Mar 2011 04:36:33 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id w4sm1131766anw.36.2011.03.16.04.36.32
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 04:36:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316113540.GB15739@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169142>

Initialize to an invalid value (0, in this case) so we can still
catch bugs as the code evolves.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 match-trees.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index 9cfcc8b..f325ff5 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -6,6 +6,7 @@ static int score_missing(unsigned mode, const char *path)
 {
 	int score;
 
+	assert(mode);
 	if (S_ISDIR(mode))
 		score = -1000;
 	else if (S_ISLNK(mode))
@@ -19,6 +20,7 @@ static int score_differs(unsigned mode1, unsigned mode2, const char *path)
 {
 	int score;
 
+	assert(mode1 && mode2);
 	if (S_ISDIR(mode1) != S_ISDIR(mode2))
 		score = -100;
 	else if (S_ISLNK(mode1) != S_ISLNK(mode2))
@@ -32,6 +34,8 @@ static int score_matches(unsigned mode1, unsigned mode2, const char *path)
 {
 	int score;
 
+	assert(mode1 && mode2);
+
 	/* Heh, we found SHA-1 collisions between different kind of objects */
 	if (S_ISDIR(mode1) != S_ISDIR(mode2))
 		score = -100;
@@ -76,8 +80,7 @@ static int score_trees(const unsigned char *hash1, const unsigned char *hash2)
 		const unsigned char *elem2;
 		const char *path1;
 		const char *path2;
-		unsigned mode1;
-		unsigned mode2;
+		unsigned mode1 = 0, mode2 = 0;
 		int cmp;
 
 		if (one.size)
-- 
1.7.4.1
