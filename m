Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AF0C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 11:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiJTLXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 07:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiJTLXR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 07:23:17 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F5D1885AB
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 04:23:14 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-367b8adf788so31498587b3.2
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 04:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sKrnMAaTPpiIqjgFsnxrphQhLctoWy1Op/WO6wI8lqg=;
        b=eKusC1XDFmoaCp13ClbQvp9GLUaC20kqJEvabg7wNmJATMTBXUgASQQmC2zbkHlDp0
         ZxtIee+MG0nXsK9c7JsEdiTBDPk58RAJaBkC9I+6K5+veCL51/NtNA3DA90UIJmAzVQQ
         k4X6k326bh7Lh84BtUwDXAKAN0wGjbnGHLhGJrbvWZOsrvddm7+/UxHJywwn+7zfZvZt
         o24QGPUF50qqCuQr/vN8YFx0ETum7KVw3oQqhbhhBfI7+9yzI90YwRPFzTW+pyGvCFPy
         GaqmT/kGSCuVct9L9CiMelI+RZ7VXmQEu5AxNGGKeezpCLNuUAUtd8iV4yZgL3mOWTAu
         5qTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKrnMAaTPpiIqjgFsnxrphQhLctoWy1Op/WO6wI8lqg=;
        b=yzuZ4jwUoKkbjSSKvXHmON/WAcHkk3P450SoXeZbFEXbbzjGuytTOCxVablhxGXuTr
         XbCd2x3sEqt43Sw2IAPPduZXSRTVKzF+6pD4ATFo8rCluVyJWpxTdm9sW+6TGV1k8Pqf
         G0yGO9jTkyPnRF6Hl0V79cBBcXJeK9uEveXoktRQGpu1lpTBk9JDKdWRN0nearADPBMJ
         ixrZILYel7G/tclf4Zm+ncebDUl9vtlHyDToTWXsuqMIMz52Jt4/nH+MQ4duGkgjI+s+
         9Cmiz9wR4UnUQXjsxSIKzv6pRq+8lycpn/XPg6tJF0b0pu8iDOHrvFNiaD8M4mp7O/Qb
         7TbQ==
X-Gm-Message-State: ACrzQf2LuMkk3T4SDF+9+jHmYlaDuCRJruUDjWq62rhmI6/r+W6Rl/pq
        yaoNoJ+lZjXzrMJdg1Bbxg3YltrdBs72xmi0BJ6QHvoMYWY=
X-Google-Smtp-Source: AMsMyM70tZu1/2oV/fu0MLkWke8fT+9NNXzQu85a3U/8Mho1iHHKhSS4jxpJHvi+7DNpdXUEnL35YVHfCGyFWuqGRKo=
X-Received: by 2002:a0d:df8c:0:b0:361:d32:986c with SMTP id
 i134-20020a0ddf8c000000b003610d32986cmr10517159ywe.311.1666264993795; Thu, 20
 Oct 2022 04:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221012135114.294680-1-christian.couder@gmail.com> <xmqqilkm9wv6.fsf@gitster.g>
In-Reply-To: <xmqqilkm9wv6.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 20 Oct 2022 13:23:02 +0200
Message-ID: <CAP8UFD2HX6rK4TRP6ynUzWn4eoHa1FrbiFOtxBaxX-ZkBF3FJw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Implement filtering repacks
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2022 at 6:46 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > For example one might want to clone with a filter to avoid too many
> > space to be taken by some large blobs, and one might realize after
> > some time that a number of the large blobs have still be downloaded
> > because some old branches referencing them were checked out. In this
> > case a filtering repack could remove some of those large blobs.
> >
> > Some of the comments on the patch series that John sent were related
> > to the possible data loss and repo corruption that a filtering repack
> > could cause. It's indeed true that it could be very dangerous, and we
> > agree that improvements were needed in this area.
>
> The wish is understandable, but I do not think this gives a good UI.
>
> This feature is, from an end-user's point of view, very similar to
> "git prune-packed", in that we prune data that is not necessary due
> to redundancy.  Nobody runs "prune-packed" directly; most people are
> even unaware of it being run on their behalf when they run "git gc".

