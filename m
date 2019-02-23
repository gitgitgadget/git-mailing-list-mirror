Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F083520248
	for <e@80x24.org>; Sat, 23 Feb 2019 09:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfBWJ3i convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 23 Feb 2019 04:29:38 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34860 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfBWJ3h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 04:29:37 -0500
Received: by mail-qk1-f194.google.com with SMTP id z13so2635740qki.2
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 01:29:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tzTx2mG0itLCrRy3UQMMvRlOrOfFTKFIYs45GzldQXM=;
        b=lmL+LuM0IHEwUEm5Oy7hISFOd60N3RydvtEiIyJWoIQVG05vgi63iREeb2kaCLyHWk
         H2rHH4lqRr4gXSn/36rqLnzFspt9MZ/PF225kiDDFHt9sG9eR3JqrTG6MAYdPBamIWTo
         BzrS0kL7/W26P9joH9o7FXEvXaGhj9yFc3AFIxNv84p5Le49Dn1jAws30Zi77krYOTsT
         Xz+d1jOznBy7Nps8znSauckc/pdid7iamoCJT0kD2Kp/cd+5xA3QTT70FXLc8cVxUsSX
         MjawMan0AH9fAkWhzq29UrKg1QMEjfskIzkOgrzfkg8B0MlzRqx3kmX7JE2GTze6hZBB
         6nCQ==
X-Gm-Message-State: AHQUAuaCGpWOvikKDTNmA8B48EX9z3HD7fCINFRaKI0jkjw9Ez6ji0CY
        zCF2sjxw4k8yVNC7TBwricquJ1L3o4woR2LhIVs=
X-Google-Smtp-Source: AHgI3IYv8J/9+dPQZ8hqvFTkxcqBNCf+9f+VFXz8jyHFfeZqSoA5B+nti3Lr34GayYP/l6aMAHYoHJC0re8xezBKINc=
X-Received: by 2002:a37:a4c2:: with SMTP id n185mr5998655qke.152.1550914176879;
 Sat, 23 Feb 2019 01:29:36 -0800 (PST)
MIME-Version: 1.0
References: <20190221223753.20070-1-avarab@gmail.com> <20190221223753.20070-8-avarab@gmail.com>
 <xmqqzhqno1r3.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhqno1r3.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 23 Feb 2019 04:29:26 -0500
Message-ID: <CAPig+cRb78wPKJGjWaMiUkazDK5LpidikDLKR8nbQ-+u1=2w=A@mail.gmail.com>
Subject: Re: [PATCH 7/8] commit-graph write: don't die if the existing graph
 is corrupt
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 6:13 PM Junio C Hamano <gitster@pobox.com> wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> > diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> > @@ -408,7 +414,7 @@ test_expect_success 'detect permission problem' '
> >       # "chmod 000 file" does not yield EACCES on e.g. "cat file"
> >       if ! test -r $objdir/info/commit-graph
> >       then
> > -             corrupt_graph_verify "Could not open"
> > +             NO_WRITE_TEST_BACKUP=1 corrupt_graph_verify "Could not open"
>
> This would not work as you think it would; corrupt_graph_verify is a
> shell function, so you cannot VAR=VAL prefix to export an environment
> variable only for the duration of the command.

As of a0a630192d (t/check-non-portable-shell: detect "FOO=bar
shell_func", 2018-07-13), this sort of problem is correctly flagged by
"make test-lint", which typically is run as part of "make test" or
"make prove".
