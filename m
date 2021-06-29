Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B75C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E0A261CAF
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhF2CLK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhF2CLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:11:09 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40349C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:08:42 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id g13-20020a4ac4cd0000b029024c717ed8aeso2174342ooq.13
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=TXcs9uiud4/Pj4aO2KK1hswjPxOGaklKC5mpchQTF70=;
        b=HT7chEM77HBBhlElkqtWYFQxCPPIHWDVdDS+xfe764m86QdVYRRUriqtBmfjwVHjQB
         w8DLEu//IqyS1AH679McxgWXmfKdG2z34GoPLDiIMK1B4EJVHXoSlS4bP+ofkRpMLL7B
         XLbYlDlp3Gr/EgWUg4EopNxVuF5khPChEhQKKoQQ4IK4FkXhoHJxS4PQH0TmcUnQfD1y
         YE/OzzPPl098oxwd7kL5wf5qcUudH9kdlhbKV2qjRETOlyMvBYRdnHHRy1Zu9tBT4ENf
         JYkgrK9JUoh+k3BMvUZYeWczv2ei6u+r+4I9fC174T3pmleI8GrCMt527sH0QAtFQ/FK
         zx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=TXcs9uiud4/Pj4aO2KK1hswjPxOGaklKC5mpchQTF70=;
        b=GrxTTPCwZIBw/2XFezPMHem+MuuE+MbOf8fCN5Cu+BvSTzDVf3D4IUvnG5F04UkKqB
         /DKrraFQop7tqhn7IqwpieYJcaeBXzrF0/krPBORqeixIBZKmjvXVi1iUIOv3U0qOT95
         zSKlsm6vDczhvbuDbQ9ahMfbrMhj/Mgq47pl5d8SfFVl8FbblnvoSxEEW+pltvefhm9e
         T5RA1XYBUCwti7fUrJzZm1ICjPrmjhXpckfhkkwCykDl91qRaHAV1vKDVQbZEWMwvQAr
         HlQC6LB5eQ16YqNEw+B19OoLk32LTMWEwWTaTPGA8dfEIi+DaQwsJ/Og3aYC+8b0xeId
         Fe5w==
X-Gm-Message-State: AOAM530TpHTmprfTDEUM5DgKQcpUi1dbI1ALBYMXuJwDJxjYYAKP1rOt
        RqfDJJd49qCJ7mQnXyLg5arfsQRM3ignbw==
X-Google-Smtp-Source: ABdhPJwZ+vdw0Y+Ui+TSqvM22PeSDigbHizIhIkLqOzjIJ5UxAg5qW7btxJPqK9Yuu4I/XZswJwIeA==
X-Received: by 2002:a4a:d1d9:: with SMTP id a25mr1931899oos.91.1624932521456;
        Mon, 28 Jun 2021 19:08:41 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id w132sm3587188oig.38.2021.06.28.19.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 19:08:40 -0700 (PDT)
Date:   Mon, 28 Jun 2021 21:08:39 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Kevin Buckley <Kevin.Buckley@pawsey.org.au>, git@vger.kernel.org
Message-ID: <60da80a7d0abb_20757208c5@natae.notmuch>
In-Reply-To: <a5579940-237b-2e4d-bf18-bc0a8f2f1ee3@pawsey.org.au>
References: <7dd55e85-38eb-7346-ff10-7124102cd22b@pawsey.org.au>
 <435b0150-cd9f-32ce-7a07-3057ef20662a@iee.email>
 <12dd4f05-456f-c763-441e-5bb16634306a@pawsey.org.au>
 <60d9410bb07a1_aac5d20888@natae.notmuch>
 <ec31434f-0c99-ffb7-6eb0-6ecb1f6e761c@pawsey.org.au>
 <60d95c6024f3d_aaf7e208a4@natae.notmuch>
 <a5579940-237b-2e4d-bf18-bc0a8f2f1ee3@pawsey.org.au>
Subject: Re: Definition of "the Git repository"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Buckley wrote:
> On 2021/06/28 13:21, Felipe Contreras wrote:
> > 
> > To try to make it more orthogonal, let's suppose the index file was
> > outside the .git directory. Would you consider then the staging area
> > separate from the repository?
> > 
> > In fact, we don't have to suppose:
> > 
> >    GIT_INDEX_FILE=/tmp/index git checkout @~ -- .
> > 
> > Does that command change the repository in any way?
>   
> I have to admit that I don't know, and that I can't immediately
> see where the "repository" would be, in that example. This is
> obviously a gap in my understanding: happy to defer to yours.

Well, think about it.

> I do however feel that the fact that we have moved to using examples
> that override the Git Index file on the command line, in order to
> define what a "repository" is, just so that we might be able to give
> a "more correct" definition of the term, to someone completely new to
> Git, suggests that, as others have already noted in the discussion,
> it's not easy to be "correct"?

No. The repository is what the repository is. The command is merely an
aid for *you* to think about it.

If you are trying to define what a swan is, and you think a swan is a
white bird, but then I show you a black swan, what do you think you
should do with your definition?

What's complicated about this definition?

  A git repository is contained in the .git directory, but it's not the
  same thing. The staging area is usually inside the .git directory too,
  but it's not part of the repository.

Why do you want to make it more complicated than that?

-- 
Felipe Contreras
