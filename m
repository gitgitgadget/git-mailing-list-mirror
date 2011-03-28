From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH svn-fe] vcs-svn: add missing cast to printf argument
Date: Sun, 27 Mar 2011 19:38:15 -0500
Message-ID: <20110328003815.GB11644@elie>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300751400-7427-1-git-send-email-david.barr@cordelta.com>
 <20110323003240.GA4949@elie>
 <7vsjuegzj8.fsf@alter.siamese.dyndns.org>
 <20110326064653.GC20529@elie>
 <7v1v1t4tkw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 02:38:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q40Td-0006id-0M
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 02:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464Ab1C1AiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2011 20:38:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39064 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab1C1AiU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2011 20:38:20 -0400
Received: by iwn34 with SMTP id 34so3098551iwn.19
        for <git@vger.kernel.org>; Sun, 27 Mar 2011 17:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=zDwyUnhMJbZHG5+6Tlrlv56YpSFtZvyj3KPVwtP+TZQ=;
        b=nizQxLvGgnWAxng78MVGMAZ5A/jxB+LThFqwf+SzA2XVJZHKaCd4TcT2i20Wy+F23t
         bsWaRUj4pRiG7zt+IgqGlR1ihQLeyY75Hm+6Aa4F27np5LwadjvJ2KebwHIv1O9D8cr6
         8kLvxLTdERL1/cAVAeDC88NALO+9K4VBTIi4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PAxe6XFydz/IqyxJxh63jlNlnho54iNElYq1GoE3dbrYnwjKR0xGxlO0ONl02MYUdc
         H7tg8mw9/6+ynl2X0mb4JGNJGDOC6Fi1n9p8jncviRjRu/FZj24dayIxXxNViLKyiBWJ
         Pqlwt9ke+Ll2vb6qx6GnA+JqEzldHCOOUMyzs=
Received: by 10.42.65.73 with SMTP id k9mr5316674ici.427.1301272699091;
        Sun, 27 Mar 2011 17:38:19 -0700 (PDT)
Received: from elie (adsl-68-255-101-206.dsl.chcgil.sbcglobal.net [68.255.101.206])
        by mx.google.com with ESMTPS id 19sm2551313ibx.52.2011.03.27.17.38.17
        (version=SSLv3 cipher=OTHER);
        Sun, 27 Mar 2011 17:38:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v1v1t4tkw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170095>

gcc -m32 correctly warns:

 vcs-svn/fast_export.c: In function 'fast_export_commit':
 vcs-svn/fast_export.c:54:2: warning: format '%llu' expects
   argument of type 'long long unsigned int', but argument 2
   has type 'unsigned int' [-Wformat]

Fix it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> Thanks.

Any time.  But clearly I can't be trusted. :/

 vcs-svn/fast_export.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 2e5bb67..99ed70b 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -51,7 +51,8 @@ void fast_export_commit(uint32_t revision, const char *author,
 		   *author ? author : "nobody",
 		   *author ? author : "nobody",
 		   *uuid ? uuid : "local", timestamp);
-	printf("data %"PRIuMAX"\n", log->len + strlen(gitsvnline));
+	printf("data %"PRIuMAX"\n",
+		(uintmax_t) (log->len + strlen(gitsvnline)));
 	fwrite(log->buf, log->len, 1, stdout);
 	printf("%s\n", gitsvnline);
 	if (!first_commit_done) {
-- 
1.7.4.2.660.g270d4b.dirty
