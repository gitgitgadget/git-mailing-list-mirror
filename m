Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2B3C388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 20:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF7420882
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 20:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUkHHE9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756391AbgJWUu2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 16:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756388AbgJWUu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 16:50:27 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930CCC0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 13:50:27 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id f20so804741uap.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 13:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dw7kEIwIKTd6dFGWtlO1RXQi7ErjEvCeFd6EY5ar+xs=;
        b=XUkHHE9jk0vF/xXENQrjoEOuc6GYB08R5MMFmWCtM9YY4n/w27EqMw2x+EMc3xio6s
         wHhL4p21qkBbZmO8+w+sRJe6a9CSGIrnHFfNO22o3WNnXjk1CMyKUVhdDh2vrEAUVf4/
         iw+qQxRS47EmLto6wLRo7wYDeie28Ejl91SHXMt2/wrF5jVwPtmu4Fzi82szbjwjiAhH
         tuV8OErs4ZGYijCOLJgOds6GgL5dISq30iqbevZ8deHriYNyTztvi3dXPTZAQW/vbABr
         66TduimJWtbIZBqbBITx0U2P4jVp+FGGON2hmvyx4GHpy2eYOzNbRN5voXudD6f4UT5k
         An/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dw7kEIwIKTd6dFGWtlO1RXQi7ErjEvCeFd6EY5ar+xs=;
        b=IUUihay1jgeT/CtYzTc0E+9NhHAnps+f3uTZrC6iSB0gOKFVnPNLbGUmOkzMbPnavt
         ebPWmRTCXKj39r22ncxutgm2YQcxBoH234JHuBy+P7CVNb9Tfz97D14LfXEAv/hM42D8
         V3bydQ5UNTxb6etQbUqrUddsDLKc0P0dEt8eC+dO1Wcf4bL8+OmrKOxuPof/sdnI4h4y
         ltJ8wdOlEumcPTBAC79Fi0N8jMCgCKWPYgLNktZY9c89Vl3JECa/swldRDWniBR05QUV
         oVwW6Cunbno+Zv3ZhAe9cZcskwdXbK1Q+qtk/ZWB164FxNdzAyazL3hD5Xg6EmnRRhIj
         D7Zw==
X-Gm-Message-State: AOAM5324wky+zp07kkvxHMQowYLDnM/eBUXT+i8jWtPCq0nxtjouhwaa
        ZaGp6IJAlzIzX2BJSognFX3InWs31b2pR835QOaGfmqsyklKNQ==
X-Google-Smtp-Source: ABdhPJzP2/J1WB7o2KVtsZBy7vmfdKHYUyNSrY2zA8Wlwrl0y1lsnn7shhYV9XGXdS0o2rC82tSSMexT2X3CSK7cv70=
X-Received: by 2002:ab0:200c:: with SMTP id v12mr3274162uak.53.1603486226489;
 Fri, 23 Oct 2020 13:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAKuTeyftpz8mQiiy2S56pxmW0fzCENAQ8=gmaTE5a-Ef5g216g@mail.gmail.com>
 <000601d6a883$66d8e180$348aa480$@nexbridge.com> <CAKuTeyc6WhEguV2mi_eg8JYrhri0inBJE-xHL3ZbFRGuYsyaDw@mail.gmail.com>
 <007901d6a8bf$0f9d3830$2ed7a890$@nexbridge.com>
In-Reply-To: <007901d6a8bf$0f9d3830$2ed7a890$@nexbridge.com>
From:   Adrien Berchet <adrien.berchet@gmail.com>
Date:   Fri, 23 Oct 2020 22:49:50 +0200
Message-ID: <CAKuTeye+kuT=zr6FoyTq8P9wj_1PnKqTdrX5sOtKhq0Z+rRaAw@mail.gmail.com>
Subject: Re: [bug] Cloning SSH repo into /tmp
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I don't know and... I am not able to reproduce this bahaviour after
rebooting this machine... I don't know what happened, I will tell you
if it happens again and if I find in which conditions it happens.
Thanks!


Le ven. 23 oct. 2020 =C3=A0 00:02, Randall S. Becker
<rsbecker@nexbridge.com> a =C3=A9crit :
>
> On October 22, 2020 5:27 PM, Adrien Berchet wrote:
> >
> > I encountered this behaviour on Linux Mint 20. But I just tried on
> > RedHatEnterpriseServer 7.6 and I could not reproduce this behaviour.
>
> I wonder whether there's something strange about how Mint partitions the =
disk, and whether /tmp is somehow configured weirdly on your machine.
>
> > Le jeu. 22 oct. 2020 =C3=A0 16:55, Randall S. Becker <rsbecker@nexbridg=
e.com> a
> > =C3=A9crit :
> >
> > >
> > > On October 22, 2020 6:28 AM, Adrien Berchet wrote:
> > > > I encountered a quite weird bug when I tried to clone a repository
> > > > into the /tmp folder (I just wanted to test something, so I was wor=
king in
> > /tmp).
> > > >
> > > > I run the following command in /tmp :
> > > >     git clone ssh://[user]@[host]/project/[project_name]
> > > > and I got the following error:
> > > >     fatal: the protocol '/tmp/ssh' is not supported
> > > >
> > > > I got the same result if a run the following command from /tmp
> > directory:
> > > >     git clone ssh://[user]@[host]/project/[project_name]
> > > > /tmp/project_name
> > > >
> > > > Nevertheless, the command works in other directories. Even the
> > > > second command works when run from another directory (this
> > command:
> > > > git clone ssh://[user]@[host]/project/[project_name]
> > /tmp/project_name).
> > > >
> > > > It is very specific and can easily be worked around so it is no big
> > > > deal but I preferred reporting this in case it hides something else=
.
> > >
> > > What platform are you running on? I have experienced similar when /tm=
p is
> > linked to a separate file system with complex ACLs.
>
