Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899E2524B5
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775080; cv=none; b=EtxHMYNlLB8XCtIMADAWQrtFDvQlTNoGtGqWcXRHVDB4V8SF2zqAXzYTauIqeUTwvgnDLfQwJhRi7ULl7TdcC0tdHqlpTNkyiPh27+kZao2RHbXkRvrdoI3IJr3FMLOuWaioRowWSefepJejDNOg5r7EqtchTZMBc8XXulri7iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775080; c=relaxed/simple;
	bh=Tf/fl2n1Y0XpAglZm4wPJCXiKVlGqlRFJEv7y4THzqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdaeOaSIu0JwQY9SykxsmgczonAEJJIKP2zf7VNjiJ41h4UMU0QXhP2vy+y2Q+v30VikixnrfRIp96xuQDaA27aJSn/trRlOvg0/O54ptmXYAWWD6FYwrMYTWDR+7BAoLHf0i3WnR9EwpvZPgL8CZirynb8+1tKO2I1WxcYvTDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=sy8+2IWb; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="sy8+2IWb"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:fc9:9524:11d1:7aa4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 350AE602EB;
	Mon, 18 Mar 2024 16:17:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1710775071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sotbr++pnaTGjpXsOGQZ4VlAGybpbc4NEfF1utfySDo=;
	b=sy8+2IWbjJ8KJoi8QUB8XM4R2cGSS7LUWxcoETNPwl2oKgzlU14/nGnzdvFEMJysJD7MO2
	dleQrfyiWQ4cPUDQjvAvYcVpQaun2MiFAVqHn5vvTjZYm/hVc3k54lx5x+da/ZFEGYspYB
	gOa7JdzAWxasmJWFNmjKLQPG37pcz1tclX9twkhatVe/B4jGai/oAGx4nHXpp7I1RlmeDY
	+LkfbRxZeRKA9DgxmcdeMNZ7Z9GpMk1YxLmFhIU0Ipv0Dz2vlhBDuD4CpzvMggU/2/vv4l
	4B03Z1iRZ1AYT9lCbqNXk+P45FB0HcsC9i50KKG5WqVjFEHCv7ApMNhlp3kV+Q==
From: Max Gautier <mg@max.gautier.name>
To: git@vger.kernel.org
Cc: =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
	Max Gautier <mg@max.gautier.name>
Subject: [RFC PATCH 5/5] DON'T APPLY YET: maintenance: remove cleanup code
Date: Mon, 18 Mar 2024 16:07:23 +0100
Message-ID: <20240318151701.26644-7-mg@max.gautier.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318151701.26644-2-mg@max.gautier.name>
References: <20240318151701.26644-2-mg@max.gautier.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This removes code to remove old git-maintenance systemd timer and
service user units which were written in $XDG_CONFIG_HOME by git
previous versions.

Signed-off-by: Max Gautier <mg@max.gautier.name>
---
 builtin/gc.c | 54 +++-------------------------------------------------
 1 file changed, 3 insertions(+), 51 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 981db8e297..6ac184eaf5 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2303,12 +2303,7 @@ static int is_systemd_timer_available(void)
 	return real_is_systemd_timer_available();
 }
 
-static char *xdg_config_home_systemd(const char *filename)
-{
-	return xdg_config_home_for("systemd/user", filename);
-}
-
-static int systemd_set_units_state(int enable)
+static int systemd_set_units_state(int run_maintenance, int fd UNUSED)
 {
 	const char *cmd = "systemctl";
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -2317,7 +2312,7 @@ static int systemd_set_units_state(int enable)
 	strvec_split(&child.args, cmd);
 
 	strvec_pushl(&child.args, "--user", "--force", "--now",
-			enable ? "enable" : "disable",
+			run_maintenance ? "enable" : "disable",
 			"git-maintenance@hourly.timer",
 			"git-maintenance@daily.timer",
 			"git-maintenance@weekly.timer", NULL);
@@ -2334,49 +2329,6 @@ static int systemd_set_units_state(int enable)
 	return 0;
 }
 
-static void systemd_delete_user_unit(char const *unit)
-{
-	char const	file_start_stale[] =	"# This file was created and is"
-						" maintained by Git.";
-	char		file_start_user[sizeof(file_start_stale)] = {'\0'};
-
-	char *filename = xdg_config_home_systemd(unit);
-	int handle = open(filename, O_RDONLY);
-
-	/*
-	** Check this is actually our file and we're not removing a legitimate
-	** user override.
-	*/
-	if (handle == -1 && !is_missing_file_error(errno))
-		warning(_("failed to delete '%s'"), filename);
-	else {
-		read(handle, file_start_user, sizeof(file_start_stale) - 1);
-		close(handle);
-		if (strcmp(file_start_stale, file_start_user) == 0) {
-			if (unlink(filename) == 0)
-				warning(_("deleted stale unit file '%s'"), filename);
-			else if (!is_missing_file_error(errno))
-				warning(_("failed to delete '%s'"), filename);
-		}
-	}
-
-	free(filename);
-}
-
-static int systemd_timer_update_schedule(int run_maintenance, int fd UNUSED)
-{
-	/*
-	 * A previous version of Git wrote the units in the user configuration
-	 * directory. Clean these up, if they exist.
-	 */
-	systemd_delete_user_unit("git-maintenance@hourly.timer");
-	systemd_delete_user_unit("git-maintenance@daily.timer");
-	systemd_delete_user_unit("git-maintenance@weekly.timer");
-	systemd_delete_user_unit("git-maintenance@.timer");
-	systemd_delete_user_unit("git-maintenance@.service");
-	return systemd_set_units_state(run_maintenance);
-}
-
 enum scheduler {
 	SCHEDULER_INVALID = -1,
 	SCHEDULER_AUTO,
@@ -2399,7 +2351,7 @@ static const struct {
 	[SCHEDULER_SYSTEMD] = {
 		.name = "systemctl",
 		.is_available = is_systemd_timer_available,
-		.update_schedule = systemd_timer_update_schedule,
+		.update_schedule = systemd_set_units_state,
 	},
 	[SCHEDULER_LAUNCHCTL] = {
 		.name = "launchctl",
-- 
2.44.0

