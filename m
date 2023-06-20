Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20242EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 12:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjFTMEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 08:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjFTMEV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 08:04:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1DBE7
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 05:04:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51a3e7a9127so8074829a12.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 05:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1687262658; x=1689854658;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8h9tXaPYcypqfx51zV2gU91yV9oqA6RUpAqlFI3F4E=;
        b=f6qHQp8YmxDhMaa0WG/g3pu5p7sSqrf5vm5WFdEIBxP4uap7s+rkH4fzEHErc5BF7E
         D5xLOfWebUDHblOX3kPVAXEkVVUbRSE3xC1neXOhZLp3+TVDRNMB7eYtj1UeU+kY/47A
         FWZgyr0d1rNMBrILMnWqpQAFTvpzVt7HApDPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687262658; x=1689854658;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8h9tXaPYcypqfx51zV2gU91yV9oqA6RUpAqlFI3F4E=;
        b=kPxAB1rWJBo1x4eQ+7gKH1aN1EKB+OYK+0GrdqK9R2i1rQe6TR/0YW1Aib0ziEjGWn
         NqmN8bxFFJY790xKa6tx5NYOcNO94ENmAmU6R+I4lZwoP6kok71Ay08WNDXGKDWueirs
         f2PUfyN2XCNxSe9yI/1IbgLk3aFtx6gxDJx+Ba7oqE0NhfmxjW2G6tCS7+nVGTAHajvV
         fhlttqTSCOXHolpJW5J+5q0CPVAF148GCiEXKyUkqRS8QbVyszDDhPreCl8v0FeEe8/u
         HqDKJ0fXtVhekw2gKi29RniUamMvBqesXxW6cO8qZNM+czEn18He8tx7aYF8pj7J2D3h
         zOag==
X-Gm-Message-State: AC+VfDxLrHIPHy0Z/WiwPcewEZt6ZJGAEHvbvpQQz0a5nFslI7Xp9btS
        ZaLcDbBQpyozbDAbUElAHuabxpt81HdHjH8W2pdbHoNUafcpm0nrGjriug==
X-Google-Smtp-Source: ACHHUZ5u8xKTUunagE/aDABxDHteTNrROxRCw3MgsGXOKlGD8Ca/1hLP27/MWTeRNktjVONgQ0aa4dC85oZCffd4EQo=
X-Received: by 2002:aa7:d60c:0:b0:505:d16:9374 with SMTP id
 c12-20020aa7d60c000000b005050d169374mr11330385edr.9.1687262658118; Tue, 20
 Jun 2023 05:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpohiTzANyhzL-mS-gg2kzbOEOiDktNbdwEXBKy9uL0-JgA@mail.gmail.com>
In-Reply-To: <CAPMMpohiTzANyhzL-mS-gg2kzbOEOiDktNbdwEXBKy9uL0-JgA@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 20 Jun 2023 14:04:06 +0200
Message-ID: <CAPMMpog8Hv_KcjNxbh_wzjwrFYt7TuTvrVy1XEtJMm6RWSKzRg@mail.gmail.com>
Subject: Re: Determining whether you have a commit locally, in a partial clone?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 1:26=E2=80=AFPM Tao Klerks <tao@klerks.biz> wrote:
>
> * Is there any way to run a single git command in a "don't use
> promisors" context?

My apologies for the self-reply, I did find a workaround here:

git -c remote.origin.url log SOME_HASH_NOT_IN_REFSPEC

I don't understand what's happening here at all, because setting
"remote.origin.url" to "True" in this way works to prevent the
normally configured URL from kicking in, but setting a different value
(or empty value) does not. The following will end up fetching from the
originally-configured URL, completely ignoring the passed-in config:

git -c remote.origin.url=3DBADURL log SOME_HASH_NOT_IN_REFSPEC

I'm still interested to know whether there's a less-hacky way of
determining "do I have this commit locally?", of course, but fwiw I am
unblocked.
