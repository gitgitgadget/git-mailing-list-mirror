From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 5/8] config: Disallow multiple config file locations.
Date: Tue, 17 Feb 2009 02:54:51 +0200
Message-ID: <1234832094-15541-5-git-send-email-felipe.contreras@gmail.com>
References: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-2-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-3-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-4-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 01:57:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZEGg-0008Gx-Nu
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 01:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbZBQAzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 19:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbZBQAzN
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 19:55:13 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:56109 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbZBQAzH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 19:55:07 -0500
Received: by mail-bw0-f161.google.com with SMTP id 5so3545431bwz.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 16:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KFt+fQrWuZ0Xgd1Wn1dHxPA3Nnt7EV4VGiZAdyxwKAg=;
        b=Z04K3xgPZrZLc20jkWNECItu2+uKIB6AmTD89a8EuhkbriVLRZTPuT4vuxZhnLkJDR
         pogQm4KAuDK88khFnnnfWpcXT75Q+q9Sm1BwNQFD/u77oqV5eIXneNofv+rIxcNOWPLB
         AGOirX8WqhKaiOqPJjLgzyuM9rlUjxu6Rho9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QKuFM1GH+ZVBfldhyI7k93FZa2z9VpldU8ydyKh/iI+LmdsWCSclxtNw+OkaIQvlSz
         0yI455ePwypafcTL16ov4KPkCjpqKBaSyldeSNrReYW36k2iBu975xrWxZamrR/5bos9
         viDmdadrUXOPKd9nTKMCXqVe5+BbHQZMpUjC0=
Received: by 10.103.106.1 with SMTP id i1mr766433mum.101.1234832105986;
        Mon, 16 Feb 2009 16:55:05 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id e10sm796045muf.11.2009.02.16.16.55.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Feb 2009 16:55:05 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1234832094-15541-4-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110283>

Either --global, --system, or --file should be used, but not any
combination.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 30de93e..cdd8a12 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -313,6 +313,11 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 
 	argc = parse_options(argc, argv, builtin_config_options, builtin_config_usage, 0);
 
+	if (use_global_config + use_system_config + !!given_config_file > 1) {
+		error("only one config file at a time.");
+		usage_with_options(builtin_config_usage, builtin_config_options);
+	}
+
 	if (use_global_config) {
 		char *home = getenv("HOME");
 		if (home) {
-- 
1.6.1.3
