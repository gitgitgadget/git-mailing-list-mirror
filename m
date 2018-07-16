Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0B6D1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 04:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbeGPFYr (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 01:24:47 -0400
Received: from pug.qqx.org ([50.116.43.67]:40914 "EHLO pug.qqx.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbeGPFYr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 01:24:47 -0400
Received: by pug.qqx.org (Postfix, from userid 1000)
        id DC8421F4F8; Mon, 16 Jul 2018 00:59:15 -0400 (EDT)
From:   Aaron Schrab <aaron@schrab.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Daniel Harding <dharding@living180.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] sequencer: use configured comment character
Date:   Mon, 16 Jul 2018 00:59:02 -0400
Message-Id: <20180716045902.16629-1-aaron@schrab.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <xmqq4lh4z870.fsf@gitster-ct.c.googlers.com>
References: <xmqq4lh4z870.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At 10:15 -0700 12 Jul 2018, Junio C Hamano <gitster@pobox.com> wrote:
>Aaron Schrab <aaron@schrab.com> writes:
>> Note that the comment_line_char has already been resolved by this point,
>> even if the user has configured the comment character to be selected
>> automatically.
>
>Isn't this a slight lie?

Looking into that a bit further, it does seem like my explanation above 
was incorrect.  Here's another attempt to explain why setting 
core.commentChar=auto isn't a problem for this change.

8< -----

Use the configured comment character when generating comments about
branches in a todo list.  Failure to honor this configuration causes a
failure to parse the resulting todo list.

Setting core.commentChar to "auto" will not be honored here, and the
previously configured or default value will be used instead. But, since
the todo list will consist of only generated content, there should not
be any non-comment lines beginning with that character.

Signed-off-by: Aaron Schrab <aaron@schrab.com>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 4034c0461b..caf91af29d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3991,7 +3991,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		entry = oidmap_get(&state.commit2label, &commit->object.oid);
 
 		if (entry)
-			fprintf(out, "\n# Branch %s\n", entry->string);
+			fprintf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
 		else
 			fprintf(out, "\n");
 
-- 
2.18.0.419.gfe4b301394

