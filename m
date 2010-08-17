From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/24] t7600 (merge): check reflog entry
Date: Tue, 17 Aug 2010 01:56:13 -0500
Message-ID: <20100817065613.GD22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 08:57:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlG7O-0006TU-4a
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 08:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756437Ab0HQG5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 02:57:49 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42918 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756402Ab0HQG5t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 02:57:49 -0400
Received: by gyg10 with SMTP id 10so2247403gyg.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 23:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rCaZ1jJjhl3AJUfwgrddeWkiAHX+f895EEKCZa8XM44=;
        b=LUuc/PXOPdmXya6RrZqkWuQAyrxSsEnREAKFuAckbMzKizvrd5c62IHvgtzG17Y8hv
         dVBl4/N5X1TClCTMpFMc0JHHQvpoUnNh3bgyZoqapbORneaMQ1w69XQlHmgwa3tFhxkR
         GGU3D7UFf1e8yNYgjZ+f91Ym+ue+/k43ZX0JY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eIqwZgOqdU2F//6nmnTmm4kuAcsc8EgrXnIspL3l2ayPODadhmfkyqnDGrJ+EYpTAr
         OYVRaJWWfw9fvWfKtEOp3totolZ6X8IeGrqTPxwhGUr/yQt7EvS9rlPbAQl90pMf82mt
         gujuZdWphVl4oKneeP3anUsaix1iyMn3xfGIU=
Received: by 10.100.165.12 with SMTP id n12mr7071081ane.23.1282028268364;
        Mon, 16 Aug 2010 23:57:48 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u14sm11747491ann.20.2010.08.16.23.57.47
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 23:57:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153707>

The details of the reflog message are not important, but
including something sane in the reflog is.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7600-merge.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 64a4265..6e839a6 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -149,10 +149,16 @@ test_expect_success 'reject non-strategy with a git-merge-foo name' '
 '
 
 test_expect_success 'merge c0 with c1' '
+	echo "OBJID HEAD@{0}: merge c1: Fast-forward" >reflog.expected &&
+
 	git reset --hard c0 &&
 	git merge c1 &&
 	verify_merge file result.1 &&
-	verify_head "$c1"
+	verify_head "$c1" &&
+
+	git reflog -1 >reflog.actual &&
+	sed "s/$_x05[0-9a-f]*/OBJID/g" reflog.actual >reflog.fuzzy &&
+	test_cmp reflog.expected reflog.fuzzy
 '
 
 test_debug 'git log --graph --decorate --oneline --all'
-- 
1.7.2.1.544.ga752d.dirty
