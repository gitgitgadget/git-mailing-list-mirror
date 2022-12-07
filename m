Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F40FC3A5A7
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 01:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiLGBul (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 20:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiLGBuS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 20:50:18 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15923537C5
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 17:50:02 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id x13so7293232ilp.8
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 17:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D/ofGwknhgagTzl7fbDSEX0j5VMiFuivE8vDnTXMl7o=;
        b=QAIt8hwGRJMEWfUNW5PqXjFNW+KdwcyxWimhuq+xFkRKi8zElIFRRQgahri00X7yIK
         khy6LQ3ycg/U7DZNFHH1h8aGZIIdPSGo7IQ1SM1zRnKS/fMYyBce4V2ucF8BOAiZWlKJ
         PWU/N13I4PC2JGhUJ1Zqqd8MgejHwM7mU1FdbyTRnEvmDWNKFCpqh6OlR6joudGb9uDS
         N586RU8PltYX669Shb+Nelw36M5BvDMWPbPUxXNZGi+MjNrcwfAo+ZfY37SiQ0VrtjIP
         tCwIoL925z/mio7Q8KWZ/AbCmpSwaBRLnk/fGsvrS9co+Wfuoh8qumJEaDGgOymo+rUB
         LdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/ofGwknhgagTzl7fbDSEX0j5VMiFuivE8vDnTXMl7o=;
        b=XS5xxrWa4coeTtPDpi3RF5xD4qGwpTNm1p6Eo7n1SgHsP13+ZI2g/F4M4MTfV6Xq4E
         7gh4prsaJr63kCyPgaEMD+EN9XWs3DJkuII/GbIsQu3znYs0iIaKpd7JL96DkzxLSrsH
         Es/gFNcl2AiVWjxrnOjRfoqhO7V4S73fARbNcYjvtmOjU4Pb3HRGbO1za/HXewSJfMNX
         pGm+9X6jseqsnWgWO5AkD7SyLdZJyMp9p252p/xBC0i6fkirSwtPyRcqXXgaRNqG1hIG
         91fgLLR0kVcd56MSU1O2CBaZajWd1dfmxOsE8wFTfeqidbohKiLGGJsKXdG6XcQJiKSA
         CBjA==
X-Gm-Message-State: ANoB5plBU6Ol5sKi8EDiZtu8X/AhaX7EfQcSXjY8RFN88XeerIE+bKm+
        ejZepspYseZIMJi4lsxC7o3Wtw==
X-Google-Smtp-Source: AA0mqf4lBRFMETCVK2K4wFRYOuWXiv3iW9U7Jk/EPkLPotyMEXaqgU92Km5yrSsc92yiplYwIURaEg==
X-Received: by 2002:a92:d4cb:0:b0:303:77da:e93d with SMTP id o11-20020a92d4cb000000b0030377dae93dmr2103229ilm.62.1670377801320;
        Tue, 06 Dec 2022 17:50:01 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r2-20020a02b102000000b00363e61908bfsm7068941jah.10.2022.12.06.17.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:50:01 -0800 (PST)
Date:   Tue, 6 Dec 2022 20:50:00 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     David Caro <dcaro@wikimedia.org>
Cc:     git@vger.kernel.org
Subject: Re: Skipping adding Signed-off-by even if it's not the last on git
 commit
Message-ID: <Y4/xSObs9QXvE+xR@nand.local>
References: <20221206170646.6lnpr6h7oprziy5b@vulcanus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221206170646.6lnpr6h7oprziy5b@vulcanus>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi David,

On Tue, Dec 06, 2022 at 06:06:46PM +0100, David Caro wrote:
> I have noticed that when requesting git commit to add the
> Signed-off-by header, it will add it even if it already exists as long
> as it's not the last in the footer.
>
> It seems that the functionality to do so has been there for a while
> (see [1]) and it's being used effectively on format-patch, but it was
> never enabled for the rest of commands.

Right; bab4d1097c (sequencer.c: teach append_signoff how to detect
duplicate s-o-b, 2013-02-12) introduced the APPEND_SIGNOFF_DEDUP flag,
which instructs append_signoff() to avoid adding a Signed-off-by
trailer if one already exists anywhere in the trailers section of the
target commit.

As bab4d1097c hints, this is desirable in some situations. However,
adding duplicated S-o-b trailers is useful in other situations. For
example, if you and I exchange a patch back and forth on this list, it
might go something like:

  1. I write up an initial patch, add my Singed-off-by, and send it to
     the list.

  2. You notice that some aspects can be improved, so you apply and
     modify the commit locally, adding your own Signed-off-by.

  3. I pick up your changes as part of a new version of the patch
     series, and resubmit it to the list, adding my own Signed-off-by
     again.

There are a couple of small things worth noting there. First, in (2),
the changes that you introduced were large enough to be worth crediting
(e.g., you didn't suggest a typofix or to modify the amount of spacing
on a line or similar), but not large enough to change the author of the
patch.

Likewise, in (3), the second instance of my Signed-off-by indicates that
I am OK with the changes that you wrote, and I certify the new version
of the patch as my own work.

One such instance is in 0ca6ead81e (alias.c: reject too-long cmdline
strings in split_cmdline(), 2022-09-28). Another is in b3c5f5cb04
(submodule: move core cmd_update() logic to C, 2022-03-15).

If you're curious to dig up more in your own project, here's a little
shell snippet I wrote up to find some examples:

    git rev-list --no-merges HEAD |
    while read rev
    do
      git -P show -s -1 --format='%(trailers:key=Signed-off-by,unfold=true)' "$rev" |
      grep -v '^$' | sort | uniq -c | grep -vq "^      1 " && echo "$rev"
    done

> I propose enabling it for commit, merge and am.

So I think that there are some legitimate uses outside of 'format-patch'
that we may want to keep the existing behavior. So I don't think we
should necessarily change the default to have other commands outside of
'format-patch' start passing APPEND_SIGNOFF_DEDUP.

But I could see a future where we add a new option that controls whether
or not we pass that flag, perhaps:

    $ git commit --signoff[=[no-]dedup]

?

Thanks,
Taylor
