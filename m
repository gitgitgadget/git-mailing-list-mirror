Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E07021F404
	for <e@80x24.org>; Fri, 19 Jan 2018 14:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755398AbeASONX (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 09:13:23 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:43938 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754809AbeASONV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 09:13:21 -0500
Received: by mail-qt0-f171.google.com with SMTP id s3so4046018qtb.10
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 06:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=0Flnm4XbJz9intklWTp2j3+W3mg4PmjYP3E/zuKZylg=;
        b=YinM9szF0dEnMdMWqGNKBQb+NjWdC7EkFLM66e0ovNp1XnXRINOXB2H2rR2xNWwj2K
         KD95S9mLRLUy7kz8kmcVpskdUL+ocVFbc+bRnqnlPM1QcDUu0hvU/ys2r7PK11aGXndE
         ASVWXZgXdiqJKq57hu12HyBdgYXjchmMyut6ED7IGOzKPO2sJR+oc3/tY640CvPk//JD
         eeIxPHwd6Sa5KHrzZ5R8LPwW7OZSwVzspyEkvYgcNBMtMe6E42mfaKSXtFH5sRKQS/G7
         VDdmfD9naPVK23BXzCD1mKQoSXdAl6BK3Lypmb5HkaBrL5qyWl6imk0UGkUUro+SKKn2
         DsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=0Flnm4XbJz9intklWTp2j3+W3mg4PmjYP3E/zuKZylg=;
        b=p/za6j/zzQfh1q7X3tK2TtaBskP2fd2/3Ie914Iex254PHoXn3wfWcEiAtDq2izLEq
         6cOGcZjbb/lX1tI7ZxAYhwEoBTQDeXXllssZVuZU/2FjtreYucfNvKQcGw0cXTCwrOBg
         J9w6pq/ws085mHxGhd4EHpC3L9MFZlbhBhaUpoi+agOh62wulbKSDs6WKL/vhYOkv7DZ
         pP73opyYICdQ8TJEsJx+vriKaGQM5++0KNR/oHfooSo/RV3oRpU277Bc7IlN/hhF90gf
         bslc8/TV09oS0Nsp1iSCuVrnwFVyz/4ezmBQ+QpeQRdsZrO/wY1L7ENvlkjaba8RfaWi
         RbjQ==
X-Gm-Message-State: AKwxytf8ey/EgDQu/mO7t5Vde2/Ubw4KzzTZwVYbuV0k0dp03pcckqxz
        EQG5LB6TlPh9NNhcYLVxVj9QYFDv46RepjnRh/rlAA==
X-Google-Smtp-Source: ACJfBotqxOD/JWwM4YgZMammN4x5kqs4hfWJcHrBpeVXQeujg6p2uEkfTU8s9WQgKAg3w7LTdsipXSyXwOPHVb3Eg10=
X-Received: by 10.237.39.103 with SMTP id n94mr26896154qtd.323.1516371200486;
 Fri, 19 Jan 2018 06:13:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.30.66 with HTTP; Fri, 19 Jan 2018 06:13:20 -0800 (PST)
From:   Danny Lin <danny0838@gmail.com>
Date:   Fri, 19 Jan 2018 22:13:20 +0800
Message-ID: <CAMbsUu7P6RGpyDm+tKbBhgPyxoTYP3Zs5rjt302O8SH-H8ujeQ@mail.gmail.com>
Subject: UTF-8-safe way for char-level-diff
To:     git develop <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git has a diff.wordRegex config that allows the user to specify a
regex that defines a word. Setting diff.wordRegex to "." works well
for a char-level diff for ASCII chars, but not for UTF-8 chars.

For example, if a file (encoded by UTF-8) with text "=E4=B8=80=E4=BA=BA" is=
 changed to
"=E4=B8=81=E4=BA=BA", "git diff --word-diff=3Dcolor" gets "<E4><B8><80><81>=
=E4=BA=BA" (where
"<80>" is red and "<81>" is green) instead of desired "=E4=B8=80=E4=B8=81=
=E4=BA=BA" (where "=E4=B8=80"
is red and "=E4=B8=81" is green). This could be very annoying when diff-ing
files containing CJK chars.

Git diff.wordRegex seems to implement a very basic regex that doesn't
support matching char range by encoding such as "\x41" for "a". Is
there a way to make the char-level diff work correctly? If not, maybe
we should implement a way to allow it.
