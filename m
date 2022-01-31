Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D859C433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 13:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358645AbiAaNHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 08:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376303AbiAaNHi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 08:07:38 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77F9C06173D
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 05:07:37 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c2so10165906wml.1
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 05:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=x7jEcfPc5qY5UQG0BmcJLqlhGez4ZeHZd/IaMcaqo30=;
        b=F6jAFrn3+mtZe8RE4c1E5J9ACBrmkysfFcgG/6y9+buCxEHiq1EZp2ZC4RY6ex/Nuj
         sIWXo7UCekBD7giubwcTdeOdMtPqwEP64qOZb2SpqXCREldLddGZIGRURq1npxjM3SXg
         lS9SGdUjxZKZJy8Da0mN/Ab0htqFUCyPiNR6qGPyFG+hUvbJBnZMxNzM+b0uDvDzNBMn
         5Xqpf3mf4IFDEa8mIa1Ee2iGj9ZpKImZqfDl87jnOfn3xqMRzxUqu96mVx3rwSyw/fr3
         eem+bhv1xcsktesPy3AiIgUwzsB0xjk8QmAFUeueyuFc5QxBLR5eeWuSqNGmf82jN0L+
         dkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=x7jEcfPc5qY5UQG0BmcJLqlhGez4ZeHZd/IaMcaqo30=;
        b=1VLgMY3V78QtFoTAZhULpwmVfdImeQ6VRy+ZARwpP1U3xIR8eGjf5CKAzysULGjetG
         4c/o4VUXCblgsOvtKyBD+r4jPmm3op53jplUBAoF/CInKxWv7UqK2v8YrWJv+NXaUyNv
         0ka/kH+JOW3PpfX5WEidO+mG3btEL9XBxhWspxebnoU8KIQzfdmhw2+y7h94OIkLdmNv
         II9DglrPhVJYfNXDcyKXYcWELwz8x5P56QXDuD2MGPCMPdFSXasryyoG/ebq+7RdBpOu
         SrGeCV0DgDACmtDgYuSIgpgCNx98Zvx0a/IeTjOKj/GgMyEOLMPL2EjwgX/+txhLYNTB
         DeLQ==
X-Gm-Message-State: AOAM532hgOEzE3WeRZAdbwyWV6Yq4CWMfskbbYcE/alvR9ukVCP1AU+e
        ZbcHuXUQTOdzrlN7vOHL2A8=
X-Google-Smtp-Source: ABdhPJzMBfoPLxdxgSvNycaRKAAkpTfZHll0oPhgd0PN8WIocylIbTNOMbqkkYyaafbdhy575c4ADA==
X-Received: by 2002:a05:600c:1d0e:: with SMTP id l14mr27128160wms.80.1643634456168;
        Mon, 31 Jan 2022 05:07:36 -0800 (PST)
Received: from localhost ([77.75.179.5])
        by smtp.gmail.com with ESMTPSA id j19sm9592459wmq.17.2022.01.31.05.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 05:07:35 -0800 (PST)
References: <20220127153714.1190894-1-t.gummerer@gmail.com>
 <xmqqmtjh0x5f.fsf@gitster.g>
 <87lez0p1db.fsf@coati.i-did-not-set--mail-host-address--so-tickle-me>
 <nycvar.QRO.7.76.6.2201281333410.347@tvgsbejvaqbjf.bet>
User-agent: mu4e 1.4.15; emacs 27.2
From:   "Thomas Gummerer" <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] fetch --prune: exit with error if pruning fails
In-reply-to: <nycvar.QRO.7.76.6.2201281333410.347@tvgsbejvaqbjf.bet>
Date:   Mon, 31 Jan 2022 13:07:33 +0000
Message-ID: <87ilu0oxyi.fsf@coati.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Johannes Schindelin writes:

> Hi Thomas,
>
> On Fri, 28 Jan 2022, Thomas Gummerer wrote:
>
>> Junio C Hamano writes:
>>
>> > Thomas Gummerer <t.gummerer@gmail.com> writes:
>> >
>> >> +test_expect_success REFFILES 'fetch --prune fails to delete branches' '
>> >> +	cd "$D" &&
>> >> +	git clone . prune-fail &&
>> >> +	cd prune-fail &&
>> >> +	git update-ref refs/remotes/origin/extrabranch main &&
>> >> +	>.git/packed-refs.new &&
>> >> +	test_must_fail git fetch --prune origin
>> >
>> > Is it because the lockfile ".new" on packed-refs prevents deletion
>> > of refs but does not block creation and updates to existing refs
>> > that it is an effective test for the "--prune" issue?  If we somehow
>> > "locked" the whole ref updates, then the fetch would fail even
>> > without "--prune", so it may be "effective", but smells like knowing
>> > too much implementation detail.  Yuck, but I do not offhand think of
>> > any better way (it is easier to think of worse ways), so without
>> > further input, I would say that this is the best (or "least bad") we
>> > can do.
>>
>> Yes, that's correct.  New refs will be created as loose refs, so they
>> don't care about packed-refs.  However deletions can potentially be
>> happening in packed-refs, and that's why it fails when 'packed-refs.new'
>> exists.
>>
>> I don't love the test either, but I also can't think of a better way to
>> do this.
>
> Maybe add a code comment about it? Something like:
>
> 	[...]
> 	: this will prevent --prune from locking packed-refs &&
> 	>.git/packed-refs.new &&
> 	[...]

Yeah, I think a comment here is a good idea, thanks!
