Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36B7C54E8D
	for <git@archiver.kernel.org>; Mon, 11 May 2020 15:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D9F5206DB
	for <git@archiver.kernel.org>; Mon, 11 May 2020 15:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AzUn6lM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgEKPgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 11:36:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63173 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgEKPgM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 11:36:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 69520D1916;
        Mon, 11 May 2020 11:36:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P3V+Yr41xKY7rCumH2S2L9uX8+s=; b=AzUn6l
        M+CeN+JiqVwcUCjotAZ+pEoz6IhLfFWByovgT9tRjNwcOIQlwOEef20En5btHKjl
        qJFUEOlHBFbcEElX3jsjI4EBz4ZCC8976dZPuntA8IzHIm2jyuWI+i+7ag4JlYmM
        0fu8t/OZQ4IWFXrEq5B5MIxBQeDbIbXqaIHHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Inzxy9/Iw3ojs95wRjF47LQ2l0xNGWWP
        oYRKQ1qBPs7Lc++L28F0z8pPfOWLa8Emldt6pmJSfJj8OrlZHm8UubCwHv6CeqPi
        ZmfeCsygKzwfm6E5Y63ORqwwPPP6AVW5WiEYLyoIQ5P81ld8If/WQqFldCBmzhtN
        6J6PyCXUODQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6143ED1915;
        Mon, 11 May 2020 11:36:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A34C1D1913;
        Mon, 11 May 2020 11:36:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     George Brown <321.george@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] contrib/git-jump: cat output when not a terminal
References: <CAFKec1W0-OOQYypP-3VC=dJnuNDrykdQ2xibc=u4D=Zo6if-+Q@mail.gmail.com>
        <xmqqd07cvl9b.fsf@gitster.c.googlers.com>
        <CAFKec1Wj_uK-moVfin3XrTEmmBaAzaJKsh1f8q-3+RBs2-3Jdg@mail.gmail.com>
        <xmqq8si0vfp3.fsf@gitster.c.googlers.com>
        <CAFKec1UGKbaV7wC78i8+uSEizjGkj2bDSfOeucvJORhORvc5KA@mail.gmail.com>
        <xmqqwo5ju47t.fsf@gitster.c.googlers.com>
        <CAFKec1Wy1iT8Z=gNDBn++XLxzGWr0UUiu3AKMU-qaR+jj2yoKQ@mail.gmail.com>
        <xmqqo8qvu0ao.fsf@gitster.c.googlers.com>
        <CAFKec1VGzpxVJV4zak46r_p2gGcw4UanFr7U4U4MSsG7t2A23w@mail.gmail.com>
        <20200511143157.GA1415@coredump.intra.peff.net>
Date:   Mon, 11 May 2020 08:36:05 -0700
In-Reply-To: <20200511143157.GA1415@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 11 May 2020 10:31:57 -0400")
Message-ID: <xmqqr1vqscuy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21F1B632-939D-11EA-B432-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>  - I'm pretty sure git-jump does _not_ work with emacs or emacsclient.

;-)  Its output can be used in M-x find-grep, though, actually.

>    However, it should work with gvim, and any isatty() check would
>    potentially cause issues there. So I'd much prefer the caller say
>    explicitly that they're not expecting the editor to start.

Yes, that is exactly what I was worried about.

> So I'm OK to leave the status quo and let people use the GIT_EDITOR
> solution in this instance. But I'd also be happy to take a patch for
> "--no-editor" or similar if somebody wants to work it up.

I actually would support --no-editor.  One thing nobody noticed so
far is that "git-jump" is only compatible with editors that support
the "-q" option from the command line, and "cat" is not among them.


Another thing I was thinking about was a change like the attached.
Plugging it thru "git var" to allow "git var GIT_JUMP_EDITOR" may
allow vim users to set it to 'cat' while setting GIT_EDITOR to vim.

It still needs a fix to get rid of the uncondtional "-q" option from
open_editor() function, though.


 cache.h  |  2 +-
 editor.c | 33 ++++++++++++++++++++++-----------
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/cache.h b/cache.h
index 0f0485ecfe..b3f7a6d6c4 100644
--- a/cache.h
+++ b/cache.h
@@ -1649,7 +1649,7 @@ const char *fmt_ident(const char *name, const char *email,
 const char *fmt_name(enum want_ident);
 const char *ident_default_name(void);
 const char *ident_default_email(void);
-const char *git_editor(void);
+const char *git_editor(const char *);
 const char *git_sequence_editor(void);
 const char *git_pager(int stdout_is_tty);
 int is_terminal_dumb(void);
diff --git a/editor.c b/editor.c
index 91989ee8a1..3d04824e9e 100644
--- a/editor.c
+++ b/editor.c
@@ -14,11 +14,29 @@ int is_terminal_dumb(void)
 	return !terminal || !strcmp(terminal, "dumb");
 }
 
-const char *git_editor(void)
+const char *git_editor(const char *program)
 {
-	const char *editor = getenv("GIT_EDITOR");
+	const char *editor = NULL;
 	int terminal_is_dumb = is_terminal_dumb();
 
+	if (program) {
+		char *varname;
+
+		varname = xstrfmt("GIT_%s_EDITOR", program);
+		editor = getenv(varname);
+		free(varname);
+
+		if (!editor) {
+			struct strbuf progname = STRBUF_INIT;
+			strbuf_addstr(&progname, program);
+			strbuf_tolower(&progname);
+			varname = xstrfmt("%s.editor", progname.buf);
+			git_config_get_string_const(varname, &editor);
+			free(varname);
+			strbuf_release(&progname);
+		}
+	}
+
 	if (!editor && editor_program)
 		editor = editor_program;
 	if (!editor && !terminal_is_dumb)
@@ -37,14 +55,7 @@ const char *git_editor(void)
 
 const char *git_sequence_editor(void)
 {
-	const char *editor = getenv("GIT_SEQUENCE_EDITOR");
-
-	if (!editor)
-		git_config_get_string_const("sequence.editor", &editor);
-	if (!editor)
-		editor = git_editor();
-
-	return editor;
+	return git_editor("SEQUENCE");
 }
 
 static int launch_specified_editor(const char *editor, const char *path,
@@ -118,7 +129,7 @@ static int launch_specified_editor(const char *editor, const char *path,
 
 int launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
 {
-	return launch_specified_editor(git_editor(), path, buffer, env);
+	return launch_specified_editor(git_editor(NULL), path, buffer, env);
 }
 
 int launch_sequence_editor(const char *path, struct strbuf *buffer,
