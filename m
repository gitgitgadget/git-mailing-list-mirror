Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAEF11FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 18:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbcLISdv (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 13:33:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63114 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751610AbcLISdu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 13:33:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63DFC5520A;
        Fri,  9 Dec 2016 13:33:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jY9Je42hB5B90iQ5DL0EvyCa9b8=; b=Obnn93
        0vQUDBtW1C8M5qa+NjxX3g219aso5svPxuZlU/5Um+QlMe4PMf9EHSzsdaWRsvIo
        HXT+UgwrzAJQlcE+oAoGgOgsofMhwCL10I0Zpd1vfxygDqYU12cNGdy3wuxnqnOK
        /3eO6VVQb6YAL2i1nOAz7BL1rwUJfSBSz1yhA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=djr8/CUNMUpbljrH4DlQaiculQHzHyDz
        eALuN6X7ocs8bVGMLjTHey/SCFwJlz3gQKtft1kt/cYgejLv9HuZ2V/9+nBpoL1F
        vbSawzkbMTp/5i0W2Je0OWKIf5BXXcYqY+G9vjEierplibS/PrK4fVHhBDvaQjKv
        mMN2AuqIy2U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B2A955208;
        Fri,  9 Dec 2016 13:33:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A164755207;
        Fri,  9 Dec 2016 13:33:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1?= =?utf-8?Q?bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH 4/5] Make sequencer abort safer
References: <20161207215133.13433-1-s-beyer@gmx.net>
        <20161207215133.13433-4-s-beyer@gmx.net>
        <alpine.DEB.2.20.1612081627290.23160@virtualbox>
        <xmqqr35itjor.fsf@gitster.mtv.corp.google.com>
        <c02708de-8b47-e490-4a1e-77f5727b1156@gmx.net>
Date:   Fri, 09 Dec 2016 10:33:47 -0800
In-Reply-To: <c02708de-8b47-e490-4a1e-77f5727b1156@gmx.net> (Stephan Beyer's
        message of "Thu, 8 Dec 2016 20:17:29 +0100")
Message-ID: <xmqq4m2drlys.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06721C7C-BE3E-11E6-9310-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephan Beyer <s-beyer@gmx.net> writes:

> However:
>
>> -static void update_curr_file()
>> +static void update_current_file(void)
>
> This function name could lead to the impression that there is some
> current file (defined by a global state or whatever) that is updated.
>
> So I'd rather rename the *file* to one of
>
>  * sequencer/abort-safety (consistent to am, describes its purpose)
>  * sequencer/safety (shorter, still describes the purpose)
>  * sequencer/current-head (describes what it contains)
>  * sequencer/last (a four-letter word, not totally unambiguous though)

OK, so here is a patch that needs to be squashed further on top of
4/5.  I just picked the first one on your list ;-)

Thanks.

 sequencer.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 874aaa4cd4..3ac4cb8d3b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -27,7 +27,7 @@ GIT_PATH_FUNC(git_path_seq_dir, "sequencer")
 static GIT_PATH_FUNC(git_path_todo_file, "sequencer/todo")
 static GIT_PATH_FUNC(git_path_opts_file, "sequencer/opts")
 static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
-static GIT_PATH_FUNC(git_path_current_file, "sequencer/current")
+static GIT_PATH_FUNC(git_path_abort_safety_file, "sequencer/abort-safety")
 
 /*
  * A script to set the GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
@@ -306,7 +306,7 @@ static int error_dirty_index(struct replay_opts *opts)
 	return -1;
 }
 
-static void update_current_file(void)
+static void update_abort_safety_file(void)
 {
 	struct object_id head;
 
@@ -315,9 +315,9 @@ static void update_current_file(void)
 		return;
 
 	if (!get_oid("HEAD", &head))
-		write_file(git_path_current_file(), "%s", oid_to_hex(&head));
+		write_file(git_path_abort_safety_file(), "%s", oid_to_hex(&head));
 	else
-		write_file(git_path_current_file(), "%s", "");
+		write_file(git_path_abort_safety_file(), "%s", "");
 }
 
 static int fast_forward_to(const unsigned char *to, const unsigned char *from,
@@ -349,7 +349,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	strbuf_release(&sb);
 	strbuf_release(&err);
 	ref_transaction_free(transaction);
-	update_current_file();
+	update_abort_safety_file();
 	return 0;
 }
 
@@ -824,7 +824,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 
 leave:
 	free_message(commit, &msg);
-	update_current_file();
+	update_abort_safety_file();
 
 	return res;
 }
@@ -1149,18 +1149,18 @@ static int rollback_is_safe(void)
 	struct strbuf sb = STRBUF_INIT;
 	struct object_id expected_head, actual_head;
 
-	if (strbuf_read_file(&sb, git_path_current_file(), 0) >= 0) {
+	if (strbuf_read_file(&sb, git_path_abort_safety_file(), 0) >= 0) {
 		strbuf_trim(&sb);
 		if (get_oid_hex(sb.buf, &expected_head)) {
 			strbuf_release(&sb);
-			die(_("could not parse %s"), git_path_current_file());
+			die(_("could not parse %s"), git_path_abort_safety_file());
 		}
 		strbuf_release(&sb);
 	}
 	else if (errno == ENOENT)
 		oidclr(&expected_head);
 	else
-		die_errno(_("could not read '%s'"), git_path_current_file());
+		die_errno(_("could not read '%s'"), git_path_abort_safety_file());
 
 	if (get_oid("HEAD", &actual_head))
 		oidclr(&actual_head);
@@ -1436,7 +1436,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 		return -1;
 	if (save_opts(opts))
 		return -1;
-	update_current_file();
+	update_abort_safety_file();
 	res = pick_commits(&todo_list, opts);
 	todo_list_release(&todo_list);
 	return res;
