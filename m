Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875D4C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 23:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiKVX6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 18:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiKVX6P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 18:58:15 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAD8769F2
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 15:58:13 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id k15so15854356pfg.2
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 15:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIVMDc1NZFF2slx9DEUBGh6lfbUI4DgvmtnKRkUWGtQ=;
        b=NPzRIz5OUA7SudxwymoP284Ej9DWhJDjAqkDPPce32XWgGVoTevDxYcwFJoW68Jcn2
         Kz9XTDSNKlC3Rkm5wjtJPGpRPL1qcP4dAA+kFQRWQ7B2eFoTF5T+62nppgoIB8QlDKvA
         S84EZ+D02GxqrzA7fLbPq06jG4VxLZCLTBGx/mYg3cNnXSsZo86vWwrDVya4pMA8YgHk
         88775mt6H30dihaR2YdU6QD67S3ezHvzCSOZnM6Cb/GbpwSbnfFrgJ9EWE1u95eTgPei
         ykftoR/VnPQ3BEMrjpBFJlYEeYqXgCfECpmXIIgtu7kq6V4A4hEvTLYRk6Rn5Y7RMqak
         GGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CIVMDc1NZFF2slx9DEUBGh6lfbUI4DgvmtnKRkUWGtQ=;
        b=bvRWf+BRvVHI7rx9KWX0QgzQQ648+4tmFsMEHXv8JsSAABjtBUhFij9JTEhU7kCQUg
         MXIJonoi5pErWmopdf1GkjufAoz//PP9pbXrFB9BZ8RLvv5pFG5q7MYRTTO5HaH4PcdU
         9LS5Yl4ykruwo4yf+p6QsVjZqRr5OplU+Tq4k0tX6wLMcOiawkR4I5l1ouikenTle2KK
         eqXH+a7Cauc1GZ0yljvRBSKQoisSRnajeoVw0He/Aogmy56fyxNOK5MfEXJOPn61ufqN
         a85tc0ISnNJguXE27NK8Cy+YchSeI/CLAqiaOLTBJOOPTSoGn33wjh+GaxVmHzM0VyRa
         clgw==
X-Gm-Message-State: ANoB5pnUsMF38vz5yd93I1PKtnynNP87+h6/tECtsLmedOQPxrc3lwvV
        t48x1hoyDddgcSr2aKJDSjJOS9+/OqdNiQ==
X-Google-Smtp-Source: AA0mqf4yqgJSBzOqIF3B2WHPNGnpVEKEhGc/UGlFhRxvQX2J6SlEUuzabKOEF0URFnep0HNizFWFJA==
X-Received: by 2002:a62:cd04:0:b0:56b:d19f:33f8 with SMTP id o4-20020a62cd04000000b0056bd19f33f8mr6331212pfg.17.1669161492772;
        Tue, 22 Nov 2022 15:58:12 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a2-20020a17090a740200b00212c27abcaesm124055pjg.17.2022.11.22.15.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 15:58:12 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] range-diff: support reading mbox files
References: <pull.1420.v2.git.1668899471058.gitgitgadget@gmail.com>
        <pull.1420.v3.git.1669108102092.gitgitgadget@gmail.com>
Date:   Wed, 23 Nov 2022 08:58:12 +0900
In-Reply-To: <pull.1420.v3.git.1669108102092.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Tue, 22 Nov 2022 09:08:21
        +0000")
