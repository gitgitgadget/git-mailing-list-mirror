Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3FFE20899
	for <e@80x24.org>; Sat, 19 Aug 2017 08:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbdHSIZU (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 04:25:20 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:38426 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752405AbdHSIZS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 04:25:18 -0400
Received: by mail-pg0-f42.google.com with SMTP id t80so48732915pgb.5
        for <git@vger.kernel.org>; Sat, 19 Aug 2017 01:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=therightstuff.de; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=YAo8HSOO/UoPDg7s4RKQuZXWEKatCI5lAjr9syVnwAM=;
        b=mOAyq9qRCodcClIHoI9O17uxR7F9DFOrp5g/7s+TUaaM5uJyFWg9gJgiwG7WsrUfuj
         KatHbbYBbsiPBPAADjZ6Uvr3lNs8baOUuJz0yKR8yV0JXUDMOv3b3GzQZf17OZegN+PE
         2I+5FnaFTP1JLSHOO9PX4hLUdMR5QCR9s0P1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=YAo8HSOO/UoPDg7s4RKQuZXWEKatCI5lAjr9syVnwAM=;
        b=oLHyBUBCH4HhEIvxry9x21v0I1clldYkgDjWAvWDDCOr3D2hrau0eVwrd8nb4+W2Dg
         NfR2x5Dd/olUyl9CdDIB5BlUnxzNMqJ3wLjndYFLdJ4RacrfQfGCaaOsWmhxTyQudQaz
         MvhD0FLW46th3YfvUoSnZvLW13T+lipphhDIA5nd3Q/vv+sLAmD2IKpDHl+mgIZOYCd6
         FOifEMEMUMmiqvEaZSJ2CukppkQeT/qu8HCN+O7Rco5BOCDcXOU7xFbhSiyU4dLHTS0T
         xpS6oilxE5G8UXkp19lTbe6UmO+oF8RVrB9fdq6ZVNzXm9StalIfFMFPSQJeehbJ5KSp
         snHA==
X-Gm-Message-State: AHYfb5gwo+hodSue/A2hJbKcQ/9fxKDaUXzmTjwqfzMJwPmM0hKLCK7N
        Inckce6ocbvo1D5Ko+DWl/hMAOFM4NKoMXkHig==
X-Received: by 10.84.236.6 with SMTP id q6mr12208279plk.341.1503131117677;
 Sat, 19 Aug 2017 01:25:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.149.7 with HTTP; Sat, 19 Aug 2017 01:24:57 -0700 (PDT)
X-Originating-IP: [2001:470:1f0b:c9a:a974:46a2:b306:7a10]
From:   =?UTF-8?Q?Alexander_Gro=C3=9F?= <agross@therightstuff.de>
Date:   Sat, 19 Aug 2017 10:24:57 +0200
Message-ID: <CACcHa=NYgir8HDeR1ES9mKsqTQYk=90Z38csTgK-vfD=fQmHLg@mail.gmail.com>
Subject: git svn show-externals output format
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I am playing with svn-to-git conversion and wanted to have a look at
the svn:externals of a test SVN repository.

$ git svn clone svn://svn.code.sf.net/p/svn-to-git/code/ svn-to-git-code

The SVN repo in HEAD revision contains three externals:

$ cd svn-to-git-code
$ git svn show-externals

# /trunk/
/trunk/https://svn.code.sf.net/p/gc-webdav/svn webdav
/trunk/https://svn.code.sf.net/p/gc-webdav/svn@1 webdav-at-revision

# /trunk/sub directory/
/trunk/sub directory/https://svn.code.sf.net/p/gc-webdav/svn 'webdav in sub=
dir'

An earlier version contains just one external:

$ git svn show-externals --revision 8

# /trunk/
/trunk/webdav https://svn.code.sf.net/p/gc-webdav/svn/

It seems like the output is inconsistent. In SVN revision 8 the output
looks like it's formatted like
<path> <URL>

In the HEAD revision it looks mangled
<path prefix><URL> <path suffix>

This makes consuming the output of git svn show-externals in HEAD
difficult because the parts are not clearly separated by space and
sometimes the path is the first element, sometimes it's a combination
of first and last elements.

I am able to checkout both revisions including externals using native svn.

Am I doing something wrong?

Thanks!


Alex
--=20
Alexander Gro=C3=9F
http://therightstuff.de/
