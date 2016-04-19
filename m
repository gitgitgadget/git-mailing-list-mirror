From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] replace --edit: respect core.editor
Date: Tue, 19 Apr 2016 16:37:00 +0200 (CEST)
Message-ID: <909769abaff1babdab77625bebd04e2013c6e344.1461076425.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 16:37:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asWmG-00030N-6Q
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 16:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbcDSOhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 10:37:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:49215 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753672AbcDSOhN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 10:37:13 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M9ra4-1b3ZOn2bJA-00B2VS; Tue, 19 Apr 2016 16:37:01
 +0200
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:C4iQsR8LCyKFFSrdumsCm5mPkvIxln5rxoEdCNfsF52NQgJmmdf
 HvmPN8QJPTqOIsVSprJv1aytroF29lYecUv6GZBmH5Na1h1E11CQXs3Noa4GphqMqNknzXg
 J5y2zuWR6S9ozoLV8HDdGYt+thQMZi7kZ6QJhTPTe4jmM5Tt2AJJHKzdUxrMi6J76GhfLof
 ZkSaR50YXya8gdWfsp2UQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vpf2h30J7V8=:JLDOYh1l00PWNyjPaKG6jp
 QA+9Y6GbpSCZKOh3JrGuNRqRszJbZ8vzMrxm6JrN9DC7KZYMJofQIQJswHSSvfxKa60hgcJkP
 3Vf6urj7vmwy26sR2EoNvG6qw2kBaohbT07stCYXzcMTKQNsIyw85MQwczUa0hvl7/ddXHc7O
 svRN3cwn08jGgPZmfVe0LJC5zOxOya2ZBqBTeblJB8d8IjzXvSw/VuUUuEC2R1SXfcbYiyt48
 UK94r7Z59WfTvrFF2jHe8GlI6OevEHIU1PPvDqa5S7nvm9ZDINxxWlA9JlQDzNtJSCC34HMFV
 4UqOqoaNY8mvCoh4YQGP39SS09n9+9AeLBoSbuFtadBBW/5pHz2lm4V6ydTQ8Ot6ZEB/u9Ejj
 VZZydkpGC4YT2WGDnv1jTcEdZZFh+yoQ6fqHbzRWn+/xhTchtWK4rcMA0/2Y6qZwqN4rctlvT
 7yE2HWbYB9RUZ4SixqgzzSKPx+l3uRp5IKOEL+yO8KL8GydKNOpcqJVmatNqQ21MoI2Yxxujd
 tb1Cjll1pLvzaxzK+VZcsQBQ3zA4n2MUgopGE6NtWBGfgMupH4I9pWwoS8X9PMTPWQriGelB/
 hhAeReKbS4mnzY5QD0S5/LdD9J7liyjfByCibC6YoTaga5bzcTeiiasJqHZnI8Lz6q5s3XvHw
 oaz7COSD6vNmXblmWmhSMubcMvKj4BYgClsANzFbg0YPRX8uhJWCXIfM8+WyBE2MmCKoE7i8O
 vnxeSemxqwNzwPCsaJo0aqoOthAyPImEV93zAYB2jc9+tGOZtpQDN69itl7GZ+DgKv5WFZ+4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291866>

We simply need to read the config, is all.

This fixes https://github.com/git-for-windows/git/issues/733

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/replace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/replace.c b/builtin/replace.c
index 748c6ca..02b13f6 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -475,6 +475,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		return replace_object(argv[0], argv[1], force);
 
 	case MODE_EDIT:
+		git_config(git_default_config, NULL);
 		if (argc != 1)
 			usage_msg_opt("-e needs exactly one argument",
 				      git_replace_usage, options);
-- 
2.8.1.206.g8b39b4a
