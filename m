Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA9311F404
	for <e@80x24.org>; Tue, 13 Feb 2018 15:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965130AbeBMPGS (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 10:06:18 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:43713 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965037AbeBMPGR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 10:06:17 -0500
Received: by mail-wr0-f173.google.com with SMTP id b52so18903992wrd.10
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 07:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wTHVTFrm1Vzp6m0XVcerivX90ug4InYubngMDmVA5QE=;
        b=oAAX0Ski3h8Wl8+U1Nb3lkeiaDabH4u8b3x8Gooym/9v0b8tJFckRDpg/YJk+PvDFV
         fYgOsPgzHBTy+akL3f9MiNb2nMLxnMchT4Ab4ENV+1VxTUTgbVVCBJtmtIhF0wTITGQN
         BebH/tIH/xyX8COXffP74HLPxK+HfHkvn5ZSKi4yI5sxLUgXGxHUVxizzq/tYl5iE0mt
         /GXunCjGsHogAr3DKr7VjsRM7/IMgbaX8T49MvtPj/dg54o/NKNzOCqHDcAhG5hRLho5
         5JfWTnow7P1OaEMSQVCUCzqdM7IM5SFt0LWzH3GNOeympKCdhvIRjNM5CgaUIT6OtxAF
         AtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wTHVTFrm1Vzp6m0XVcerivX90ug4InYubngMDmVA5QE=;
        b=L/LwjnldDmUp5yEhe9bzmswUhFv9gr4A5xqLSLD0Bnd2+SiaTIStYZguDg1tShCd0d
         U6EDJYmkN+bPNVGo9FZCLJNKIaPoHEN0W8M0zx6f6lW2fxU5H2fhoHwqgLA9bk3FCUsL
         XYbqn0iikcrrHigluIEezZFLVlg3yrzt8bSAN0QJXz6kwe6jOivWHiivNN4/Vog0TIg9
         P3c54jOlXHvnQrwGfRb3MLb4AWDbdf5qpneGhdxfhiJ0QOvOdFkcYV36N0qW1xzFuxxx
         zrSaaH2h+M5jSR90V+0/z+9xC5/d1xBxpaq8tf5w2I9tsriIwzn2Z2e/Tn9eTRB+7GZY
         CxbA==
X-Gm-Message-State: APf1xPBkUbW8HbtddEjipuqt2i02LecxlI8jR3VLdKqXjlI+L94qPDo0
        Njqkn2rpWSOdoRG0B6izpG8V2w0+dPZ9TtBCgvDCBA==
X-Google-Smtp-Source: AH8x224kghJ4sG12PJihzN3PhnmaYFZQhEemoRJk21uxVpFcMBs2OoUKAQK77/L8rQQIsHQG6XYqh7XIeJBaXiGgs9o=
X-Received: by 10.223.173.18 with SMTP id p18mr1667061wrc.29.1518534376146;
 Tue, 13 Feb 2018 07:06:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.197.5 with HTTP; Tue, 13 Feb 2018 07:06:15 -0800 (PST)
From:   =?UTF-8?B?zqPPgM+Nz4HOv8+CIM6SzrHOts6xzq/Ov8+C?= 
        <sbazaios@gmail.com>
Date:   Tue, 13 Feb 2018 17:06:15 +0200
Message-ID: <CAOmC-AncOZfAwowXLjwDbL9Bdx1+=RbXsrd72LzEBd2W-=LAQg@mail.gmail.com>
Subject: make git diff output easier to read - use better diff heuristics
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, I've came across an issue when using the git diff command. In
particular the diff is different to what the svn diff produces. While
both being correct the output of the svn diff is easier to understand
than the git diff one. See the following issue on github where I
initially reported the issue:

https://github.com/git-for-windows/git/issues/1494

I have Included a picture to better illustrate the problem. What do
you think? Is it possible to make git diff output similar to svn diff
regarding this issue?
