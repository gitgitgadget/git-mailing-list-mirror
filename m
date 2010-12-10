From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/10] vcs-svn: use higher mark numbers for blobs
Date: Fri, 10 Dec 2010 04:21:35 -0600
Message-ID: <20101210102135.GA26331@burratino>
References: <20101210102007.GA26298@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 10 11:22:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR06y-0002BB-O1
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 11:22:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508Ab0LJKVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 05:21:55 -0500
Received: from mail-gw0-f42.google.com ([74.125.83.42]:39632 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530Ab0LJKVy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 05:21:54 -0500
Received: by gwb20 with SMTP id 20so2883764gwb.1
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 02:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZumsJTtqjK/BXAfdT5GeLinXTnr4TNEnbY52UVHrO8s=;
        b=NxapDM5e6PP1p4pEiu+cWc0dNrV86NOy5GFm8hMrZGhTFNm5pYvqJL8XFEdxWuAIrX
         9rtj3eMkeLNv1ZQ28WJZq/sbh9Gx+yGN2uHJeXTCOmHfgIzZ1wByNWO+901dtjgpv0SQ
         J05kXL5kaSyte/iN1mzWxRuKg6R3ek7lR5NAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AMLnInmloLcEwjC1FYJoOg1i5jCG9dXItWEx409aQKLTuiIFVGuudKQgdsatJRkdf2
         LnIP7SJRVRDKaKBjIVeH5MNrdVEq99hWFhvy6vCuN8qVzd8QxT3ARtak6NGK2uh2nvPW
         7I2YROu8Xk4kLFFVAn7pxt3dfuyb1+FzG9RXw=
Received: by 10.42.220.136 with SMTP id hy8mr323038icb.380.1291976513262;
        Fri, 10 Dec 2010 02:21:53 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.ameritech.net [69.209.58.175])
        by mx.google.com with ESMTPS id gy41sm2499692ibb.11.2010.12.10.02.21.51
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 02:21:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101210102007.GA26298@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163396>

Prepare to use mark :5 for the commit corresponding to r5 (and so on).

1 billion seems sufficiently high for blob marks to avoid conflicting
with rev marks, while still leaving room for 3 billion blobs.  Such
high mark numbers cause trouble with ancient fast-import versions, but
this topic cannot support git fast-import versions before 1.7.4 (which
introduces the cat-blob command) anyway.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/repo_tree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index eb55636..a4d8340 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -298,7 +298,7 @@ void repo_commit(uint32_t revision, uint32_t author, char *log, uint32_t uuid,
 static void mark_init(void)
 {
 	uint32_t i;
-	mark = 0;
+	mark = 1024 * 1024 * 1024;
 	for (i = 0; i < dent_pool.size; i++)
 		if (!repo_dirent_is_dir(dent_pointer(i)) &&
 		    dent_pointer(i)->content_offset > mark)
-- 
1.7.2.4
