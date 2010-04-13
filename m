From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 8/9] builtin: check pager.<cmd> configuration if
 RUN_SETUP_GENTLY is used
Date: Mon, 12 Apr 2010 21:30:03 -0500
Message-ID: <20100413023003.GH4118@progeny.tock>
References: <20100413021153.GA3978@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 13 04:30:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1VtF-0000A6-Cx
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 04:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651Ab0DMCaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 22:30:07 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39701 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754608Ab0DMCaD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 22:30:03 -0400
Received: by pva18 with SMTP id 18so3544439pva.19
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 19:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZQQs50Ha8eImLwSUXiY3BpBQHeKCIH4epkYqZ1E5q28=;
        b=pZlS2TdIrLWnAAq/T8WdG4jbHbItGqnHhXG13N6EFxhXoGLZlUPeRIwKj5bWWsIewO
         QtuHkigXoTO/LMLNRHNhWAsRR8WVkoV/xno8KmKse7o9u4w+BiFUX4dFHQoIZRuOWBFv
         Kkq1M6zqGcuOdTswo59+Xai0puumHBfExnRnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RKrPkU7jOgxlEc0N1ec0HnyjYVRoaOC/izzjfkEhTmRC2xnncEmJxJR9L4wU/kHyGj
         kgXpqMSv7uKcbvjA+tjR7JlKgOvwZm8fKhewUjpoQ8BM3Kzpjx9Kxf1iu6vgLxM5PIhM
         YC2leJ8zF2myrzskx66iNzpOHcKlQhz0Am74o=
Received: by 10.142.65.24 with SMTP id n24mr2085546wfa.302.1271125803009;
        Mon, 12 Apr 2010 19:30:03 -0700 (PDT)
Received: from progeny.tock (wireless-239-104.uchicago.edu [128.135.239.104])
        by mx.google.com with ESMTPS id 22sm4494845iwn.12.2010.04.12.19.30.02
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 19:30:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100413021153.GA3978@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144787>

Eventually, all git commands should check their configuration at
start-up.  For now, reading configuration before repository discovery
is dangerous because it could cause a pager.<cmd> setting from the
current repository to be neglected.

But for commands with RUN_SETUP or RUN_SETUP_GENTLY set, it is safe.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 20e9bfc..56e93cf 100644
--- a/git.c
+++ b/git.c
@@ -251,7 +251,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 			prefix = setup_git_directory_gently(&nongit_ok);
 		}
 
-		if (use_pager == -1 && p->option & RUN_SETUP)
+		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY))
 			use_pager = check_pager_config(p->cmd);
 		if (use_pager == -1 && p->option & USE_PAGER)
 			use_pager = 1;
-- 
1.7.0.4
