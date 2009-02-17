From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 08/10] config: Disallow multiple config file locations.
Date: Tue, 17 Feb 2009 15:52:54 +0200
Message-ID: <1234878776-13250-8-git-send-email-felipe.contreras@gmail.com>
References: <1234878776-13250-1-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-2-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-3-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-4-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-5-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-6-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-7-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 14:55:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZQPp-0001sQ-8W
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 14:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbZBQNxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 08:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649AbZBQNxc
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 08:53:32 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:51922 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbZBQNxb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 08:53:31 -0500
Received: by mail-bw0-f161.google.com with SMTP id 5so4067593bwz.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 05:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8c5xBKxhSZAPB8QN3j4aa3LQKvoDKzfTxyJ9NBpzmLo=;
        b=kcZ4vnNLVEbs4i0fP8uqiu1aIJJHMxWN6dTV0J5hLLlLS2iBtsl60Ybx/2TPaCY5ro
         FPg2fFEBfhoEytGm6cVVcSsr0ksu1W3k9XPlBikHhW9VZzVAawRUV7DNUpHHOPCfRawe
         AoEzVFUS426D5WAeSgXXrEzxiUb3rZB00GhZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fDbQeWyUMKWDc2UNAQPJ8D0Y5Ap3iLktfvWxK1DRLf8RUP2lwBUzBhf2ir93rCI7dM
         XbdUJ+7owAhqShnLo/YRb3C11Wu8Z9Y6hkOk8yLZowoP1rgjJvJAyn1puuj5B4VEbp35
         tnkEPCtFwbxWKRzusNGq9/qb1CyyocaDQ3k0M=
Received: by 10.223.109.198 with SMTP id k6mr1004574fap.46.1234878809476;
        Tue, 17 Feb 2009 05:53:29 -0800 (PST)
Received: from localhost (net-63.nrpn.net [192.89.6.63])
        by mx.google.com with ESMTPS id g11sm9594031gve.5.2009.02.17.05.53.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 05:53:28 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1234878776-13250-7-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110380>

Either --global, --system, or --file should be used, but not any
combination.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 8ee0cd9..a674246 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -315,6 +315,11 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 	argc = parse_options(argc, argv, builtin_config_options, builtin_config_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
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
