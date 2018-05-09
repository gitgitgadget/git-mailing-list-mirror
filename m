Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA7E71F424
	for <e@80x24.org>; Wed,  9 May 2018 17:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935196AbeEIRmi (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 13:42:38 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:35120 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933555AbeEIRmh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 13:42:37 -0400
Received: by mail-ua0-f196.google.com with SMTP id a2so23088540uak.2
        for <git@vger.kernel.org>; Wed, 09 May 2018 10:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PrbVOiqYRQZW763ZOdk3CeKMwsbWEou1UEASNzosFGo=;
        b=e3ibCKM9pke1t8H6y6qFF7uTVkZe+wtcuIt+/zyUlXA/KuHMnmi5m1rLkojXJUhIrD
         6qU6LVx0/OBzPkqZe9qIYfl69sWrLLUSQwmGQLuLFDgrDhtj2+26XdEs0z67++CQKXTu
         v2MFXtQo1aoI+czm+Z6P40EcID4AV9vgYR0+cHTTQMRKpb6fR/JfD7ZuY9H4ecZt7Bh0
         EY3KAe+sFQDa4+L68MlcOi+DkVjKFQnaIGvABpddiZSNvqX99wueUy52KRoTR9uB5HvM
         5YDpZKlOC7ULPivNxgGvRoHtJSX3JzZ6M/z+LZGTGcEfJ6y/YxL24F+mANCQ16VgYO+1
         JMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PrbVOiqYRQZW763ZOdk3CeKMwsbWEou1UEASNzosFGo=;
        b=jVhQG9zEqNQNmxts28gRkWLrgwnwZgB9mAvLOfMZNhskoa22mqxEOUHC4BIAAOzDFY
         TO47EC7VrwiJCvvXYmQseP1ydMqr1LiCauaxA5C9yQ8NcgzkoMzqJ/hkUf/ovp2mDUmO
         JoQOjw2rxS6j+jSYIUKbh617MPgYiqwviGTojyQHOqap/Nq7ZF/3ODQrrbmBzDFe0JWW
         Z/9zZTlV+1ipmJUetOV4DMm2Y+QVr0D9FyUNYVZMK0xwWTOT72FLKu8XVmzpzO5HbM/H
         yTCxT5rsr7sNRy2YofmsT9MB89qn2DwXU9FN4jDNn1yckAeG356gaHzyYSOd4L/sAtEe
         SueQ==
X-Gm-Message-State: ALQs6tCMGJ4r277dLsZiwKNHDZqbVTm+Hgr40zBzi4+i1oGTJpLMqSY9
        XFA6fiP2I1nblkjpzD/iRBjdtAdE4GlEGGY7pLA=
X-Google-Smtp-Source: AB8JxZr/RlTOzItgVMBErr8uudXILeKd8aclRtqe96R+n32d04fSSNHTtLZzLrUOL8Er8qtFcht2G5y1WVW5Rz6p54k=
X-Received: by 10.176.10.26 with SMTP id q26mr39242190uah.23.1525887756694;
 Wed, 09 May 2018 10:42:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Wed, 9 May 2018 10:42:36 -0700 (PDT)
In-Reply-To: <20180509170409.13666-1-pclouds@gmail.com>
References: <20180509170409.13666-1-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 9 May 2018 10:42:36 -0700
Message-ID: <CABPp-BHGLkEnYaR2rQqLRSraMgxW7E=fmS1=bGTVeSi2VrPKcw@mail.gmail.com>
Subject: Re: [PATCH] repository: fix free problem with repo_clear(the_repository)
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 9, 2018 at 10:04 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> the_repository is special. One of the special things about it is that
> it does not allocate a new index_state object like submodules but
> points to the global the_index variable instead. As a global variable,
> the_index cannot be free()'d.
>
> Add an exception for this in repo_clear(). In the future perhaps we
> would be able to allocate the_repository's index on heap too. Then we
> can remove revert this.

"remove revert"?
