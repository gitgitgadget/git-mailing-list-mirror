Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 617611F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 02:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbfJ1C0g (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 22:26:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55716 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfJ1C0g (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Oct 2019 22:26:36 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43932201D8;
        Sun, 27 Oct 2019 22:26:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=byLDhUUOr/ab/kFILuwrwFjPT9w=; b=tz88MV
        0HyXja4AlNTm7KYEAJngZaxOcL2HR3Bchrr2WBcauQo4DRz6l3rHEOiIKkbOCb1L
        k5jS0167XPwungIehFXGo9Zp4aExwycjCaetCPXZM4JcHzIM4C3xXBy/6ytwpCUw
        VUkmk64/KygjcNF17Nln58RzuhL8w+3rDdWfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YKMX13t4eWfKuxijmYz4e0eqJep/alkC
        G/SL41n9PlDs6Udq2i4t0pSpdVMRJq7t9rJZHl1uOdTjiPKfvn8hqbLYd5CqZ55U
        GGktl4wfvzLDNsGNVPmU3LUOBOaNUCqXOtfiUOWeF9X8/5EwG1I+HcsO3IfgCmPV
        Lt0j6ULvI9s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2BE1A201D5;
        Sun, 27 Oct 2019 22:26:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6EBF8201D3;
        Sun, 27 Oct 2019 22:26:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] worktree: teach "add" to ignore submodule.recurse config
References: <pull.430.git.1572196585.gitgitgadget@gmail.com>
Date:   Mon, 28 Oct 2019 11:26:32 +0900
In-Reply-To: <pull.430.git.1572196585.gitgitgadget@gmail.com> (Philippe Blain
        via GitGitGadget's message of "Sun, 27 Oct 2019 17:16:24 +0000")
Message-ID: <xmqqtv7ta9lz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BBF030A-F92A-11E9-B2B1-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  3. I'm on OS X 10.11.6 (Apple clang-800.0.42.1) and I get a warning
>     compiling builtin/merge.c : 
>     
>     >     CC builtin/merge.o
>     builtin/merge.c:831:33: warning: data argument not used by format string [-Wformat-extra-args]
>                             no_scissors_editor_comment), comment_line_char);
>                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~  ^
>     builtin/merge.c:809:4: note: format string is defined here
>     N_("An empty message aborts the commit.\n");
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     ./gettext.h:86:20: note: expanded from macro 'N_'
>     #define N_(msgid) (msgid)
>                        ^~~~~
>     1 warning generated.

I am not sure if the compiler needs fixing in this case, but the
following may work it around.

 builtin/merge.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index e2ccbc44e2..0746f11df2 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -826,9 +826,12 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 			strbuf_commented_addf(&msg, "\n");
 		}
 		strbuf_commented_addf(&msg, _(merge_editor_comment));
-		strbuf_commented_addf(&msg, _(cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS ?
-			scissors_editor_comment :
-			no_scissors_editor_comment), comment_line_char);
+
+		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
+			strbuf_commented_addf(&msg, _(scissors_editor_comment));
+		else
+			strbuf_commented_addf(&msg, _(no_scissors_editor_comment),
+					      comment_line_char);
 	}
 	if (signoff)
 		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
