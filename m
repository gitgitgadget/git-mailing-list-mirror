Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C52C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 15:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245501AbiFCP1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 11:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238749AbiFCP1E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 11:27:04 -0400
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC2D21B3
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 08:27:03 -0700 (PDT)
Received: by mail-ot1-x349.google.com with SMTP id d11-20020a0568301b6b00b0060b495e7458so2267894ote.8
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 08:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Jj0zGNbWpIrUirG5Xaies7WTUn3Jttqvt8hTse+9u9I=;
        b=QB73ikN54EUItkmKP3xAK95xRVqByUtV1KUBiAFk+0As3wSlvlleXhvmB4+rKvk/bh
         LXHHzaQWN/ToBSlMs6NR32bQc0THEOuIneZUbxNhP/ZYwvCWBxH561oeb29ZVgAvZA+g
         vxXyaHzaZ/sMWj0S935/7ifuMKFS2107TQY2VMlyVMs3V8Kp2bziZqW8PCSd2TXoc/lF
         T1QXbyVNspkxTnKHinIUd6cHLSt0+/FoUSh2thOPjGdIpHjZVc1WtamDFABFrtLJ6nez
         IQ3cjwQKZk/KYuDjII5Cl4uASBswsoCtAIBs72EXQ9ldGuI/3+7g9HXqc93pgRcR2iRT
         gyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=Jj0zGNbWpIrUirG5Xaies7WTUn3Jttqvt8hTse+9u9I=;
        b=Vl5TMcHK1OW9Ze/uzeaqZh73iKT91M3ZEFZsNeO+OYIGj/QYHcjaQqRnYqeGLAbXQu
         lM0PDCMJy4lSse22vleNNqFc9Vqg3KVTQAU/T9B9SNmuWM4W6zsqNFF+sRxD2wt0r06f
         EK8Pg2f/UCo+lOvCsO6COrjYp2EgShzpJ1YKaT6+oilsIUAbFL0SafEIwVDzEYf2tJMB
         W1cQISzDPHbkoHtPF/jse3dY8pY9xj3rnxLbSzcynWg9nd08dS7Xk1jwnGo0f8clmeKs
         +EFsBGr85Gbldfvs9xC2jZ54ffjfFZ/RZIsgocrpTWMbWWlQgDwTa1h1HVV3ipErzjsX
         //BA==
X-Gm-Message-State: AOAM532SdXiYkFD5D7DbONzHuNmqVwV8hAcPBgXI7YzYTyaZY92Lux1u
        DsNNyrXhUxx9uTnFoYXvnZLVs/O5HgsmXr8271Zf
X-Google-Smtp-Source: ABdhPJzQwVL1fPnb/Fvfw5wkF6TyffVQ4UWzElUsYXIH1Mtg6QycyEQwd+TA5v9DfNbAsScgSNMM/ajMZV5G5yPhh060
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:4b83:b0:1e3:3ad3:612c with
 SMTP id lr3-20020a17090b4b8300b001e33ad3612cmr20963717pjb.87.1654270012282;
 Fri, 03 Jun 2022 08:26:52 -0700 (PDT)
Date:   Fri,  3 Jun 2022 08:26:48 -0700
In-Reply-To: <220603.86k09yxf4z.gmgdl@evledraar.gmail.com>
Message-Id: <20220603152649.486683-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: Re: [PATCH v2] commit,shallow: unparse commits if grafts changed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        derrickstolee@github.com, me@ttaylorr.com, gitster@pobox.com,
        bagasdotme@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> Are we going to have the same issue with tags, c.f. parse_tag() and
> there being no unparse_tag()?
>=20
> (I don't know offhand, just asking)
>=20
> I have some semi-related (test) changes locally where we do have blind
> spots in tag v.s. commit parsing semi-related to this, i.e. in the whole
> "unparsed" stage.
>=20
> So I wonder what happens with a tag that's pointing to a shallow object
> that's parsed, but its underlying commit becomes un-parsed.
>=20
> Or maybe that's impossible, I'm not too familiar with "shallow"...

As Stolee said, grafts (and shallow) are only on commits.

[1] https://lore.kernel.org/git/394c054e-e1d2-41a5-a655-2ad3cb7219e0@github=
.com/

> Nit: Can this be
> e.g. s/repo-with-unreachable-upstream-shallow/repo/. The overly long
> repo name makes this much harder to follow. Compare this one which would
> clean up after itself too:
>=20
> 	test_when_finished "rm -rf repo" &&=20
> 	git init repo &&
> 	git -C repo submodule add ../a-submodule a-submodule &&
> 	git -C repo commit -m "added submodule" &&
>=20
> 	SHALLOW=3D$(cat shallow/.git/shallow) &&
> 	git -C repo fetch --update-shallow ../shallow/.git "$SHALLOW":refs/heads=
/a-shallow
>=20
> (I didn't check if that test really works, i.e. do we have a "repo"
> already, but you get the idea...

Yes I can do that. I'll see if there are any more comments and send out
a new version after the weekend.
