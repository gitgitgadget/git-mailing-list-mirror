Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C7FC433DF
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 20:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18D412073B
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 20:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILJjs/aF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgFGUMj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 16:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGUMj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 16:12:39 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59EFC08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 13:12:38 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id mb16so15968115ejb.4
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 13:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xjeXjJTGFFqO/wyrm76ALjZB7QREBRqIs8mMB2X75Gs=;
        b=ILJjs/aFwpkn+06gkq2E4tsZrXD7Ii4Uu3adI3u3LQh9+bfYU65rjUdfP0yJYBKpA+
         6uThzaZJCg6cwKT2uGZoMEDH1WOBZvcA6ZMCGq+2lnZGTcTQkFu/pYms1W+vS45pxeci
         LCM/QjExIKgh2VjONpBG84IV/YDmrKsEBeJlLlel0d+a3fcxjoWYiVIAuttf8iveAjrC
         lV1mP8/koyj0/gxtUVfiZPZAZchDv9SULckJQ0bJS6rpC9Xityi2RiZuuALH+ZspgvNk
         ZO9Dtnk/Ez/193YsjDxfAhvkJr2NgYryi9ehN1ZmJDnhhLI9eh5K9KMVFHk3yBL5ACvk
         u2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xjeXjJTGFFqO/wyrm76ALjZB7QREBRqIs8mMB2X75Gs=;
        b=O47x6an9gsLNqCn9r076zSimjeHBNGK/xMQbfvFZVcGSXxGScZcG+YNRDhS7h+Qwl+
         xx3cKBVpdpKcst6pjVBp5FDx3G25WyFtAF4hwxBm2uLteEwYDZEaoUntQUbJ14hbEszY
         ekRR4TXEPoQxZpG1Sp382U2UAon3/Tk9o6Lp+fGpT3CJbldRFzjF+tKVjNHetF4s+43n
         LfX6biOe/WR18bL6OAWAmuGjQLurzl0r6gt+T0PoSCdhzaTq0uw39Y2vpf1OOMI9ePDY
         zLWHiOXNqf5eSaAimJ4UbDj+f2qfGIV2BEusgVFw6TnqMURkEDW//qpHQVpy8bmuqg/E
         O4qQ==
X-Gm-Message-State: AOAM530KYBYEcf5i+P+AKuRhz3BZP3DndKHVf2pb6KfKE/uCqXAVGKls
        5u7l52ROS/pzbCq+QvDMd/g=
X-Google-Smtp-Source: ABdhPJyUDCVeyvhJX+Spw9EsGcY1qQvMYkpiH+ZcJbMXFEgIcTkPmSMpm+8gjE1A0LftvvmuUDqbyg==
X-Received: by 2002:a17:906:f189:: with SMTP id gs9mr17704115ejb.203.1591560757315;
        Sun, 07 Jun 2020 13:12:37 -0700 (PDT)
Received: from szeder.dev (78-131-14-185.pool.digikabel.hu. [78.131.14.185])
        by smtp.gmail.com with ESMTPSA id a13sm8909766eju.59.2020.06.07.13.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2020 13:12:36 -0700 (PDT)
Date:   Sun, 7 Jun 2020 22:12:33 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] refs: implement reference transaction hooks
Message-ID: <20200607201233.GB8232@szeder.dev>
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
 <xmqq4krttl4k.fsf@gitster.c.googlers.com>
 <20200603112604.GA25644@tanuki.pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200603112604.GA25644@tanuki.pks.im>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 03, 2020 at 01:26:04PM +0200, Patrick Steinhardt wrote:
> On Tue, Jun 02, 2020 at 10:47:55AM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> > > The above scenario is the motivation for a set of three new hooks that
> > > reach directly into Git's reference transaction. Each of the following
> > > new hooks (currently) doesn't accept any parameters and receives the set
> > > of queued reference updates via stdin:
> > 
> > Do we have something (e.g. performance measurement) to convince
> > ourselves that this won't incur unacceptable levels of overhead in
> > null cases where there is no hook installed in the repository?
> 
> Not yet, but I'll try to come up with a benchmark in the next iteration.
> I guess the best way to test is to directly exercise git-update-refs, as
> it's nearly a direct wrapper around reference transactions.
> 
> > > +	proc.in = -1;
> > > +	proc.stdout_to_stderr = 1;
> > > +	proc.trace2_hook_name = hook_name;
> > > +
> > > +	code = start_command(&proc);
> > > +	if (code)
> > > +		return code;
> > > +
> > > +	sigchain_push(SIGPIPE, SIG_IGN);
> > > +
> > > +	for (i = 0; i < transaction->nr; i++) {
> > > +		struct ref_update *update = transaction->updates[i];
> > > +
> > > +		strbuf_reset(&buf);
> > > +		strbuf_addf(&buf, "%s %s %s\n",
> > > +			    oid_to_hex(&update->old_oid),
> > > +			    oid_to_hex(&update->new_oid),
> > > +			    update->refname);
> > > +
> > > +		if (write_in_full(proc.in, buf.buf, buf.len) < 0)
> > > +			break;
> > 
> > We leave the loop early when we detect a write failure here...
> > 
> > > +	}
> > > +
> > > +	close(proc.in);
> > > +	sigchain_pop(SIGPIPE);
> > > +
> > > +	strbuf_release(&buf);
> > > +	return finish_command(&proc);
> > 
> > ... but the caller does not get notified.  Intended?
> 
> This is semi-intended. In case the hook doesn't fully consume stdin and
> exits early, writing to its stdin would fail as we ignore SIGPIPE. We
> don't want to force the hook to care about consuming all of stdin,
> though.

Why?  How could the prepared hook properly initialize the voting
mechanism for the transaction without reading all the refs to be
updated?

> We could improve error handling here by ignoring EPIPE, but making every
> other write error fatal. If there's any other abnormal error condition
> then we certainly don't want the hook to act on incomplete data and
> pretend everything's fine.

As I read v2 of this patch, a prepared hook can exit(0) early without
reading all the refs to be updated, cause EPIPE in the git process
invoking the hook, and that process would interpret that as success.
I haven't though it through how such a voting mechanism would work,
but I have a gut feeling that this can't be good.

