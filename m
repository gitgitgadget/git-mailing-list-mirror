From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/12] vcs-svn: save marks for imported commits
Date: Sun, 6 Mar 2011 17:04:23 -0600
Message-ID: <20110306230423.GD24327@elie>
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
X-From: git-owner@vger.kernel.org Mon Mar 07 00:04:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwN05-0006Ev-UU
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 00:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987Ab1CFXEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 18:04:30 -0500
Received: from mail-gw0-f51.google.com ([74.125.83.51]:42907 "EHLO
	mail-gw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab1CFXE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 18:04:29 -0500
Received: by gwb15 with SMTP id 15so2201664gwb.10
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 15:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Sz+kTCP9DCqDYr0nPu4QlKK6kuPwFoapCb+wcJcnIio=;
        b=wbVdPHRQK1Ht/Gs8sbUq/sY8B3iN9H6qHXck94xwkQ43vMrmeaeKxmL6WLglGEmv06
         S37xKvRoNYGH8gL7v/IDlFxKnvMir7rkC12lYkDZyqb+xzpwdIM6IE6rxurNw9ytYcrz
         C5SiZCmdonE50VLhQK7SIMKRuCzSpu3xIvLoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uugy487SlxtBuklgYgr67aWHITsiT1xHBIo7EXvougFKgwRKtZ/XSAubnCdHGrZnAi
         dRcXAGZakW/sQSpu8usmkaY0+AJYsv4e2dLGhQu+/XQhyMdI0Rexo7j3rj3S6aSH23Cv
         5ugvTVXWEk9zXVZr9GtxTbQUCUQ05Fw9s+6Dw=
Received: by 10.150.149.34 with SMTP id w34mr3636252ybd.309.1299452668515;
        Sun, 06 Mar 2011 15:04:28 -0800 (PST)
Received: from elie (adsl-69-209-66-207.dsl.chcgil.ameritech.net [69.209.66.207])
        by mx.google.com with ESMTPS id w15sm1245759ybk.13.2011.03.06.15.04.26
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 15:04:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110306225419.GA24327@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168549>

Date: Thu, 9 Dec 2010 18:57:13 -0600

This way, a person can use

	svnadmin dump $path |
	svn-fe |
	git fast-import --relative-marks --export-marks=svn-revs

to get a list of what commit corresponds to each svn revision (plus
some irrelevant blob names) in .git/info/fast-import/svn-revs.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
From David's tree.

 vcs-svn/fast_export.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 260cf50..932824a 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -45,6 +45,7 @@ void fast_export_commit(uint32_t revision, uint32_t author, char *log,
 		*gitsvnline = '\0';
 	}
 	printf("commit refs/heads/master\n");
+	printf("mark :%"PRIu32"\n", revision);
 	printf("committer %s <%s@%s> %ld +0000\n",
 		   ~author ? pool_fetch(author) : "nobody",
 		   ~author ? pool_fetch(author) : "nobody",
-- 
1.7.4.1
