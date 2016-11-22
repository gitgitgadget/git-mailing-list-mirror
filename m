Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF2AF1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 21:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933737AbcKVVW2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 16:22:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50411 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932904AbcKVVW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 16:22:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F01E4EF80;
        Tue, 22 Nov 2016 16:22:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bXGyt1V4NNlTxkCMGXVvzollhfE=; b=FKKSRI
        gyfHX+84dQjWv56TV7pKRm+p6uR8kff6qZYuwl4Dwm2HtLwN5W1JeGvxM47Wx4vN
        fYx5JsISiZY5rjpvcU5mL9bkA4xvnVjbzUXg9S1S+fY9Nl1RqwyWkT9KI8hIpT3w
        XeS78PMU5SfjryMY9hKD3Mt/X4SAsXHu8rLXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BEUEygRsZ6qptJtzMvO6cat5Zftf/gUY
        AvjhQsY6KarCeyme/R8Hg3BA63s5z4ztCxudUigvKPswh/uPjHT5gGHWYlYx+Vyj
        6LA77g/30EbVW38jvxY130fSvj0Y/B2ZXfLFZ1DOmzTEdDmEvLAvDmGPPPMpg1bA
        CYzJpTPpmRI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05A554EF7E;
        Tue, 22 Nov 2016 16:22:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F0A04EF7A;
        Tue, 22 Nov 2016 16:22:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: Re: [PATCH 2/3] stripspace: respect repository config
References: <cover.1479737858.git.johannes.schindelin@gmx.de>
        <5567548295222401fab10d3f2901c1787afbfd07.1479737858.git.johannes.schindelin@gmx.de>
        <CACsJy8D5oBR+vo2B+Ro2Q4SX0CG3jME4Gfs1_6AohccmpNvD0A@mail.gmail.com>
        <alpine.DEB.2.20.1611221712480.3746@virtualbox>
        <xmqqshqjqw3z.fsf@gitster.mtv.corp.google.com>
        <xmqqzikrpbz2.fsf@gitster.mtv.corp.google.com>
        <20161122195015.rztaixpz7zvdxb4u@sigill.intra.peff.net>
        <xmqqoa17p8k0.fsf@gitster.mtv.corp.google.com>
        <20161122211920.3qdohxdktykqhyga@sigill.intra.peff.net>
Date:   Tue, 22 Nov 2016 13:22:24 -0800
In-Reply-To: <20161122211920.3qdohxdktykqhyga@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 22 Nov 2016 16:19:21 -0500")
Message-ID: <xmqqeg23p5v3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C389C4C4-B0F9-11E6-8F5D-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Nov 22, 2016 at 12:24:15PM -0800, Junio C Hamano wrote:
>
>> > Do you want to do another round of -rc3? Ship with the
>> > minor regressions and fix them up in v2.11.1?
>> 
>> I am leaning towards the former (though we may also end up doing the
>> latter).
>
> I think I'd lead towards -rc3, as well. Our schedule is somewhat
> arbitrary anyway, and one week is less important than somebody picking
> up the new release and trying to puzzle out a regression that we already
> have a fix for.

OK.  The "mailinfo" part turns out a bit more than RUN_SETUP_GENTLY
as it takes paths from the command line that needs to be adjusted
for the prefix.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Tue, 22 Nov 2016 13:13:16 -0800
Subject: [PATCH] mailinfo: read local configuration

Since b9605bc4f2 ("config: only read .git/config from configured
repos", 2016-09-12), we do not read from ".git/config" unless we
know we are in a repository.  "git mailinfo" however didn't do the
repository discovery and instead relied on the old behaviour.  This
was mostly OK because it was merely run as a helper program by other
porcelain scripts that first chdir's up to the root of the working
tree.

Teach the command to run a "gentle" version of repository discovery
so that local configuration variables like mailinfo.scissors are
honoured.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c  | 19 +++++++++++++++----
 git.c               |  2 +-
 t/t5100-mailinfo.sh | 13 +++++++++++++
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index f6df274111..e3b62f2fc7 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -11,15 +11,20 @@
 static const char mailinfo_usage[] =
 	"git mailinfo [-k | -b] [-m | --message-id] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] <msg> <patch> < mail >info";
 
+static char *prefix_copy(const char *prefix, const char *filename)
+{
+	if (!prefix || is_absolute_path(filename))
+		return xstrdup(filename);
+	return xstrdup(prefix_filename(prefix, strlen(prefix), filename));
+}
+
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
 	const char *def_charset;
 	struct mailinfo mi;
 	int status;
+	char *msgfile, *patchfile;
 
-	/* NEEDSWORK: might want to do the optional .git/ directory
-	 * discovery
-	 */
 	setup_mailinfo(&mi);
 
 	def_charset = get_commit_output_encoding();
@@ -54,8 +59,14 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 
 	mi.input = stdin;
 	mi.output = stdout;
-	status = !!mailinfo(&mi, argv[1], argv[2]);
+
+	msgfile = prefix_copy(prefix, argv[1]);
+	patchfile = prefix_copy(prefix, argv[2]);
+
+	status = !!mailinfo(&mi, msgfile, patchfile);
 	clear_mailinfo(&mi);
 
+	free(msgfile);
+	free(patchfile);
 	return status;
 }
diff --git a/git.c b/git.c
index efa1059fe0..fd3abf85d2 100644
--- a/git.c
+++ b/git.c
@@ -445,7 +445,7 @@ static struct cmd_struct commands[] = {
 	{ "ls-files", cmd_ls_files, RUN_SETUP | SUPPORT_SUPER_PREFIX },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
-	{ "mailinfo", cmd_mailinfo },
+	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY },
 	{ "mailsplit", cmd_mailsplit },
 	{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
 	{ "merge-base", cmd_merge_base, RUN_SETUP },
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index e6b995161e..7171f67539 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -158,4 +158,17 @@ test_expect_success 'mailinfo handles rfc2822 comment' '
 	test_cmp "$DATA/comment.expect" comment/info
 '
 
+test_expect_success 'mailinfo with mailinfo.scissors config' '
+	test_config mailinfo.scissors true &&
+	(
+		mkdir sub &&
+		cd sub &&
+		git mailinfo ../msg0014.sc ../patch0014.sc <../0014 >../info0014.sc
+	) &&
+	test_cmp "$DATA/msg0014--scissors" msg0014.sc &&
+	test_cmp "$DATA/patch0014--scissors" patch0014.sc &&
+	test_cmp "$DATA/info0014--scissors" info0014.sc
+'
+
+
 test_done
-- 
2.11.0-rc2-170-g4c384f318f

