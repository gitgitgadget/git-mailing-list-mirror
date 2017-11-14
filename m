Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE68E201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 06:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbdKNGOn (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 01:14:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52920 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750790AbdKNGOm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 01:14:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4851CAE3CD;
        Tue, 14 Nov 2017 01:14:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z5pYjLt4AqK7K50dDfq4mHgmu/U=; b=TRRXCY
        c0d3mljIdUUrHfTdElarYEZHoXSox0kXcibrbhAI3TIvH1SLRidzz4nUS1DJvuou
        xGO0fExqaa145FJihKbwPC5soKkvzfijtCruQoLSVxnNKoSUEDnMR+YQUHBzkJJc
        irWEj+p9n5KJkUXvVp5CzF7jG+NOwLE/czUu0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gQxuY0AJRICYrWE6crnQQbhgL2ZL920c
        WD3hsGPREhMofGPtiDNPJGxPDKR84lhTC6SAFbkchRgwG8eMoSLWvuRjMMFvLfY8
        7H06SMJiUGVeD2eBGj6PSIfyn3RUNRjOUJsA1Mh2CXoeuJs8sEIzE5Am7IOOFw41
        mY08s/63mxE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EB0AAE3CC;
        Tue, 14 Nov 2017 01:14:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC5B5AE3CB;
        Tue, 14 Nov 2017 01:14:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 3/3] log: add an option to generate cover letter from a branch tip
References: <xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com>
        <936c2b33-3432-f113-d84b-0623246ec673@suse.de>
Date:   Tue, 14 Nov 2017 15:14:33 +0900
In-Reply-To: <936c2b33-3432-f113-d84b-0623246ec673@suse.de> (Nicolas
        Morey-Chaisemartin's message of "Mon, 13 Nov 2017 18:13:39 +0100")
Message-ID: <xmqq7eut4cae.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15E07A5C-C903-11E7-82FF-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de> writes:

> -	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
> -	const char *msg;
> +	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n\n";

Hmmmm.

> @@ -1021,17 +1021,21 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  	if (!branch_name)
>  		branch_name = find_branch_name(rev);
>  
> -	msg = body;
>  	pp.fmt = CMIT_FMT_EMAIL;
>  	pp.date_mode.type = DATE_RFC2822;
>  	pp.rev = rev;
>  	pp.print_email_subject = 1;
> -	pp_user_info(&pp, NULL, &sb, committer, encoding);
> -	pp_title_line(&pp, &msg, &sb, encoding, need_8bit_cte);
> -	pp_remainder(&pp, &msg, &sb, 0);
> -	add_branch_description(&sb, branch_name);
> -	fprintf(rev->diffopt.file, "%s\n", sb.buf);
>  
> +	if (!cover_at_tip_commit) {
> +		pp_user_info(&pp, NULL, &sb, committer, encoding);
> +		pp_title_line(&pp, &body, &sb, encoding, need_8bit_cte);
> +		pp_remainder(&pp, &body, &sb, 0);
> +	} else {
> +		pretty_print_commit(&pp, cover_at_tip_commit, &sb);
> +	}
> +	add_branch_description(&sb, branch_name);
> +	fprintf(rev->diffopt.file, "%s", sb.buf);
> +	fprintf(rev->diffopt.file, "---\n", sb.buf);
>  	strbuf_release(&sb);

I would have expected that this feature would not change anything
other than replacing the constant string *body we unconditionally
print with the log message of the empty commit at the tip, so from
that expectation, I was hoping that a patch looked nothing more than
this:

 builtin/log.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 6c1fa896ad..0af19d5b36 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -986,6 +986,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			      struct commit *origin,
 			      int nr, struct commit **list,
 			      const char *branch_name,
+			      struct commit *cover,
 			      int quiet)
 {
 	const char *committer;
@@ -1021,7 +1022,10 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	if (!branch_name)
 		branch_name = find_branch_name(rev);
 
-	msg = body;
+	if (cover)
+		msg = get_cover_from_commit(cover);
+	else
+		msg = body;
 	pp.fmt = CMIT_FMT_EMAIL;
 	pp.date_mode.type = DATE_RFC2822;
 	pp.rev = rev;


plus a newly written function get_cover_from_commit().  Why does
this patch need to change a lot more than that, I have to wonder.

This is totally unrelated, but I wonder if it makes sense to do
something similar for branch.description, too.  If the user has a
meaningful description prepared with "git branch --edit-desc", it is
somewhat insulting to the user to still add "*** BLURB HERE ***".
