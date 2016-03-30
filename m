From: Marios Titas <redneb@gmx.com>
Subject: [PATCH 2/2] ident: make the useConfigOnly error messages more informative
Date: Wed, 30 Mar 2016 22:29:43 +0300
Message-ID: <1459366183-15451-2-git-send-email-redneb@gmx.com>
References: <1459366183-15451-1-git-send-email-redneb@gmx.com>
Cc: Marios Titas <redneb@gmx.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 21:30:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alLoZ-0003PI-9K
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 21:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbcC3T35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 15:29:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:59955 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752704AbcC3T34 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 15:29:56 -0400
Received: from localhost.localdomain ([79.103.155.63]) by mail.gmx.com
 (mrgmx103) with ESMTPSA (Nemesis) id 0M6zvN-1ZpYaj3Zkz-00wn2S; Wed, 30 Mar
 2016 21:29:53 +0200
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1459366183-15451-1-git-send-email-redneb@gmx.com>
X-Provags-ID: V03:K0:PIF5uMvPf05qoUFnkMoB4gktnJYKCRczqQQOBjRb14vcgc4Iksf
 MYi3BBPk1ZIbxC++6a1Yw2aauyhxHQAYwALmXtW7HG7cQZlBBfuEGv9EIoovbQ/0jwSI80+
 gqs0gkk51dDiJE3/rnwvpyIwOXzMUJzNpg1M0FgE+cEUHgLd6mYDwNWHIMwTKzyN98lttEf
 RVztE96GKNjEq7OUOk/fw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:68n6est1dWY=:ox7u/f7+X3llPxOuKzBtzX
 lVAWrasz9wtca1XFQW1QWSdaK9LS26bGvPdcMotbn0GhTXle/aKNqQDSHhdSyCu+Zj3VJ1sCO
 ay/F/ga7bjMAjh8smcCnWHI0UWcWdJbPIU65kKA5hj6X/SaU+QDymIZ2A78dnGXbjMyclk02s
 5hpFmH3t3WMEpnw1/jogLuufXNosLOu3VreO5vbnzbghjPbYhLU4+LNJXDwOak9dhNA80iGus
 oMGhH92di5kDXRoV/fYyse7WzqnVgxTHRs4tFa+njYJRnTeeWkhojwOrgkJWw14mewJaahQ9e
 oeq4DDXL1IsFMR0G+3yuKzD5KQcuMB5IyQjyi0LpQR91Dx1KzSWbfjg5TFgblBSSFj8KapeBz
 tqJQTo+DLqMoDZy7bUsZ/9L2GwD9lulIKFmVqApwbIpdPBtmVqTMRlJuPHO9MKEZn/MkX2hMh
 Odsf6/W5DxgbAYoxQynZR3xhgM+ghgRif3nxBnQ/I97v2VpcfnYlTbPYLQZmMkjwllL6YWfg8
 q2sD3OuEKMDP7wWBFkFXgLsTNmvlYS5Mip9mMsCfcmOuuOeOjW7wXpxKpD91tbGgFKYQjTQId
 wQnRsc5A4iH1iHzUnfR4OO/4d21g3nVET9+KKQfl795192nRUpMlWZisR+5BL6lyuTH6ZpcIh
 yTSH5zfcaQ/tmsKuhReWK0trM0aalnpjIPh9r79EcO4n4ZDVdFnpy4XM3tjfq3Bh7T4aT0TEE
 +Iz8I0aRQoc0EOfxwXiAjn9DrusStsx2Uf+Z2zBJGLNaU3DlGAZ8fJ/yZSA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290339>

The env_hint message applies perfectly to the case when
user.useConfigOnly is set and at least one of the user.name and the
user.email are not provided. Additionally, use a more descriptive error
message when that happens.

Signed-off-by: Marios Titas <redneb@gmx.com>
---
 ident.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/ident.c b/ident.c
index 74b2663..4fd82d1 100644
--- a/ident.c
+++ b/ident.c
@@ -352,8 +352,10 @@ const char *fmt_ident(const char *name, const char *email,
 		int using_default = 0;
 		if (!name) {
 			if (strict && ident_use_config_only
-			    && !(ident_config_given & IDENT_NAME_GIVEN))
-				die("user.useConfigOnly set but no name given");
+			    && !(ident_config_given & IDENT_NAME_GIVEN)) {
+				fputs(env_hint, stderr);
+				die("no name was given and auto-detection is disabled");
+			}
 			name = ident_default_name();
 			using_default = 1;
 			if (strict && default_name_is_bogus) {
@@ -375,8 +377,10 @@ const char *fmt_ident(const char *name, const char *email,
 
 	if (!email) {
 		if (strict && ident_use_config_only
-		    && !(ident_config_given & IDENT_MAIL_GIVEN))
-			die("user.useConfigOnly set but no mail given");
+		    && !(ident_config_given & IDENT_MAIL_GIVEN)) {
+			fputs(env_hint, stderr);
+			die("no email was given and auto-detection is disabled");
+		}
 		email = ident_default_email();
 		if (strict && default_email_is_bogus) {
 			fputs(env_hint, stderr);
-- 
2.8.0
