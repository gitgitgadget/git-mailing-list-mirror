Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6D3C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 21:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E69AA206D5
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 21:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/Hbpqwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgFHVZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgFHVZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 17:25:09 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DF2C08C5C2
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 14:25:09 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id r16so9085549qvm.6
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 14:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mEEXrDPMqlrpaaVoTsusso4+wuxOUKPhSyFsfUkKvlI=;
        b=F/HbpqwriOe4oZlJLp+mjH/E+SobEE6TRkR1bCp4475Q2StPlUZP+l36tYni5FNFiu
         LTrBw5Qlr2ddorCw8MFZRnEFV55pNwh/L3lychdrXXVsfHWAmaQJDbiluxbbJqikej2Z
         YKt2qR77WjV3NKs04HZewfS3kcu19Ue+FGz6vIjAMzJuml21yHuuy5uA9P63ndExMoEd
         J2A0G+LtLdBD040ddDUPd0sVI8dfVcsYplN3m+AZDLyv8IXQcslanUTqOQB/znS4NBrL
         Tg7nZIIFrti1h6c9SYyHgLnsunQW2qZcbwbvZM49WXWG3j1yfW5vjDcKOjSt59HQF1zP
         O4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mEEXrDPMqlrpaaVoTsusso4+wuxOUKPhSyFsfUkKvlI=;
        b=DJgJ6aYMFSTPUpu9jFMuHhgJoQ6JROsrQVj3GSzCSbX+KSMtXfpguNzQoTf9sm5ZBt
         iPF9cRjp9Rzj6+Xd8B8aWfO9iu3068GBbmluN8DmuqXVEKOVpewGPhSzC2nKXbIA8+ma
         J0DkRPD6+gWEdpKOStYRpqqi0eSWQ6wyfNuNcs5r4uSe5oWnmBILA0KPz6p/Ua2jWoXl
         bWcViDqtdNwFmQq1FMQ+3FZIH/dRDrl+kDLeKbLMG0Bn+Fkr82XyjAYEpAh2j684dkrs
         3u47Loz4iCJ8oLfxHZtCOuAINU8aaTfcK6D1YDSWJlgLyl+ZNndyKCVz5gUfeDPzA7sn
         Puzg==
X-Gm-Message-State: AOAM53132I6R1zUO+0AEh5wD8eJWiw5s1ocFFHj5IT4rEos8dQFNLhv2
        qxgsJ/S/mvcj0wL5RBYQUqw=
X-Google-Smtp-Source: ABdhPJy0oWdra9ShhWJoOg6gRAa4Fk9G0tEo2WE8+D8xlEeQyg7iyYBqR2H/+lA19FkIq36ycEYOGA==
X-Received: by 2002:a0c:fd24:: with SMTP id i4mr698014qvs.69.1591651508502;
        Mon, 08 Jun 2020 14:25:08 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id p4sm6567277qkf.53.2020.06.08.14.25.07
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 08 Jun 2020 14:25:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] docs: mention MyFirstContribution in more places
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200608211132.194267-1-emilyshaffer@google.com>
Date:   Mon, 8 Jun 2020 17:25:05 -0400
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6BD1731B-8D1D-4A07-BE23-70AEB740C455@gmail.com>
References: <20200608211132.194267-1-emilyshaffer@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

> Le 8 juin 2020 =C3=A0 17:11, Emily Shaffer <emilyshaffer@google.com> a =
=C3=A9crit :
>=20
> While the MyFirstContribution guide exists and has received some use =
and
> positive reviews, it is still not as discoverable as it could be. Add =
a
> reference to it from the GitHub pull request template, where many
> brand-new contributors may look. Also add a reference to it in
> SubmittingPatches, which is the central source of guidance for patch
> contribution.
>=20
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>=20
> Since v1, only the tiny nit - took Philippe's advice to refer to a
> "step-by-step" tutorial, instead of an "interactive" tutorial.
>=20
> Thanks.
> - Emily

Thanks. Looks good.=20

Reviewed-by: Philippe Blain <levraiphilippeblain@gmail.com>=
