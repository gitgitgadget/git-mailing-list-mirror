Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38DFB1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 03:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932813AbeDXDF4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 23:05:56 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39575 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932753AbeDXDF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 23:05:56 -0400
Received: by mail-wr0-f195.google.com with SMTP id q3-v6so36425629wrj.6
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 20:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LzWGEuzHqDv+mVsc5XmNiCdA7fVWERQIrq0xcoPcwVg=;
        b=S14WB4QbuYoSnwXrL0ZeINaA9ZmEJKJmeFl7oq1LG4yqd653Yp9jbmLyP2yaRLfwvK
         gP/yEcZYxiVYRKeR1wbCRJk0Wdlvul/wxTcxBE3i2Ixq8KwYvQc/eakOJ1wTeHqja8iE
         tsij/E1d1V1aGAX1GxEkzf1UQPc5NiqPHXR9S0AgRFajvZOIktwG4FRzr3fLWfkrxIfS
         dzkAnsIGmNk3kMftvAT5vV9nC91OiNPj57kbfvnA2HgT8GIuka7HT4SzXMA54b15ZSnz
         EJjU4hqH8GDZx/YfML+bKUyxaUC7fpQTZiSQFf4UdwuBNtYW0rJCB/n1tXiKYAvoBBLh
         FTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LzWGEuzHqDv+mVsc5XmNiCdA7fVWERQIrq0xcoPcwVg=;
        b=aWXWeUbaOqLg1LDx3WY3rT5uAkk/nUF0YtK4fxtnUHCsHDHZ/qPjFRIRe0Ha9bZ0lN
         AkrRQvhjQfkFTf0NgglmVGwQ2qMAyVtC5m0FHtj6YyJb8dGqb8idmDI6b7VQcuHZgp+4
         X4BJsNMMNQ01QICpRjSgeiXLPcC1jenyJNtK89HWGX1omfiC5rmZjn/x6Dd4tzwCDtP5
         oMmjMuJa07tUXg5v7oLdXUOJJm0UL9s4eZXS/UiurFzPyzkNYMva7yG/6UmKyoQX5gRp
         ONxEoLg0lhtCKHVAR9noqL+3nxtvVDMCTypPA5vAHpWcdeJDRbWW+FZXL86M4Hnhcx5q
         0aCQ==
X-Gm-Message-State: ALQs6tDKYmBg+uXoDhX/1QZp2MO3b38Hg139QGHOovgMMkG7lYX9UEqq
        hpAMyUQHQ0zM/ACYqSBPiSk=
X-Google-Smtp-Source: AIpwx48AL0QnSJ7JxewijBzZQCYf3egVI+alFji1FuWKgitk3Sw0rCQugwC4RaHiL6+sDXKQzDEfPQ==
X-Received: by 2002:adf:874c:: with SMTP id 12-v6mr18811042wrz.275.1524539154570;
        Mon, 23 Apr 2018 20:05:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m83sm10155619wma.17.2018.04.23.20.05.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 20:05:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v2] unpack_trees: fix breakage when o->src_index != o->dst_index
References: <CABPp-BGQy=-k1TN-i2U89x7gJ7z8_ciTM3DJzTnVKsvi94LpBg@mail.gmail.com>
        <20180424002423.11373-1-newren@gmail.com>
Date:   Tue, 24 Apr 2018 12:05:53 +0900
In-Reply-To: <20180424002423.11373-1-newren@gmail.com> (Elijah Newren's
        message of "Mon, 23 Apr 2018 17:24:23 -0700")
Message-ID: <xmqq604h717y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>  unpack-trees.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index e73745051e..08f6cab82e 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1284,9 +1284,20 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  	o->result.timestamp.sec = o->src_index->timestamp.sec;
>  	o->result.timestamp.nsec = o->src_index->timestamp.nsec;
>  	o->result.version = o->src_index->version;
> -	o->result.split_index = o->src_index->split_index;
> -	if (o->result.split_index)
> +	if (!o->src_index->split_index) {
> +		o->result.split_index = NULL;
> +	} else if (o->src_index == o->dst_index) {
> +		/*
> +		 * o->dst_index (and thus o->src_index) will be discarded
> +		 * and overwritten with o->result at the end of this function,
> +		 * so just use src_index's split_index to avoid having to
> +		 * create a new one.
> +		 */
> +		o->result.split_index = o->src_index->split_index;
>  		o->result.split_index->refcount++;
> +	} else {
> +		o->result.split_index = init_split_index(&o->result);
> +	}
>  	hashcpy(o->result.sha1, o->src_index->sha1);
>  	o->merge_size = len;
>  	mark_all_ce_unused(o->src_index);
> @@ -1412,7 +1423,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  						  WRITE_TREE_SILENT |
>  						  WRITE_TREE_REPAIR);
>  		}
> -		move_index_extensions(&o->result, o->dst_index);
> +		move_index_extensions(&o->result, o->src_index);

Can src_index be NULL here?  I am getting segfaults everywhere,
starting from t0000-basic that populates the index by reading one
tree object via read-tree.

>  		discard_index(o->dst_index);
>  		*o->dst_index = o->result;
>  	} else {
