Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E2FC55178
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 21:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F1D72220B
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 21:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nlsSZKF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731940AbgKDVWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 16:22:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59015 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbgKDVW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 16:22:29 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6575AA389F;
        Wed,  4 Nov 2020 16:22:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qqbs1Zi/w+x30d3cz/nI46E3CcY=; b=nlsSZK
        F/qdZtm1GTgjTDcQxMVGWDLI92Wjo6tW9mmFpnFI1zMjD71NTVMML9ygBJyiqoLC
        cS/qf2CD4FHXNceSlDPmr9CBRp6JQJLDT1oE6StIkq++ijak3McLv2gNkIqt25yW
        psqVdL9A7XvnpELr0LGaW197WuGCAnOwNqL1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JT73ryFwY80xfV1WFCKb8GnPsfTWvFB/
        MDC1/CzzyrFYsEDsflGPDvWVT7UgwL97KWHsXitN6DllZngZboiBUmZVx2xMS7Fu
        dpmudlW6g/L52h/t6DnSPHLBoAXZUyxK2l3N03f3yE91KF/UXhs0rmkxLmc3NoUu
        zifjjlcRcX0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D603A389E;
        Wed,  4 Nov 2020 16:22:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D46D2A389D;
        Wed,  4 Nov 2020 16:22:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 08/11] fetch-pack: advertise trace2 SID in capabilities
References: <cover.1604006121.git.steadmon@google.com>
        <cover.1604355792.git.steadmon@google.com>
        <11b5b1b54f14354f08c9eb230d5b4e6a3de1996b.1604355792.git.steadmon@google.com>
Date:   Wed, 04 Nov 2020 13:22:27 -0800
In-Reply-To: <11b5b1b54f14354f08c9eb230d5b4e6a3de1996b.1604355792.git.steadmon@google.com>
        (Josh Steadmon's message of "Mon, 2 Nov 2020 14:31:06 -0800")
Message-ID: <xmqqimaklsvg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D79EEEB0-1EE3-11EB-A078-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> When trace2 is enabled, the server sent a trace2-sid capability, and
> trace2.advertiseSID is true, advertise fetch-pack's own session ID back
> to the server.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  fetch-pack.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index b10c432315..7fbefa7b8e 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -35,6 +35,8 @@ static int fetch_fsck_objects = -1;
>  static int transfer_fsck_objects = -1;
>  static int agent_supported;
>  static int server_supports_filtering;
> +static int server_sent_trace2_sid;
> +static int advertise_trace2_sid;
>  static struct shallow_lock shallow_lock;
>  static const char *alternate_shallow_file;
>  static struct strbuf fsck_msg_types = STRBUF_INIT;
> @@ -326,6 +328,8 @@ static int find_common(struct fetch_negotiator *negotiator,
>  			if (deepen_not_ok)      strbuf_addstr(&c, " deepen-not");
>  			if (agent_supported)    strbuf_addf(&c, " agent=%s",
>  							    git_user_agent_sanitized());
> +			if (advertise_trace2_sid && server_sent_trace2_sid && trace2_is_enabled())
> +				strbuf_addf(&c, " trace2-sid=%s", trace2_session_id());
>  			if (args->filter_options.choice)
>  				strbuf_addstr(&c, " filter");
>  			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
> @@ -979,6 +983,9 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
>  				      agent_len, agent_feature);
>  	}
>  
> +	if (server_supports("trace2-sid"))
> +		server_sent_trace2_sid = 1;
> +
>  	if (server_supports("shallow"))
>  		print_verbose(args, _("Server supports %s"), "shallow");
>  	else if (args->depth > 0 || is_repository_shallow(r))
> @@ -1191,6 +1198,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
>  		packet_buf_write(&req_buf, "command=fetch");
>  	if (server_supports_v2("agent", 0))
>  		packet_buf_write(&req_buf, "agent=%s", git_user_agent_sanitized());
> +	if (advertise_trace2_sid && server_supports_v2("trace2-sid", 0) && trace2_is_enabled())
> +		packet_buf_write(&req_buf, "trace2-sid=%s", trace2_session_id());
>  	if (args->server_options && args->server_options->nr &&
>  	    server_supports_v2("server-option", 1)) {
>  		int i;
> @@ -1711,6 +1720,7 @@ static void fetch_pack_config(void)
>  	git_config_get_bool("repack.usedeltabaseoffset", &prefer_ofs_delta);
>  	git_config_get_bool("fetch.fsckobjects", &fetch_fsck_objects);
>  	git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);
> +	git_config_get_bool("trace2.advertisesid", &advertise_trace2_sid);
>  	if (!uri_protocols.nr) {
>  		char *str;

The same comment as 05/11 and 06/11 applies to this repeated
appearance of this boolean expression:

	advertise_trace2_sid && trace2_is_enabled()

If we are committed to stick to the "even if we were told to
advertise, do not alllocate a session ID" design, perhaps it is
cleaner to clear advertise_trace2_sid at the very beginning,
immediately after we learn that the tracing is disabled and the
advertiseSID configuration is read.  That way, everybody needs to
only care about advertise_trace2_sid variable.

Incidentally, if we decide to change the semantics to auto allocate
the session ID if advertiseSID configuration asks us to advertise
(it is OK if we do not enable the full trace2 suite), we can still
make the code only check advertise_trace2_sid variable, without
adding repeated check of trace2_is_enabled() everywhere at all.


