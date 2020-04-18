Return-Path: <SRS0=qItC=6C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16193C352BE
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 17:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0DBA21D93
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 17:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kt6wdnny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgDRRg5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Apr 2020 13:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgDRRg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Apr 2020 13:36:57 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6519C061A0C
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 10:36:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i10so6756806wrv.10
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 10:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JtRpj+4Fc+XDFKF2XkdBoek3To78uWFaFe9CGyFgslA=;
        b=Kt6wdnnygcJvuN6G4XjW3SaRxTz7Hyg19kCpd0ftrghzyS9LxA3EsROAejFeK332iJ
         gBWTkxe4otHS2Y/kue3EZYMCf3AKuFc3P6lO0zt1BqIhhWGlX/7RXBXxpazj4udKtam5
         RkYrfbgLsrfrBMLz7K5k3iQwIx5As+5b+no67cqBwHctv3sIAJWmYcNTipfYcVW0oNA+
         gZkSa55mWVnYmvkmfc3O02dZwoaUyHMeEIb55TEE42dbQVJHnv4XGXDGu/avgVjKWssn
         xya5prp5uurcNs3URck4K5CRT+xEimZGI7OfqBoyP30PhxzIi//bI5wRZcQqY288M2pV
         rdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JtRpj+4Fc+XDFKF2XkdBoek3To78uWFaFe9CGyFgslA=;
        b=QjejRbrza4kpOQpXEgaCyDscwZHsqj2WEBD8nYpiZnfu4D63D/fe5H8HyatHRMF8qR
         SG067/bBZml5vz5FY5C9JE+UfX2DBiCJrnD7mMwzc9Im7B1f5A9RF6ZatBKWsg9ffnnU
         jn0Cip1EtGuzKjB2EiuhI5+CmaiL1JOeStMitJpF/xAV8Edht8ruT9eO8HdqQ2Q9W/MD
         ntc1O7kgrX7y9VEIfdIoNGAZgwkjBczjVx6MoNGSDHIYdjV582RtasDJMhxCyXkWfW1X
         gdzGbZPJUuoaeTYC18BhGIfNQa+YlMpPCM5VA3ByQ/J61lkpEZLjVR1ObJk6VPGX6BmO
         WGEA==
X-Gm-Message-State: AGi0PubAbGbWeAwNhWsag9E3541/GhzrvuC+CrkqOwAVcwb+Uo6f+9OP
        eR1QYIZHChifvf3m9BK22Gg=
X-Google-Smtp-Source: APiQypIOIvQSS5LiCyNfETJpRi2FTDGhOJtPsqrYIirJYz+s+/Yxp/7H3IvH9K/xUCuMlvh+CMfQjw==
X-Received: by 2002:adf:bb94:: with SMTP id q20mr10707324wrg.105.1587231414156;
        Sat, 18 Apr 2020 10:36:54 -0700 (PDT)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id g74sm12555246wme.44.2020.04.18.10.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 10:36:53 -0700 (PDT)
Date:   Sat, 18 Apr 2020 19:36:51 +0200
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2020, #01; Wed, 15)
Message-ID: <20200418173651.djzriazxj5kbo6ax@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Sat, 18 Apr 2020 16:43:57 +0200
References: <20200416211208.xqnnrkvcl2jw3ejr@doriath>
 <20200416213009.GA1721147@coredump.intra.peff.net>
 <xmqqh7xjxeew.fsf@gitster.c.googlers.com>
 <20200416224708.zr4dlrz4hpaqsz2s@doriath>
 <20200416230554.bhk2yfycjwjpxggy@doriath>
 <xmqq4ktjxawx.fsf@gitster.c.googlers.com>
 <20200417125415.6o5avmae3cyvq4fy@feanor>
 <xmqq1romvx2q.fsf@gitster.c.googlers.com>
 <20200417220445.sasjy4rvzonoz7cn@doriath>
 <xmqq8sitvgtd.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8sitvgtd.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Junio C Hamano, Fri 17 Apr 2020 at 16:22:06 (-0700) :
> Ah, of course ;-) The code in builtin/push.c rely on being able to
> pass NULL as the name and rely on current branch getting used; you
> have to pass the name of the ref you are trying to format %(push)
> for, so you would trigger add_url_alias(), which says as a fallback
> that URL for "origin" is "origin" and makes ret->url non-NULL (hence
> it no longer is !valid_remote() and gets returned).  

Indeed, if 'origin' is implicit and does not exists, then
remote_get(NULL) returns NULL, while
remote_get(remote_for_branch(current_branch, NULL)) returns the 'origin' remote

Likewise pushremote_get(NULL) will differ from
remote_get(pushremote_for_branch(current_branch, NULL)) if 'origin' is the
implicit push remote and does not exists.

In particular, there is currently no way to check with remote_get("origin") if
an implicit 'origin' really exists or not.

What we would need to get the same results is an extra parameter to
remote_get_1 which tells it if the given name was obtained explicitly or
implicitly.


Now this induces some bugs in the ref-filter machinery.
For instance, for %(upstream:remotename) and %(push:remotename), the code
prints `remote_for_branch(branch, &explicit)` and
`pushremote_for_branch(branch, &explicit)` respectively only if they are
explicit.

But this is not quite correct, if we think of %(upstream:remotename) as to
"which remote would a bare `git fetch` contact when on this branch?"; then
'origin' should be printed, provided it really exists.


> Geez.  This is tricky.
> > But I think that means that my fixup is actually wrong when a pushRemote is
> > set without a remote while 'origin' do exist.

So here is a test done about whether a triangular setup is detected, when a
branch has a pushRemote but no remote and
1) pushRemote=foobar, origin does not exists
2) pushRemote=foobar, origin does exists
3) pushRemote=origin, origin does not exists
4) pushRemote=origin, origin exists
in the following cases:
A) `git push` B) "%(push)" with the code currently in next 
C) "%(push)" with the fixup I sent D) what I would have expected

  A   B   C   D
1 no  yes no  yes
2 yes yes no  yes
3 no  no  no  no
4 no  no  no  no

Assuming D is indeed the correct way to go, there are two ways to fix
is_workflow_triangular in push.c (not tested): one is to replace
	return (fetch_remote && fetch_remote != remote);
by
	return (!fetch_remote || fetch_remote != remote);
Indeed in this case we know that the push remote exists, so if the
fetch_remote does not exists, we know we are in a triangular workflow.

Another way would be to call 
  fetch_remotename=remote_for_branch(current_branch, &explicit);
and compare it with remote->name.


Going back to my 'fixup', it is clearly wrong (in the opposite direction of
what is currently in next!). But assuming that 'D' is what we want for
triangular workflows, the patch in next is actually correct and it is `git
push` who is wrong :)


About the patch currently in next, apart from this situation which is
tricky to fix as you observed, one thing I may have changed if you had not
commited it already is to change
static int is_workflow_triangular(struct branch *branch)
into
static int is_workflow_triangular(struct branch *branch, struct remote *push_remote)
since all the callers already have the push_remote, this would prevent us from
recomputing it. But this can be a separate fix, if you think this does not
warrant a revert of the merge.


PS: While I am on the subject of bugs in ref-filter.c, for exhaustivity,
in push.c `setup_push_upstream` checks that
	(branch->merge_nr != 1)
but this is not done for %(push)
