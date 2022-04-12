Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E1CC433EF
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 19:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245692AbiDLT0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 15:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiDLT0V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 15:26:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0F41E9
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 12:24:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id v4so10062760edl.7
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 12:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=g4HFGi6XHpL88QfpFKYx9nbvvBZg6Sy36RQ7Oqeo8Vk=;
        b=iZTtVcpdOwCm9RGRPfCqpzE0z7doaZh9MCK366gtsH1lT4OtGrRFHNR+faavARNBid
         cdos8zZBg8xveyqzKT1eSBAjNWmCLY+zRj1gZBSbMUM03YBwoy+6iW7rRxTnDKYgPdsJ
         IMZvxOZQcpGzReseeVuKa1QAwm0EuAzmRZLb5no4G1b7VMfdvoViqK4jjOk+6mZSwXrO
         YW2y023JpBG8OCT4TgAnyU1lUDfp3sWwBAqJs/Csb8i/nOjtBgydt7ha/nVuErGul8Sy
         +CGCN+L+39/RGnlg3jE6cND9++7an3UOEDDFhkkJvW/d+79j1cw6Ccv3IWp4onsPuTSW
         pvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=g4HFGi6XHpL88QfpFKYx9nbvvBZg6Sy36RQ7Oqeo8Vk=;
        b=19DAEyhQi2pXCtEm4/YEjVKaqiIFuFTUjDeuuigDLI+vAxjpue7llP4qNRAp6C/UfX
         5bsKWH0iN58pO01riguTWEETnXaU+bz/W/vDpc13Jk+13JzNKpcj59qwCJzINSerA4Pu
         oW+NguUzRbabUpW+gdSCfDMVapUwBChGx/hGLSW96y2Vg7e9Dzof+qudaR0EoolVf6JJ
         ewg5L1kjT2C4QYfvt4q1qPa9hEllujlJ0dni8+hmGp/2nUKoQP5+dxjYOg6ekKEqtfx1
         TVvzmBl9JfKAhfQ1KeUBk+g3p4R/QeXeZIY+mstmnucLDwJJZcIgu1GXwbTIiBFHvJ5l
         Y2mQ==
X-Gm-Message-State: AOAM530v2AnjkOCa9VbChCXtGtNMjDVLqAj7gIZWmI6HnUGX9Mjrp3Nb
        0tssoe5swA3/xnKlDQCfea4=
X-Google-Smtp-Source: ABdhPJxz7zMG4Dx8a6fzBVQxd21iwj2ZvAFo8KQkGbMeAiJLl55nTEOApPDNyPpTMq2iYJOxlEAtxA==
X-Received: by 2002:a50:9986:0:b0:413:bbdd:d5a1 with SMTP id m6-20020a509986000000b00413bbddd5a1mr40764230edb.26.1649791440530;
        Tue, 12 Apr 2022 12:24:00 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm13527349ejk.119.2022.04.12.12.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 12:23:59 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1neM7L-004nL7-ES;
        Tue, 12 Apr 2022 21:23:59 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan <git.jonathan.bressat@gmail.com>
Cc:     cogoni.guillaume@gmail.com, Matthieu.Moy@univ-lyon1.fr,
        git@vger.kernel.org, guillaume.cogoni@gmail.com,
        Jonathan <Jonathan.bressat@etu.univ-lyon1.fr>
Subject: Re: [PATCH 1/1] Merge with untracked file that are the same without
 failure and test
Date:   Tue, 12 Apr 2022 21:21:39 +0200
References: <CAA0Qn1sBF=PAduCQCXbYkeu4cphw7O+AnvwFNMWijuKYskaT8g@mail.gmail.com>
 <20220412191556.21135-1-Jonathan.bressat@etu.univ-lyon1.fr>
 <20220412191556.21135-2-Jonathan.bressat@etu.univ-lyon1.fr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220412191556.21135-2-Jonathan.bressat@etu.univ-lyon1.fr>
Message-ID: <220412.86czhmgl68.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 12 2022, Jonathan wrote:

