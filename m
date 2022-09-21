Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82520ECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 15:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiIUPnK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 11:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIUPm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 11:42:57 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBB0B7FC
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 08:42:55 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id r134so5358945iod.8
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=JsQXSNxzZLZuRJ282WEBJgwO0JhreIXQVJNc9JZhFm4=;
        b=8Jh/mxEkEOR0XbXbkWELvzS94v5O1H7Cjnq5/4D4pQapNwQK58w9kGFk4lehpEMtl2
         8zqt2ZievauGOt5F/aEPY/fIAlF0C29xjcypnQ8A1cJK1m3RPhaXvboJLeUH+w97T3rF
         zFVyrHGPgE6RBFxL+0hdBCaarr/RFQGnKL9jAvTnGFubdQ/iDk0zPjesXQdseT7j9C6H
         qttgK6RCR6LM4ad2b3Zb6dtcLprcE46geB23WQTHw2Fhsoh6RH8vkTnmYwQ9DxTh/ZpM
         xGFXZsZY0aL2T7zHzL70cbKRX1xGz2u0XCjWywONcgsKeGog01I4lOeNOmWjRCu4KDIu
         3gEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JsQXSNxzZLZuRJ282WEBJgwO0JhreIXQVJNc9JZhFm4=;
        b=UL0vuqDGB4RQuaF4fdJI6AeJPrZXKpt1+037vjmpQ1P22KGfSxOZMZ/+yC1R7mLfiD
         opQGMnzZomUFsbFeeeHN6GJSC3zNxg5XztEHsXZo9rAOUHU9ivghera1fBsiUp7mxZsk
         SIf6IfwqqetUjEafviuT9ImLcmaWc2w2h+0SSoGv8ysEQhn7zIZRpXRDJqZjuxecZjHK
         kAe0AZebMhW1rA71GfvzUI+2Dn20Bxb4E4YUr0QjW1sCQNOgzwk2xmhgbxKn4m3YMeor
         wonaADIYp7vG61KCUIBN0BDyzK5HN5RhQyVRY3hGev/466AQ1HuZ4CWW8tCJK8RpjAgk
         Xg7w==
X-Gm-Message-State: ACrzQf3lpIgi9/ZhsZ9sQgwWmbDgK4QlVNC4TfvLx9jpF/Fm6h9zS0Cb
        g0wEd29grAawyQyQYC5QGi+3vQ==
X-Google-Smtp-Source: AMsMyM7Lqr/bZ8ZGRfBXK6/JDYQ/UNyPzVGjH0ytMGy3cZvz8+amXyb3TbV+AEFIjprerrfRgy/6ng==
X-Received: by 2002:a05:6638:16cf:b0:35a:576b:6e33 with SMTP id g15-20020a05663816cf00b0035a576b6e33mr12999790jat.159.1663774974792;
        Wed, 21 Sep 2022 08:42:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x92-20020a0294e5000000b0035a6005bbdesm1145110jah.152.2022.09.21.08.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:42:54 -0700 (PDT)
Date:   Wed, 21 Sep 2022 11:42:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] merge-tree: fix segmentation fault in read-only
 repositories
Message-ID: <Yysw/YIxx/JRF4Ph@nand.local>
References: <pull.1362.git.1663774248660.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1362.git.1663774248660.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2022 at 03:30:48PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index ae5782917b9..25c7142a882 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -412,6 +412,7 @@ static int real_merge(struct merge_tree_options *o,
>  	struct commit_list *merge_bases = NULL;
>  	struct merge_options opt;
>  	struct merge_result result = { 0 };
> +	const struct object_id *tree_oid;
>
>  	parent1 = get_merge_parent(branch1);
>  	if (!parent1)
> @@ -446,7 +447,8 @@ static int real_merge(struct merge_tree_options *o,
>  	if (o->show_messages == -1)
>  		o->show_messages = !result.clean;
>
> -	printf("%s%c", oid_to_hex(&result.tree->object.oid), line_termination);
> +	tree_oid = result.tree ? &result.tree->object.oid : null_oid();
> +	printf("%s%c", oid_to_hex(tree_oid), line_termination);

My understanding is that we can get a clean result from
merge_incore_recursive(), but still have failed to write the physical
tree object out?

In other words, the two sides *could* have been merged, but the actual
result of doing that merge couldn't be written to disk (e.g., because
the repository is read-only or some such)?

If so, then this approach makes sense, and I agree with your idea to
use the all-zeros OID instead of the empty tree one. It would be
nice(r?) if we could just abort this command earlier, since `merge-tree`
promises that we'll write the result out as an object. So I don't think
a non-zero exit before we have to print the resulting tree object would
be unexpected.

But I don't have a strong feeling about it either way. So, if you want
to proceed here and just emit the all-zeros OID, I think that is a fine
approach.

> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
> index 28ca5c38bb5..e56b1ba6e50 100755
> --- a/t/t4301-merge-tree-write-tree.sh
> +++ b/t/t4301-merge-tree-write-tree.sh
> @@ -810,4 +810,12 @@ test_expect_success 'can override merge of unrelated histories' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'merge-ort fails gracefully in a read-only repository' '
> +	git init --bare read-only &&
> +	git push read-only side1 side2 &&
> +	test_when_finished "chmod -R u+w read-only" &&

Do we care about keeping this read-only repository around after the
test is done? It seems odd to have a directory called "read-only" be
user-writable. I'd probably just as soon replace this with:

  test_when_finished "rm -fr read-only" &&

Otherwise, this patch looks good. Thanks for working on it!

Thanks,
Taylor
