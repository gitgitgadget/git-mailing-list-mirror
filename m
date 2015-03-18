From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 3/4] docs/git-credential-store: document XDG file and precedence
Date: Wed, 18 Mar 2015 15:04:35 +0800
Message-ID: <1426662276-8728-3-git-send-email-pyokagan@gmail.com>
References: <1426662276-8728-1-git-send-email-pyokagan@gmail.com>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 08:05:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY82v-0004Cx-1t
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 08:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbbCRHFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 03:05:30 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35500 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722AbbCRHF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 03:05:27 -0400
Received: by pdbop1 with SMTP id op1so34332680pdb.2
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 00:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xhlfrPUGnM0B4wL92nnefADqH4Vg5jHUdUYfJ0YNFRo=;
        b=a6TnDYWuj4uETIdRb+H1yCdRPh9U2y4ks0Rn4Al65dVZYWBtN3z9LndHK+9o4Q2ju6
         v5lx2uCnRnOTalE72aXtfzk2+i/J+CthYEmx26nJGGi0JQ/F+b+GdvkIDxXnZnHz46ok
         wkkwmJwbvU0+ofr60z5mov+keIt1ruNbu8Hg2T75WVoJCS1KASGdbVGkm1WFH5ljNMKA
         rNsy+X9hHpNPm6R+24QGzCfA0tb7MDmWBzc9xSVlrFY76mxra53jNbq3XGeMAKgw5l/m
         xNiNlTFSPz/TsY/j5plk5Ch0XNXxCId3X4QIscb/5mKhozvne0ezHmXWbKqxLxEDTrda
         F6lA==
X-Received: by 10.66.221.8 with SMTP id qa8mr25467298pac.62.1426662327209;
        Wed, 18 Mar 2015 00:05:27 -0700 (PDT)
Received: from yoshi.chippynet.com ([101.127.143.183])
        by mx.google.com with ESMTPSA id y2sm25741542pdm.31.2015.03.18.00.05.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2015 00:05:24 -0700 (PDT)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1YY82b-0002MJ-Ve; Wed, 18 Mar 2015 15:05:21 +0800
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426662276-8728-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265685>

git-credential-store now supports an additional default credential file
at $XDG_CONFIG_HOME/git/credentials. However, ~/.git-credentials takes
precedence over it for backwards compatibility. To make the precedence
ordering explicit, add a new section FILES that lists out the credential
file paths in their order of precedence, and explains how the ordering
affects the lookup, storage and erase operations.

Also update documentation for --store to briefly explain the operations
on multiple files if the --store option is not provided.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

The previous version can be found at [1].

[1] http://thread.gmane.org/gmane.comp.version-control.git/265305/focus=265308

The changes are as follows:

* Remove "support for this file was added fairly recently" statement, as
it will become out-dated with time. Thanks Eric for pointing this out.

 Documentation/git-credential-store.txt | 35 ++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index bc97071..e16afd8 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -31,10 +31,41 @@ OPTIONS
 
 --file=<path>::
 
-	Use `<path>` to store credentials. The file will have its
+	Use `<path>` to lookup and store credentials. The file will have its
 	filesystem permissions set to prevent other users on the system
 	from reading it, but will not be encrypted or otherwise
-	protected. Defaults to `~/.git-credentials`.
+	protected. If not specified, credentials will be searched for from
+	`~/.git-credentials` and `$XDG_CONFIG_HOME/git/credentials`, and
+	credentials will be written to `~/.git-credentials` if it exists, or
+	`$XDG_CONFIG_HOME/git/credentials` if it exists and the former does
+	not. See also <<FILES>>.
+
+[[FILES]]
+FILES
+-----
+
+If not set explicitly with '--file', there are two files where
+git-credential-store will search for credentials in order of precedence:
+
+~/.git-credentials::
+	User-specific credentials file.
+
+$XDG_CONFIG_HOME/git/credentials::
+	Second user-specific credentials file. If '$XDG_CONFIG_HOME' is not set
+	or empty, `$HOME/.config/git/credentials` will be used. Any credentials
+	stored in this file will not be used if `~/.git-credentials` has a
+	matching credential as well. It is a good idea not to create this file
+	if you sometimes use older versions of Git that do not support it.
+
+For credential lookups, the files are read in the order given above, with the
+first matching credential found taking precedence over credentials found in
+files further down the list.
+
+Credential storage will per default write to the first existing file in the
+list. If none of these files exist, `~/.git-credentials` will be created and
+written to.
+
+When erasing credentials, matching credentials will be erased from all files.
 
 EXAMPLES
 --------
-- 
2.1.4
