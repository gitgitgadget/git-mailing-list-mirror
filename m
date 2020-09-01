Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5431FC433E2
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 10:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE3720C56
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 10:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1L1Q00t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgIAK2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgIAK2o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 06:28:44 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5D2C061244
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 03:28:42 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o16so404907pjr.2
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 03:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NovdcSUPG6fV87BQH7paSSwRIKWmdzO8IsGAtayeH48=;
        b=X1L1Q00trQJ9WuHeCLOX2Mcwmg4c8UsKAf2RxpRtstmjPmp4NhLUGBiKcpGChRa0vu
         sdZQgcyYhNy5TMpUoKhy1ZqFK4RCF9vzP4Xnm7M7Dhgt4pRoIyxOAvIBvr/VqEYyS3Bw
         xOJ6koGMl1p2tWx+FluirNdEMMTv/WB1jye8qZJIzAFsVIjhbZZ2Vov9x1Xq2RiTwdx6
         vcU82C3rTg39DopJkdO2MOq9x1qSbi2hDIfQgdPNtCaTF8AwwTICKuOHzCR0yT+QRdZX
         VLDovUAEfTBbbi59l85Tk8G4RJfU2/0LfX7RU+fkWwqbp6NHRubEt9k+zBd6qKIk5NyY
         yh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=NovdcSUPG6fV87BQH7paSSwRIKWmdzO8IsGAtayeH48=;
        b=fuspzEu5ZwW0ZqtAN/OoKKxqST2UhIk6z3ujhfmWzcjEYS+tMNkPcic5oY9FTjJFFF
         2afGXkt67Fl4ahaJuvVP3s7JLBuKX06HVnZWKyIH39/UDhGArZdRpBySFUraBGSIQR5q
         NNSS4gOxGu1D0WqIBTeudjFnqaS0MYIuD80cUhZHBKxmyz4Jfufo406OLrhWZpojv72T
         YjNSPZbDtSfny04WtjhyocwDFwto/H+6dJEuYJQ93waLJuCCc9jeb9lIPEz0rKVkTfA4
         YZooCbhA1I3aqEcOTxKBedxUfeXRltrOT5Zsyf1owTwjhrRQJf/DrNCjoE8tfyqNbBvq
         0tSA==
X-Gm-Message-State: AOAM530Dat4NYvtLD9FxOD9Vw36eA7JTDEV6J2jPTHSMZB/MQ+VYBK/4
        +5OIq+JTLmfRwRnmoup7WVs=
X-Google-Smtp-Source: ABdhPJzyZPgVPfYG3HW1+76JA/NZ6vuouXAVgXOManTrhYg0Xq9QJz1OUytuNo8XW03fV/Em8xgMVQ==
X-Received: by 2002:a17:90b:3004:: with SMTP id hg4mr911720pjb.7.1598956121575;
        Tue, 01 Sep 2020 03:28:41 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:79b:52ed:48f6:b1a4:ca3c:754b])
        by smtp.gmail.com with ESMTPSA id t10sm1436207pfq.52.2020.09.01.03.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 03:28:40 -0700 (PDT)
Date:   Tue, 1 Sep 2020 15:56:24 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, stolee@gmail.com
Subject: Re: [PATCH v3 06/11] commit-graph: add a slab to store topological
 levels
Message-ID: <20200901102624.GB10388@Abhishek-Arch>
Reply-To: CANQwDwdsV0mSos7M_d7UP1CjT1rCyA_GfaYarMKUZaFdDZ0WRg@mail.gmail.com
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <b347dbb01b9254ab8d79fbbd0f7c2b637efde62e.1597509583.git.gitgitgadget@gmail.com>
 <85d03jlu05.fsf@gmail.com>
 <20200825061418.GA629699@Abhishek-Arch>
 <855z97dvsp.fsf@gmail.com>
 <CANQwDwdsV0mSos7M_d7UP1CjT1rCyA_GfaYarMKUZaFdDZ0WRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANQwDwdsV0mSos7M_d7UP1CjT1rCyA_GfaYarMKUZaFdDZ0WRg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 09:56:44AM +0200, Jakub Narębski wrote:
> On Tue, 25 Aug 2020 at 09:33, Jakub Narębski <jnareb@gmail.com> wrote:
>
> ...
>
> >
> > All right, we might want to make use of the fact that the value of 0 for
> > topological level here always mean that its value for a commit needs to
> > be computed, that 0 is not a valid value for topological levels.
> > - if the value 0 came from commit-graph file, it means that it came
> >   from Git version that used commit-graph but didn't compute generation
> >   numbers; the value is GENERATION_NUMBER_ZERO
> > - the value 0 might came from the fact that commit is not in graph,
> >   and that commit-slab zero-initializes the values stored; let's
> >   call this value GENERATION_NUMBER_UNINITIALIZED
> >
> > If we ensure that corrected commit date can never be zero (which is
> > extremely unlikely, as one of root commits would have to be malformed or
> > written on badly misconfigured computer, with value of 0 for committer
> > timestamp), then this "happy accident" can keep working.
> >
> >   As a special case, commit date with timestamp of zero (01.01.1970 00:00:00Z)
> >   has corrected commit date of one, to be able to distinguish
> >   uninitialized values.
> >
> > Or something like that.
> >
> > Actually, it is not even necessary, as corrected commit date of 0 just
> > means that this single value (well, for every root commit with commit
> > date of 0) would be unnecessary recomputed in compute_generation_numbers().
> >
> > Anyway, we would want to document this fact in the commit message.
> 
> Alternatively, instead of comparing 'level' (and later in series also
> 'corrected_commit_date') against GENERATION_NUMBER_INFINITY,
> we could load at no extra cost `graph_pos` value and compare it
> against COMMIT_NOT_FROM_GRAPH.
> 
> But with this solution we could never get rid of graph_pos, if we
> think it is unnecessary. If we split commit_graph_data into separate
> slabs (as it was in early versions of respective patch series), we
> would have to pay additional cost.
> 
> But it is an alternative.
> 
> Best,
> -- 
> Jakub Narębski

I think updating a commit date with timestampt of zero to use corrected
commit date of one would leave us more options down the line.

Changing this is easy enough.

For a root commit with timestamp zero, current->date would be zero and 
max_corrected_commit_date would be zero as well. So we can set 
corrected commit date as `max_corrected_commit_date + 1`, instead of the
earlier `(current->date - 1) + 1`.

----

diff --git a/commit-graph.c b/commit-graph.c
index 7ed0a33ad6..e3c5e30405 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1389,7 +1389,7 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 					max_level = GENERATION_NUMBER_V1_MAX - 1;
 				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
 
-				if (current->date > max_corrected_commit_date)
+				if (current->date && current->date > max_corrected_commit_date)
 					max_corrected_commit_date = current->date - 1;
 				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
 			}
