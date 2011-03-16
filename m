From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/8] svn-fe: do not use "return" for tail call returning void
Date: Wed, 16 Mar 2011 02:01:50 -0500
Message-ID: <20110316070150.GD5988@elie>
References: <20110316024959.GA24932@elie>
 <20110316065256.GA5988@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 08:02:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzkk3-0005xn-SN
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 08:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771Ab1CPHB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 03:01:56 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:46470 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704Ab1CPHBy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 03:01:54 -0400
Received: by yia27 with SMTP id 27so541960yia.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 00:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=84khsC94mV0Qvgl+ZmYseYRN6tXxUThKEe9InxAUn5E=;
        b=ZF63qBOo/vAvmd061hoc2CMtgCs6GOuwRlb6owtVYwPwsYQn7FIWFLOlVk+/YqUdyV
         5T4zsuD7pLuoqNVAWCgdcxUjaATpMyfVeUpszs12MUF4MgApA7Ktz6uG9Wy8HM+5P5s7
         91pFwLagcXMSoyXkGwlr4P8ImtH9lvk+6ejLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OJYA+BwWFBCCDgtA+CYLoNX9yUaGb8Z1FbzeC8yTDUCG2u3Fimk1q9ypYqR1yuxBX9
         yyAS5cmtIgm6ThG68vWyLhuuPGvs9ptQyeHNbw36xB1RBurYoR7dWgvPUAoGLOMbq9Uy
         ezklEXWXpsA2FVyq0ZwfKkTQh2yWB77ojMWqo=
Received: by 10.91.3.12 with SMTP id f12mr1015793agi.5.1300258914211;
        Wed, 16 Mar 2011 00:01:54 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id c38sm829379anc.38.2011.03.16.00.01.52
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 00:01:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316065256.GA5988@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169111>

As v1.7.4-rc0~184 (2010-10-04) reminds us, a void function shouldn't
try to return something.

Noticed with gcc -pedantic:

 vcs-svn/svndump.c: In function 'handle_node':
 vcs-svn/svndump.c:213:3: warning: ISO C forbids 'return' with expression,
  in function returning void [-pedantic]

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/svndump.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index ee7c0bb..3a0a75e 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -210,7 +210,8 @@ static void handle_node(void)
 		if (mark || have_props || node_ctx.srcRev)
 			die("invalid dump: deletion node has "
 				"copyfrom info, text, or properties");
-		return repo_delete(node_ctx.dst);
+		repo_delete(node_ctx.dst);
+		return;
 	}
 	if (node_ctx.action == NODEACT_REPLACE) {
 		repo_delete(node_ctx.dst);
-- 
1.7.4.1
