Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFDAC4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 18:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A524B2173E
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 18:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TGBQ7MKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgJGSlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 14:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbgJGSls (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 14:41:48 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605F3C0613D2
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 11:41:48 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id v33so1984376qtd.3
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 11:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VXb0bqrC7GDgpHMbLIS8upOJ/NWQMlpptoy1eXLp+h8=;
        b=TGBQ7MKp/V2yQK5HrQQ6PK0a1c0Mw0EHcHtkmxzAppq32q4hyDXgEkWrc8zyVbhmis
         aVujhJS7Z4n6nFUQ/uk25nYViYKmkqS0u4fpIzal/UBM0S6CVb/Gxah4/eK7fVuOnckp
         CMlOun1uIqgBMjJX6oO1CkK3gx0XYc2vpfb3DfbS/aI6qVPmBus+xDR91ZxAJJNVLLwc
         TCNi9NcKikwFa+X1omGdd706DSFCrwdMpTbMIJNWj7m8u1rxRSxcW8iCES4NqrxafujR
         6J6tlKj2SywJLsn5VIi5VLnYRHE5o9Bs/27u1e+J0WoEY9Yh/LmeABD+mQ3q2HZL/1pa
         KjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VXb0bqrC7GDgpHMbLIS8upOJ/NWQMlpptoy1eXLp+h8=;
        b=o/dtjx6tojdHVRt7y5djBRZ66osDB0AxJlFuqdHx2pQ77vwnDoxqsH8uoz+Zeu+/x2
         01B+5lfQEe2zHYPH0/sIE9/GX5UYYksqKrYi1aULED3IKPQyaERtTIitfzIhMOyiTflS
         IKaXp2JK07pBIJC1MN2d0H8i3HtKj1OV6HyRAugPJDEH1elHfpfIn3WE3Sef8+AEZdwY
         x8AsNMWmUJd04Vo4lkIX8rvHnb74VnSjOlftvJBv3X/u4XDPtUGNVpIDirurQ0ZSttIc
         mXtNW9GEP8z60IVty6EwvzCZ66PTI0DhdzpBuPyANwnO2BtqX8UlxUD5Y9BfDRXzjvpA
         NhXA==
X-Gm-Message-State: AOAM533Yyix94vn4KYED+Ph1Mu2l6YiS9yt1lAtwo0NO3PNNSImXiDfA
        Pit3vCoEVCpGz79CPyw8TPcEj7JzbdLH1E9qvNuh
X-Google-Smtp-Source: ABdhPJy3QFwFWX+Zbl0iEFXVwSuc+q6iVYMh+8eMZUprD2cxuOfDKzFFGBDInsNAC5XGUIGPkhPawQVzm9mLodB5ACSM
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:f1cb:: with SMTP id
 u11mr4511234qvl.21.1602096107460; Wed, 07 Oct 2020 11:41:47 -0700 (PDT)
Date:   Wed,  7 Oct 2020 11:41:43 -0700
In-Reply-To: <xmqqlfgi2axr.fsf@gitster.c.googlers.com>
Message-Id: <20201007184143.1304267-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqlfgi2axr.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: Re: [ANNOUNCE] Git v2.29.0-rc0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     peff@peff.net, jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jeff King <peff@peff.net> writes:
> 
> > Hmm. That commit removes the call to display_progress() from the main
> > loop of threaded_second_pass(), and doesn't appear to add another one
> > anywhere. Is the solution really as simple as adding it back in? I.e.
> >
> > diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> > index 8acd078aa0..6dbb4317e0 100644
> > --- a/builtin/index-pack.c
> > +++ b/builtin/index-pack.c
> > @@ -1028,6 +1028,10 @@ static void *threaded_second_pass(void *data)
> >  		struct object_entry *child_obj;
> >  		struct base_data *child;
> >  
> > +		counter_lock();
> > +		display_progress(progress, nr_resolved_deltas);
> > +		counter_unlock();
> > +
> >  		work_lock();
> >  		if (list_empty(&work_head)) {
> >  			/*
> >
> > That _seems_ to work fine, but I'm not sure why it was removed in the
> > first place (for a good reason, or simply as an accident when rewriting
> > the variable declarations at the top of the loop?).
> 
> The above looks like an obvious and trivial fix to go back closer to
> the original.

Thanks for noticing it, Peff. Yes, that looks like the correct fix. I
thought that it might have crept in when I was rebasing, but looks like
it was present in the original version [1].

[1] https://lore.kernel.org/git/505d8e79cd983d5b3dfd56c4f0432ad647132957.1570663470.git.jonathantanmy@google.com/

> We seem to have removed find_unresolved_deltas() helper function in
> that series, but there remains a mention to it in a comment, which
> we would probably should rethink (it just may be the matter of
> removing the mention, or if "just like in ..." may have been the
> last example of doing what the comment suggests all code to do, it
> may reveal a need for larger clean-up---I dunno).

Maybe the whole comment block should be deleted and replaced with
something like:

 Ensure that this node has been uncompressed and return its contents.

 In the typical and best case, this node would already be uncompressed
 (through the invocation to resolve_delta() in threaded_second_pass())
 and it would not be pruned. However, if pruning of this node was
 necessary due to reaching delta_base_cache_limit, this function will
 find the closest ancestor with uncompressed data that has not been
 pruned (or if there is none, the ultimate base object), and uncompress
 each node in the delta chain in order to generate the uncompressed data
 for this node.

(I'm using "uncompress" here because I find the original "deflate" term
confusing - I thought that "deflate" meant compress, and thus the
"data" here would be the uncompressed form, and hence undeflated or
inflated.)

The original comment [2] was describing two paths in which uncompressed
forms could be generated - one in find_unresolved_deltas() going from
parent to children, and one here from "current node to top parent"; and
it said that all generated uncompressed forms (here, and "just like in
find_unresolved_deltas()" - as Junio quoted) can be pruned. I think my
suggested comment block above retains that information.

[2] https://kernel.googlesource.com/pub/scm/git/git/+/refs/tags/v2.28.0/builtin/index-pack.c#868
