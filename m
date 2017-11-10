Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D72C1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 19:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753660AbdKJTVx (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 14:21:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64088 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753581AbdKJTVx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 14:21:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 57D1FBEA7F;
        Fri, 10 Nov 2017 14:21:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=4Tr5+1M5FyMuQ8Cns677MiH+Li8=; b=rKQfTGAc5QWZkwdM2C8o
        VJPb2Mdiwl6PXamrXBKHJHBQGyQIMGVlHqT+eHhWWP265EdMfCcX2i+orjmRfi0q
        Xmg5WbQ1DhWXBBftFLl9X1q4VqElHB94UsMJC092dnPbIQn4wDcmaeRHkIIfnCVz
        50rEgHp5sQKPDwI/2KTazCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=ef0FBspXEng6eWjQqhIGQoBjLNiXZ40l+86xu/wDpgkvtk
        uYTQpI1mDja7XTRZ7anHCZ1cZuW9vsbW4um0/5nom7f+ljvSwgqZGJ/18YRhuUWD
        lazZ/G2JELnrkaC8FvOIEdcDmcfczNFBGYqhuBySpgkcr9UUvaHAo7VwA6ibI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E4D3BEA7E;
        Fri, 10 Nov 2017 14:21:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BFC89BEA7C;
        Fri, 10 Nov 2017 14:21:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/9] sequencer: dont't fork git commit
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
        <20171110110949.328-1-phillip.wood@talktalk.net>
Date:   Sat, 11 Nov 2017 04:21:50 +0900
Message-ID: <xmqqo9oadjn5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67B80AC0-C64C-11E7-A723-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> Here's the summary from the previous version
> These patches teach the sequencer to create commits without forking
> git commit when the commit message does not need to be edited. This
> speeds up cherry picking 10 commits by 26% and picking 10 commits with
> rebase --continue by 44%. The first few patches move bits of
> builtin/commit.c to sequencer.c. The last two patches actually
> implement creating commits in sequencer.c.

Thanks.  The changes since the initial iteration seems quite small
and I didn't find much objectionable.

Here are some style fixes I needed to add on top to make the output
of "diff master HEAD" checkpatch.pl-clean.  I think 3/9 and 9/9 are
the culprits.

diff --git a/sequencer.c b/sequencer.c
index 1f65e82696..a989588ee5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -592,7 +592,7 @@ static int read_env_script(struct argv_array *env)
 	return 0;
 }
 
-static char *get_author(const char* message)
+static char *get_author(const char *message)
 {
 	size_t len;
 	const char *a;
@@ -1104,7 +1104,7 @@ static int try_to_commit(struct strbuf *msg, const char *author,
 	}
 
 	if (update_head_with_reflog(current_head, oid,
-				    getenv("GIT_REFLOG_ACTION"), msg, &err)){
+				    getenv("GIT_REFLOG_ACTION"), msg, &err)) {
 		res = error("%s", err.buf);
 		goto out;
 	}
@@ -1121,7 +1121,7 @@ static int try_to_commit(struct strbuf *msg, const char *author,
 	return res;
 }
 
-static int do_commit(const char *msg_file, const char* author,
+static int do_commit(const char *msg_file, const char *author,
 		     struct replay_opts *opts, unsigned int flags)
 {
 	int res = 1;
@@ -1521,7 +1521,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
 			strbuf_addstr(&msgbuf, ")\n");
 		}
-		if (!is_fixup (command))
+		if (!is_fixup(command))
 			author = get_author(msg.message);
 	}
 
diff --git a/sequencer.h b/sequencer.h
index 27f34be400..e0be354301 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -72,7 +72,7 @@ int template_untouched(const struct strbuf *sb, const char *template_file,
 		       enum commit_msg_cleanup_mode cleanup_mode);
 int update_head_with_reflog(const struct commit *old_head,
 			    const struct object_id *new_head,
-			    const char* action, const struct strbuf *msg,
+			    const char *action, const struct strbuf *msg,
 			    struct strbuf *err);
 void commit_post_rewrite(const struct commit *current_head,
 			 const struct object_id *new_head);


