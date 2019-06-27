Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE4251F461
	for <e@80x24.org>; Thu, 27 Jun 2019 17:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfF0RaC (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 13:30:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57708 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfF0RaC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 13:30:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1930B7B33A;
        Thu, 27 Jun 2019 13:30:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8xW8q0ZIQIuPnkz7GlXXsnq/IjA=; b=setb3J
        1f4u6+L6Tcgipsju0eYymAsPgcdPp29jt7GP7eneSUI4fv1J5CiOc9w60jBryTdl
        O6zV/sjwTF+6yIuC5KXlHAaw0PA+4u6y9SJa59RGCv9+v0/beVI4KOwWhBzbr/lJ
        JvBPFIOsEovbNrRzBsJBG/gf79+VOacvTrxOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NBkCPns6nUM6eFbOz6VkbpGuSbemZDlT
        mR8QfOpRRUutxOoDI6fZQbrsPQl/VpogkE8e/8996orJph2RDWyUGylYFq1kqqSi
        lmWT4uWDzZqg+j5RCwQkRZrqfWgn3GLqmAawKVGpTHXocKSn87BfeQTFdBbo5hg1
        3p+46Aq1b0E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 11F697B339;
        Thu, 27 Jun 2019 13:30:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C037D7B338;
        Thu, 27 Jun 2019 13:29:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 2/3] sequencer: factor out todo command name parsing
References: <pull.275.git.gitgitgadget@gmail.com>
        <pull.275.v2.git.gitgitgadget@gmail.com>
        <c3885c0b8f55957695650c2d1e25f9036d7e80dd.1561644762.git.gitgitgadget@gmail.com>
Date:   Thu, 27 Jun 2019 10:29:53 -0700
In-Reply-To: <c3885c0b8f55957695650c2d1e25f9036d7e80dd.1561644762.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Thu, 27 Jun 2019 07:12:45
        -0700 (PDT)")
Message-ID: <xmqqh88baqcu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E0B8930-9901-11E9-8029-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> As I don't want to burden other callers with having to pass in a pointer
> to the end of the line the test for an abbreviated command is
> changed.

A comma missing somewhere between "As <<REASON>>, <<CONSEQUENCE>>",
perhaps after "end of the line"?

> This change should not affect the behavior. Instead of testing
> `eol == bol + 1` the new code checks for the end of the line by testing
> for '\n', '\r' or '\0' following the abbreviated name. To avoid reading
> past the end of an empty string it also checks that there is actually a
> single character abbreviation before testing if it matches. This
> prevents it from matching '\0' as the abbreviated name and then trying
> to read another character.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 919e3153f5..793f86bf9a 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2076,6 +2076,18 @@ const char *todo_item_get_arg(struct todo_list *todo_list,
>  	return todo_list->buf.buf + item->arg_offset;
>  }
>  
> +static int is_command(enum todo_command command, const char **bol)
> +{

This is a tangent, but the reason why the caller of this function is
named parse_insn_line() (and not parse_command_line()) is because a
"command" often refers "rebase", "cherry-pick" etc., and we need a
word to differenciate these from what is to be done as an individual
step.  Once the codebase stabilizes (read: I am excluding this kind
of change outside the scope of a series like this one), we'd need to
clean up the names in this file, I think.

> +	const char *str = todo_command_info[command].str;
> +	const char nick = todo_command_info[command].c;
> +	const char *p = *bol + 1;
> +
> +	return skip_prefix(*bol, str, bol) ||
> +		((nick && **bol == nick) &&

OK, making sure that nick is not NUL is the key to avoid stepping
past the NUL after the line that begins at *bol, as explained in the
additional paragraph in the proposed log message.

Looking good.

> +		 (*p == ' ' || *p == '\t' || *p == '\n' || *p == '\r' || !*p) &&
> +		 (*bol = p));
> +}
> +
>  static int parse_insn_line(struct repository *r, struct todo_item *item,
>  			   const char *buf, const char *bol, char *eol)
>  {
> @@ -2097,12 +2109,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>  	}
>  
>  	for (i = 0; i < TODO_COMMENT; i++)
> -		if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
> -			item->command = i;
> -			break;
> -		} else if ((bol + 1 == eol || bol[1] == ' ' || bol[1] == '\t') &&
> -			   *bol == todo_command_info[i].c) {
> -			bol++;
> +		if (is_command(i, &bol)) {
>  			item->command = i;
>  			break;
>  		}
