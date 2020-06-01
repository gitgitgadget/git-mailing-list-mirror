Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363B1C433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 20:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC27206E2
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 20:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hwYKrgA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgFAUhP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgFAUhO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 16:37:14 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8895FC061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 13:37:14 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id a7so1201172qvl.2
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 13:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1tQd9g0t7CgxuaOz/L8jWeAqrKD9eznrPyqMbeCHbII=;
        b=hwYKrgA/m4A2mcizCvnhSy+xZX4tCdaIYMILiLki4JVt9Itlgpm8hwlHpI8fDndT6L
         iIuRtDPd68584Ofx+NVam1MkoNoIy0TNNVEsArVKs9NC8XFOtGjnIl54N+7C5hBvCV5r
         uGQQOtuxAnMFEiNKiJoP6BVr0bNQTaqBbgbXizQd4LvQJY+CgvJIs8h5TagQr4ZPVNj1
         T43ffFJjJWNS/0Ls8sbo7pV+7DGIvrINVZ8LJx8Yf/wU23R3yqQgR2o+ZCsrVT4V0sju
         9U5zSsqoOgGERvMSuhkXp5DSS+BWJ/QSJSw6o0CflGe5KrI3kWdfjMosMilGUOZ7At35
         H0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1tQd9g0t7CgxuaOz/L8jWeAqrKD9eznrPyqMbeCHbII=;
        b=FRcXfcrsijuAUX2G09TrdQckArQKtVlnYzPBK2c5PCRJ76g6S3whJTXWsa4uOI4G91
         t9Q/VbI0le9tDAcBjYQJzsb16M+qOuVz4Bn0ZyjzGrDja2NEbv51SzAKk+sxaRAwfJVv
         hMiR61qvfP+3Lbmp1r6oOOCMZmixWC7yfP0iGYRVnVuh9xG04C9va9yCyRdD3dJsf22w
         hgq/+QsPcqC7DNO6OYACMB6K/pWPo7JzVtE9vcSC035VCoRAd6qtMfITCwiD3w7JgBpA
         5XfubnuaOVkN+jD1AteckKOEKp5YlP0RulEjshNcGxMCbn1ebanM0cp714e34zukJHcP
         wnbg==
X-Gm-Message-State: AOAM530Tn9u4Rn9RoIE+uSc8nUPUx+zwke+cV6+VCQPtUTk9L2u0xUDd
        pjupQ7ndq3texSKYQiG348Yt4/0QosUrgCqSwg6D
X-Google-Smtp-Source: ABdhPJzyRTk9mdS6YMgvtWzB7a/xb8YbW2X/VjeDIIkeZ4WLk+TTJeJIJIOEIhjt0fKyo5xteKzxa/0oaozjU2zcDclS
X-Received: by 2002:a0c:ee25:: with SMTP id l5mr21901359qvs.5.1591043833489;
 Mon, 01 Jun 2020 13:37:13 -0700 (PDT)
Date:   Mon,  1 Jun 2020 13:37:10 -0700
In-Reply-To: <xmqqmu5qxs6e.fsf@gitster.c.googlers.com>
Message-Id: <20200601203710.222245-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqmu5qxs6e.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: Re: [PATCH 1/8] http: use --stdin when getting dumb HTTP pack
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > When Git fetches a pack using dumb HTTP, it reuses the server's name for
> > the packfile (which incorporates a hash), which is different from the
> > behavior of fetch-pack and receive-pack.
> 
> My first two reads of the above mistakenly thought that for some
> reason the packfile has the URL to the server encoded in its name,
> but that is not what you meant by "the server's name".  You rather
> meant "the name the server stores the packfile under", "the name the
> server gave the packfile", "it reuses the name the server uses for
> the packfile".  The last rephrase may be the easiest to understand.

OK - I'll use that.

> > A subsequent patch will allow downloading packs over HTTP(S) as part of
> > a fetch. These downloads will not necessarily be from a Git repository,
> > and thus may not have a hash as part of its name.
> 
> A location that is not necessarily a Git repository can still honor
> the naming convention, so I find this a bit weak argument.  After
> all, the procedure to prepare such a CDN backed file would be using
> Git and the (git) "natural" name for the resulting packfile is
> easily available to it, isn't it?
> 
> I am not necessarily against loosening the limitation of the shape
> of the filename, but we may want to say the reason why we want to
> name the packfile on the CDN side differently from how Git would
> naturally name them.  What benefit would we get out from geing able
> to do so?  Perhaps it makes arrangements such as "you can fetch
> 'pack-v1.0.pack' to become reasonably up-to-date if you at least
> have the version v1.0 software", "if the last time you fetched from
> us was 2020-05-20 or after, you can fetch 'pack-2020-05-20.pack' and
> be assured that you aren't missing anything", etc.?  Such a "why
> would somebody want to name the packfile differently" would make a
> more convincing justification.

I didn't want to unnecessarily exclude features like signed URLs which
may change the way the URL is - for example, in Google Cloud Storage,
the signed part is a suffix [1]. I'll include this in the commit
message.

Having said that, after rereading my patch:

 (1) I'm not sure anymore if the restriction is that there must be a
     hash in the filename. It might be just that the filename
     must end in ".pack.temp". (Having said that, if the filename was
     not named "<hash>.pack.temp", it would look different to the rest
     of the contents of "objects/pack/", which may or may not be fine.)

 (2) The filename restriction in question is on the local filename, not
     the URL. We could do any manipulation we want on the URL (e.g. by
     appending ".pack.temp").

And one idea that came up at $DAYJOB is that if we're using a suffix of
the URL as the filename, there may be a clash of names anyway, so we
might as well use the hash instead (which is reported by the server).
I'll take a further look - maybe this patch will no longer be needed.

[1] https://cloud.google.com/storage/docs/access-control/signed-urls
