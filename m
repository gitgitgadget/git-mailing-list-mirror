Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E486111
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 18:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="f33AxDZ3"
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867ABD4C
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 11:39:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1c9b7c234a7so9408515ad.3
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 11:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1697827194; x=1698431994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilbzUpAXCRHFu13+dCsU/z6RaJA/e8bJeUA+rWbVMZE=;
        b=f33AxDZ3K3AGebhJu1I4OoYLD9Qklylq/dnS5Hqwx7wSpc7RtJ6MgZ378o2Llv3GgW
         rh/+8GOyeAiesPbE2mCsaI6McWYj/PIP+SwJTJch9yGBYq+gWejGm5kpbZXj7Hfv4g9z
         /jBMrDmuCGjRBml7w/C2ad/sCE3q2uNXHEHhWGi9q6Gml0kHev9Z32vrBnZqorsi7dpK
         fHylvI++1r4+rjX5yfJ5bbomFFyK+YKS4+6fME1UEXwyFxbG5OdygF0O987OkrTJvoCx
         8hx+urkZqVLPUWlfmRMf7beryDEubH+vblEF4O1zAQeIbbVhyvpvTv6C4+rdkqX66Kov
         GiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697827194; x=1698431994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilbzUpAXCRHFu13+dCsU/z6RaJA/e8bJeUA+rWbVMZE=;
        b=SEQd0NlzvQ8YdkHFOnrnuAQradlnzjKB/FXUXIHAER9r/VV38wytp+ksYsTHukLw0y
         qClxPLZWN3ACKzCg7lShMoP8FsN37N1zDYM+d5qeg6AhUvRO3TmxU6sAp54i2SPQz+ty
         9O28i17hNiMeFB/IEh1fHIcU06f6zeDZClmnCkgbKXdcgbd1OQEWDLsVO+W5sFwe6UA+
         qIXWTFDsumMHlYQ/P+y5z2q1VZJTgGXk5TL0JQI7Hp/CbgskCc87RnMwjGv+PdDAthyZ
         aWPYvscT/+9tliivnydbuidOn4wFnokZUIp11y+Ry1rBzVb5M11TFlVlm6ufzWWYGlS4
         cnKw==
X-Gm-Message-State: AOJu0YyRB7bWaEEMhm7F0f71xjBsgUNHiZITgs+xeP7uVsTxJhJ1+xHB
	x0LuYGmDV2q6FNodNOylEqdNmcw93ynvO3IB05MQ8gY7AgK33Q==
X-Google-Smtp-Source: AGHT+IHNoq4KOwWPjwbIXfKuk/WispiP4CmdnIsp91yEDHWNHakz/fNbWqbK8O1L0N3v0AiPuiDa/Q==
X-Received: by 2002:a17:90a:53c5:b0:27d:8d0:713e with SMTP id y63-20020a17090a53c500b0027d08d0713emr2964271pjh.10.1697827193797;
        Fri, 20 Oct 2023 11:39:53 -0700 (PDT)
Received: from localhost.localdomain (mobile-166-170-46-176.mycingular.net. [166.170.46.176])
        by smtp.gmail.com with ESMTPSA id s15-20020a17090a5d0f00b0027e022bd62fsm2994353pji.5.2023.10.20.11.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:39:53 -0700 (PDT)
From: Jacob Stopak <jacob@initialcommit.io>
To: git@vger.kernel.org
Cc: Jacob Stopak <jacob@initialcommit.io>
Subject: [RFC PATCH 1/5] status: introduce -t, --table flag
Date: Fri, 20 Oct 2023 11:39:43 -0700
Message-ID: <20231020183947.463882-2-jacob@initialcommit.io>
X-Mailer: git-send-email 2.42.0.402.gbe8243af7b.dirty
In-Reply-To: <20231020183947.463882-1-jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
---
 Makefile         |   1 +
 builtin/commit.c |   2 +
 table.c          | 117 +++++++++++++++++++++++++++++++++++++++++++++++
 table.h          |   6 +++
 wt-status.c      |  72 +++++++++++++++++++----------
 wt-status.h      |   1 +
 6 files changed, 174 insertions(+), 25 deletions(-)
 create mode 100644 table.c
 create mode 100644 table.h

