Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6092BC433FE
	for <git@archiver.kernel.org>; Sat,  1 Oct 2022 18:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJASsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Oct 2022 14:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJASsV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2022 14:48:21 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C731571D
        for <git@vger.kernel.org>; Sat,  1 Oct 2022 11:48:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l12so6670422pjh.2
        for <git@vger.kernel.org>; Sat, 01 Oct 2022 11:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=XaVY52w9dSgqVMQPtla9iWGSobRuRYR6VR9vFARgGPI=;
        b=Vk8drv2PULxK3A9R2REvSZ8le4VptI52uFFGpCZ6PSkOdHXIruTFEnWKDDuXOYBqMB
         dR9DN7aJDe/AwBzVswreCoWWhtlT9J9JS/pWuALeGqZlvZ4ItcUXQNml6LkY5E++v+y+
         hk7/qJwXNDBizhFWenKA+3HGBGdEGFoy4kia6zClbcrfclqpErwJCCF2wzWoPoZVJ3nw
         oNHzgUQzoZCOk3ucPozz5K0QZVrgnk0PccS8i3l0ftA+M5ttZGGy+gegVIB1fDikSNMI
         w4NSzLC0BG1ooY2itVW7GxJIz3HGU/eToRnLq5GDtiAlyzWm2gkCBxdfq/Zo0guRaBVA
         pZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XaVY52w9dSgqVMQPtla9iWGSobRuRYR6VR9vFARgGPI=;
        b=t++vxuatMGMpjWE7gD/gCJylbttvP76RtIcXG/LlnoeJoADfuak0RdHTIfCyC0ZcBy
         QNU1LH6utHRC5TRvYgXeN6zhzvdnjOVHnTHbNj+GTdb95zMZHzrdouBdKl7NTSSoEylF
         QAd3D1UR5hqEEbqWj07yE7Z7kXH9ZfTG1FIosBY0KFrcS6CU6xObiTMS7oG9JlEyTJrK
         egSRAzOh7hpymyb17RKDaRbz8benccSKU/T24ecP4j2GZi3J+zDBjiF0MkRpYsyxVEi1
         LSgqUgTQbVYX482rhV5EaRK6E9JdgtHkDcZKHAEYd5NFDHgcusDmQvzTWvpaGF4YdR/H
         Uh5g==
X-Gm-Message-State: ACrzQf2Br4q5LPS8tYNbqdAiIU6kleTznL5EY3rtLoBk5KTTYZSn90QY
        n0ruW0/hETtY7XQQg5+nGPg=
X-Google-Smtp-Source: AMsMyM5TtTxFAyUSbJCkYkDzxDoD9oTP0T6v1CdFr2vfO41PWO6k7QqpkY7qap/1e6AGjVNhXpWOCg==
X-Received: by 2002:a17:902:82ca:b0:17b:6eaa:5da3 with SMTP id u10-20020a17090282ca00b0017b6eaa5da3mr12982152plz.33.1664650100318;
        Sat, 01 Oct 2022 11:48:20 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id ja4-20020a170902efc400b0016ed8af2ec0sm2080181plb.29.2022.10.01.11.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 11:48:19 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 23/36] doc txt & -h consistency: make "read-tree"
 consistent
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
        <patch-v3-23.36-01e20b8e452-20220930T180415Z-avarab@gmail.com>
Date:   Sat, 01 Oct 2022 11:48:19 -0700
In-Reply-To: <patch-v3-23.36-01e20b8e452-20220930T180415Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 30 Sep
 2022 20:07:46
        +0200")
Message-ID: <xmqqh70n2xe4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> The C version was right to use "()" in place of "[]", let's update

Incomplete description: use () in place of [] around what?

> the *.txt version accordingly, and furthermore list the *.c options in
> the same order as the *.txt.

Good.

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Documentation/git-read-tree.txt | 2 +-
>  builtin/read-tree.c             | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
> index b9bfdc0a319..7567955bad8 100644
> --- a/Documentation/git-read-tree.txt
> +++ b/Documentation/git-read-tree.txt
> @@ -9,7 +9,7 @@ git-read-tree - Reads tree information into the index
>  SYNOPSIS
>  --------
>  [verse]
> -'git read-tree' [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>]
> +'git read-tree' [(-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>)
>  		[-u | -i]] [--index-output=<file>] [--no-sparse-checkout]
>  		(--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])
>  
> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> index b3a389e1b1f..f4cbe460b97 100644
> --- a/builtin/read-tree.c
> +++ b/builtin/read-tree.c
> @@ -39,7 +39,7 @@ static int list_tree(struct object_id *oid)
>  
>  static const char * const read_tree_usage[] = {
>  	N_("git read-tree [(-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>)\n"
> -	   "              [-u | -i]] [--no-sparse-checkout] [--index-output=<file>]\n"
> +	   "              [-u | -i]] [--index-output=<file>] [--no-sparse-checkout]\n"
>  	   "              (--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])"),
>  	NULL
>  };
