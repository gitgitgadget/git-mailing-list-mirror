Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 003711F462
	for <e@80x24.org>; Tue, 28 May 2019 22:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfE1WfL (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 18:35:11 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:38807 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfE1WfL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 18:35:11 -0400
Received: by mail-vs1-f50.google.com with SMTP id b10so411480vsp.5
        for <git@vger.kernel.org>; Tue, 28 May 2019 15:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jmiqO87Z7cb0KM7B5+2M92ACNJmrdVI27JX3MyOE3RI=;
        b=hLnXoN6w3DOw5RWjAnW3ntF5bv1swgmo//7+uZuHnQIM6IFl/+0YWZXDDXHQyEXzjS
         SY76ROQn3DAu/URToCGzz+ZajZNG5WhrN6zqyf71D3wQDDHEZfoMW4747PvNQJ9RRHOI
         eGPwdRXNwbWxdeAXmMr/0nn/+py0ZimkWvHNx4tX5txekaTN5Hgm0o4fDsozaQcvfNfA
         kqYEkU5JGYw3vtthweXTkUhMYeqIAnBVIb1qmX/xwVHJtoJyQqGDdt/1bL3gmIsg9nAg
         vQ98q9sIOiEugoFJ2DEBIzvoKcYnby2XPToJCH/6BicYaNtIaksHMoPDWokBFBlzaB5N
         8f5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jmiqO87Z7cb0KM7B5+2M92ACNJmrdVI27JX3MyOE3RI=;
        b=pdBpCexh5MGoD6fkXDQFphfV/52Vpa+sSiemzn860TrjsZUGQRfzAhWgVNvaG8mh6c
         h07Yg1hQ5WID+HNX5pFgAXD88zvqB8YXrjHC02AwmUyPTajAGma5ZM/8lG2x3YSxp8Qf
         ew/yE9+9eDC39M9tGcliqTRRtNAHXCw5vmXF2+UMgDAQSoMNct8PBms60+jIAuDlJ1hx
         2CLkMIHrxqUhzwjxaSdAuermGOXEqOFJFcJTeinljuB6/4+HSII6U8+HFA5aeFJBQC7F
         453jXC3+9t3eIHNBiFrJoKsgXSUt2QGgFTCY+Q0q12QlexozboVLjm7QDsiR22go7bQc
         nq4w==
X-Gm-Message-State: APjAAAXxDWD/WsONoCOC84s7OcqiJCWM3CfgiwmoZRhU8ngk2oqgghiD
        Hy0x2C80B+TKCMvTQpMxihpsGf/Ryt24gRr+rRGJZ925K4Ctwg==
X-Google-Smtp-Source: APXvYqx0IC8S2CuNEyZ5ZfyWWsumgvsFdgNXLUE4Sa5R/ei8nTAMES3x8v+zl8Z3b0pDnvm+UwxOS1CRi3TCg9niWXg=
X-Received: by 2002:a67:fc59:: with SMTP id p25mr19349378vsq.49.1559082909343;
 Tue, 28 May 2019 15:35:09 -0700 (PDT)
MIME-Version: 1.0
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 28 May 2019 19:34:58 -0300
Message-ID: <CAFQ2z_O7rupGS4rntiUwJCHUj3bO0U88bVAToveEo_uU0Eu96w@mail.gmail.com>
Subject: git-clone --config remote.origin.fetch regression
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(see also https://github.com/google/zoekt/issues/81)

It looks like git 2.21 included a regression. The command

git clone --bare --progress \
  --config "remote.origin.fetch=3D+refs/heads/*:refs/heads/*" \
  https://github.com/google/zoekt.git \
  /tmp/zoekt-git2.20.git

would succeed with git 2.20, but fails with

 fatal: multiple updates for ref 'refs/heads/master' not allowed

in git 2.21, probably caused by commit 515be83.

Should I call git in another way? I originally included
"remote.origin.fetch=3D+refs/heads/*:refs/heads/*" to avoid getting
Gerrit refs (refs/changes/*), but maybe I should use a different
incantation?

--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
