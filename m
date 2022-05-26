Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA0EC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 20:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244324AbiEZUF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 16:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbiEZUFz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 16:05:55 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409DE5E764
        for <git@vger.kernel.org>; Thu, 26 May 2022 13:05:54 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id hh4so2801171qtb.10
        for <git@vger.kernel.org>; Thu, 26 May 2022 13:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9e+1rKZH6Onth7P2Py3+VskZgWgFiazBjUvYFuxrWuU=;
        b=ToePpkzUw5dKrys6v3mWagyKKxLKtmm2SgXuCQ76gB/THU9o4smQf+BSgK7FwrW6Ll
         HJx6oImcCEoLyR9ab4nSex+qeUAGBaM17GEMUmfbx5sNRSfmT4FOc9CRenR0cQxExz+K
         6b9CwSR/Z5i+Oip75fRWp9go1jTePEzsduQunllsUGsZfTIM/TIyR7MdKFOfctCzoOgB
         Qi2T0r4s/oKzauZTYwE8vXuQ5CZk0h8HOQkK7kSmLlf/sqdteYeAKRD6xS9lXou2NqdW
         SqyiCYBXsPKw2s3ze0Ot/F1j3MIpPrteAb0LxeRAJ+9Q91fAIKxkuKsPD9jAUubbyPhn
         QhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9e+1rKZH6Onth7P2Py3+VskZgWgFiazBjUvYFuxrWuU=;
        b=DmdVbLrqt9QvbmxW0cLal5YQ3AdyWfzImBo/uJV/KxpUmmU755mU8vt/BU9BpYDmOJ
         h35VL5px8XgpKfIwCpsV37Zv1ot5wATa/ZZaQohF1b3RZ1NN5TZ4BKgohrDLbyMrItZF
         eRY3phCXLkbYZMVSOBsEPTC4iu1GQUKqu/MqjKrtYaL5rTKXo23KNpJ3vFyiVs67iVgY
         EzKB4jU8k53QWwLBoM+rY/TvWAesGiYC5XHj5zOyb+e1wZeRz5cP+qtqZ26imE2Boq1z
         KQ1/1AFcnLjLlr66wlhzUTQHDvTUa4KmtpCh9DQoVfOf/nHRcbP3HXZ5ADuLiu7YBgdT
         BJOA==
X-Gm-Message-State: AOAM533XbcZOxoGnF8wF//HtsBFLlOJxAbcAj+daklMQq7uLvRcYhi2L
        wwI3ZR2WYvUcal90SnRAWONCwQ==
X-Google-Smtp-Source: ABdhPJzIN3jnYyqtCbilolqF4eTNwxng4aNyB98uCfZSwkv9PjaJcXMmIE6Cf73JHbc+tIPG0cj/0w==
X-Received: by 2002:ac8:5a4f:0:b0:2f3:ddac:fe60 with SMTP id o15-20020ac85a4f000000b002f3ddacfe60mr30688873qta.90.1653595553397;
        Thu, 26 May 2022 13:05:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cj18-20020a05622a259200b002f940d5ab2csm1462309qtb.74.2022.05.26.13.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:05:52 -0700 (PDT)
Date:   Thu, 26 May 2022 16:05:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jonathantanmy@google.com, gitster@pobox.com
Subject: Re: [PATCH v2 3/4] builtin/pack-objects.c: ensure included
 `--stdin-packs` exist
Message-ID: <Yo/dnnz8DPbUKDnX@nand.local>
References: <cover.1652458395.git.me@ttaylorr.com>
 <cover.1653418457.git.me@ttaylorr.com>
 <cdc3265ec27f04accc433d9e4e54ac0edc3b3746.1653418457.git.me@ttaylorr.com>
 <f8509b71-1951-58fe-c12d-3ced30e4ed79@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8509b71-1951-58fe-c12d-3ced30e4ed79@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 26, 2022 at 12:21:48PM -0700, Victoria Dye wrote:
> > pack does not pass the `is_pack_valid()` check.
> >
> > The `--stdin-packs` mode of `pack-objects` is not quite prepared to
> > handle this. To prepare it for this change, do the following two things:
> >
> >   - Ensure provided packs pass the `is_pack_valid()` check when
> >     collecting the caller-provided packs into the "included" and
> >     "excluded" lists.
> >
>
> Is the 'is_pack_valid()' check happening for the "excluded" packs? It looks
> like you only added it for the packs in the "included" list in this patch.

You're right that we don't do it explicitly. That's OK, since we won't
use any objects in excluded packs, and thus don't need to eagerly grab
an descriptor on it to prevent against the race we're handling here.

(In practice, we do end up calling is_pack_valid() on excluded packs
later on, via

  - want_found_object() (or one of its many callers), which itself calls
  - has_object_kept_pack(), which calls
  - find_kept_pack_entry(), which calls
  - fill_pack_entry(), which calls
  - is_pack_valid(), which calls

but that's a side-effect that doesn't help or hurt us.)

We _do_ need to be able to open the .idx (which happens in
`fill_pack_entry() -> find_pack_entry_one() -> open_pack_index()` , but
we'll fail appropriately when the index cannot be located.

> The rest of this makes sense and (as far as I can tell) lines up with the
> implementation below.

Thanks for taking a look!

Thanks,
Taylor
