From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH 2/2] Use ALLOC_GROW in builtin/push.c
Date: Sat, 31 Jul 2010 08:57:36 -0400
Message-ID: <fbf6f49fa7c1d6b265d6cf6cfa772ec133550389.1280580026.git.jaredhance@gmail.com>
References: <201007300021.34061.trast@student.ethz.ch>
 <cover.1280580026.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 14:57:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfBdN-0006Hc-3S
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 14:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386Ab0GaM5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jul 2010 08:57:44 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36839 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab0GaM5n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 08:57:43 -0400
Received: by qyk7 with SMTP id 7so4438996qyk.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 05:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GA3PYOMxkh3vQMXDhQ729cy7+zQd/UP1rdRpIeRz0IU=;
        b=HX4zheJL9RUbw6KL3leGb/0yjq61raZbuUxQDJYgabPs8VlNtsObL7xXsCtMN0qimS
         Jf2+ax1VsoC3wfEXEVEnp7aD0ZFNj9/t0FkAjHzbldDTOns4eud7HKTLkzlGdOGsB0Sa
         FTUsOTRXuzqfXDgab3CM0h/zhR4dRir4yuLFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NB4vdZ562pASw2TQoyMRMm2I9w+n9/3xK5x6RuOvyNFD8giy6FYpe+zqxeGjGuGEe7
         7cn/ND5aJifDqdMZ6vsK7BI6j+wNstxJATsoLV5D0WUY8biT4tEpXaO+AB/McZ/M5d4X
         gz5L+s2yeWVuUrEaLg0KsDFl5GNAXwHAwR13U=
Received: by 10.220.126.166 with SMTP id c38mr2159865vcs.52.1280581060119;
        Sat, 31 Jul 2010 05:57:40 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-101-209-27.cinci.res.rr.com [174.101.209.27])
        by mx.google.com with ESMTPS id e20sm1345592vcm.40.2010.07.31.05.57.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 05:57:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1280580026.git.jaredhance@gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152324>

The current implementation of add_refspec(const char *ref) duplicates
functionality found in the xalloc api. Use ALLOC_GROW instead to prevent
code duplication.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 builtin/push.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 79d8192..0da0ec8 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -22,11 +22,12 @@ static int progress;
 
 static const char **refspec;
 static int refspec_nr;
+static size_t refspec_alloc;
 
 static void add_refspec(const char *ref)
 {
 	refspec_nr++;
-	refspec = xrealloc(refspec, refspec_nr * sizeof(char *));
+	ALLOC_GROW(refspec, refspec_nr, refspec_alloc);
 	refspec[refspec_nr-1] = ref;
 }
 
-- 
1.7.2
