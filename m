Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 066D82070C
	for <e@80x24.org>; Wed,  6 Jul 2016 15:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbcGFPRg (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 11:17:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753130AbcGFPRf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 11:17:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 24622297DE;
	Wed,  6 Jul 2016 11:17:29 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GQOz3XYcHu3UJQkuV0kP1q29lXA=; b=Is2DMl
	SkN2rRD8WePWbMQgD/9xhf1fExuwV2B38KtbYpE05+6/Qu3yjmlM10VsCiszbmiN
	46bj8+Qyh7X1NAGFaSy3seJMXKzha8Ez3RHrPqGfyyA9ytVZWUwM9einOpWoiPJ/
	L7zwNkzPdXTK/8CyK+U/nGNCeDpGCEJE4qf0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m3rZg8j68EPIpnc5Jfzj7YInf3hefTok
	FmYnuw33qk8itXbyBWTTNsw6xp6hRTz6pMWXysA1tyV2WgkmGL2u3WzZ3H/K1osb
	dqrk5trKOk+PL+B/n4EKxMJGdq+U1wcGnLqsWVUEP0TpuKZQYAluwXotY5tL907u
	M+7mGOtsZAc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C4E5297DD;
	Wed,  6 Jul 2016 11:17:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 990FF297DC;
	Wed,  6 Jul 2016 11:17:28 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	"dmh\@ucar.edu" <dmh@ucar.edu>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] consistent setup code for external commands
References: <7210bce6-093b-9fdf-9a9b-94059ad0d4e3@ucar.edu>
	<20160701040715.GB4832@sigill.intra.peff.net>
	<20160701055532.GA4488@sigill.intra.peff.net>
	<xmqq4m89vw5i.fsf@gitster.mtv.corp.google.com>
	<20160701223912.GB32545@sigill.intra.peff.net>
Date:	Wed, 06 Jul 2016 08:17:26 -0700
In-Reply-To: <20160701223912.GB32545@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 1 Jul 2016 18:39:12 -0400")
Message-ID: <xmqq60sivlrt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C08DA89C-438C-11E6-8EAB-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jul 01, 2016 at 03:19:37PM -0700, Junio C Hamano wrote:
>
>> > Here they are:
>> >
>> >   [1/5]: add an extra level of indirection to main()
>> >   [2/5]: common-main: call git_extract_argv0_path()
>> >   [3/5]: common-main: call sanitize_stdfds()
>> >   [4/5]: common-main: call restore_sigpipe_to_default()
>> >   [5/5]: common-main: call git_setup_gettext()
>> 
>> As this is also a fix to maint-2.8 track, I tweaked them to ensure
>> that they apply there, and queued the result as jk/common-main.  I
>> double checked the result by comparing the result of applying these
>> five patches directly on top of master, and the result of merging
>> that jk/common-main (based on maint-2.8) into master, and they seem
>> to match.
>
> Thanks, this obviously is a regression in v2.8, but I didn't even think
> about that and just built it on top of master.
>
> I think the cleanup that Dscho suggested elsewhere in the thread is a
> good idea on top, but that can also just wait and come separately.

OK.

I think that amounts to the following single patch, which I cherry
picked from the topic in Dscho's repository he mentioned earlier.

With this applied on top of jk/common-main-2.8, when I merge it to
his b764cdf, the result matches his common-main topic, so we three
are on the same page, I'd think, and the result can be fed to the
2.8.x maintenance track.

-- >8 --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Fri, 1 Jul 2016 15:01:28 +0200
Subject: [PATCH] mingw: declare main()'s argv as const

In 84d32bf (sparse: Fix mingw_main() argument number/type errors,
2013-04-27), we addressed problems identified by the 'sparse' tool where
argv was declared inconsistently. The way we addressed it was by casting
from the non-const version to the const-version.

This patch is long overdue, fixing compat/mingw.h's declaration to
make the "argv" parameter const.  This also allows us to lose the
"const" trickery introduced earlier to common-main.c:main().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 common-main.c  | 8 +-------
 compat/mingw.h | 2 +-
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/common-main.c b/common-main.c
index 3be5ad1..44a29e8 100644
--- a/common-main.c
+++ b/common-main.c
@@ -22,15 +22,9 @@ static void restore_sigpipe_to_default(void)
 	signal(SIGPIPE, SIG_DFL);
 }
 
-int main(int argc, char **av)
+int main(int argc, const char **argv)
 {
 	/*
-	 * This const trickery is explained in
-	 * 84d32bf7678259c08406571cd6ce4b7a6724dcba
-	 */
-	const char **argv = (const char **)av;
-
-	/*
 	 * Always open file descriptors 0/1/2 to avoid clobbering files
 	 * in die().  It also avoids messing up when the pipes are dup'ed
 	 * onto stdin/stdout/stderr in the child processes we spawn.
diff --git a/compat/mingw.h b/compat/mingw.h
index 69bb43d..1ac9086 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -535,7 +535,7 @@ extern CRITICAL_SECTION pinfo_cs;
 void mingw_startup();
 #define main(c,v) dummy_decl_mingw_main(); \
 static int mingw_main(c,v); \
-int main(int argc, char **argv) \
+int main(int argc, const char **argv) \
 { \
 	mingw_startup(); \
 	return mingw_main(__argc, (void *)__argv); \
-- 
2.9.0-457-ge524329

