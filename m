Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6788420954
	for <e@80x24.org>; Thu,  7 Dec 2017 16:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753146AbdLGQaf (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 11:30:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58503 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753148AbdLGQad (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 11:30:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6444CC079A;
        Thu,  7 Dec 2017 11:30:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YIJaydlLnlrb6uAdicgLDf5ehlc=; b=IU8YAy
        WQJ+5icTEBXqXu0fR4T3Wqws/tldq1lpWPnvQuS8N3iLzJ/So49V5lExK+bvB1Fz
        IEAJu/i8doFD4401SxwOq6fXdzKk/SUh1qI7ZOXZ+DokuCZ2dbpkVSEuJ3HFct4l
        N7ofY6SFUTLTWCtLMMviBZl6hFamuENoxvp7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mWnUQOzMECJUnQMa/mKyijkIgfF4uAfo
        UH0Mq213m2SQ5+417zYRIBU8Lq+Yw31uhEZJIZtfQfl0npUAW/ItAs3l6sVF4Ouz
        XJE6tZBdFmIiRhdBSmL/zbbVPogUaTV6QPX6sHwFg8vUhQAyy6fL3u+STQwgiz4L
        LMr9uOlEMTs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C767C0799;
        Thu,  7 Dec 2017 11:30:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB44AC0796;
        Thu,  7 Dec 2017 11:30:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Lars Schneider <lars.schneider@autodesk.com>, git@vger.kernel.org,
        sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net
Subject: Re: [PATCH v5 2/2] launch_editor(): indicate that Git waits for user input
References: <20171207151641.75065-1-lars.schneider@autodesk.com>
        <20171207151641.75065-3-lars.schneider@autodesk.com>
        <xmqqr2s6ee7e.fsf@gitster.mtv.corp.google.com>
        <FCBDBD58-0593-4FFC-B574-61D67CAF13C6@gmail.com>
        <D17F94FA-702E-4E37-BDA5-94F0FFD5BD01@gmail.com>
Date:   Thu, 07 Dec 2017 08:30:30 -0800
In-Reply-To: <D17F94FA-702E-4E37-BDA5-94F0FFD5BD01@gmail.com> (Lars
        Schneider's message of "Thu, 7 Dec 2017 17:16:13 +0100")
Message-ID: <xmqqmv2uec0p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F18A80D2-DB6B-11E7-8830-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> Can you squash that if you like it?

I thought you also had to update the log message that you forgot to?

Here is the replacement I queued tentatively.

-- >8 --
From: Lars Schneider <larsxschneider@gmail.com>
Date: Thu, 7 Dec 2017 16:16:41 +0100
Subject: [PATCH] launch_editor(): indicate that Git waits for user input

When a graphical GIT_EDITOR is spawned by a Git command that opens
and waits for user input (e.g. "git rebase -i"), then the editor window
might be obscured by other windows. The user might be left staring at
the original Git terminal window without even realizing that s/he needs
to interact with another window before Git can proceed. To this user Git
appears hanging.

Print a message that Git is waiting for editor input in the original
terminal and get rid of it when the editor returns, if the terminal
supports erasing the last line.  Also, make sure that our message is
terminated with a whitespace so that any message the editor may show
upon starting up will be kept separate from our message.

Power users might not want to see this message or their editor might
already print such a message (e.g. emacsclient). Allow these users to
suppress the message by disabling the "advice.waitingForEditor" config.

The standard advise() function is not used here as it would always add
a newline which would make deleting the message harder.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |  3 +++
 advice.c                 |  2 ++
 advice.h                 |  1 +
 editor.c                 | 24 ++++++++++++++++++++++++
 4 files changed, 30 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9593bfabaa..6ebc50eea8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -351,6 +351,9 @@ advice.*::
 	addEmbeddedRepo::
 		Advice on what to do when you've accidentally added one
 		git repo inside of another.
+	waitingForEditor::
+		Print a message to the terminal whenever Git is waiting for
+		editor input from the user.
 --
 
 core.fileMode::
diff --git a/advice.c b/advice.c
index d81e1cb742..af29d23e43 100644
--- a/advice.c
+++ b/advice.c
@@ -17,6 +17,7 @@ int advice_set_upstream_failure = 1;
 int advice_object_name_warning = 1;
 int advice_rm_hints = 1;
 int advice_add_embedded_repo = 1;
+int advice_waiting_for_editor = 1;
 
 static struct {
 	const char *name;
@@ -38,6 +39,7 @@ static struct {
 	{ "objectnamewarning", &advice_object_name_warning },
 	{ "rmhints", &advice_rm_hints },
 	{ "addembeddedrepo", &advice_add_embedded_repo },
+	{ "waitingforeditor", &advice_waiting_for_editor },
 
 	/* make this an alias for backward compatibility */
 	{ "pushnonfastforward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index c84a44531c..f7cbbd342f 100644
--- a/advice.h
+++ b/advice.h
@@ -19,6 +19,7 @@ extern int advice_set_upstream_failure;
 extern int advice_object_name_warning;
 extern int advice_rm_hints;
 extern int advice_add_embedded_repo;
+extern int advice_waiting_for_editor;
 
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
diff --git a/editor.c b/editor.c
index c65ea698eb..8acce0dcd4 100644
--- a/editor.c
+++ b/editor.c
@@ -45,6 +45,23 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		const char *args[] = { editor, real_path(path), NULL };
 		struct child_process p = CHILD_PROCESS_INIT;
 		int ret, sig;
+		int print_waiting_for_editor = advice_waiting_for_editor && isatty(2);
+
+		if (print_waiting_for_editor) {
+			/*
+			 * A dumb terminal cannot erase the line later on. Add a
+			 * newline to separate the hint from subsequent output.
+			 *
+			 * In case the editor emits further cruft after what
+			 * we wrote above, separate it from our message with SP.
+			 */
+			const char term = is_terminal_dumb() ? '\n' : ' ';
+
+			fprintf(stderr,
+				_("hint: Waiting for your editor to close the file...%c"),
+				term);
+			fflush(stderr);
+		}
 
 		p.argv = args;
 		p.env = env;
@@ -63,6 +80,13 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		if (ret)
 			return error("There was a problem with the editor '%s'.",
 					editor);
+
+		if (print_waiting_for_editor && !is_terminal_dumb())
+			/*
+			 * Go back to the beginning and erase the entire line to
+			 * avoid wasting the vertical space.
+			 */
+			fputs("\r\033[K", stderr);
 	}
 
 	if (!buffer)
-- 
2.15.1-480-gbc5668f98a

