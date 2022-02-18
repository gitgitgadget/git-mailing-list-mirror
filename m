Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16D6C433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 20:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239451AbiBRU3y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 15:29:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiBRU3x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 15:29:53 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31B1277910
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 12:29:35 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cm8so7744465edb.3
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 12:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=o0T8XIXgxO4a2vhjIQXe/iCiXrxL+rWtmuKl4LQONb0=;
        b=hrg25r6Q+kN/VoXs9z4Mjv+bOH4WAMTr0yMlKkWxEp7bK72HPHaEB1F+w55dkJjVO+
         h5n0TUTlzV3QbAiD/ECnkVp1Ds2TsivqgsVg6cSTkYd1cZxaEMhn+SG6zMmT02P8N6bD
         IuA8l0fo4vUuZrs1aF9BCBpvLMdZEIZArM2SUKwqmku26dmDxoeOx1hId3IVpwFBmR2q
         a9RY3gRNFukoIgOS3DQEt3ROJO0XvbVOcG3i3209e6CkNNvhLxE9qCRcwI+DQI3MamPz
         nN5GpHCi2r7Ev+kl29TsgnZLlfjeZ8sPpP9fizUGfGyKmmNBVzZ8FLE792Yf+e+LxErj
         DE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=o0T8XIXgxO4a2vhjIQXe/iCiXrxL+rWtmuKl4LQONb0=;
        b=u55uFs+Wz2N64FBH2pRGSOfqK0EBB1RFRg+zvxHQomriFIwzs++wifXvLJ55Ls2ywx
         aQgZ/JI7HCld5p0+CO86Uxg0dlsml8XvkDxO7d2NIee66/yfq4NtzawUVTM1dlOohQ/h
         WCB8r+qM2IOX1fboRN+nfmvtrqTNVpb9UDIf16OqFecVu+Z7+ekDk3Uet67C2MR56T5k
         wiq9Ukafia2Hw7T8csivgg6le35uWIiBww5R5RiE/xu3/y9/xAenTpARL00Gl8s27aVr
         9uqe2T/xnGMVE7risabpfStovvbC0suiBMpYJnvvJ2aJ3duWiQuGI198b9sTpo8tvkRH
         6yrQ==
X-Gm-Message-State: AOAM530nJDcbOFUMX6BKGuknQaaqEm9TYlA/H33kQPi5VRmCVQ8GSmAJ
        lAarOSzAPQUZ7ZX03kWGCx8=
X-Google-Smtp-Source: ABdhPJxLZjaV17rOerGu7MCe1NvmnIPBUI2U8LlZjgq7yZIRM0EClcUIttgSyKS4X0QqqJ6NcSLE/w==
X-Received: by 2002:a05:6402:520a:b0:412:8361:d11e with SMTP id s10-20020a056402520a00b004128361d11emr9909706edd.190.1645216174105;
        Fri, 18 Feb 2022 12:29:34 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u23sm2577479edo.64.2022.02.18.12.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 12:29:33 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nL9si-004PcT-TW;
        Fri, 18 Feb 2022 21:29:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] glossary: describe "worktree"
Date:   Fri, 18 Feb 2022 21:25:15 +0100
References: <xmqqczjvxy3o.fsf@gitster.g>
 <CABPp-BHrFb_AA2OAiR7Bmq7vQuyG2Wme_PdjPdY8j-tp3VJfJg@mail.gmail.com>
 <xmqqiltmwufw.fsf@gitster.g>
 <CAFQ2z_OgVcaty1wMX0O0mj-PYSAphKAkXgTCW+uJKDAuCwLn4w@mail.gmail.com>
 <xmqqh796tw34.fsf@gitster.g>
 <CAFQ2z_Pvje9LM0iyiP87S-L754zepEE_9k=_4Oa0w1Lo_pb=TQ@mail.gmail.com>
 <xmqqczjuttyw.fsf@gitster.g>
 <CAFQ2z_O=WguSAJDD4DRpwtX54A5dWQZQPCuQDR81idknQgchaA@mail.gmail.com>
 <xmqqtucx8g34.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqtucx8g34.fsf@gitster.g>
Message-ID: <220218.867d9rhqab.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 17 2022, Junio C Hamano wrote:

> Han-Wen Nienhuys <hanwen@google.com> writes:
>
>> For FETCH_HEAD, doing
>>
>>   git fetch host refs/changes/23/123/1 && git checkout FETCH_HEAD
>>
>> is the standard idiom for downloading a change from Gerrit. I suspect
>> there might be other similar idioms. This means we have to read them
>> through the refs machinery.
>
> This merely means we have to read them through the object-name
> machinery around get_oid().  Historically that was done by calling
> repo_dwin_ref() from get_oid_basic(), which is where refs machinery
> enters the picture, and because we had only files backend, it was OK
> and convenient to treat .git/FETCH_HEAD and .git/refs/heads/master
> in the same codepath.  But there is no reason for the arrangement to
> stay that way.  .git/FOOBAR_HEAD files can be read as a file (we can
> say we let files-backend to handle it, but we can also extract a helper
> function out of it and make it clear that it truly has no dependence
> on the refs machinery) while .git/refs/* can be read from the refs
> machinery that may be backed by reftable backend.
>
>> I think the most sensible approach is to pass the read/write through
>> refs_* functions, but special-case the storage, so it doesn't go
>> through reftable. We already do this for FETCH_HEAD and MERGE_HEAD in
>> refs_read_raw_refs.
>
> I think we are more or less on the same page.  I do not think these
> files behave like refs (they have no reflog, and they do not serve
> as anchoring points for the purpose of gc/fsck) and we need a
> special code path, which might be identical to the current ref-files
> backend code, to handle them no matter what backend is used for true
> refs.

I'm not sure I get all the concerns in this thread, are we talking about
having FETCH_HEAD be not-in-reftable mainly because it's multi-value?

Maybe we will need these special refs on-disk forever, but it seems
preferrable to pursue a plan where we use the preferred ref backend for
them.

That means that we can make them part of the normal ref transaction for
the backend, and could eventually support a world where a repo
e.g. talks to remote DB service for its refs (with shared storage for
repos).

For the "no reflog" is that really a critical property to maintain, or
just how the file backend happens to work now? In any case weren't we
talking about explicitly supporting the "explicit no reflog", "reflog
only for this ref" etc. that we support in the file backend in reftable?
Then we could presumably turn off the reflog for these special refs.

Similarly, for "gc" etc. supporting that doesn't seem like such a big
deal in that codepath, even if these end up being stored in some "real"
ref store. We can just ignore them when we're checking reachability.

But I may be entirely missing the point here...
