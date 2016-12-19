Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F37C11FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 20:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755927AbcLSUvE (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 15:51:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65337 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752461AbcLSUvD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 15:51:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EB94599FC;
        Mon, 19 Dec 2016 15:51:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3DgNEhv1E2aoDMxrets0JODsYgw=; b=Xl2zKS
        joxlDf5LQthruVKzUI/pE/f23pp1xIAQ9ZvxaBv+ZkzUaqOzJaGUMpFR7bIxQjj+
        ljvuy+9vNBSR+chafpmTyn8cBHScRBlHnyTl+TfNk0xL5UUeE2YCBcmJttAja0C+
        49ZJ6dali26Hnd8r4zGSnYwPyCNHU9ssD10Oc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uRunBv624kV0jmASah2knrX8/mKNOQdB
        xOdFBYIgosyRNfOP3nPqeDAKh4FqTuupKxj3DgUVweXvbjKsnr1oLfEsmLOPO7kO
        1bdXGYYHyc1eqlXC7yxhLYMRQCz/MfDFcMtIPNUJwhmFZRyqM5oUXsuuNcBxbUaD
        CdYXfbsq/xA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15281599FB;
        Mon, 19 Dec 2016 15:51:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 80966599F9;
        Mon, 19 Dec 2016 15:51:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Josh Bleecher Snyder <josharian@gmail.com>, vascomalmeida@sapo.pt,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug report: $program_name in error message
References: <CAFAcib8yauNRB6UbO8qS2_Ff4fDt-7mMsmgop8d1V0j=RoTBSA@mail.gmail.com>
        <CAGZ79kZ=QK5s0_94+4GNs3M5oo49GLm-KkT5K=yZktxX8C4UCw@mail.gmail.com>
        <CAFAcib9-rUSqyBRpauw3pTf9OPTKLYNf7bdh2gyykBNtJTZKGg@mail.gmail.com>
        <CAGZ79ka=RzAjrb=7u7p5xnveo=kcNCoGn=TC=0j-CBp8Oby7OA@mail.gmail.com>
        <xmqqk2avodi1.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 19 Dec 2016 12:50:59 -0800
In-Reply-To: <xmqqk2avodi1.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 19 Dec 2016 12:44:22 -0800")
Message-ID: <xmqqfuljod70.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9BF90DC-C62C-11E6-9B93-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Comparing these changes that involve "\$variable" ...
>
>  	dashless=$(basename -- "$0" | sed -e 's/-/ /')
>  	usage() {
> -		die "usage: $dashless $USAGE"
> +		die "$(eval_gettext "usage: \$dashless \$USAGE")"
> ... and these that appear in the same patch ...
>
> @@ -190,13 +193,16 @@ cd_to_toplevel () {
>  require_work_tree_exists () {
>  	if test "z$(git rev-parse --is-bare-repository)" != zfalse
>  	then
> -		die "fatal: $0 cannot be used without a working tree."
> +		program_name=$0
> +		die "$(gettext "fatal: \$program_name cannot be used without a working tree.")"
> ...
>  
> tells me that the latter needs to be eval_gettext?

Just for fun:

    $ git grep -n '[^_]gettext .*\\\$'

shows three hits.  Two of them are from that one.

The other is at git-rebase--interactive.sh:440

Perhaps like this to fix.

-- >8 --
Subject: rebase -i: fix mistaken i18n

f2d17068fd ("i18n: rebase-interactive: mark comments of squash for
translation", 2016-06-17) attempted to apply sh-i18n and failed to
use $(eval_gettext "string with \$variable interpolation").

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase--interactive.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 41fd374c72..96865b2375 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -437,7 +437,8 @@ update_squash_messages () {
 			}' <"$squash_msg".bak
 		} >"$squash_msg"
 	else
-		commit_message HEAD > "$fixup_msg" || die "$(gettext "Cannot write \$fixup_msg")"
+		commit_message HEAD >"$fixup_msg" ||
+		die "$(eval_gettext "Cannot write \$fixup_msg")"
 		count=2
 		{
 			printf '%s\n' "$comment_char $(gettext "This is a combination of 2 commits.")"
