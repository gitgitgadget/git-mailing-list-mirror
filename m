Return-Path: <SRS0=lsTH=42=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBA7C10F27
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 17:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B54208C3
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 17:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LMdBzgKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgCIRMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Mar 2020 13:12:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54001 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgCIRMN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Mar 2020 13:12:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73347559EE;
        Mon,  9 Mar 2020 13:12:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v9rX2LORkv3OakMSz6l17iCMC98=; b=LMdBzg
        KhmspLwdBeQtcTHElkvPnjPQW7q6kth1ufV3n3gWP0usIt2KN1kTU3W3KZJ8GRm3
        TOFzDgAIQBTxeJMzin4qSmKDsHvvNrQ8WDTlYxiR0oxSg59DDunJ3rifirRi/iGv
        fSh2x9sF/N2yI124pXDfVGwyuAbj/AAYCqdms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f6ZOUxf0HJlRrb+6+XKj48VAIKlxj5Zp
        M8WdlqWLDq2K0wJN1MpTOQWUoFKN2jQ6q71N/UwvZRTrciPYRk98BP81jI8uQp8I
        /QaS4TdeQBqyPoYyoya30a/0ZnplWozVkVMi4QdRm6c1i5UiQhybbklth2u1Nz/p
        RHjMX16DqS4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69101559ED;
        Mon,  9 Mar 2020 13:12:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C1724559EC;
        Mon,  9 Mar 2020 13:12:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 1/5] receive-pack: add new proc-receive hook
References: <CANYiYbE2V3bLfEgH-aRDv4Y5V+_BTZn-oUN7fOVpARm+_14BdQ@mail.gmail.com>
        <20200308145631.64040-2-zhiyou.jx@alibaba-inc.com>
Date:   Mon, 09 Mar 2020 10:12:09 -0700
In-Reply-To: <20200308145631.64040-2-zhiyou.jx@alibaba-inc.com> (Jiang Xin's
        message of "Sun, 8 Mar 2020 22:56:27 +0800")
Message-ID: <xmqq7dzt1mhi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D022896-6229-11EA-8FF1-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

>  builtin/receive-pack.c       |  93 +++++-
>  t/t5411-proc-receive-hook.sh | 547 +++++++++++++++++++++++++++++++++++
>  2 files changed, 628 insertions(+), 12 deletions(-)
>  create mode 100755 t/t5411-proc-receive-hook.sh
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 2cc18bbffd..23d0c224d2 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -312,7 +312,8 @@ struct command {
>  	struct command *next;
>  	const char *error_string;
>  	unsigned int skip_update:1,
> -		     did_not_exist:1;
> +		     did_not_exist:1,
> +		     have_special_ref:1;
>  	int index;
>  	struct object_id old_oid;
>  	struct object_id new_oid;
> @@ -669,6 +670,9 @@ static void prepare_push_cert_sha1(struct child_process *proc)
>  
>  struct receive_hook_feed_state {
>  	struct command *cmd;
> +	int feed_normal_ref;
> +	int feed_special_ref;
> +	int hook_must_exist;
>  	int skip_broken;
>  	struct strbuf buf;
>  	const struct string_list *push_options;
> @@ -684,8 +688,14 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
>  	int code;
>  
>  	argv[0] = find_hook(hook_name);
> -	if (!argv[0])
> -		return 0;
> +	if (!argv[0]) {
> +		if (feed_state->hook_must_exist) {
> +			rp_error("cannot to find hook '%s'", hook_name);
> +			return 1;
> +		} else {
> +			return 0;
> +		}
> +	}
>  
>  	argv[1] = NULL;

Why do you even need "must-exist" in the first place?  In other
parts of Git, when a hook does not exist, processing by that missing
hook is simply not done.  Why does it have to cause an error?

If there is a reasonable answer to the above question, then the
concept that hooks can be marked as "must exist -- otherwise it is
an error" would be independently useful and the support for that
concept should be split out as a separate step before this one, I
would think.

Also, I am not sure why you have to have one single "special" ref
hierarchy to be handled by the hook.  Why not feed everything and
let the hook decide?

I would have expected a design more along the lines of "if the hook
exists, then feed all the refs to the hook, let the hook do whatever
it wants and report what it did back to the receive-pack process, so
that the client side can learn what got accepted and what got
rejected (and possibly other things that may require protocol
extension later)".  One of the possible things the hook can report
may be "I did not do anything for this ref, please do whatever you
normally do".  That way, you do not need to introduce "there are two
classes of refs, normal and special"---that becomes an unused and
unnecessary concept.  For whichever ref the hook considers "normal",
it can use the mechanism to say "I want you to do the normal thing".
And when it sees refs/for/ prefix (or whatever is considered
"special" at the hook's discretion), it can do whatever it wants,
and report "OK, I ate it" or "No, I reject it" (which are only the
two things that can be returned back to the client within the
current protocol, IIUC).  We may later want to extend the mechanism
to allow richer response by the hook at the same time to extend the
on-the-wire protocol and then it may become possible for the hook to
take a push to refs/for/master, update refs/heads/master to the
commit (or to some other commit), and report "OK, I accepted it and
also updated refs/heads/master to this other commit".
