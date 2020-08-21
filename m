Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56FEC433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8888D20748
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hqoeaDhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgHUSqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:46:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56777 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgHUSqM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 14:46:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D39627B2FB;
        Fri, 21 Aug 2020 14:46:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4MHWdSiHtYmrPJqvOhkzAmhY6OE=; b=hqoeaD
        hOWmR+clHnujIer57ViXrqTleUI315N/2HIyxl81wUitsgkuQ8XL6v58pTEQAwfw
        B9mJnPIBhga47cMiu/khxd1qnPrLnsPjuFAdkIcnZNRKmd+eUdrTImfOldp3K5GX
        +m2K14xyz5fXUjpQFOHUciEr8fgKta8wG84Bw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wtIqiQwlKT12D8yOfYGPFipwBc492/n/
        jvkmYCrj9vIXkdPD+BHgQvDX1bYWqCNf//VLDQQNKWE2UBii2TVVdmVRlQkIu7bb
        8LyUkVx9G7AnxW2nvlSJxazbNLfUrzn9ZSCDXmYrfkFPfvrmN+TzdrJnwXNuBy6l
        E/g5r81O984=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB87C7B2FA;
        Fri, 21 Aug 2020 14:46:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55A7B7B2F9;
        Fri, 21 Aug 2020 14:46:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Alvaro Aleman <aaleman@redhat.com>, git@vger.kernel.org
Subject: Re: --author arg on commit only works if there is an email configured already
References: <CAOW=8D2J3t3cE32q2xNqSOPTa6gxR5gSuJUCCj5MSj58ccc3Cg@mail.gmail.com>
        <87ft8fvoow.fsf@igel.home>
Date:   Fri, 21 Aug 2020 11:46:09 -0700
In-Reply-To: <87ft8fvoow.fsf@igel.home> (Andreas Schwab's message of "Fri, 21
        Aug 2020 20:28:15 +0200")
Message-ID: <xmqqr1rz96ry.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 949B595E-E3DE-11EA-BEA6-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Aug 21 2020, Alvaro Aleman wrote:
>
>> It seems the `--author` arg on the `git commit` command only works if
>> an author email is configured already somewhere:
>
> The `--author' argument only sets the author, but git still need to fill
> in the committer.

In other words, the --author option works just fine.  You still need
to tell Git what committer identity you want to use, and the easiest
way to do so is with user.{name,email} configuration variables.

I wonder if it helps to give an extra line of message like the
attached (untested) patch, though.

 ident.c | 51 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/ident.c b/ident.c
index e666ee4e59..177ac00261 100644
--- a/ident.c
+++ b/ident.c
@@ -345,18 +345,35 @@ int split_ident_line(struct ident_split *split, const char *line, int len)
 	return 0;
 }
 
-static const char *env_hint =
-N_("\n"
-   "*** Please tell me who you are.\n"
-   "\n"
-   "Run\n"
-   "\n"
-   "  git config --global user.email \"you@example.com\"\n"
-   "  git config --global user.name \"Your Name\"\n"
-   "\n"
-   "to set your account\'s default identity.\n"
-   "Omit --global to set the identity only in this repository.\n"
-   "\n");
+
+static void ident_env_hint(enum want_ident whose_ident)
+{
+	static const char *env_hint =
+		N_("\n"
+		   "*** Please tell me who you are.\n"
+		   "\n"
+		   "Run\n"
+		   "\n"
+		   "  git config --global user.email \"you@example.com\"\n"
+		   "  git config --global user.name \"Your Name\"\n"
+		   "\n"
+		   "to set your account\'s default identity.\n"
+		   "Omit --global to set the identity only in this repository.\n"
+		   "\n");
+
+	switch (whose_ident) {
+	case WANT_AUTHOR_IDENT:
+		fputs(_("Author identity unknown\n"), stderr);
+		break;
+	case WANT_COMMITTER_IDENT:
+		fputs(_("Committer identity unknown\n"), stderr);
+		break;
+	default:
+		break;
+	}
+
+	fputs(_(env_hint), stderr);
+}
 
 const char *fmt_ident(const char *name, const char *email,
 		      enum want_ident whose_ident, const char *date_str, int flag)
@@ -375,12 +392,12 @@ const char *fmt_ident(const char *name, const char *email,
 	if (!email) {
 		if (strict && ident_use_config_only
 		    && !(ident_config_given & IDENT_MAIL_GIVEN)) {
-			fputs(_(env_hint), stderr);
+			ident_env_hint(whose_ident);
 			die(_("no email was given and auto-detection is disabled"));
 		}
 		email = ident_default_email();
 		if (strict && default_email_is_bogus) {
-			fputs(_(env_hint), stderr);
+			ident_env_hint(whose_ident);
 			die(_("unable to auto-detect email address (got '%s')"), email);
 		}
 	}
@@ -397,13 +414,13 @@ const char *fmt_ident(const char *name, const char *email,
 		if (!name) {
 			if (strict && ident_use_config_only
 			    && !(ident_config_given & IDENT_NAME_GIVEN)) {
-				fputs(_(env_hint), stderr);
+				ident_env_hint(whose_ident);
 				die(_("no name was given and auto-detection is disabled"));
 			}
 			name = ident_default_name();
 			using_default = 1;
 			if (strict && default_name_is_bogus) {
-				fputs(_(env_hint), stderr);
+				ident_env_hint(whose_ident);
 				die(_("unable to auto-detect name (got '%s')"), name);
 			}
 		}
@@ -411,7 +428,7 @@ const char *fmt_ident(const char *name, const char *email,
 			struct passwd *pw;
 			if (strict) {
 				if (using_default)
-					fputs(_(env_hint), stderr);
+					ident_env_hint(whose_ident);
 				die(_("empty ident name (for <%s>) not allowed"), email);
 			}
 			pw = xgetpwuid_self(NULL);