> When doing a merge while there is untracked files with the same name
> as merged files, git refuses to proceed. This commit change this
> behavior and make git overwrite files if their contents are the same.
> This new behaviour is more pleasant for a user and will never be a
> frustrating moment.
>
> Add a if statement that check if the file has the same content as the
> merged file thanks to the function ie_modified() (read-cache.c).
> ie_modified () checks the status of both files, if they are different,
> it verifies their contents.
>
> Add new tests that need to pass to confirm that the new feature works.
>
> Co-authored-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
> ---
>  t/t7615-merge-untracked.sh | 79 ++++++++++++++++++++++++++++++++++++++
>  unpack-trees.c             |  4 ++
>  2 files changed, 83 insertions(+)
>  create mode 100755 t/t7615-merge-untracked.sh
>
> diff --git a/t/t7615-merge-untracked.sh b/t/t7615-merge-untracked.sh
> new file mode 100755
> index 0000000000..71a34041d2
> --- /dev/null
> +++ b/t/t7615-merge-untracked.sh
> @@ -0,0 +1,79 @@
> +#!/bin/sh
> +
> +test_description='test when merge with untracked file'
> +
> +. ./test-lib.sh
> +
> +

Too much whitespace.

> +test_expect_success 'overwrite the file when fastforward and the same content' '
> +    echo content >README.md &&

The coding style in this project is TAB-indent, not 4 spaces
> +    test_commit "init" README.md &&
> +    git branch A &&
> +    git checkout -b B &&
> +    echo content >file &&
> +    git add file &&
> +    git commit -m "tracked" &&


Can't these and a lot of the test also just use test_commit, you can do
this sort of thing with its multi-param invocation, if you're trying to
specifically avoid tags there's an option for that.

> +    git switch A &&
> +    echo content >file &&
> +    git merge B
> +'
> +
> +test_expect_success 'merge fail with fastforward and different content' '
> +    rm * &&
> +    rm -r .git &&

Can we just set this up in a "git init repo" or whatever instead?

> +    git init &&
> +    echo content >README.md &&
> +    test_commit "init" README.md &&
> +    git branch A &&
> +    git checkout -b B &&
> +    echo content >file &&
> +    git add file &&
> +    git commit -m "tracked" &&
> +    git switch A &&
> +    echo dif >file &&
> +    test_must_fail git merge B

And thendo this in a sub-shell?

> +'
> +
> +test_expect_success 'normal merge with untracked with the same content' '
> +    rm * &&
> +    rm -r .git &&

Please use test_when_finished in the tests themselves for teardown,
rather than having the "next test" do the cleanup after the last one.

> +    git init &&
> +    echo content >README.md &&
> +    test_commit "init" README.md &&
> +    git branch A &&
> +    git checkout -b B &&
> +    echo content >fileB &&
> +    echo content >file &&
> +    git add fileB &&
> +    git add file &&
> +    git commit -m "tracked" &&
> +    git switch A &&
> +    echo content >fileA &&
> +    git add fileA &&
> +    git commit -m "exA" &&
> +    echo content >file &&
> +    git merge B -m "merge"
> +'
> +
> +test_expect_success 'normal merge fail when untracked with different content' '
> +    rm * &&
> +    rm -r .git &&
> +    git init &&
> +    echo content >README.md &&
> +    test_commit "init" README.md &&
> +    git branch A &&
> +    git checkout -b B &&
> +    echo content >fileB &&
> +    echo content >file &&
> +    git add fileB &&
> +    git add file &&
> +    git commit -m "tracked" &&
> +    git switch A &&
> +    echo content >fileA &&
> +    git add fileA &&
> +    git commit -m "exA" &&
> +    echo dif >file &&
> +    test_must_fail git merge B -m "merge"
> +'
> +
> +test_done
> \ No newline at end of file

Git's telling you something here... :)

> diff --git a/unpack-trees.c b/unpack-trees.c
> index 360844bda3..834aca0da9 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -2259,6 +2259,10 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
>  			return 0;
>  	}
>  
> +	if (!ie_modified(&o->result, ce, st, 0))
> +		return 0;
> +
> +

Too much whitespace.

>  	return add_rejected_path(o, error_type, name);
>  }

