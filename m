Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B8CC2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 09:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EEE820725
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 09:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vX4FjTkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgIWJrT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 05:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIWJrT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 05:47:19 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5631CC0613CE
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 02:47:19 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y17so857527plb.6
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 02:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aML/t4h7mVIpkcQcJXsgYsRWGFx2matPFxn2ZhcrDrQ=;
        b=vX4FjTkBhSAiMyvt0rZXAn6zyg5IG17T+/RP4/VvVUCa4gj/Y+sWQNIaAltd7J6Vn+
         mphzGX1cy30Adl83vNCIi18BHkHJqqBhCGCE8XNdZfjlcdbbjTSPdxMZ2vl+SI/hfD28
         4SUbcXS7LnQ4yTkNso9Iqgnirku42jMEI3+/pFB1R9Z5I1e8ByvpxPB/lK8tubtUoLq4
         Ahg0+4qJu7vK+vWb0R3YPp+17szAfIuBh20vKEbQC+j7fzf6hrMK6jM9xmvtlwW07fdj
         TtjmiCn9r6oL/C0+P1Qkb5LOFGxRmQEyeDOfwLacFSbwih3fdPRl+EQ4i/OTicdLEGaG
         JeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aML/t4h7mVIpkcQcJXsgYsRWGFx2matPFxn2ZhcrDrQ=;
        b=i9MUyMRtz9RiSc39osSpm+SGquwNJESX3F2lhFnIxOkvexl9iK9eG6gkvlCzivB/0I
         F+Ntb0lX5JgfRzlMUO8yidyJyE2TcULURyAN5AVx3ekFTPXP9KyJrnR3FrqkxpfcNAvB
         nvNxoATh8/8EX7vrbJM3eOqabLvWM87aC1/j4Wsej0BTozOoYE5cfOhflZeOwtlLJiiv
         9lqbLf1BbfoAwqFcN8dj9xXX6bqKF1DX2RlaHZlmoUyqQfHNghDeOhR8D7seOb70vbDF
         tH1giXA8NStPWRo1keGXHuJeCsH4reAGTF/xrs2gFVxCFiKxTw9lAS8P59uii9m1i++e
         dMGw==
X-Gm-Message-State: AOAM530Q2DTrfEzhwRyLvUpNMSTSl1gW9ZT0KmDnDgpGi4+8Qfw0Nwax
        L+d7skO3GD+9Th7vLX1h8f0=
X-Google-Smtp-Source: ABdhPJxSReW1BqHMnUpaka4zuZ2e9sBpVj47kX9rYfgWKFZUQjLTLSU/CDg0e2alTC4UfOxNBBRKEQ==
X-Received: by 2002:a17:90a:7bcf:: with SMTP id d15mr7448278pjl.230.1600854438885;
        Wed, 23 Sep 2020 02:47:18 -0700 (PDT)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id y6sm5098776pjl.9.2020.09.23.02.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 02:47:18 -0700 (PDT)
Date:   Wed, 23 Sep 2020 02:47:16 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] builtin/diff-tree: learn --merge-base
Message-ID: <20200923094716.GA1309694@generichostname>
References: <c0d27b125e969e13c52b0fa806a8e3caa8c20ac6.1600328336.git.liu.denton@gmail.com>
 <xmqq363gs1mt.fsf@gitster.c.googlers.com>
 <20200918104833.GB1874074@generichostname>
 <xmqqy2l7m3hk.fsf@gitster.c.googlers.com>
 <20200920110148.GA227771@generichostname>
 <xmqqzh5jf73t.fsf@gitster.c.googlers.com>
 <20200921172740.GA946178@generichostname>
 <xmqqwo0met17.fsf@gitster.c.googlers.com>
 <20200921215409.GA1018675@generichostname>
 <xmqqblhyepup.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqblhyepup.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, Sep 21, 2020 at 03:18:06PM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > This does not happen because at the top of diff_get_merge_base(), we
> > have
> >
> > 	for (i = 0; i < revs->pending.nr; i++) {
> > 		struct object *obj = revs->pending.objects[i].item;
> > 		if (obj->flags)
> > 			die(_("--merge-base does not work with ranges"));
> > 		if (obj->type != OBJ_COMMIT)
> > 			die(_("--merge-base only works with commits"));
> > 	}
> >
> > which ensures that we don't accept any ranges at all.
> 
> I think we should lose that loop, or at least the first test.
> 
> If we are not removing the support for "A..B" notation and still
> accept "diff A..B" happily, not accepting "diff --merge-base A..B"
> would appear inconsistent to the users.  

I disagree, in the documentation, it clearly states that this option is
only available to the diff modes that accept endpoints, not
ranges:

	'git diff' [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]::

and

	'git diff' [<options>] [--merge-base] <commit> <commit> [--] [<path>...]::

so it seems perfectly consistent to me. The documentation gives the
impression that the range notations are their own separate mode anyway.

And worst case scenario, if we receive user reports that they believe
the feature is inconsistent, it's 100x easier to change it to allow
ranges than attempting to remove support for ranges in the future.

Thanks,
Denton