diff --git a/Makefile b/Makefile
index 9c6a2f125f..a7399ca8f0 100644
--- a/Makefile
+++ b/Makefile
@@ -1155,6 +1155,7 @@ LIB_OBJS += submodule-config.o
 LIB_OBJS += submodule.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
+LIB_OBJS += table.o
 LIB_OBJS += tempfile.o
 LIB_OBJS += thread-utils.o
 LIB_OBJS += tmp-objdir.o
diff --git a/builtin/commit.c b/builtin/commit.c
index 7da5f92448..4338896dbf 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1539,6 +1539,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F('M', "find-renames", &rename_score_arg,
 		  N_("n"), N_("detect renames, optionally set similarity index"),
 		  PARSE_OPT_OPTARG | PARSE_OPT_NONEG, opt_parse_rename_score),
+		OPT_SET_INT('t', "table", &status_format,
+			    N_("show status in table format"), STATUS_FORMAT_TABLE),
 		OPT_END(),
 	};
 
diff --git a/table.c b/table.c
new file mode 100644
index 0000000000..54cf9e4d07
--- /dev/null
+++ b/table.c
@@ -0,0 +1,117 @@
+#define USE_THE_INDEX_VARIABLE
+#include "builtin.h"
+#include "gettext.h"
+#include "strbuf.h"
+#include "wt-status.h"
+#include "config.h"
+#include "string-list.h"
+#include "sys/ioctl.h"
+
+static const char *color(int slot, struct wt_status *s)
+{
+	const char *c = "";
+	if (want_color(s->use_color))
+		c = s->color_palette[slot];
+	if (slot == WT_STATUS_ONBRANCH && color_is_nil(c))
+		c = s->color_palette[WT_STATUS_HEADER];
+	return c;
+}
+
+static void build_table_border(struct strbuf *buf, int cols)
+{
+	strbuf_reset(buf);
+	strbuf_addchars(buf, '-', cols);
+}
+
+static void build_table_entry(struct strbuf *buf, char *entry, int cols)
+{
+	strbuf_reset(buf);
+	strbuf_addchars(buf, ' ', (cols / 3 - 1 - strlen(entry)) / 2);
+	strbuf_addstr(buf, entry);
+
+	/* Bump right padding if entry length is odd */
+	if (!(strlen(entry) % 2))
+		strbuf_addchars(buf, ' ', (cols / 3 - 1 - strlen(entry)) / 2 + 1);
+	else
+		strbuf_addchars(buf, ' ', (cols / 3 - 1 - strlen(entry)) / 2);
+}
+
+static void print_table_body_line(struct strbuf *buf1, struct strbuf *buf2, struct strbuf *buf3, struct wt_status *s)
+{
+	printf(_("|"));
+	color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "%s", buf1->buf);
+	printf(_("|"));
+	color_fprintf(s->fp, color(WT_STATUS_CHANGED, s), "%s", buf2->buf);
+	printf(_("|"));
+	color_fprintf(s->fp, color(WT_STATUS_UPDATED, s), "%s", buf3->buf);
+	printf(_("|\n"));
+}
+
+void build_and_draw_status_table(struct wt_status *s)
+{
+	struct winsize w;
+	int cols;
+	struct strbuf table_border = STRBUF_INIT;
+	struct strbuf table_col_entry_1 = STRBUF_INIT;
+	struct strbuf table_col_entry_2 = STRBUF_INIT;
+	struct strbuf table_col_entry_3 = STRBUF_INIT;
+	struct string_list_item *item;
+
+	/* Get terminal width */
+	ioctl(STDOUT_FILENO, TIOCGWINSZ, &w);
+	cols = w.ws_col;
+
+	/* Ensure table is divisible into 3 even columns */
+	while (((cols - 1) % 3) > 0 || !(cols % 2)) {
+		cols -= 1;
+	}
+
+	build_table_border(&table_border, cols);
+	build_table_entry(&table_col_entry_1, "Untracked files", cols);
+	build_table_entry(&table_col_entry_2, "Changes not staged for commit", cols);
+	build_table_entry(&table_col_entry_3, "Changes to be committed", cols);
+
+	/* Draw table header */
+	printf(_("%s\n"), table_border.buf);
+	printf(_("|%s|%s|%s|\n"), table_col_entry_1.buf, table_col_entry_2.buf, table_col_entry_3.buf);
+	printf(_("%s\n"), table_border.buf);
+
+	/* Draw table body */
+	for_each_string_list_item(item, &s->untracked) {
+		build_table_entry(&table_col_entry_1, item->string, cols);
+		build_table_entry(&table_col_entry_2, "", cols);
+		build_table_entry(&table_col_entry_3, "", cols);
+		print_table_body_line(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, s);
+	}
+
+	for_each_string_list_item(item, &s->change) {
+		struct wt_status_change_data *d = item->util;
+		if (d->worktree_status && d->index_status) {
+			build_table_entry(&table_col_entry_1, "", cols);
+			build_table_entry(&table_col_entry_2, item->string, cols);
+			build_table_entry(&table_col_entry_3, item->string, cols);
+		} else if (d->worktree_status) {
+			build_table_entry(&table_col_entry_1, "", cols);
+			build_table_entry(&table_col_entry_2, item->string, cols);
+			build_table_entry(&table_col_entry_3, "", cols);
+		} else if (d->index_status) {
+			build_table_entry(&table_col_entry_1, "", cols);
+			build_table_entry(&table_col_entry_2, "", cols);
+			build_table_entry(&table_col_entry_3, item->string, cols);
+		}
+		print_table_body_line(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, s);
+	}
+	
+	if (!s->untracked.nr && !s->change.nr) {
+		build_table_entry(&table_col_entry_1, "-", cols);
+		build_table_entry(&table_col_entry_2, "-", cols);
+		build_table_entry(&table_col_entry_3, "-", cols);
+		printf(_("|%s|%s|%s|\n"), table_col_entry_1.buf, table_col_entry_2.buf, table_col_entry_3.buf);
+	}
+
+	printf(_("%s\n"), table_border.buf);
+	strbuf_release(&table_border);
+	strbuf_release(&table_col_entry_1);
+	strbuf_release(&table_col_entry_2);
+	strbuf_release(&table_col_entry_3);
+}
diff --git a/table.h b/table.h
new file mode 100644
index 0000000000..30e0d5509b
--- /dev/null
+++ b/table.h
@@ -0,0 +1,6 @@
+#ifndef TABLE_H
+#define TABLE_H
+
+void build_and_draw_status_table(struct wt_status *s);
+
+#endif /* TABLE_H */
diff --git a/wt-status.c b/wt-status.c
index 9f45bf6949..24b56ea559 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -31,6 +31,7 @@
 #include "lockfile.h"
 #include "sequencer.h"
 #include "fsmonitor-settings.h"