Message-ID: <xmqqr0xupmnf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +static inline int strtost(char const *s, size_t *result, const char **end)
> +{
> +	unsigned long u;
> +	char *p;
> +
> +	errno = 0;

Minor nit.  If this is to be able to see the error condition from
strtoul(), I think it should be done after the "!isdigit()" test,
immediately before we make strtoul() call, to avoid clearing errno
unnecessarily.

> +	/* negative values would be accepted by strtoul */
> +	if (!isdigit(*s))
> +		return -1;
> +	u = strtoul(s, &p, 10);
> +	if (errno || p == s)
> +		return -1;

> +static int parse_hunk_header(const char *p,
> +			     size_t *old_count, size_t *new_count,
> +			     const char **end)
> +{
> +	size_t o = 1, n = 1;
> +
> +	if (!skip_prefix(p, "@@ -", &p) ||
> +	    strtost(p, NULL, &p) ||
> +	    /* The range is -<start>[,<count>], defaulting to count = 1 */
> +	    !(*p == ' ' || (*p == ',' && !strtost(p + 1, &o, &p))) ||
> +	    !skip_prefix(p, " +", &p) ||
> +	    strtost(p, NULL, &p) ||
> +	    /* The range is +<start>[,<count>], defaulting to count = 1 */
> +	    !(*p == ' ' || (*p == ',' && !strtost(p + 1, &n, &p))) ||
> +	    !skip_prefix(p, " @@", &p))
> +		return -1;
> +
> +	*old_count = o;
> +	*new_count = n;
> +	*end = p;

We care only about how long the hunk is, and do not care exactly
where in the preimage it sits.  The code looks correct, but for such
a specialized "parser", the name of the function gives a false
impression that it does a lot more.  Finding it only slightly
disturbing.

> + * This function finds the end of the line, replaces the newline character with
> + * a NUL, and returns the offset of the start of the next line.
> + *
> + * If no newline character was found, it returns the offset of the trailing NUL
> + * instead.

Pretty bog-standard "read each line" helper.  I suspect we may want
to consolidate multiple copies we may have elsewhere after the dust
settles.  Looking good.

> +static inline int find_next_line(const char *line, size_t size)
> +{
> +	char *eol;
> +
> +	eol = memchr(line, '\n', size);
> +	if (!eol)
> +		return size;
> +
> +	*eol = '\0';
> +
> +	return eol + 1 - line;
> +}




> +static int read_mbox(const char *path, struct string_list *list)
> +{
> +	struct strbuf buf = STRBUF_INIT, contents = STRBUF_INIT;
> +	struct strbuf long_subject = STRBUF_INIT;
> +	struct patch_util *util = NULL;
> +	enum {
> +		MBOX_BEFORE_HEADER,
> +		MBOX_IN_HEADER,
> +		MBOX_IN_COMMIT_MESSAGE,
> +		MBOX_AFTER_TRIPLE_DASH,
> +		MBOX_IN_DIFF
> +	} state = MBOX_BEFORE_HEADER;
> +	char *line, *current_filename = NULL;
> +	int len;
> +	size_t size, old_count = 0, new_count = 0;
> +	const char *author = NULL, *subject = NULL;
> +
> +	if (!strcmp(path, "-")) {
> +		if (strbuf_read(&contents, STDIN_FILENO, 0) < 0)
> +			return error_errno(_("could not read stdin"));
> +	} else if (strbuf_read_file(&contents, path, 0) < 0)
> +		return error_errno(_("could not read '%s'"), path);
> +
> +	line = contents.buf;
> +	size = contents.len;
> +	for (; size; size -= len, line += len) {
> +		const char *p;
> +
> +		len = find_next_line(line, size);
> +
> +		if (state == MBOX_BEFORE_HEADER) {
> +parse_from_delimiter:
> +			if (!skip_prefix(line, "From ", &p))
> +				continue;
> +
> +			if (util)
> +				BUG("util already allocated");

OK.  The only transition that brings us into _BEFORE_HEADER state
is from _IN_DIFF and we consume and clear the current util there
before the transition happens, so this BUG() will trigger only when
there is some programming error, not any data errors.

Good.

> +			util = xcalloc(1, sizeof(*util));
> +			if (get_oid_hex(p, &util->oid) < 0)
> +				oidcpy(&util->oid, null_oid());
> +			util->matching = -1;
> +			author = subject = NULL;
> +
> +			state = MBOX_IN_HEADER;
> +			continue;
> +		}
> +
> +		if (starts_with(line, "diff --git ")) {
> +			struct patch patch = { 0 };
> +			struct strbuf root = STRBUF_INIT;
> +			int linenr = 0;
> +			int orig_len;
> +
> +			state = MBOX_IN_DIFF;
> +			old_count = new_count = 0;
> +			strbuf_addch(&buf, '\n');
> +			if (!util->diff_offset)
> +				util->diff_offset = buf.len;
> +
> +			orig_len = len;
> +			/* `find_next_line()`'s replaced the LF with a NUL */
> +			line[len - 1] = '\n';

Does this work correctly when the input ended with an incomplete
line that lacked the final LF?  find_next_line() would have given
the size of the remaining input, and the byte at line[len-1] is the
last byte on the incomplete line that is not LF.

> +			len = len > 1 && line[len - 2] == '\r' ?
> +				error(_("cannot handle diff headers with "
> +					"CR/LF line endings")) :
> +				parse_git_diff_header(&root, &linenr, 1, line,
> +						      len, size, &patch);

Cute (in that it tries to use a single "len < 0" for all error
conditions) but moderately hard to follow.

> +			if (len < 0) {
> +				error(_("could not parse git header '%.*s'"),
> +				      orig_len, line);
> +				release_patch(&patch);
> +				free(util);
> +				free(current_filename);
> +				string_list_clear(list, 1);
> +				strbuf_release(&buf);
> +				strbuf_release(&contents);
> +				strbuf_release(&long_subject);
> +				return -1;
> +			}

OK.

> +			if (patch.old_name)
> +				skip_prefix(patch.old_name, "a/",
> +					    (const char **)&patch.old_name);
> +			if (patch.new_name)
> +				skip_prefix(patch.new_name, "b/",
> +					    (const char **)&patch.new_name);

Do we only accept "-p1" patches?  From time to time we seem to hear
on this list from folks in communities that do not use -p1 (aka a/
and b/) convention.

> +		} else if (state == MBOX_IN_HEADER) {
> +			if (!line[0]) {

OK.  After seeing a block of header lines, the first empty line
signals the end of the headers and we transition into a new state.

> +				state = MBOX_IN_COMMIT_MESSAGE;

As an in-body "From:" can have have another blank line or some
in-body header other than "From: " before it at the beginning of an
e-mail body, I do not think this is a good code structure.  I would
have expected that the first blank line would transition us into a
new state (in-commit-messages state) without doing anything else and
in that state:

 - Leading blank lines are skipped, and we will stay in the same state.

 - From:, Subject:, Date:, etc. are interpreted as in-body headers,
   and we will stay in the same state, expecting more in-body
   headers,

 - Everything else will bring us into "we are now really reading the
   log" state (do not lose that line that made us transition into
   the new state---that line is the first line of the body).

would happen.

> +		} else if (state == MBOX_IN_COMMIT_MESSAGE) {
> +			if (!line[0]) {
> +				strbuf_addch(&buf, '\n');
> +			} else if (strcmp(line, "---")) {
> +				int tabs = 0;
> +
> +				/* simulate tab expansion */
> +				while (line[tabs] == '\t')
> +					tabs++;
> +				strbuf_addf(&buf, "%*s%s\n",
> +					    4 + 8 * tabs, "", line + tabs);

I am not sure if special casing the empty line above is correct.  I
am assuming that you are pretending as if you read an "git show -s"
output after applying that patch, but "git log" gives a 4-space
indent even for an empty line, I think.  A quick sanity check

    $ git show -s | cat -e

on the patch I am responding to tells me that it is the case.

I'll stop here, as I see Phillip saw the reading of "diff --git"
output well enough to notice that diff.suppressBlankEmpty is handled
correctly and I'd trust his review.

Thanks.
