From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 01/10] builtin/commit.c: convert trivial snprintf calls to xsnprintf
Date: Fri,  3 Jun 2016 07:47:15 +0000
Message-ID: <20160603074724.12173-1-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 09:48:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8jqX-0000Ry-85
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 09:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbcFCHsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 03:48:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36131 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbcFCHsj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 03:48:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id a20so9968574wma.3
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 00:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=w3OJ4CgdYTOxWIkU6UKCnxIIdd43erADgwFw6Z9LM9c=;
        b=D0YPSUH7Vw9UarVa1cx09n6kbxBRlOXD6wOEIKzcASXwOY4sCm3r6gVuQAPGhJ4tcp
         WW9Mw1C0JCWyhKUBF8E18FlSk2elmHHZIbq5e49Nz1G48PV0lbL8911cCmGGXwBnqchO
         jvlx2jJ88LYjJvLYXnMYehmRqWGO/WGZS0CNx2DCZngFdikwOEY6XyTlVG3WhqbF07o9
         pwahZyybBRCF4IloPivpbdfsQdspUcUC/Wqtc0gDXfhtpghwRGYHPKi95tXFEPqzbde3
         w/wTv0lzDkFzp/FEQPqyDnexgdhVwKKdb4fkDr/WhUStNEwGnPXMKr8gjR6B9QN12naF
         /YTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w3OJ4CgdYTOxWIkU6UKCnxIIdd43erADgwFw6Z9LM9c=;
        b=NREtFYt+WBEM3SXCPC16qc3ZLxKOrBCiuydy4eBR9zgqnHPDddu6P+42KMLRU+nvvE
         xX6xXDDUgi+SdXZnQPPgD6T/OkTxU4EQoxgu+i3ziCErgZGIzwSu9sxyMxMgBX+cLuFq
         5md1R+FaVR8jOFhq8hfehzFq9Brprb8pCSEKAm522akVV6Yph/mUD9b/kiPKNRU8B23p
         bOnTcNHr48ektNK1TBm2MiUj3Xrj3mZh7+OUsOPo82EEzSeQH8ALQVd0ofhXtXdcztC4
         Ewnujc8nul8phNXp4HKt3kNB+2pZQpQVZyvmH5vTBd4wEI3qIhRsFCfMLaSp0la3fqJ/
         JKeA==
X-Gm-Message-State: ALyK8tLCxiWsmnp8WyAmENc9s2L7+MOZV2/7OYUKpvoooB4/m77lHNauuSDRoJdyrbYRAw==
X-Received: by 10.195.8.40 with SMTP id dh8mr2365466wjd.178.1464940118183;
        Fri, 03 Jun 2016 00:48:38 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id o10sm4307311wjz.37.2016.06.03.00.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jun 2016 00:48:37 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc1.265.geb5d750
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296276>

With the commits f2f02675 and 5096d490 we have been converted in some files the call
from snprintf/sprintf/strcpy to xsnprintf. This patch converts the remaining calls
to snprintf with xsnprintf under the following conditions:

- The call to snprintf does not control the outcome of the command
  or the presence of truncation errors.
- A call to snprintf can generate a fatal error, directly or indirectly.

The other few remaining cases in which a call to snprintf can generate a soft error
have not been changed.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 443ff91..c65abaa 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1552,7 +1552,7 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
 	code = start_command(&proc);
 	if (code)
 		return code;
-	n = snprintf(buf, sizeof(buf), "%s %s\n",
+	n = xsnprintf(buf, sizeof(buf), "%s %s\n",
 		     sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
 	sigchain_push(SIGPIPE, SIG_IGN);
 	write_in_full(proc.in, buf, n);
-- 
2.9.0.rc1.265.geb5d750
