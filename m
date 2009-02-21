From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH B v4 5/5] git config: don't allow --get-color* and variable type
Date: Sat, 21 Feb 2009 02:49:29 +0200
Message-ID: <1235177369-2727-6-git-send-email-felipe.contreras@gmail.com>
References: <1235177369-2727-1-git-send-email-felipe.contreras@gmail.com>
 <1235177369-2727-2-git-send-email-felipe.contreras@gmail.com>
 <1235177369-2727-3-git-send-email-felipe.contreras@gmail.com>
 <1235177369-2727-4-git-send-email-felipe.contreras@gmail.com>
 <1235177369-2727-5-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 01:51:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lag5Z-0007JC-LQ
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 01:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525AbZBUAtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 19:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754414AbZBUAtr
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 19:49:47 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:42984 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510AbZBUAto (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 19:49:44 -0500
Received: by mail-bw0-f161.google.com with SMTP id 5so3160824bwz.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 16:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=caJDW879jBcGTwPsD8EAgZwqYnovXFv2o8ExUxd52Yc=;
        b=S9qunvW9dZOfh+LKiU4ezEgE9VrlrCvcH98wCTNInCpf42mjtDcaE+35oBmFnGc1b5
         ThEXRC1hDYxokIvEOXFtbyH/pd3NBwWhvPHlKfLDyuYaSrL68PCfxKFDKrYncWDn48EU
         HHO1Ic3zVrDBlpbe7yyX09pX2pM6pCEBoZyuk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IYsXC4otDFh73KE1JVoqtPPeH0RyWEHOpe0nepgnkzhT/zbBPZ/EhcVEHdww+D4UC6
         oOuvcSPn7RxnLcgxtqHe8xKekYwEiOCFJT5hH8/3IH/Jl5ivWPF79tjmeL/aL2ztqRkp
         EG3W0qA2zrresWeANNNjqKZhy3LvxSbbUDtK8=
Received: by 10.181.206.7 with SMTP id i7mr481626bkq.57.1235177383126;
        Fri, 20 Feb 2009 16:49:43 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id y15sm5887187fkd.12.2009.02.20.16.49.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Feb 2009 16:49:42 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1235177369-2727-5-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110916>

Doing so would be incoherent since --get-color would pick a color slot
and ignore the variable type option (e.g. --bool), and the type would
require a variable name.

Suggested by Junio C Hamano.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 8045926..9930568 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -359,6 +359,11 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 	if (get_colorbool_slot)
 	    actions |= ACTION_GET_COLORBOOL;
 
+	if ((get_color_slot || get_colorbool_slot) && types) {
+		error("--get-color and variable type are incoherent");
+		usage_with_options(builtin_config_usage, builtin_config_options);
+	}
+
 	if (HAS_MULTI_BITS(actions)) {
 		error("only one action at a time.");
 		usage_with_options(builtin_config_usage, builtin_config_options);
-- 
1.6.1.3
