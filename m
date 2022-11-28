Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD6FC4321E
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 04:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiK1ElN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Nov 2022 23:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiK1ElJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2022 23:41:09 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC93DBE3B
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 20:41:05 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id a9so5879568pfr.0
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 20:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hGGAgW1aQu8mXgDQN/xjXuy4E0ArAEQRa7JOzl8MB/Y=;
        b=MPNOJe4HGIBvbi+e1mwUbxA25H4ACK/PgQbJ2RfoU+Eiqj9bTRTt/W+AxQOAmFdXtA
         P1OVg85H+ePvXqHk2NYdi/o6WAL6HEIZ7eEErPEHj+YNjdlqtCCV8S/HmFoBS9Y7hocq
         T3iisVAOisx4pkwHRn+7NEuQWFppOkeuVH703Fon3N3QtEt/USbB2EI/1Nmyuy1SKOIj
         1bk3J9XXmjFoULHi6PPBU+VqzUJ4JZXWMR6+5h1vnzvWSnByDM8wTL/xBo7a47rTBw7r
         dEGx1Lt/K/qRsDr18T8owq+s2HEu6blKaeQd7F/C0IouqU0uweOahPFSXOAs7x7HKLVD
         aXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGGAgW1aQu8mXgDQN/xjXuy4E0ArAEQRa7JOzl8MB/Y=;
        b=7QpSwp4BvDEW7R2zDSUj0RsJcgvV/7s650ALGPdMlLZG5td1RVQq9uhgKhycD1nhhy
         KPnxOxWkTI1obg2Jm36ujnNmFPL8f6tThIOm1s0Kwk6YUGirY2fNMF2mqmMEdZWns5Qq
         jBU5J3AUFfqgTHfIDFZGavcMkl6HzqarLR2BFWicpNppp3i+GxpPdCbk3bvMynF4FOSw
         2ZEzpBqFN0Dyk1kgO7Ameqs0/9pFHWiF55Pg2ruEhHbb7oiiPMQ1h8pMa89IgOESc4/X
         KHvor77a91w334KX8E1Nhqqqlkc8hBg+O+Kuq0IhaYLAD3rqL8H0qgfMvOIZVu4cOSoK
         Gxdg==
X-Gm-Message-State: ANoB5pkkflddFQpqTT1o9yeOFRjLj5W9KvjHBrq9zzzWPMK9ZekCKRAS
        0PRVc8GSJBhkku/iTnxyLYY=
X-Google-Smtp-Source: AA0mqf5Pnwu3ewgQ5Lz8AZ/FsmqLytpqFfeFST1GZ2bQz7J1CK4EPp1B3ONGrjk7F+QEtI6PfbnNCw==
X-Received: by 2002:a05:6a00:1d98:b0:56d:4670:6e2a with SMTP id z24-20020a056a001d9800b0056d46706e2amr39622498pfw.77.1669610465296;
        Sun, 27 Nov 2022 20:41:05 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902e84a00b001869efb722csm7636369plg.215.2022.11.27.20.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 20:41:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v1 4/4] t1301: do not change $CWD in "shared=all" test case
References: <20221127145130.16155-1-worldhello.net@gmail.com>
        <20221127145130.16155-4-worldhello.net@gmail.com>
Date:   Mon, 28 Nov 2022 13:41:04 +0900
Message-ID: <xmqqwn7f7ktb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> In test case "shared=all", the working directory is permanently changed
> to the "sub" directory. This leads to a strange behavior that the
> temporary repositories created by subsequent test cases are all in this
> "sub" directory, such as "sub/new", "sub/child.git". If we bypass this
> test case, all subsequent test cases will have different working
> directory.
>
> Since the test case "shared=all" and all subsequent will work properly
> in the default test repository, we don't need to create and change to
> the "sub" directory in the test case "shared=all".

It is much worse than that.  If existing tests after this step were
running destructive operations in their "..", because we have this
extra "sub" directory and such a destructive test were running
there, the damage would have been contained in $TRASH_DIRECTORY but
with this change, it will touch t/ (or the parent directory of the
$TRASH_DIRECTORY).  So, "will work properly" may not be sufficient;
we need to audit the rest of the script and make sure there is no
such funny "step outside the test enviromnent" happening before we
are sure that this is a "safe" change.

It is the "right" thing to do, though.  I do not see any reason why
we want to have an extra level "sub" directory there.




>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  t/t1301-shared-repo.sh | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
> index 3ca91bf504..c4f2f72f6b 100755
> --- a/t/t1301-shared-repo.sh
> +++ b/t/t1301-shared-repo.sh
> @@ -46,8 +46,6 @@ do
>  done
>  
>  test_expect_success 'shared=all' '
> -	mkdir sub &&
> -	cd sub &&
>  	git init --template= --shared=all &&
>  	test 2 = $(git config core.sharedrepository)
>  '
