Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B45221F453
	for <e@80x24.org>; Fri, 25 Jan 2019 00:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfAYAXK (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 19:23:10 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40142 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfAYAXK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 19:23:10 -0500
Received: by mail-ot1-f54.google.com with SMTP id s5so6970499oth.7
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 16:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XXvygjQje4pCYqjP+zX6HIqx1/86IPBy3Y0sKhrAm8U=;
        b=N2ocXSYBagtNmeOPzpNa6W0UVUmbPMTI303joLkwLxUrh8jqjk5ptSJnAErc1xsaVv
         MWuE3splko2lHfW0TDGgH+5i7s4XID1tqM/ZF2L+j9RszHKHyhWwK2S5HcyS+0LIOFYB
         qaciAGNQqxfciX5FAu2ZR5JCHf9IEzcqNRfEHGO34JCxqJD2PneCsmAMEngpQPIn03SL
         90t+vJS0sIww1aUfvn01lz7eeo3BkrLQHtNJq59Be8qA/EkKupDkkIlp963DjovDu9/4
         vuceIJxwi35fn9d4F9DvnlNRTYe4XHwbzaaUJTj4gxeTUUOoeDpyXmSZis1Jdx74/8CY
         fn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XXvygjQje4pCYqjP+zX6HIqx1/86IPBy3Y0sKhrAm8U=;
        b=s8o4JJbb26oT8jsh4OzoUr7NvI2uDNxBl4a/8MZfr13QZHir42OngnfOSrXDVlXX9m
         J/8621YqPvmQXsun/+EMQyL5gpBhxwQqwMdSHDmASXErz2UM95Y/D9JKm0w33qR5Q1ra
         IuGdtYEVPchPSCt76harSAzhBVipg1p/GbH04FMfJk2IbVCQ9ivuVr/OmzqQu+Gm7Vd8
         QXGDSb/2FNwhhXVuptsNjLZX9inKVLkEi1Aue3BLrwxcAbRrlwE+6AXdX9gLwVLceG7f
         EGRSeMbChumYo5zxVWjAoff8lxg/TEqiqP/QGg4k3vwRXNuj+1UD5V74QQYGkO7FHrq8
         9wgg==
X-Gm-Message-State: AJcUukeWQwtuYitfB9JV7SxN2fap6LE4ik3373xxRqV8vg7JZ+r4GLeY
        7YUkDqwJE8SRUWJRS8OqqWAm3FtFzU5vldtIMzzOKBWq
X-Google-Smtp-Source: ALg8bN7824lDeYlKMlD8GjVo4FgvTkOnwkva9zjWYCJIMrzAZRSiTSEk6vctPKLDnXuS0/slNzhvUwo1WBIjAPKbaV8=
X-Received: by 2002:a9d:4618:: with SMTP id y24mr5850036ote.154.1548375789130;
 Thu, 24 Jan 2019 16:23:09 -0800 (PST)
MIME-Version: 1.0
From:   Norbert Kiesel <nkiesel@gmail.com>
Date:   Thu, 24 Jan 2019 16:22:58 -0800
Message-ID: <CAM+g_NvpqPJusmwt1ODQcFhOmphs2U_fkPPxwzv540-6ON=PJw@mail.gmail.com>
Subject: git stash changes ORIG_HEAD
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I monitor a couple of Git repos by reviewing changes via:

% git pull
% git log -p -w --no-merges ORIG_HEAD..

This works wonderfully for me.  However, sometimes I have pending
changes in my repo (because I did not yet committed them to a new
branch).  I thought I could simply use

% git pull --rebase --autostash
% git log -p -w --no-merges ORIG_HEAD..

However, this does not work as intended because stashing moves
ORIG_HEAD.  Right now I use

% orig=$(git rev-parse HEAD)
% git pull --rebase --autostash
% git log -p -w --no-merges orig..

Is it really necessary that ORIG_HEAD is moved while stashing? This
does defeat it's purpose because it's always identical to HEAD after
the stash is applied. Or could we have an option to not do that? Or is
there already another symbolic
name I could use?

Best,
  Norbert