+#include "table.h"
 
 #define AB_DELAY_WARNING_IN_MS (2 * 1000)
 #define UF_DELAY_WARNING_IN_MS (2 * 1000)
@@ -1833,39 +1834,46 @@ static void wt_longstatus_print_state(struct wt_status *s)
 		show_sparse_checkout_in_use(s, state_color);
 }
 
-static void wt_longstatus_print(struct wt_status *s)
+static void wt_longstatus_print_onwhat(struct wt_status *s, const char *branch_name)
 {
+	const char *on_what = _("On branch ");
 	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
 	const char *branch_status_color = color(WT_STATUS_HEADER, s);
+
+	if (!strcmp(branch_name, "HEAD")) {
+		branch_status_color = color(WT_STATUS_NOBRANCH, s);
+		if (s->state.rebase_in_progress ||
+		    s->state.rebase_interactive_in_progress) {
+			if (s->state.rebase_interactive_in_progress)
+				on_what = _("interactive rebase in progress; onto ");
+			else
+				on_what = _("rebase in progress; onto ");
+			branch_name = s->state.onto;
+		} else if (s->state.detached_from) {
+			branch_name = s->state.detached_from;
+			if (s->state.detached_at)
+				on_what = _("HEAD detached at ");
+			else
+				on_what = _("HEAD detached from ");
+		} else {
+			branch_name = "";
+			on_what = _("Not currently on any branch.");
+		}
+	} else
+		skip_prefix(branch_name, "refs/heads/", &branch_name);
+
+	status_printf_more(s, branch_status_color, "%s", on_what);
+	status_printf_more(s, branch_color, "%s\n", branch_name);
+}
+
+static void wt_longstatus_print(struct wt_status *s)
+{
 	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(s->repo);
 
 	if (s->branch) {
-		const char *on_what = _("On branch ");
 		const char *branch_name = s->branch;
-		if (!strcmp(branch_name, "HEAD")) {
-			branch_status_color = color(WT_STATUS_NOBRANCH, s);
-			if (s->state.rebase_in_progress ||
-			    s->state.rebase_interactive_in_progress) {
-				if (s->state.rebase_interactive_in_progress)
-					on_what = _("interactive rebase in progress; onto ");
-				else
-					on_what = _("rebase in progress; onto ");
-				branch_name = s->state.onto;
-			} else if (s->state.detached_from) {
-				branch_name = s->state.detached_from;
-				if (s->state.detached_at)
-					on_what = _("HEAD detached at ");
-				else
-					on_what = _("HEAD detached from ");
-			} else {
-				branch_name = "";
-				on_what = _("Not currently on any branch.");
-			}
-		} else
-			skip_prefix(branch_name, "refs/heads/", &branch_name);
 		status_printf(s, color(WT_STATUS_HEADER, s), "%s", "");
-		status_printf_more(s, branch_status_color, "%s", on_what);
-		status_printf_more(s, branch_color, "%s\n", branch_name);
+		wt_longstatus_print_onwhat(s, branch_name);
 		if (!s->is_initial)
 			wt_longstatus_print_tracking(s);
 	}
@@ -2133,6 +2141,17 @@ static void wt_shortstatus_print(struct wt_status *s)
 		wt_shortstatus_other(it, s, "!!");
 }
 
