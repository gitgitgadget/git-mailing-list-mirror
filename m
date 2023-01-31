Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432FEC38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 20:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjAaUeb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 15:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjAaUe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 15:34:29 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31185975C
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 12:34:28 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id lc15so4018418qvb.7
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 12:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WFPmHE4GwMPcZQCYIpCOfY/dZlIaOQJAAmOh0j/sJZc=;
        b=iPgmpl0lJaduf/RkvA1VDQ1DYobvj7+o3oMDmj4UW17tGfVPYrZ9/5GsXFs+f9f6FN
         1ZnC1MHDTuDPOjPlovWGroikpKCaJMTnE3FloHixwG73kU9YEvTA/lU82zxG3ry2lKWV
         y+X+h9T2NvcAy84M9ByE5sUYKKx/ZFwSCOxwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFPmHE4GwMPcZQCYIpCOfY/dZlIaOQJAAmOh0j/sJZc=;
        b=oFx3ezKaZCNL/okAEJ+wEmYcUx/VFP0H2awOGr/AmZrzimB+mUjn3Xqbz0wYmSZvQr
         rMLBm7PLFlmmg6GHqmt/Uc6AoY0DGeu4P0ty4FJ7Oc7RKW0g2Xh3DGYVOTB1tCSWHxel
         k9FG/NrTXbNkyUbre8UBXFdhRxlFLzkjcUHZwkJhp9i/o61N5l/8pz6upaLzCsM+gSmF
         nO1h/UIcSObtlSfiiFbvWw6SffwrNkDKqvRnrhQbTmwNfs5DIkBS8MIwBFf7reWi4CON
         MdSUB0GsgCopvJYCZBVU5n052apqaUL9ETZ9TW4emUtOz3Zuv5FmCItS55SBsqUfuXcO
         XWpQ==
X-Gm-Message-State: AO0yUKXX1N/u20CNFUslr4unl4Go6yp1/+daT93Gz+7nrUjIxXuFL+iF
        gTyXvlOk/4nDR2zNLzk4hs5AhWH57DLs6/eF
X-Google-Smtp-Source: AK7set/CB7zIEgsxvhgQp63DN0EER/B/cEjDvVN8nq6UNTDquHzAkhi/+pJbED1zIudzxpmWKzIqHQ==
X-Received: by 2002:a0c:e051:0:b0:537:7a52:ee8e with SMTP id y17-20020a0ce051000000b005377a52ee8emr495809qvk.20.1675197267842;
        Tue, 31 Jan 2023 12:34:27 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id h189-20020a3753c6000000b006fbb4b98a25sm10725007qkb.109.2023.01.31.12.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 12:34:27 -0800 (PST)
Date:   Tue, 31 Jan 2023 15:34:25 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Eli Schwartz <eschwartz93@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
Message-ID: <20230131203425.qxy5f7aappzip5om@meerkat.local>
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
 <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
 <6fc8e122-a190-c291-c347-258a5a2ad9c9@gmail.com>
 <20230131162049.mgqdxcucjesw4afr@meerkat.local>
 <df7b0b43-efa2-ea04-dc5b-9515e7f1d86f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df7b0b43-efa2-ea04-dc5b-9515e7f1d86f@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 31, 2023 at 11:34:59AM -0500, Eli Schwartz wrote:
> In most contexts, it's utterly unacceptable to not remember the checksum
> of the file you used last time and instead simply trust PGP identity
> verification. This permits upstream the technical means to be malicious,
> and re-upload a totally different tarball with the same name, different
> contents, and different PGP signature, and you will never notice because
> the PGP signature is still okay.

Yes, it's true, and it's something that Sigstore tries to address.

That said, if I wanted to trojan a download and had access to both the
infrastructure and the developer's credentials, I wouldn't pick a months-old
release for this purpose. I would wait until I see a new release coming out
and then swap it mid-flight. This lets me defeat even transparency-log based
solutions like sigstore.

(I'll probably be giving a talk at the Linux Security Summit titled "How to
trojan the Linux Kernel" where I'll go into some of these considerations. :))

-K
