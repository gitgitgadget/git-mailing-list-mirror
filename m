Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110C5C25B06
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 22:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240113AbiHDW75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 18:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237584AbiHDW7l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 18:59:41 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577784D807
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 15:57:26 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id c185so993485oia.7
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 15:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=wa88Xlv/ZljV/nrpdDrslMKY2CyRU/NmH55aQGJwfUo=;
        b=ZL7oPdYe4hflernt1wkObAavLfNrb3DPEHunxhwsbuIUlpv1HzYBOfYF4lnUgEBLsV
         skkiiWevDjOSGiy/n+Gjgqrpf7jDevtFMEeabd/rH20MWL3QTJZkBVs7Iq0VxH90LEPh
         IMEsqdX7l5S3FToZ8TB65yED7oI8bbqbr0r82/S+HS+JAQ5WeBFwJFzJ9Tvz1cq07MDT
         blSusj9EqOvl5RvrcBHASfKYT8Nv6iADgygc65Uj/CF4rn4977tH8lRRyXOiq2LZRNSf
         TCOqsgIyz3WkMBhgD4Cxo9YLjh+PMPYk2wi7h1fP2X1YCEmCWXWYbDlyZUrvqZhPD+RQ
         0CPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wa88Xlv/ZljV/nrpdDrslMKY2CyRU/NmH55aQGJwfUo=;
        b=b7CT9PibjQg9AoxbTboWPOCCTrvoh/lpg8aq9xJrzkbPUUvpLXBdwOG43WwRzJ1DLQ
         pBStwc8lUEQJqNzW9cBbuAUBijY8pTMX1dr0hoFEOZ/JeAmgvnLeZyXBl2/eRf7XXXxw
         zW6Tn1H1zYndVPGY5O5ZhrEjHRWi7geIOg6VdWsAzGiFRQ2aVR7rNzoOGy83MHMtwwQm
         yq1muuT+hXp0RY0xz0oFwmTjlOGB4G4PII2CMs2Zdi6sG4UTz+nEX1wlQiGPXKV90wdE
         +egDnE74jU9dUGIGYR/RlrV3vVZAfu2QghkH7+SeiAor61SfErYF/UpDr0zGiyUnTBDa
         SMuQ==
X-Gm-Message-State: ACgBeo2bBym5U3Mn0qpnJqJC7j6qGLQnz/q+DEVO3NgcuFlSjaijrnMw
        X3vBCKqtqUmWfjKqPrtZD2ZbNQmUnClGuukOsfYORw==
X-Google-Smtp-Source: AA6agR6UyV8j3pMYAwuC/6kDW3PWRyf96iSfgAiHd3kCy43P+x93+o+nVZD022fYGnOQvR2eZp8uhcp3RR2pYlKnroY=
X-Received: by 2002:a05:6808:10d4:b0:33a:baf0:338c with SMTP id
 s20-20020a05680810d400b0033abaf0338cmr1821795ois.4.1659653845498; Thu, 04 Aug
 2022 15:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220502170904.2770649-1-calvinwan@google.com>
 <20220728230210.2952731-1-calvinwan@google.com> <8a1ff659-2086-f3cf-469a-76f5e2bc60e3@gmail.com>
In-Reply-To: <8a1ff659-2086-f3cf-469a-76f5e2bc60e3@gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 4 Aug 2022 15:57:14 -0700
Message-ID: <CAFySSZDNFAn6jZuby8Xj4EGUq0f7BJHv1gZwBNU0h+5D4+ny1A@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] cat-file: add --batch-command remote-object-info command
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This might be a daft question but could we teach cat-file to check if an
> object is available locally and if it is not retrieve just the metadata
> from the remote rather than adding a new command to --batch-command?
> That way it would be transparent to the user and they would not have to
> worry about whether they might be querying a remote object or not.

Definitely a good question! If we did this over a large amount of objects and
we didn't have those objects locally, then we would have to query for each
of them, resulting in a lot of transport overhead. Therefore, I needed to use
--batch-command to allow me to query all at once. This also begs the
question of why I don't check for the objects locally before querying the
server. The intention of my patch assumes that the user querying for
object-info knows they don't have the object locally and would therefore
like to see the size of an object they could potentially fetch. This could
definitely be potential future work (which I should mention in my commit
message!)