+static void wt_tablestatus_print(struct wt_status *s)
+{
+	if (s->show_branch) {
+		const char *branch_name = s->branch;
+		wt_longstatus_print_onwhat(s, branch_name);
+		wt_longstatus_print_tracking(s);
+	}
+
+	build_and_draw_status_table(s);
+}
+
 static void wt_porcelain_print(struct wt_status *s)
 {
 	s->use_color = 0;
@@ -2560,6 +2579,9 @@ void wt_status_print(struct wt_status *s)
 	case STATUS_FORMAT_LONG:
 		wt_longstatus_print(s);
 		break;
+	case STATUS_FORMAT_TABLE:
+		wt_tablestatus_print(s);
+		break;
 	}
 
 	trace2_region_leave("status", "print", s->repo);
diff --git a/wt-status.h b/wt-status.h
index ab9cc9d8f0..70a3b7a2e4 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -73,6 +73,7 @@ enum wt_status_format {
 	STATUS_FORMAT_SHORT,
 	STATUS_FORMAT_PORCELAIN,
 	STATUS_FORMAT_PORCELAIN_V2,
+	STATUS_FORMAT_TABLE,
 
 	STATUS_FORMAT_UNSPECIFIED
 };
-- 
2.42.0.402.gbe8243af7b.dirty

