Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 977AE1F424
	for <e@80x24.org>; Mon, 16 Apr 2018 10:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753755AbeDPKA4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 06:00:56 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:43670 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752883AbeDPKAz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 06:00:55 -0400
Received: from [192.168.2.201] ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id 80wPfMi4XHCow80wPf8EKd; Mon, 16 Apr 2018 11:00:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1523872854;
        bh=gK1aB2DXf8gIJKhf6CS4y7JmV6xL+gU1HIVaP8WDgrI=;
        h=Reply-To:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=HdRmJdzcnbR9Y7hmRIt1JxuZ8cbwk8VpEk+PEFkZ8Ur64JXAjjUVAnv8VSo5a+1S3
         8HtNdm8M8Cu504wRVISOJ6oWpVqsDdJpibXS2B7zFqtwZ8OyF9MmKX6ZkpP5c3bY9N
         Yc1wEEwuIHMaEHea4zMInUqj9uxFO1IGAReK1a6I=
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=SfXZiMZu c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=IkcTkHD0fZMA:10 a=SQ0badRnRpLHX10H574A:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Regression in patch add?
To:     mqudsi <mqudsi@neosmart.net>, git@vger.kernel.org
References: <01010162c940b8bb-d8139971-3ee2-4cd6-bb19-35126d46753b-000000@us-west-2.amazonses.com>
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <20828345-bd21-3c45-a899-e6a97910d663@talktalk.net>
Date:   Mon, 16 Apr 2018 11:00:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <01010162c940b8bb-d8139971-3ee2-4cd6-bb19-35126d46753b-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfA7GMm0QqR3Pw5egpj1vpWrf0Z4ewn0iBP+v2YLCFc4htC1RbWSU9BTz18pbQ3o0n8TBZVG+RRthGw2i1p6yqtquPtzkWWbVwZvLpXie6tHKl4Tp/AMb
 MVWAt5i0eHapdmcXrd0CNiK402obFeCicnnqd1zqjuwWu3I9QKs9CntkYvaxteFui2hu5v9ePlZ3hnWsOvYCnVWedW2vu8nj5oskroOhii6Zhig8qSL34pnu
 NJPMhizqzcD2GIBR7DIaHA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/04/18 13:21, mqudsi wrote:
> 
> Hello all,
> 
> I'm currently running the latest version of git built from `master`, and
> I'm running into what appears to be a regression in the behavior of the
> piecewise `git add -p` when applying a manually edited chunk.
> 
> I first run `git add -p`, then manually edit a chunk (after hitting `s`
> once, if it matters).

Thanks for mentioning that, it can matter as the code that stitches
split hunks back together can't cope with edited hunks properly (though
the code that checks the hunk immediately after it's been edited doesn't
bother to try and stitch things back together).

> The chunk originally contains the following:
> 
> ```diff
> # Manual hunk edit mode -- see bottom for a quick guide
> @@ -20,7 +20,7 @@
>  	"call dein#add('Shougo/dein.vim', {'rev': 'master'})
> 
>  	" Add or remove your plugins here:
> -	" call dein#add('flazz/vim-colorschemes')
> -	call dein#add('Haron-Prime/evening_vim')
> +	call dein#add('flazz/vim-colorschemes')
> +	call dein#add('danilo-augusto/vim-afterglow')
> 
>  	"core plugins that change the behavior of vim and how we use it globally
> ```
> 
> Under git 2.7.4, I can edit it to the following, which is accepted
> without a problem:
> 
> ```diff
> # Manual hunk edit mode -- see bottom for a quick guide
> @@ -20,7 +20,7 @@
> 	"call dein#add('Shougo/dein.vim', {'rev': 'master'})
> 
> 	" Add or remove your plugins here:
> -	" call dein#add('flazz/vim-colorschemes')
> -	call dein#add('Haron-Prime/evening_vim')
> +	call dein#add('flazz/vim-colorschemes')
> +	call dein#add('Haron-Prime/evening_vim')
> 
> 	"core plugins that change the behavior of vim and how we use it globally
> ```
> 
> All I did here was remove one `+` line and manually add another (which
> is a variant of the second `-` line).
> 
> Under git 2.17.0.252.gfe0a9ea, the same piece is opened in $VISUAL for
> editing (and if left unmodified applies OK), but when modified in the
> to the same exact value, after exiting the editor I receive the
> following error from git:
> 
>     error: patch fragment without header at line 15: @@ -25,7 +25,8 @@

I'm not quite sure what that error message is telling us, I need to
spend some time understanding the code in apply.c that creates this
error message.

I assume that the header is coming from the next hunk which was created
when you split the original hunk. If you could post the original hunk
before it was split and the hunk starting at line 25 after it was split
that might help.

As Martin said if you could share the files or come up with a
reproducible example that would really help in figuring out what is
going wrong.

Thanks for reporting this

Phillip


> I'm not sure what to make of this.
> 
> Thank you,
> 
> Mahmoud Al-Qudsi
> NeoSmart Technologies
> 
> 

