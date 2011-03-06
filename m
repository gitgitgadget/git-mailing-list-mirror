From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/12] vcs-svn: use higher mark numbers for blobs
Date: Sun, 6 Mar 2011 17:03:48 -0600
Message-ID: <20110306230348.GC24327@elie>
References: <20101210102007.GA26298@burratino>
 <20110306225419.GA24327@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 00:04:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwMzX-00063t-TP
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 00:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448Ab1CFXDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 18:03:55 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49740 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab1CFXDy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 18:03:54 -0500
Received: by ywj3 with SMTP id 3so1415557ywj.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 15:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=uwzfTxTomM2oxnoDqURCNonUUYWDqzd7IarykumkNF8=;
        b=oLPO7fzGlHnyTX1xZIVYmXferGT2xUtFquxMBl4IUo9QqkgYaj0JjrbWUR+uXb99Fp
         s0snChl7/5AQgxSjtjLo3wbO8F6G/wyTNuQCgfa51DVWn+IoxCPG9oJ2pgSEU0CVsQ6O
         LERiA5vo68fIg79ZtzLmOZbOEyqGIbuwSgHoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AZr/8GvaksLdFVJg7tvNSJmzmVo8pJSrqyl5fYRZyj6iDjy2upW/WbM7arKAbU8gJW
         IvCdHhWAE8dlx57WD8NqR4UZ6MpsRI+mw8dvVfTBtQ2YMD9wyvjwRsbsWdSnUhY7NatX
         3huD454UMCMZV1Wl7+oLvT62AsJznSU1opWVA=
Received: by 10.101.179.7 with SMTP id g7mr1035081anp.264.1299452633656;
        Sun, 06 Mar 2011 15:03:53 -0800 (PST)
Received: from elie (adsl-69-209-66-207.dsl.chcgil.sbcglobal.net [69.209.66.207])
        by mx.google.com with ESMTPS id c28sm2875774ana.1.2011.03.06.15.03.51
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 15:03:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110306225419.GA24327@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168548>

Date: Fri, 10 Dec 2010 04:21:35 -0600

Prepare to use mark :5 for the commit corresponding to r5 (and so on).

1 billion seems sufficiently high for blob marks to avoid conflicting
with rev marks, while still leaving room for 3 billion blobs.  Such
high mark numbers cause trouble with ancient fast-import versions, but
this topic cannot support git fast-import versions before 1.7.4 (which
introduces the cat-blob command) anyway.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Unchanged except for a tiny tweak in the working of the change
description.

 vcs-svn/repo_tree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index 491f013..093c5ff 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -289,7 +289,7 @@ void repo_commit(uint32_t revision, uint32_t author, char *log, uint32_t uuid,
 static void mark_init(void)
 {
 	uint32_t i;
-	mark = 0;
+	mark = 1024 * 1024 * 1024;
 	for (i = 0; i < dent_pool.size; i++)
 		if (!repo_dirent_is_dir(dent_pointer(i)) &&
 		    dent_pointer(i)->content_offset > mark)
-- 
1.7.4.1
