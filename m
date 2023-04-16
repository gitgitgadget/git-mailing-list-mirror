Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA0EC77B73
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 15:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjDPPZS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Apr 2023 11:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDPPZR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2023 11:25:17 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1442170C
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 08:25:15 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id fw30so5090045ejc.5
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 08:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681658714; x=1684250714;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M1EJE0I86XrVKeqWU0ElLU7S6LSSb5zs+yPTTytEP58=;
        b=YhYMJsLO01nDGmbTtJzYHLM24PppB79FGVltXaW8om7aNQfKo0HKZ1eRy8AOVx6T9j
         EO9sQ6x9U2YLcs0BfJt4MFT+iyg75iEw5hl5ECCyZk6LykpoeioqFW+72ZMSEn8mi2eG
         UiLOz4x4mV9kBuU+mSgwj0pJOob2s0RykPMs9qqcNiBk9dOX15SvS4WcIUhbl3K1Xq+2
         H/nYb+rukXUv1pyxGexHTdNYAflV5ulAL8S+RfPNdsym5jE9a3xgDikHBuwNvduY3Ew/
         YnNwH76Lbftz2mYoWqjeFh2y4umZEEZqnnhtaAjfCd4JBG+zy0wgiQWksn2fzym7XR/B
         EfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681658714; x=1684250714;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M1EJE0I86XrVKeqWU0ElLU7S6LSSb5zs+yPTTytEP58=;
        b=hF3H+ypGCwkks88AZyKiwiGpUj+XoI3l59+ICEdETZjkSehMBplinWgigmVbwx1v3a
         WuhnVQuc04tr+NcHsUHnDuOlZoSG5mdJm+O5hWcufpxld7b9vClwK2C3dg6bHucJDmzW
         GvpFhAptXDXXbgR4v9P2MTz1iUNTKygMPLN093KrTNYXg9zsguMHcUpyKNXoUCZd4d1l
         1lMHK31wazaBQnKeH00/lHglcYTz5L1c9Mnjw08tA3kEwVM45VOP3H+PQJkKSO9HH40p
         239X1On65qe3D9p9bRmjrv/C5JHAHnlMFBDKEg2ngUtlND0n2yIEFG55a81W5xJTtm4f
         uwlA==
X-Gm-Message-State: AAQBX9cREYzZtO32yGCxAiCFC1VuDu8JjoCvJ2wExHNeyKowBdzaD9k3
        Fhq+0L3L1TxXT41oKHXdMjM=
X-Google-Smtp-Source: AKy350ajUJdnT+tZ5Vdmva0dshXYlcKTJvCvmM7H2U+KeG4VvPEbFQcSSt/DZeCpzDignwZ1ecV9dQ==
X-Received: by 2002:a17:906:898:b0:94f:2916:7d7 with SMTP id n24-20020a170906089800b0094f291607d7mr3696240eje.19.1681658714094;
        Sun, 16 Apr 2023 08:25:14 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id i21-20020a17090639d500b0094a9f434fc2sm5270401eje.176.2023.04.16.08.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 08:25:13 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1po4Fd-005gm7-0m;
        Sun, 16 Apr 2023 17:25:13 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Rohit Ner <rohitner1@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: How to write to the commit graph on clone?
Date:   Sun, 16 Apr 2023 17:24:33 +0200
References: <CAKazavxTXwcZFtL2XyU3MpaUR=snWY8w8Lwpco+mkbqm2nWE=w@mail.gmail.com>
 <5b99135f-c1d4-434b-b508-35f5d66dd2bb@app.fastmail.com>
 <b5316855-971d-4b7b-89cd-e81ececc5124@app.fastmail.com>
 <CAKazavzS112w3wsxnA-2ibWH3xGrE_w7Av+VZg-DfgfH0aK72A@mail.gmail.com>
 <ZDSjBQhyDBGi9wBN@nand.local> <20230416070906.GA3271@szeder.dev>
 <743b64a0-8731-46b8-a456-aaa51e310b9b@app.fastmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <743b64a0-8731-46b8-a456-aaa51e310b9b@app.fastmail.com>
Message-ID: <230416.86edojsvc6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 16 2023, Kristoffer Haugsbakk wrote:

>> The commit-graph has been enabled by default in v2.24.0, released over
>> three years ago.  I wonder why Rohit's and/or Kristoffer's repos
>> didn't have it already?!
>
> I might have done a fresh clone of Linux right before I replied to this
> email thread, or else it might have just been lying around. (I don=E2=80=
=99t
> work on Linux. ;)
>
> I found out that I need to add this to my Git config in order for the
> commit graph to be updated on `git fetch`, so I added it:
>
>     [fetch]
>             writeCommitGraph =3D true
>
> I was wondering if this would help with cloning, so I did a fresh one:
>
>     $ git clone https://github.com/torvalds/linux/ linux-github-2
>     $ cd linux-github-2/
>     $ time git log --oneline --graph | head -1
>     *   3e7bb4f24617 Merge tag '6.3-rc6-smb311-client-negcontext-fix' of =
git://git.samba.org/sfrench/cifs-2.6
>
>     real	0m10.364s
>     user	0m9.700s
>     sys	0m0.666s
>
> So no.
>
> But doing a `git fetch origin` fixed it:
>
>     $ git fetch origin
>     Expanding reachable commits in commit graph: 1171056, done.
>     Writing out commit graph in 5 passes: 100% (5855280/5855280), done.
>     $ time git log --oneline --graph | head -1
>     *   3e7bb4f24617 Merge tag '6.3-rc6-smb311-client-negcontext-fix' of =
git://git.samba.org/sfrench/cifs-2.6
>
>     real	0m0.017s
>     user	0m0.007s
>     sys	0m0.013s
>
> Is there any config for writing to the commit graph on clone?

I don't think there is, but here's a lengthy discussion I started a
while ago about having some "on glone gc", which would cover this:
https://lore.kernel.org/git/87tvm3go42.fsf@evledraar.gmail.com/

I haven't re-read it just now, but if you're interested that should be a
good place to start.
