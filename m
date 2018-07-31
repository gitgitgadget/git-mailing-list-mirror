Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5719C1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 00:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbeGaCTR (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 22:19:17 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34684 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732058AbeGaCTR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 22:19:17 -0400
Received: by mail-yw0-f193.google.com with SMTP id j68-v6so5114960ywg.1
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 17:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kwevwDLs2V7u86JD1mSb6N7iZtV8/j5sFEH3ICrREHc=;
        b=L0o80YlxJrdiaeQ5lTUcSacU1YUVf90ZceCQPJix82bawHbImaJCzwtWCk6O6YKb5P
         WIac9ggjsEEbqKoXXi73cswpv/SDJswBKUg2kVfdYDEcT4lnBdefgDlmFoCQvHiyZuEV
         3gj5mDO2u9G4RQtnPL2oSBMCwtQyBKqsgJEQMSecMehLt3QHloPezhp10MWXbUYSrHvT
         fKnDdrBIAH4rCRKfOmGuscs/3iiE2vhA44BOzdPSJueWn2y+ALKvwzSCmalk9IBj3IXU
         VYY94P6E3geEnB+Qisonqo6R3F9jQSG5ScGnn19k1uc7fEaDH1AiX+DnInUvGQgWlr7L
         HnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kwevwDLs2V7u86JD1mSb6N7iZtV8/j5sFEH3ICrREHc=;
        b=BI/tJHRvvUnpC9a+2bi0FqoSes4vzQRCJ0DKBCcTAcgYyTOsMn+EvKYEAHsxy5D99o
         xgg3t6SxNlgpEexVWjSXsWPQGWLf6QdLzgAqFIqCFEDyigb7BpsmQo+1bugK8JrNpa3k
         K/OfOh2jriJDnUiZXwvEcmDd15lnEnul02eadMODarvsxGfu/EKp8gcmE+SFekpyuWLQ
         yfZfD3kET4vAQg6yAMF9aTbSsxn3KWCG6h4paO6j3Tkqc2JZZlJTt3ficwxMPOkssGsV
         gfE4mXlWyZZ9uKlJoTE0o8jZXpdpu5siB72v8ku6qhFArhyZ3EjnYMaLTFbZTNM0/mGQ
         4msg==
X-Gm-Message-State: AOUpUlFc97/pt3VIkXKf16WbYv/8Pc38aaHHaamb0tNB1XMghVSCt1xJ
        7sshzuRazzq/s9m/Lvlu7LtjEHv4MUB+zBM5j2qiAQ==
X-Google-Smtp-Source: AAOMgpdatVcapmQX8G0VGiUFOmDB8DIJiHUqvRKrESGMiS+LuiWaQJexdqTF6wuCaubxZIr2hX/lBWyoCrEaaN/d7/w=
X-Received: by 2002:a0d:c5c7:: with SMTP id h190-v6mr10334374ywd.421.1532997702258;
 Mon, 30 Jul 2018 17:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180730194731.220191-3-sbeller@google.com> <20180731001858.122968-1-jonathantanmy@google.com>
In-Reply-To: <20180731001858.122968-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 30 Jul 2018 17:41:31 -0700
Message-ID: <CAGZ79kbwt2RGo2Z2ARSzfHOZdL_VWF1sR+=EE=QWx1ibLL+KwQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] refs: switch for_each_replace_ref back to use a ref_store
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        git <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 30, 2018 at 5:19 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > So let's go back to the clean API, just requiring a ref_store as an
> > argument.
>
> Here, you say that we want ref_store as an argument...

I do.

>
> > -int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_data)
> > +int for_each_replace_ref(each_ref_fn fn, void *cb_data)
> >  {
> > -     return do_for_each_ref(get_main_ref_store(r),
> > +     return do_for_each_ref(get_main_ref_store(the_repository),
> >                              git_replace_ref_base, fn,
> >                              strlen(git_replace_ref_base),
> >                              DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
>
> ...but there is no ref_store as an argument here - instead, the
> repository argument is deleted with no replacement. I presume you meant
> to replace it with a ref_store instead? (This will also fix the issue
> that for_each_replace_ref only works on the_repository.)

Yes, I would want to pass in a ref_store and use that as the first argument
in do_for_each_ref for now.

That would reduce the API uncleanliness to have to pass the repository twice.

> Taking a step back, was there anything that prompted these patches?

I am flailing around on how to approach the ref store and the repository:
* I dislike having to pass a repository 'r' twice. (current situation after
  patch 1. That patch itself is part of Stolees larger series to address
  commit graphs and replace refs, so we will have that one way or another)
* So I sent out some RFC patches to have the_repository in the ref store
  and pass the repo through to all the call backs to make it easy for
  users inside the callback to do basic things like looking up commits.
* both Duy (on list) and Brandon (privately) expressed their dislike for
  having the refs API bloated with the repository, as the repository is
  not needed per se in the ref store.
* After some reflection I agreed with their concerns, which let me
  to re-examine the refs API: all but a few select functions take a
  ref_store as the first argument (or imply to work on the ref store
  in the_repository, then neither a repo nor a ref store argument is
  there)
* I want to bring back the cleanliness of the API, which is to take a
  ref store when needed instead of the repository, which is rather
  bloated.

> Maybe at least the 2nd one should wait until we have a situation that
> warrants it (for example, if we want to for_each_replace_ref(), but we
> only have a ref_store, not a repository).

okay, then let's drop this series for now and I'll re-examine what is
needed to have submodule handling in-core.

Thanks,
Stefan
