Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D260C433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 20:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC696619C5
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 20:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhC3UhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 16:37:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56410 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbhC3UhB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 16:37:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 07F0A11A80B;
        Tue, 30 Mar 2021 16:37:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p6TAdi7GWGMlyp4z2fgMxwzaB8w=; b=A7/miw
        XxeqWbv88Skp+U9OGOwgEhXjgDHul67zzrwLpnqMUlNmyONRbX2mXPN0fNoNsHLK
        MCjm3lBWy/+flw6cUjMM3AhX3WPqjyZeuC1X30DbYo1ek9dCqh+Zumq4ivoFHMXv
        sXfZrG6tCyx1tRvIuY38gwqvh6HuQOSTBq+nY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VvuPLlvDPoz5NYlYayGZnNXdAp47lIvH
        i/y324a1RWLOLzAWY1ZBvZ+hpRQhNmZrcBvZsjgDVEjdBZEmjEOAN6HY7JiJR1Ee
        lEG/CKNofYi1HrQ5qO9thJOTUiPQObcSA64QCR2A37+InAXJmCT+4ZihxuUxCDiK
        IaoiLkQ1q7Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 010B711A80A;
        Tue, 30 Mar 2021 16:37:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2CB6111A807;
        Tue, 30 Mar 2021 16:36:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stavros Ntentos <stdedos@gmail.com>
Cc:     git@vger.kernel.org, stdedos+git@gmail.com, bagasdotme@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v2] pathspec: advice: long and short forms are incompatible
References: <xmqqmtunks8q.fsf@gitster.g>
        <20210330190517.21138-1-133706+stdedos@users.noreply.github.com>
