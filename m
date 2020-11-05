Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5634C55178
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 18:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 420462083B
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 18:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHTDbHou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbgKES7D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 13:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732000AbgKES7C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 13:59:02 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D72C0613CF
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 10:59:02 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id k7so1232586plk.3
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 10:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=5h89TumKM2+h/U+OvNoWDNDRLeiPox+jNvDt56mnl4E=;
        b=bHTDbHou7SH8t2ef51S9jE5Sa+wd9rrrG09XtU1hHwkhUuAXwXPjR7mMmsRdiIMjKl
         eauH+HUetqEPLOVbhW0rlsJk5r1+pq6/PLbpYQU7vVxp3QomZR9LgDmF+sbtltT9JKj8
         wF8CV0NJqAAvDtl13cB/Ah+F1JRg6AF3GVIPTXLbco0qLJVYsmyALC/i4zEqiWbkbEc2
         nrgdtitJyqu2mY3bzWimFvxS2/NRKxd1W5hU3A3XMzgAJ2HBaVNJyVnR/x/YrpGhOdPg
         ENtFw8pscNJ+bf+2oQj146hyu8h4ox4+Ky/IEN5bXLF3fMljlKAysRnxL0KhZxwBQb3p
         URdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=5h89TumKM2+h/U+OvNoWDNDRLeiPox+jNvDt56mnl4E=;
        b=hO2C384x80BCibKcv1BwOSDylCWGGpDISUbTOq7x35sEMWcY7aUK94js6alQrxHxLy
         TNr2x/cu4TmPS3dvqGVUsnHDnLwmoKXt6SI3eYms7zKAQqZK3BzTBz6ZWxqxxbWzHfpd
         wqAWiOMLCTtB2X1hBnisu6UE1fVVHRNKO5RP9PfHb7CrpPyjGW4NxjanohVMaZ313+v6
         hi84/Fhyi2JTXdJn7CVaWazRQEm99gPe1YLCJ4S5EJTvbC4uVBQfYzq9kl0I9P/yinf4
         goF7+jRf1zMDE0msLqmBAoiQ+twyoihmSUrtIVjNvRohAxr+ADjgxV2txtPZ2RaCdDEI
         w+Mg==
X-Gm-Message-State: AOAM532sDpc2C5pCfOXzsmrA7SDqeOoknIVDqVVJrCaQmp02cwQqWsGy
        AebuaD0xUKmAA1Fan/UZPDPvIhvi696+Wg==
X-Google-Smtp-Source: ABdhPJz3bTKCIxAbfAQdXjPQ0Ah+1g/I+vI+virTn8MOLvSzcxzDC+X3rr6wv8vDySy/0A+s/02gnA==
X-Received: by 2002:a17:90b:180f:: with SMTP id lw15mr3771038pjb.119.1604602742277;
        Thu, 05 Nov 2020 10:59:02 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
        by smtp.gmail.com with ESMTPSA id e10sm3595740pfl.162.2020.11.05.10.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:59:01 -0800 (PST)
Date:   Thu, 5 Nov 2020 10:58:55 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 08/11] fetch-pack: advertise trace2 SID in capabilities
Message-ID: <20201105185855.GB36751@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover.1604006121.git.steadmon@google.com>
 <cover.1604355792.git.steadmon@google.com>
 <11b5b1b54f14354f08c9eb230d5b4e6a3de1996b.1604355792.git.steadmon@google.com>
 <xmqqimaklsvg.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqimaklsvg.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.11.04 13:22, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > When trace2 is enabled, the server sent a trace2-sid capability, and
> > trace2.advertiseSID is true, advertise fetch-pack's own session ID back
> > to the server.
> >
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> >  fetch-pack.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index b10c432315..7fbefa7b8e 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -35,6 +35,8 @@ static int fetch_fsck_objects = -1;
> >  static int transfer_fsck_objects = -1;
> >  static int agent_supported;
> >  static int server_supports_filtering;
> > +static int server_sent_trace2_sid;
> > +static int advertise_trace2_sid;
> >  static struct shallow_lock shallow_lock;
> >  static const char *alternate_shallow_file;
> >  static struct strbuf fsck_msg_types = STRBUF_INIT;
> > @@ -326,6 +328,8 @@ static int find_common(struct fetch_negotiator *negotiator,
> >  			if (deepen_not_ok)      strbuf_addstr(&c, " deepen-not");
> >  			if (agent_supported)    strbuf_addf(&c, " agent=%s",
> >  							    git_user_agent_sanitized());
> > +			if (advertise_trace2_sid && server_sent_trace2_sid && trace2_is_enabled())
> > +				strbuf_addf(&c, " trace2-sid=%s", trace2_session_id());
> >  			if (args->filter_options.choice)
> >  				strbuf_addstr(&c, " filter");
> >  			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
> > @@ -979,6 +983,9 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
> >  				      agent_len, agent_feature);
> >  	}
> >  
> > +	if (server_supports("trace2-sid"))
> > +		server_sent_trace2_sid = 1;
> > +
> >  	if (server_supports("shallow"))
> >  		print_verbose(args, _("Server supports %s"), "shallow");
> >  	else if (args->depth > 0 || is_repository_shallow(r))
> > @@ -1191,6 +1198,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
> >  		packet_buf_write(&req_buf, "command=fetch");
> >  	if (server_supports_v2("agent", 0))
> >  		packet_buf_write(&req_buf, "agent=%s", git_user_agent_sanitized());
> > +	if (advertise_trace2_sid && server_supports_v2("trace2-sid", 0) && trace2_is_enabled())
> > +		packet_buf_write(&req_buf, "trace2-sid=%s", trace2_session_id());
> >  	if (args->server_options && args->server_options->nr &&
> >  	    server_supports_v2("server-option", 1)) {
> >  		int i;
> > @@ -1711,6 +1720,7 @@ static void fetch_pack_config(void)
> >  	git_config_get_bool("repack.usedeltabaseoffset", &prefer_ofs_delta);
> >  	git_config_get_bool("fetch.fsckobjects", &fetch_fsck_objects);
> >  	git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);
> > +	git_config_get_bool("trace2.advertisesid", &advertise_trace2_sid);
> >  	if (!uri_protocols.nr) {
> >  		char *str;
> 
> The same comment as 05/11 and 06/11 applies to this repeated
> appearance of this boolean expression:
> 
> 	advertise_trace2_sid && trace2_is_enabled()
> 
> If we are committed to stick to the "even if we were told to
> advertise, do not alllocate a session ID" design, perhaps it is
> cleaner to clear advertise_trace2_sid at the very beginning,
> immediately after we learn that the tracing is disabled and the
> advertiseSID configuration is read.  That way, everybody needs to
> only care about advertise_trace2_sid variable.
> 
> Incidentally, if we decide to change the semantics to auto allocate
> the session ID if advertiseSID configuration asks us to advertise
> (it is OK if we do not enable the full trace2 suite), we can still
> make the code only check advertise_trace2_sid variable, without
> adding repeated check of trace2_is_enabled() everywhere at all.

Good point. Once we settle on whether or not to advertise when tracing
is enabled, I'll update these conditionals in V3.
