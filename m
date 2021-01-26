Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C030C43333
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E326620674
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbhAZWBX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394505AbhAZSQu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 13:16:50 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04141C061574
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 10:16:10 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s64so13754944yba.20
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 10:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=A15DgMkwk5Y+vCov63N6SFEnKb3higLhbLWjB/qcc4o=;
        b=hzEcVyogmcjgpE37EZxuon7ddpOTvPA1+74nyzzK9kwrZek7fgwD9eQsh2t9hbG202
         XrLUeFwVCzWtS/fpKbKsUOExEp5eFeF0eEQmsNSN6P5QOqMp/aeMdds0szJw5k6z73Qq
         WBKRlQisrP2Wj2XxgZSb0mtvmtlASTtx+JHoLubV1fJscI0VSjf7FmCOPsB2/c51kNDU
         ZzOlL5RuvNmomzWwCmdbAAvvJrUWcbpF/tA+3dhffFp0fO3ovK6VZD/X+2Yton63UF9R
         E+qk3xGjhvuTk5CF5K0Stc3chgPqIWKX83feBOF6imJzvAIRmY/5wKnk2bjvAiGdXXj/
         ZR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A15DgMkwk5Y+vCov63N6SFEnKb3higLhbLWjB/qcc4o=;
        b=n15JT+0TE+OrdQVtB6ZiEz9cwJXmi6aq/kqGOQZ4vsspkEoa1VAOIpJok56ZeSPuWK
         AYWFF5e2lNwcgbkmIghljmYUiAJpyb4g+WC5vqi5nG1aM7Ldcyfy+lNX2uQfsSp6Lpl3
         TlBaJAdinmayK5Sncnx7ri8N+3J6MjrHkogyoOpq1lDlY7fh1C03dizs8X8LYRDObbox
         cbrgiC6NAwDjbokhTdiVXhkO3XlnwLpSx5mqqoKHUrSWDEIZp/1XnB2Y4ibHLvnByUqq
         VoN8KhG/YYt7x/6AzPxdq/QcApQu9mJoHdKO22Bxch75t2s5nkI7HV5aevFcLNWzE5lD
         EvnQ==
X-Gm-Message-State: AOAM5322u3Zet8eu8L8OECi3GAkhOVnn4EF0pjGAytbFUHIaSPnzjp5r
        Ee8FC5hztMERWLZVGzhN4vIn+/bJrp+SlAK1R4ae
X-Google-Smtp-Source: ABdhPJyV8vVRwa44qs6Xt845bg1br0J82/SLxZh9/cUATSpZQKfPoJOylMbfze0aYGqREXC/lCnFIC/JOhXz22WkLNDw
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:ab23:: with SMTP id
 u32mr10562610ybi.328.1611684969222; Tue, 26 Jan 2021 10:16:09 -0800 (PST)
Date:   Tue, 26 Jan 2021 10:16:06 -0800
In-Reply-To: <YAnqQZaVByUYYRNr@coredump.intra.peff.net>
Message-Id: <20210126181606.2335396-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YAnqQZaVByUYYRNr@coredump.intra.peff.net>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: Re: [PATCH v4 2/3] connect, transport: add no-op arg for future patch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Dec 22, 2020 at 01:54:19PM -0800, Jonathan Tan wrote:
> 
> > In a future patch we plan to return the name of an unborn current branch
> > from deep in the callchain to a caller via a new pointer parameter that
> > points at a variable in the caller when the caller calls
> > get_remote_refs() and transport_get_remote_refs(). Add the parameter to
> > functions involved in the callchain, but no caller passes an actual
> > argument yet in this step. Thus, the future patch only needs to concern
> > itself with new logic.
> 
> OK. Since the call stack is so deep, it's nice to get all of this diff
> noise out of the way of the third patch.
> 
> It does make me wonder if we should be passing a struct like:
> 
>   struct transport_fetch_options {
> 	struct strvec ref_prefixes;
> 	char **unborn_head;
>   }
>   #define TRANSPORT_FETCH_OPTIONS_INIT = { STRVEC_INIT }
> 
> which would solve this problem once for any future options.

That's a good idea, and I've switched patch 2 to doing this. It also
makes it easier to explain (no "unborn_head" dummy variable that does
nothing, since I can just introduce "unborn_head" in patch 3).

> > @@ -455,7 +455,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
> >  			     struct ref **list, int for_push,
> >  			     const struct strvec *ref_prefixes,
> >  			     const struct string_list *server_options,
> > -			     int stateless_rpc)
> > +			     int stateless_rpc,
> > +			     char **unborn_head_target)
> 
> Is a single string enough? The way the protocol is defined, I think the
> server is free to tell us about other unborn symrefs, too (but of course
> our implementation does not). And I'm not sure what we'd do with such
> values (in a "--mirror" clone, I guess we could make local copies of
> them).
> 
> Should we be prepared for that at the transport layer, or is it
> over-engineering?

With the struct, I think we're prepared for it.
