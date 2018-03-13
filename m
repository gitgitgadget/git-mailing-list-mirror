Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CECD51F404
	for <e@80x24.org>; Tue, 13 Mar 2018 17:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbeCMRxO (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 13:53:14 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46553 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbeCMRxN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 13:53:13 -0400
Received: by mail-wr0-f194.google.com with SMTP id m12so1279999wrm.13
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 10:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YQTOVK6ixrohwiJ6yvIqQ9TiJrjC0Vw0zWzPDHh+t6U=;
        b=lgJnuu/sJhq4eMtH+yL04t/v0LHS/mz9KFH72JHMeH+pvku2k3PAcx7ahXeE2BLsoK
         XeL+ac0oiiiBvYOGzYfVqL9XW1GBNal4+dquKm1Yl1Iip3qB63siFWTlvAtfhMR94LV0
         edbeFVboC054yg1QwRFcTAzPVydhLAFxRGTD5DeDnDzwAPGF/BvuoQTSU/NuAnCYRhTk
         7qJgZ8yEz7APUspT335rNco9oljVvR71K6ufSU4l2nzshbobj0IeWaPTWYPEy3YFSBTX
         eFuKS8SmSWGIlQjMHKTNpd7zKS7tO9EXhdd2HLeRKNfI6hYcdN29o7c6dNguSu1oluBY
         CZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YQTOVK6ixrohwiJ6yvIqQ9TiJrjC0Vw0zWzPDHh+t6U=;
        b=KeCH4QUHNHZonbKDknkQP15P38Xd3dVYgYJlgc/0FcSmLSiLATJKWZiGQ7gXBxX0hM
         ZYfJVjLPMSb/0MDY+uILpS4SNrg+gY+dX2MaGZ7dcMdRuJJiaDohRwX534ywVV3vSerc
         XL9klEaj2jnkdjh+Fv+HOZPcfJDm3cDNgB0F1PTG9H4IG6H9EL2wvh8QQhiSQDOCz91A
         yNrP1xTXMY9/WByA49RbVHX0qfFQPaQbmdvmsXa4g2AH/rugWm/JmVltl8z0oIyIscdP
         1Hnhi9y1Ui1zPrD6y2BSDE9OR7YB4XGwYA25Ot1mVUxkZP8deAvbU8a8WfHymGRJFUVJ
         d1Qg==
X-Gm-Message-State: AElRT7G+ukRuaAaKeHu5CgRgw/8a/6krh9wreC+dn25nwtRElRRJxQBT
        urtz5nzRmkGmg+gt2On9OJ4=
X-Google-Smtp-Source: AG47ELumzBuKSabUc9tiLLmv879Y2Hz+5hDR5D/yACuO74V1AAR814wMC6eK774HwEUTn7gV365hlA==
X-Received: by 10.223.197.139 with SMTP id m11mr1332717wrg.198.1520963592146;
        Tue, 13 Mar 2018 10:53:12 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r70sm945874wmg.40.2018.03.13.10.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 10:53:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Takuto Ikuta <tikuta@chromium.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] fetch-pack.c: use oidset to check existence of loose object
References: <20180309131136.219303-2-tikuta@chromium.org>
        <20180309132655.224308-1-tikuta@chromium.org>
        <xmqq606558k2.fsf@gitster-ct.c.googlers.com>
        <CALNjmMqBbZTFVRnc__wewWy3808n9J9xfgu8ZH-FWyWJKvqb9w@mail.gmail.com>
Date:   Tue, 13 Mar 2018 10:53:10 -0700
In-Reply-To: <CALNjmMqBbZTFVRnc__wewWy3808n9J9xfgu8ZH-FWyWJKvqb9w@mail.gmail.com>
        (Takuto Ikuta's message of "Sat, 10 Mar 2018 22:19:15 +0900")
Message-ID: <xmqqo9jr3lrt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Takuto Ikuta <tikuta@chromium.org> writes:

>> During fetch, everything_local() tries to mark common part by
>> walking the refs the other side advertised upon the first contact,
>> so it is correct that the number of checks is not reduced in a fetch
>> that does not fetch many refs, but the number of remote-tracking refs
>> you have has no effect, so I doubt such a rephrasing would make the
>> description more understandable.  "When fetching from a repository
>> with large number of refs" is probably what you want to say, no?
>
> For refs existing in local repository, everything_local looks to be able to find
> corresponding object from packed or loose objects. And if it exists,
> I think, cost of lstat(2) is relatively smaller than other operations.
> But for remote refs, everything_local fails to find it from packed
> object (this check is fast)
> and it tries to find loose object by using lstat(2), and this fails and slow.
> My patch is to skip this lstat(2) to non-existing ref objects for repositories
> having large number of remote refs.

This still does not make sense to me, and I suspect that I am
misreading you.  In what sense are you using the word "repository"
and "remote refs"?

Imagine this situation.  I have a local repository A, I fetch from a
remote repository B but in my repository A, I do *not* use
remote-tracking refs to remember what the last values of refs at
repository B.  Now when I try to fetch a single ref from B into A,
many refs B advertises point at objects A has never heard about, and
that triggers many lstat(2) that yields ENOENT that is slow.  Your
patch is to optimize this so that we learn these objects do not
exist locally without running many lstat(2) to objects and helps
repositories (like my repository A) when fetching from a repository
with large number of refs (like the repository B).  It does not
matter how many "remote refs" receiving repository (e.g. my A) has,
and it does not matter how many "remote refs" sending repository
(e.g. my B) has---whether it is refs/remotes/origin/foo
(i.e. "remote") or refs/heads/foo (i.e. "local"), a ref at B that
points at an object that is missing at A will cause the same
lstat(2) at A without your change.

That is why I think "When fetching from a repository with large
number of refs" is what you meant, not "fetching into a repository
with large number of remote refs" nor "fetching from a repository
with large number of remote refs".

Thanks.
