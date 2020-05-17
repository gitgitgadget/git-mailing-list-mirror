Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BD0C433E0
	for <git@archiver.kernel.org>; Sun, 17 May 2020 02:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03677206D4
	for <git@archiver.kernel.org>; Sun, 17 May 2020 02:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8SsJlqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgEQCsM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 22:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgEQCsL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 May 2020 22:48:11 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EA1C061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 19:48:10 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id q8so1247447pfu.5
        for <git@vger.kernel.org>; Sat, 16 May 2020 19:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ZP9VjMR8yHhvcMk5os61bhqQ20DQHIjsrWvijN0mVxI=;
        b=D8SsJlqSHw/xeveTkqoNMMZ1WOQaMD+aCpgN+O05I9ZrKyF/Zfdyl7q7Qa75C65jfZ
         p5Dbg0oTyaXezhomzbbOQ9a0HUISWezDJDyhBGZXAfJRESeJl8VOXC0cbtrd7U8YrBLs
         OJ6SGRd1HWLKrYTOYyITJVb8hEiJvXKtqAavfnqjGTj4Aaty0+m85vgDwsxlyRS77Djz
         hM6pXNYHs6Jo6xaCJRdryoLGQKuBURXOSSBAxgtT8lbZp44wIcXGJOzFgxZTl3OCxQ6+
         UVUzL9T75087+yvTSCEeQ6GiKSy0QWknGhwTyjs0ZSW92JAq8VpPT28+F8zJWNE8M/c0
         QXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ZP9VjMR8yHhvcMk5os61bhqQ20DQHIjsrWvijN0mVxI=;
        b=SBJ5rKegjzQVbW5BGN60YnAPblVQsZph7tmLFOPXyIq+Nan/UQLGbi8cUZGbwxXOTs
         5qPkXw/5I3dy+i60khIKy/EiTAqr9pZfFiLTW2IY7BY3uYT8AzqwmlMcVCFBnLc7i3QD
         0k4fw563WwY58OzmjuRAIKiEjj21KYqvGfFsBg4cwqDIYj2L8j9F+m4lQ9Lci9iCEwnF
         N4Psm+94GjWJuOMu3rIxhTDtyQVSfhZx9gk9yUMZmw8JcMFvMBUf5ywaExjbD+jt3tMV
         CPXEnf9KPg3pYSTRwzjMsM8dDxyin6NQZcll5SGOOVnC3AINTnzavsfDuZ0yQ7KWuoKI
         b+rQ==
X-Gm-Message-State: AOAM530LE+upE0febNouF6TpfHstW1rkkXPb3lCgDcSbaAOi/IdrCZee
        f0uUG9UzB0qXflvAbUeahXo=
X-Google-Smtp-Source: ABdhPJzkPyPdCwh8sNmYGyWbdWSxEWMeehwmd7RkWoT+CPQWAhF70CVV4l2JmKufbcusxL3GPo+ylw==
X-Received: by 2002:aa7:80d9:: with SMTP id a25mr11385806pfn.220.1589683689704;
        Sat, 16 May 2020 19:48:09 -0700 (PDT)
Received: from [192.168.1.61] ([171.244.97.49])
        by smtp.gmail.com with ESMTPSA id ce21sm4931446pjb.51.2020.05.16.19.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 19:48:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Danh Doan <congdanhqx@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4] diff: add config option relative
Date:   Sun, 17 May 2020 09:48:03 +0700
Message-Id: <67A0CBED-16A8-4DD1-9F79-1495FC242A0C@gmail.com>
References: <20200517021452.GA2114@danh.dev>
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
In-Reply-To: <20200517021452.GA2114@danh.dev>
To:     Laurent Arnoud <laurent@spkdev.net>
X-Mailer: iPhone Mail (17E262)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On May 17, 2020, at 09:14, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <con=
gdanhqx@gmail.com> wrote:
>=20
> =EF=BB=BFHi Laurent,
>=20
>> On 2020-05-16 21:40:33+0200, Laurent Arnoud <laurent@spkdev.net> wrote:
>> Subject: Re: [PATCH v4] diff: add config option relative
>=20
> I think the subject should be changed to.
>=20
>    diff: allow overriding --relative

I feel stupid about this now.
Please disregard my comment about subject.=
