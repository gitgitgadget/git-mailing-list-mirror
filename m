Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0BBC433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 01:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D635020723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 01:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYrLtkck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403870AbgE2Bt6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 21:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390018AbgE2Bt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 21:49:56 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C9BC08C5C6
        for <git@vger.kernel.org>; Thu, 28 May 2020 18:49:54 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w1so888377qkw.5
        for <git@vger.kernel.org>; Thu, 28 May 2020 18:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8oRN9fvrg7W5O5v4cxyyyfYEt2gYunvnQfXs3DuXmbk=;
        b=RYrLtkckWNUqqyytFy3ocTzQ2xho+V2EL9/fqaSHDAj9FFkk0s0XazGjFUt4awQcdR
         Y5aEy8P8PTra2bJ9kUD3JcGylaQE/WWVj7pE0CNAR4+xg82M1N2vKtnsfhtG3JMy2bPV
         n0a71MSNwAls+BvhavxP9R5sh37KlB+EyoBRCiQ5OsvN4yLlus3ADqmwUeC3NdIDMEVz
         gLRStcSKGP8RIKUHW0nYOb8HhZ4NVXARKBUpFa4AcCgBn+7oQpwbM8TxjwmSCcIxYWTN
         Az7RDnkKyD5/cLg5BuBrnd5gZ1ulDFsl6KXUH0LKvVUabsxQTw6MQeuHXI52JtfmtZh3
         10nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8oRN9fvrg7W5O5v4cxyyyfYEt2gYunvnQfXs3DuXmbk=;
        b=Ve+kE03MwLyd0GSAr8dNq+szfwIwWNsCNpKqZPaWUxj8aaWpLLx/hsjhwTLaaq9vzT
         JXW0wZF/Uf6mfUVGyIKs/McXRReRZSP5IXTYwiajCOnYIp4A80cpHzJQpY7upUYmvka2
         jsotgHbMAagK+9LyW1kRikdW7gABDWs5CLXseR4m2dgjXD7VfG2Wia4Cp+SXxvzSnBm0
         IQM98g/ZroSaKgIsSx1NncR/nHOPddoUDqpvbU8frJaBc/rcga2HN92LkxwBlhYRJ7f+
         gO03e0ebF+uHIv22fgPa18KItIYBDcpayIEfTBXL77Ted5LavLjINKx1Af3UYVr0B+jy
         bUhw==
X-Gm-Message-State: AOAM5301IIoPm+gA5bs0SHr0915KVb3Xj/gYhV71Dmpk57u7z8FWqNdx
        k0vp2vC+sf8gVwtHE61JSgA=
X-Google-Smtp-Source: ABdhPJxLSluiQRaNdxFTfPvZqACVVih+6s5VGVucoclrXrIcdwQxfx9879kAPyHNhzJ3EH7wwpvqdQ==
X-Received: by 2002:a05:620a:1310:: with SMTP id o16mr5724608qkj.68.1590716994063;
        Thu, 28 May 2020 18:49:54 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id 11sm6415336qtb.41.2020.05.28.18.49.52
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 28 May 2020 18:49:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [git-scm.com PATCH] community: advertise 'git-bugreport' tool
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200528231608.59507-1-emilyshaffer@google.com>
Date:   Thu, 28 May 2020 21:49:51 -0400
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <83936F1F-BFA8-4F74-8C24-07D42B1A044C@gmail.com>
References: <20200528231608.59507-1-emilyshaffer@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

> Le 28 mai 2020 =C3=A0 19:16, Emily Shaffer <emilyshaffer@google.com> a =
=C3=A9crit :
>=20
> Starting with 2.27.0, 'git bugreport' can gather diagnostic info and
> drop the user into an editor with a template for a useful bugreport.
> Advertise this feature to users who want to report a bug in Git.
>=20
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>=20
> Hi all,
>=20
> Since this patch deals with some prominent information about how to
> contact the community, I figured it was worth passing through the list
> for feedback rather than just sending a PR to the website repo.
> Discussion prior to this patch here:
> https://github.com/git/git-scm.com/issues/1464
>=20
> In the index.html.erb diff I'm interested in wordsmithing feedback; =
this
> is the page which appears at https://git-scm.com/community. The diff =
in
> _debugging.html.erb is modifying the list of references in
> https://git-scm.com/docs - I'm interested in feedback on whether this =
is
> the best header to include git-bugreport under.

I think maybe `app/views/shared/ref/_setup.html.erb` would be a better =
fit ?
That's the section at the top of the page, with `git`, `help` and =
`config`, called
"Setup and Config"...=20

The wording on the community page looks good.

Thanks,

Philippe.=