I am Ok with adding the --filter option to `git gc`, or a config
option with a similar effect. I wonder how `git gc` should implement
that option though.

If we implement a new command called for example `git filter-packed`,
similar to `git prune-packed`, then this new command will call `git
pack-objects --filter=...`.

`git gc` is already running `git repack` under the hood in a number of
cases though. So running `git gc --filter=...` would in many cases
call `git pack-objects` twice, as it would call it once through git
repack and once through `git filter-packed`. Or am I missing something
here?

If on the other hand --filter was implemented in some way in `git
repack`, then `git gc --filter=...` could just call `git repack` once.

So even if the new feature should be run only through `git gc` and
perhaps a new command possibly called `git filter-packed`, I think it
might make sense for efficiency to implement it in some ways, like
maybe with some undocumented option or flag, in `git repack`.

> Reusing pack-objects as an underlying mechanism is OK, but this
> needs to be plumbed through to "git gc" for a more consistent
> experience for the end users.

It seems to me that `git prune-packed` might only remove objects that
are already in pack files. So there is no risk of losing data or
corrupting the repo.

Instead, the new feature could in some cases lose data and corrupt the
repo if some removed objects haven't yet been pushed. So on the client
side, it seems dangerous to me to make it run automatically without a
check that everything has been pushed.

Unfortunately some users might already run `git gc` automatically, in
cron scripts for example, and they might be tempted to just add the
`--filter=...` to their `git gc` script, or to set up a config option
with a similar effect without always properly checking that everything
has been pushed.

So I am Ok with trying to make the experience consistent, but I would
be worrying that it would let people shoot themselves in the foot too
easily.

I feel that an obscure `git repack` option would be less likely to be
run automatically.

> Is there a way to check if the "promisor remote" is still willing to
> keep the previous promise it made, so that the users do not have to
> see "we may corrupt the repository as the result of this operation,
> you have been warned", by the way?  Possibly with a protocol
> extension?
>
> In a sense, once you made a partial clone, your repository is at the
> mercy of the remote.  They can disappear any time with majority of
> the data you depend on, leaving only what you created locally and
> haven't pruned away, in a repository that may technically pass
> "fsck", because the things that are supposed to exist locally
> exists, but may not be usable in practice.

Yeah, when a user clones using --filter=..., the remote can disappear
anytime, and we haven't been very worried about that.

> So from that point of
> view, a simple check that asks "I earlier fetched from you with this
> filter and these tips of histories; are you still willing to support
> me?" and gets yes/no answer might be sufficient.  A remote that is
> not trustworthy can say "yes" and still change their mind later, so
> such a check may not even be needed.

Yeah, or a remote that is using some kind of high availability system
underneath might consider that it's too expensive and useless to check
if everything is properly saved everywhere, as the underlying system
has been designed for that purpose and already runs enough internal
checks.

> The above two big paragraphs is a way to say that I am not all that
> worried about losing objects that we should be able to refetch again
> by adding this feature.

I agree. I think it's more important to worry about objects that might
have been added locally to the repo, but might not have been pushed
somewhere else (yet).

> The perceived need for "--force" or "must
> run from terminal" may be overblown.  I do not think this negatively
> affects correctness or robustness at all (as long as the pruning is
> not buggy, of course).

I am Ok to remove the "must run from terminal" and "--force" if we
consider that people using this feature should know what they are
doing.

> HOWEVER
>
> Unlike prune-packed, pruning objects that could be refetched has
> negative performance impact.  So adding an option to enable/disable
> such pruning is needed.

I think a command line option like `--filter=...` is what makes it the
most obvious that something special is going on, compared to a config
option.

> If the frontmost UI entry point were "gc",
> it needs an opt-in option to invoke the "filtering repack", in other
> words.  "pack-objects" should not need any more work than what you
> have here (with the "terminal" and "force" discarded), as "--filter"
> is such an opt-in option already.

Yeah. So to sum up, it looks like you are Ok with `git gc
--filter=...`  which is fine for me, even if I wonder if `git repack
--filter=...` could be a good first step as it is less likely to be
used automatically (so safer in a way) and it might be better for
implementation related performance reasons.
