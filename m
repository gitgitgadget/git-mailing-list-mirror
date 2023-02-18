Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19CFC61DA4
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 04:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjBREeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 23:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBREeF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 23:34:05 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B272A159
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 20:34:01 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1676694839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wPxIs1b4jwLQAztPaFq+ZHBkd7Tex/hUNFKFBWpFNB8=;
        b=PdzQHY9P0iLYV9aljbGJTHPE/66xrOXsDRVI2X7CuKGwZuOZ62VaccFfs847BTyPQbZuA0
        WThGhEJ9B+k/Fl2/I8F+s4CcxuKqZLFMIm4dqmzyPZyDvNWCqQRakJjsvN0NAlCERattYi
        /HFphdhcEmgPyL2LUNVTLSnUwGtR984=
Date:   Sat, 18 Feb 2023 04:33:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   ronan@rjp.ie
Message-ID: <2aff5436d69e09241bee775cf03e9723@rjp.ie>
Subject: Re: Git pull without fetch
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Chris Torek" <chris.torek@gmail.com>, git@vger.kernel.org
In-Reply-To: <xmqqo7prk7vj.fsf@gitster.g>
References: <xmqqo7prk7vj.fsf@gitster.g>
 <CAPx1Gvd8vizeyveKgE2o2GStQsiGxN4aaASqYc81Nk28ogFLJg@mail.gmail.com>
 <49c07b5dc2afbd422d492d59380ad2c2@rjp.ie>
 <fc7d9fdde0443532eb9c32f26f9f054e@rjp.ie>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> That is very much working as designed.=0A=0AYes, I realize. I'm not rep=
orting a bug. I guess I just think it would be handy=0Ato more convenient=
ly reach the prefetched updates when I'm offline, and I gather=0Afrom con=
versation there is no method builtin to git.=0A=0AFor now I've settled on=
 this to be "pretend fetch":=0A=0A$ git for-each-ref refs/prefetch/ --for=
mat=3D'update refs/%(refname:lstrip=3D2) (refname)' | git update-ref --st=
din=0A=0Awhich I can follow-up with a no-argument `git rebase`, similar t=
o a `git pull`=0Aif the remote was available.=0A=0AIn my original questio=
n I had intended only to update the upstream of my current=0Abranch, but =
I've decided that's not necessary for me. However, I have found that=0Ait=
 is possible to get the upstream reference for the current branch like so=
:=0A=0A$ git rev-parse --symbolic-full-name '@{upstream}' refs/remotes/or=
igin/master=0A=0Ausing this it should be possible to find the correspondi=
ng prefetched reference=0Ain refs/prefetch if it exists and only update t=
hat reference without parsing=0A"branch.<name>.remote", "remote.<name>.fe=
tch", and "branch.<name>.merge" myself.