Date:   Tue, 30 Mar 2021 13:36:56 -0700
In-Reply-To: <20210330190517.21138-1-133706+stdedos@users.noreply.github.com>
        (Stavros Ntentos's message of "Tue, 30 Mar 2021 22:05:17 +0300")
Message-ID: <xmqqo8f0cr9z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC50CF7C-9197-11EB-B24D-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stavros Ntentos <stdedos@gmail.com> writes:

>> It may be more helpful if, rather than looking at what comes after
>> '(', we looked at what came before '(' and helped the user write
>> them out in the longform
>
> I don't see any explicit code in parsing the shortform magics, except:
> 		/* Special case alias for '!' */
> 		if (ch == '^') {
> 			*magic |= PATHSPEC_EXCLUDE;
> 			continue;
> 		}
> and therefore I would like to avoid such task (although I love well-written
> DWIMs-or-close-to-them).

I am not yet interested in doing DWIM, but a good advice is always
welcome.

Along the lines of the attached illustration patch, perhaps.

    $ git show --oneline --stat -- ':/!(glob)**/*.txt'
    hint: ':/!(...': cannot mix short- and longform pathspec magic
    hint: instead, spell the shortform magic '/!' as 'top,exclude' inside :(...


 Documentation/config/advice.txt |  3 +++
 advice.c                        |  3 +++
 advice.h                        |  2 ++
 pathspec.c                      | 29 +++++++++++++++++++++++++++++
 4 files changed, 37 insertions(+)

diff --git c/Documentation/config/advice.txt w/Documentation/config/advice.txt
index acbd0c09aa..05a3cbc164 100644
--- c/Documentation/config/advice.txt
+++ w/Documentation/config/advice.txt
@@ -119,4 +119,7 @@ advice.*::
 	addEmptyPathspec::
 		Advice shown if a user runs the add command without providing
 		the pathspec parameter.
+	mixedPathspecMagic::
+		Advice shown if a user tries to mix short- and
+		longform pathspec magic.
 --
diff --git c/advice.c w/advice.c
index 164742305f..9426bc5295 100644
--- c/advice.c
+++ w/advice.c
@@ -33,6 +33,7 @@ int advice_checkout_ambiguous_remote_branch_name = 1;
 int advice_submodule_alternate_error_strategy_die = 1;
 int advice_add_ignored_file = 1;
 int advice_add_empty_pathspec = 1;
+int advice_mixed_pathspec_magic = 1;
 
 static int advice_use_color = -1;
 static char advice_colors[][COLOR_MAXLEN] = {
@@ -95,6 +96,7 @@ static struct {
 	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
 	{ "addIgnoredFile", &advice_add_ignored_file },
 	{ "addEmptyPathspec", &advice_add_empty_pathspec },
+	{ "mixedPathspecMagic", &advice_mixed_pathspec_magic },
 
 	/* make this an alias for backward compatibility */
 	{ "pushNonFastForward", &advice_push_update_rejected }
@@ -113,6 +115,7 @@ static struct {
 	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated", 1 },
 	[ADVICE_IGNORED_HOOK]				= { "ignoredHook", 1 },
 	[ADVICE_IMPLICIT_IDENTITY]			= { "implicitIdentity", 1 },
+	[ADVICE_MIXED_PATHSPEC_MAGIC]			= { "mixedPathspecMagic", 1 },
 	[ADVICE_NESTED_TAG]				= { "nestedTag", 1 },
 	[ADVICE_OBJECT_NAME_WARNING]			= { "objectNameWarning", 1 },
 	[ADVICE_PUSH_ALREADY_EXISTS]			= { "pushAlreadyExists", 1 },
diff --git c/advice.h w/advice.h
index bc2432980a..d56c1896a0 100644
--- c/advice.h
+++ w/advice.h
@@ -33,6 +33,7 @@ extern int advice_checkout_ambiguous_remote_branch_name;
 extern int advice_submodule_alternate_error_strategy_die;
 extern int advice_add_ignored_file;
 extern int advice_add_empty_pathspec;
+extern int advice_mixed_pathspec_magic;
 
 /*
  * To add a new advice, you need to:
@@ -51,6 +52,7 @@ extern int advice_add_empty_pathspec;
 	ADVICE_GRAFT_FILE_DEPRECATED,
 	ADVICE_IGNORED_HOOK,
 	ADVICE_IMPLICIT_IDENTITY,
+	ADVICE_MIXED_PATHSPEC_MAGIC,
 	ADVICE_NESTED_TAG,
 	ADVICE_OBJECT_NAME_WARNING,
 	ADVICE_PUSH_ALREADY_EXISTS,
diff --git c/pathspec.c w/pathspec.c
index 18b3be362a..ce9d1738a8 100644
--- c/pathspec.c
+++ w/pathspec.c
@@ -336,6 +336,32 @@ static const char *parse_long_magic(unsigned *magic, int *prefix_len,
 	return pos;
 }
 
+/*
+ * Give hint for a common mistake of mixing short and long
+ * form of pathspec magic
+ */
+static void warn_mixed_magic(unsigned magic, const char *elem, const char *pos)
+{
+	struct strbuf longform = STRBUF_INIT;
+	int i;
+
+	if (!advice_enabled(ADVICE_MIXED_PATHSPEC_MAGIC))
+		return;
+	for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
+		if (pathspec_magic[i].bit & magic) {
+			if (longform.len)
+				strbuf_addch(&longform, ',');
+			strbuf_addstr(&longform, pathspec_magic[i].name);
+		}
+	}
+	advise(_("'%.*s(...': cannot mix short- and longform pathspec magic"),
+	       (int)(pos - elem), elem);
+	advise(_("instead, spell the shortform magic '%.*s' as '%s' inside :(..."),
+	       (int)(pos - (elem + 1)), elem + 1,
+	       longform.buf);
+}
+
+
 /*
  * Parse the pathspec element looking for short magic
  *
@@ -356,6 +382,9 @@ static const char *parse_short_magic(unsigned *magic, const char *elem)
 			continue;
 		}
 
+		if (ch == '(')
+			warn_mixed_magic(*magic, elem, pos);
+
 		if (!is_pathspec_magic(ch))
 			break;
 
