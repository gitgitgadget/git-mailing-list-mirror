Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CEBC433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 00:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A96E6109D
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 00:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbhKIAZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 19:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbhKIAZm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 19:25:42 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04041C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 16:22:58 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 3-20020a620403000000b0044dbf310032so11711248pfe.0
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 16:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=rOTURaP5PaQeOSsIpcmd46Y91R+MNLyAPR1yU2Z6iBo=;
        b=sND67PsF9L5RqerA58v1bnL0+omM94fi+xxhrIl6ZGmOoCuBeU8x017IAt8YEGYRwj
         IFgk0SugtevNbLfyos//qztbh+XrFEQR4WSr4c1A+k9fXl2L/OEM6qPyQUIXurcbA2LI
         hF/bjpOR/BDUoBgt+v60Vz2JC4mp7QIMXacy1/kpdy4gDGYK6Suxap4dDYjSQVFDOKPn
         ECSE0Vub7G64IqgWxGdsc5n1ARjKo8rzG+Z+tNH47ot8JLKBMbFOYNutut4hmYHrgv8D
         kimfLZMG7G5cXhFQa8u6X6DMtZiqU0BaAQbauvm7CLvGWVQo6CqBOGj6N1zT7xgL4g2i
         jV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=rOTURaP5PaQeOSsIpcmd46Y91R+MNLyAPR1yU2Z6iBo=;
        b=PE0VOZ304TZxWF9GGl0NwK6f0Tb0cgTclo4FEcaPiy540G4kSox/MDynULhAv2HrhE
         RIV0pvVRGynKuzel9zKcI7olLPoKE/mfYU+SgOLCfWxng60gemODx1zN0mv9sZdXrWfm
         PWeF4CCNgFTIqPQ8RZz8iMZZIIzeRuhWo+Q+wuCK73hq6rOUnMk6+ruKVnzSpexiiVo/
         sNb2wZEKykSQ07WcroY2VVK+ECrH99HxuWTmnsIAwHWEqlgt2534pln9pMoaT5kxiaLU
         WPsM5GNXZgJpMILIvuLenfv0q2qSekO2O3mezOkiiOjr8xGydLzUxiiXFeYMR98rBYNw
         0Agg==
X-Gm-Message-State: AOAM533+VB8OZ4kIRNhKjsL6RSISIo/PmVBDLLqfebopnqH4ZfZrcybp
        xYDz9n3/D/l6MYRGBeOacawT5weqhHqGSrEMQg51
X-Google-Smtp-Source: ABdhPJyP6yfQzHT15kUv62+yNQ20O/BzBHVJR0ZgrI6Xn0HA42IiBnelkQqvWTNaIzhx/vzeB+KLQxeDT94hy02Ie/0A
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:acc:b0:44b:ff29:621b with
 SMTP id c12-20020a056a000acc00b0044bff29621bmr3226024pfl.32.1636417377493;
 Mon, 08 Nov 2021 16:22:57 -0800 (PST)
Date:   Mon,  8 Nov 2021 16:22:55 -0800
In-Reply-To: <YYWTCcAljHQRTJQ/@google.com>
Message-Id: <20211109002255.1110653-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YYWTCcAljHQRTJQ/@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: Re: [WIP v2 2/2] config: include file if remote URL matches a glob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net,
        gitster@pobox.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> To expand a little more on this:

[snip]

> The nice thing about 'hasRemoteUrl' in this case is that we don't need
> to know the location of the user's big-oss-project/ checkout on disk. We
> can set that config globally and they can checkout big-oss-project as
> many times and as many places as they wish. It wouldn't be possible to
> ship configs via a package manager or other automated script without it.

Ah, thanks for the elaboration!

> > NEEDSWORK: The way this works is that if we see such an include, we
> > shunt all subsequent configs into a stash (while looking for URLs), the=
n
> > process the stash. In particular, this means that more memory is needed=
,
> > and the nature of error reporting changes (currently, if a callback
> > returns nonzero for a variable, processing halts immediately, but with
> > this patch, all the config might be read from disk before the callback
> > even sees the variable). I'll need to expand on this and write a
> > documentation section.
>=20
> Hm. I'm not so sure about making another structure for storing config
> into memory, because we already do that during the regular config parse
> (to make things like git_config_get_string() fast). Can we not re-walk
> the in-memory config at the end of the normal parse, rather than reading
> from disk twice?
>=20
> I think git_config()/repo_config() callback even does that for you for fr=
ee...?

The main thing is that we wouldn't know if an entry would have been
overridden by a value from an includeif.hasremoteurl or not.

> What's the easiest way to "try it and see", to add tooling and find out
> whether the config files would be reopened during the second parse?
> Because I suspect that we won't actually reopen those files, due to the
> config cache.

As =C3=86var says, strace should work. The hard part is implementing the
recursive config parse, but it looks like the way to go, so I'll try it
and see how it goes.

[1] https://lore.kernel.org/git/211106.8635o9hogz.gmgdl@evledraar.gmail.com=
/

> So couldn't we do something like....
>=20
> pass #1:
>  if (include)
>    if (not hasRemoteUrl)
>      open up path & parse
>  put config into in-memory cache normally
> pass #2: (and this pass would need to be added to repo_config() probably)
>  if (include)
>    if (hasRemoteUrl)
>      open up path & parse
>      insert in-order into in-memory cache
>  don't touch existing configs otherwise
>
> I think it's in practice similar to the approach you're using (getting
> around the weird ordering with a cache in memory), but we could reuse
> the existing config cache rather than creating a new and different one.

What do you mean by "insert in-order"? If you mean figuring out which
variables would be overridden (and for multi-valued variables, what
order to put all the values in), I think that's the hard part.

Another thing is that at the point where we read the config
(config_with_options()), we have a callback, so we would need to make
sure that we're writing to the in-memory cache in the first place (as
opposed to passing a callback that does something else). That might be
doable by changing the API, but in ay case, I'll try the recursive
config parse first.
