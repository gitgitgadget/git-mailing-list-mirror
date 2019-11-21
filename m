Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D230C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 06:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F3820872
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 06:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UsNqtN6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfKUGOj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 01:14:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60564 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKUGOj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 01:14:39 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A0477AD45C;
        Thu, 21 Nov 2019 01:14:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EZeWUKTOrXXqoSpvHy3aXsf8zM0=; b=UsNqtN
        6PuJkZyr6W75NBpZPBS6Sq+ny/pi5utgTnUZ8ctvpjAfiIm4koKbt/ohZRrXPLhv
        GkSG4oyqFvKU7ByMXjw4DZFkxa7iaAgS300nZ8w4BKS9HUHeTZfxnf+ckBSNSXfr
        Q0XxO5ftdgCUiylC3WqjYNYm8cedxAPUc9NZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oh+8KyN4wMzwCodDxWYHLEkwIH58QQnL
        uWb5ZPzQwFR1963+wjm+LxmakkXfRf9v8IvyqhsOFiFKyNZ/HuBZbOaYE9Lx7dOS
        8kEoCs7ORWDE0u/F5rCMYhLeQ06w9Kjb7SCldXFxH5s2I2FrWVUnf8FTX3yqWmRL
        L3pKbmJ2H6k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 897D8AD45B;
        Thu, 21 Nov 2019 01:14:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8766DAD459;
        Thu, 21 Nov 2019 01:14:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: Re: [PATCH v5 0/6] rebase -i: support more options
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
        <20191101140003.13960-1-rohit.ashiwal265@gmail.com>
Date:   Thu, 21 Nov 2019 15:14:28 +0900
In-Reply-To: <20191101140003.13960-1-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Fri, 1 Nov 2019 19:29:57 +0530")
Message-ID: <xmqqimnd92nv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DD8D204-0C26-11EA-BA9E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As I hate to leave a mostly done topic hanging around forever, I am
tempted to queue these fixups on top (instead of squash them in) to
tie the loose ends after a few weeks' inactivity.

Thanks.

-- >8 --
Subject: rebase -i: finishes touches to --reset-author-date

Clarify the way the `--reset-author-date` option is described,
and mark its usage string translatable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-rebase.txt | 6 ++++--
 builtin/rebase.c             | 6 +++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index c8d54d221d..03809da835 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -392,8 +392,10 @@ See also INCOMPATIBLE OPTIONS below.
 
 --ignore-date::
 --reset-author-date::
-	Instead of using the given author date, reset it to the
-	current time. This implies --force-rebase.
+	By default, the author date of the original commit is used
+	as the author date for the resulting commit.  This option
+	tells Git to use the current timestamp instead and implies
+	`--force-rebase`.
 +
 See also INCOMPATIBLE OPTIONS below.
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 44768082b8..d5c09f159c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1437,9 +1437,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			 &options.committer_date_is_author_date,
 			 N_("make committer date match author date")),
 		OPT_BOOL(0, "reset-author-date", &options.ignore_date,
-			 "ignore author date and use current date"),
-		OPT_BOOL(0, "ignore-date", &options.ignore_date,
-			 "ignore author date and use current date"),
+			 N_("ignore author date and use current date")),
+		OPT_HIDDEN_BOOL(0, "ignore-date", &options.ignore_date,
+				N_("synonym of --reset-autohr-date")),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
 				  N_("passed to 'git apply'"), 0),
 		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,


