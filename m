From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] checkout, commit: remove confusing assignments to
 rev.abbrev
Date: Tue, 27 Jul 2010 13:37:07 -0500
Message-ID: <20100727183706.GD5578@burratino>
References: <19531.65276.394443.190317@winooski.ccs.neu.edu>
 <20100725130935.GA22083@LK-Perkele-V2.elisa-laajakaista.fi>
 <20100725221539.GA21813@burratino>
 <7vbp9uaii2.fsf@alter.siamese.dyndns.org>
 <20100726190448.GA32367@burratino>
 <7vzkxc7rpn.fsf@alter.siamese.dyndns.org>
 <20100727182942.GB5578@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org,
	Will Palmer <wmpalmer@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 20:38:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odp2p-0005EZ-I1
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 20:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470Ab0G0SiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 14:38:22 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46727 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388Ab0G0SiV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 14:38:21 -0400
Received: by wyf19 with SMTP id 19so3372421wyf.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 11:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=e7QXuFXzRSBKktIGckgonRKshJ26CvkPvXi4eF+XZqE=;
        b=v25jF6QA1AgwqO9mLbOM1MkKjfEmS8Qox7xZdt0NjwFwr1xl84MI0NyhRQ2HZjnkoC
         +sA/fYdMBpuUmcFVZAPyPmJYaRoJXppjIReYrawoLfRv4jKL58j5wVYXjc+rNIrA8LSd
         7bzyx+ay1yLKKNAr21nxUk687D+hafTK2CkrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tfLxpLRuvUG3p+5rvSIobqxUkMutDeh4yzhFMfEigs/uJHozcbb6/wXMBBkxcvMxRO
         HU35eGmbawTGbwPdmRMhFugFskEHzrRzKRvDjjj1VhbddKIXxHE7J3HiPFisBx8JnG/h
         uONr5VbaDXPioNgGIgNtZOTZ1VQP4iYws3Djo=
Received: by 10.227.127.82 with SMTP id f18mr9218538wbs.185.1280255899479;
        Tue, 27 Jul 2010 11:38:19 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id a1sm4483107wbb.20.2010.07.27.11.38.14
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 11:38:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100727182942.GB5578@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151971>

Since they do not precede setup_revisions, these assignments of 0 to
rev.abbrev have no effect.

v1.7.1.1~17^2~3 (2010-05-03) taught the log --format=%h machinery
to respect --abbrev instead of always abbreviating, so we have to pay
attention to the abbrev setting now.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/checkout.c |    1 -
 builtin/commit.c   |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1994be9..eef2b48 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -279,7 +279,6 @@ static void show_local_changes(struct object *head)
 	struct rev_info rev;
 	/* I think we want full paths, even if we're in a subdirectory. */
 	init_revisions(&rev, NULL);
-	rev.abbrev = 0;
 	rev.diffopt.output_format |= DIFF_FORMAT_NAME_STATUS;
 	if (diff_setup_done(&rev.diffopt) < 0)
 		die("diff_setup_done failed");
diff --git a/builtin/commit.c b/builtin/commit.c
index a78dbd8..279cfc1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1163,7 +1163,6 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	init_revisions(&rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
 
-	rev.abbrev = 0;
 	rev.diff = 1;
 	rev.diffopt.output_format =
 		DIFF_FORMAT_SHORTSTAT | DIFF_FORMAT_SUMMARY;
-- 
1.7.2.21.g04ff
