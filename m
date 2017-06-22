Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4EA920802
	for <e@80x24.org>; Thu, 22 Jun 2017 20:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbdFVUcs (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 16:32:48 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34862 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbdFVUcr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 16:32:47 -0400
Received: by mail-pg0-f68.google.com with SMTP id f127so3770350pgc.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 13:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/At0PDC4e1LJFWhttjroFeO3I3aqlvAxDuJdo6RB1b0=;
        b=FBVq2wXLnlqNSjbonf+ucL0fOvw/yEop09eLMp1FvpA/6T/L3f2LW/XDAO1BFCmnS6
         isc2BuR0eTMXPQXjKR3clm/SM1Nyw8+JETxikvOq/sSCsBaaR5dXVH6/4CBiX/F0HipS
         9TU0xfp0jRLxfF+gS6GUrNpkNN5yDiiMYaK8cCyYQbuSgVM8vkLNbqcjBAJJCaXg1u5s
         PKH7tJr4ia1Eh6z8qaEcNA70JDh1QY/KYecYTFydYbrH1P2Lzj/69J9ZSK0KAr7YkQYp
         p5iATdcGLR3wYWah/e/MNBy8bm/MiYoy7Kw224qzr95LBxT4YX2WJTmMNWjNlcR9pY6b
         s6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/At0PDC4e1LJFWhttjroFeO3I3aqlvAxDuJdo6RB1b0=;
        b=X2hkL9B96G3ZpyQQVX91BEa83GcaXgxl3NrPCa2ji6RH0GX+cCc/W2qXkxdaQNBFm7
         Vx9ujOd2y7mWBj86COlipV1OAoggp6SsSn7Iq0cyfATOB5bCbB5HYHB7bq0yq7utveQn
         ikUnoXSwk7N2myTfNzuP6Rtn+LoaFIuJEXwKoMDTr+Qf9NTvgA+eOCAutHBqghMMdT5T
         DVlEsGBm0mPyzhyX7/lvaXniM/t3sC3fFoWSR5c6kIz5o96UBLVo34VJWLAJQyCz+oyW
         TleV6hHD2oZ5otMtCocFOExRRQii2RwB0BDoXMMWLFb7jZk64rlk/IEHWIVab6jv0EXe
         X38w==
X-Gm-Message-State: AKS2vOzi+vq1sBV7xlDPfTT2AU56lMI8oqP2HxE8odiylp6c1AzDgcAV
        CmCfv7dlPCZffw==
X-Received: by 10.84.134.34 with SMTP id 31mr4973164plg.51.1498163566293;
        Thu, 22 Jun 2017 13:32:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id k129sm5794204pfc.87.2017.06.22.13.32.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 13:32:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>
Subject: Re: Truncating HEAD reflog on branch move
References: <20170621213924.wh43i2h7v2zwihq3@genre.crustytoothpaste.net>
        <xmqqpodxm2t8.fsf@gitster.mtv.corp.google.com>
        <87efud7xjd.fsf@kyleam.com>
        <20170622151603.rrh2j7zsotyt2jxe@sigill.intra.peff.net>
        <xmqqziczkh4k.fsf@gitster.mtv.corp.google.com>
        <20170622184516.kq3y7nxwohm3coq4@sigill.intra.peff.net>
        <xmqqvannkfp8.fsf@gitster.mtv.corp.google.com>
        <20170622202146.cxrkjca636xl4dgk@sigill.intra.peff.net>
Date:   Thu, 22 Jun 2017 13:32:44 -0700
In-Reply-To: <20170622202146.cxrkjca636xl4dgk@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 22 Jun 2017 16:21:46 -0400")
Message-ID: <xmqqd19vix03.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I'd be tempted to just ditch the whole thing and teach
> get_revision_1() to just walk through the list of logs, rather than this
> weird "add a pending commit and then try to figure out which reflog it
> referred to". For instance, right now:
>
>   git log -g HEAD $(git symbolic-ref HEAD)
>
> only shows _one_ reflog. The patch below is the direction I'm thinking.
> It fails two tests, but haven't dug yet.
>
> ---
>  reflog-walk.c | 112 +++++++++--------------------------
>  reflog-walk.h |   4 +-
>  revision.c    |  24 ++++----
>  3 files changed, 43 insertions(+), 97 deletions(-)

Yeah, I agree with the "we now show diffs with true parents"
reasoning, and I like the above code reduction, obviously ;-)

> @@ -3114,18 +3112,20 @@ static void track_linear(struct rev_info *revs, struct commit *commit)
>  
>  static struct commit *get_revision_1(struct rev_info *revs)
>  {
> +	if (revs->reflog_info) {
> +		struct commit *commit = next_reflog_entry(revs->reflog_info);
> +		if (commit) {
> +			commit->object.flags &= ~(ADDED | SEEN | SHOWN);
> +			return commit;
> +		}
> +	}
> +
>  	if (!revs->commits)
>  		return NULL;
>  
>  	do {
>  		struct commit *commit = pop_commit(&revs->commits);
>  
> -		if (revs->reflog_info) {
> -			save_parents(revs, commit);
> -			fake_reflog_parent(revs->reflog_info, commit);
> -			commit->object.flags &= ~(ADDED | SEEN | SHOWN);
> -		}
> -
>  		/*
>  		 * If we haven't done the list limiting, we need to look at
>  		 * the parents here. We also need to do the date-based limiting

This part of the patch I can 100% agree with ;-)  

I do not think command line parser does not allow "log -g
maint..master" so all the "limited" processing the remainder of
get_revision_1() does shouldn't matter.

I however think pathspec will affect simplify_commit() and suspect
that "git log -g -20 HEAD path" will behave differently.  Perhaps
the difference is "it used to use path in an unexplainable way, now
it ignores", in which case this is an improvement.

Thanks.





