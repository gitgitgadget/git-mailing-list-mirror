Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 797441F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 03:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732084AbfJPDfW (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 23:35:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58179 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbfJPDfV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 23:35:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8B65FA3FA8;
        Tue, 15 Oct 2019 23:35:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m8urmCPLPyDjmykjbb+EdmxkWTo=; b=NyybIb
        WUf3q51UCwjOX8I65ixQHz3Ylrd1cbhWCOPysNDxKuattfFIF/zjo9WU7YehMr56
        ypqicmyQWZdZfCxV+yIIP6MmQRsDGyKSfHqOkhkRKI8x4+7TnmSK8DjWZeWL2Qsl
        3+s1JOk8UPQUMPRucQwSTlFWMaBD/6/+4T6N4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AU3HHUI2Es1o3Vbiowf5T77UyHrknvdO
        AOjlMULxYkoBrgA/md9wRclpI5WcsT76zslHF8gPf0/C0zAFq89TRcXywMhRa0xk
        1WClwkP3XxWhpUW09tBkVK+qBmUY0tl8+6LFCS/2DQQOThD5JgPrjsMH9dC1guwE
        Zpv/LJuCioo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 84F3AA3FA7;
        Tue, 15 Oct 2019 23:35:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B3EA5A3FA5;
        Tue, 15 Oct 2019 23:35:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, James Coglan <jcoglan@gmail.com>
Subject: Re: [PATCH v3 01/13] graph: automatically track display width of graph lines
References: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
        <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
        <722ab8973ace92aeef8669eced2919a144240cc0.1571183279.git.gitgitgadget@gmail.com>
Date:   Wed, 16 Oct 2019 12:35:14 +0900
In-Reply-To: <722ab8973ace92aeef8669eced2919a144240cc0.1571183279.git.gitgitgadget@gmail.com>
        (James Coglan via GitGitGadget's message of "Tue, 15 Oct 2019 23:47:47
        +0000")
Message-ID: <xmqq8spl9xcd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F87472AC-EFC5-11E9-B6FD-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"James Coglan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +struct graph_line {
> +	struct strbuf *buf;
> +	size_t width;
> +};
> +
> +static inline void graph_line_addch(struct graph_line *line, int c)
> +{
> +	strbuf_addch(line->buf, c);
> +	line->width++;
> +}
> +
> +static inline void graph_line_addchars(struct graph_line *line, int c, size_t n)
> +{
> +	strbuf_addchars(line->buf, c, n);
> +	line->width += n;
> +}
> +
> +static inline void graph_line_addstr(struct graph_line *line, const char *s)
> +{
> +	strbuf_addstr(line->buf, s);
> +	line->width += strlen(s);
> +}
> +
> +static inline void graph_line_addcolor(struct graph_line *line, unsigned short color)
> +{
> +	strbuf_addstr(line->buf, column_get_color_code(color));
> +}

All makes sense, and as long as nobody uses strbuf_add*() on
line->buf directly, it shouldn't be too hard to extend these
to support graph drawn characters outside ASCII in the future
after this series settles.

>  static void graph_output_pre_commit_line(struct git_graph *graph,
> ...
>  	for (i = 0; i < graph->num_columns; i++) {
>  		struct column *col = &graph->columns[i];
>  		if (col->commit == graph->commit) {
>  			seen_this = 1;
> -			strbuf_write_column(sb, col, '|');
> -			strbuf_addchars(sb, ' ', graph->expansion_row);
> -			chars_written += 1 + graph->expansion_row;
> +			graph_line_write_column(line, col, '|');
> +			graph_line_addchars(line, ' ', graph->expansion_row);

Nice reduction of noise, as the proposed log message promises.

>  int graph_next_line(struct git_graph *graph, struct strbuf *sb)

I just noticed it but does this have to be extern?  Nobody outside
graph.[ch] seems to have any reference to it.  That might mean that
it may be easier than we thought earlier to change the second
parameter of this to "struct graph_line *", instead of us wrapping
an incoming strbuf (which external callers are aware of, as opposed
to graph_line which we prefer not to expose to outsiders).  Whether
we change the second parameter or not, the first clean-up may be to
turn this function into a file-scope static, perhaps?

All the changes are very pleasing to see.  Thanks.
