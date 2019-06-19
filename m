Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 791931F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbfFSVNL (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:13:11 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:37211 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFSVNL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:13:11 -0400
Received: by mail-ot1-f51.google.com with SMTP id s20so523201otp.4
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 14:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=v53breCFyPawpjqBEpdZziEW3mIstuh09eKzPhbgjdM=;
        b=B4LBS1AozytRhHl4YMNALjcaKVWOXgr8mAthyNgIHwsxPpXvfj+RpH/MijR/Qi4q1j
         KAuHu6EZPKOdY5eRJqcc/jmiw3yiC/TwQz5nO/cYgG2aGr/5FhB57ZMtBC3b4oasmg+H
         qrKLw0RxZkzCCw4yfbklN1F3Qpl8HcMBgCNb37mgFtAOdBgBIZnny5pxydQwpiR3+l0E
         irFFwrtrNYxFc5zLPXGjZ7ki8D+OPZyy3PMMH/ILeTdx8h38KDkaLh7wL01Ym0scZuxy
         MtL15/xB3wXzUzLn8MsyU+jB0MLD+U3OM1Op7I7Cn9OeWxGlPFrEwVPGWjtXsJ+p0Nkt
         bvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=v53breCFyPawpjqBEpdZziEW3mIstuh09eKzPhbgjdM=;
        b=rJ2pYx60GqnLShoK8muH+0JB7PL6siPWuE1J08gTsczJNTORcS6//+AnbzUHpuL9mG
         McMZAciMXmkUOKonwFwh1gshglUFwyikL/fC70Oj0I7c/bPmQcn0vJRjr2ga6pe0e+kq
         i24vOZZ5pkpmAQGXAA2v25lZciD8tF72S83Fiy5P7LlJk50Vd+6GHK6uVnFJ2HgcFXcb
         vXjms5UFI8eD3QE4rbvfdm0+Ya9F3glEh0yzSTlcCF2xqd2Uxh9ttsvT/Jqx2FWB1HOy
         m1Wz+srz5T+fAhUUpV9r4XeBZvGJDGYk5qnewwicpZ8JJV9QVj4QivwmZ0JcQM49YLaw
         ZmSw==
X-Gm-Message-State: APjAAAVzQLe0OtJsxkTVuILqgGUzLcDyOD0O5HQ7S1ttlhe/lFD8pbOC
        7ElwrZRZQbMGYt/vvWSuwJuombNZRuzCjn3z34+G9Vpk
X-Google-Smtp-Source: APXvYqxqf59Q8ftL3iODbFak3ARyEjJLfi7q/OJIEkQ6qd3OjseABeUV7bANpZM5eXI505biw0+PXSEDCuljkHBeMSw=
X-Received: by 2002:a9d:460d:: with SMTP id y13mr7707871ote.368.1560978790465;
 Wed, 19 Jun 2019 14:13:10 -0700 (PDT)
MIME-Version: 1.0
From:   Oliver Soong <osoong@gmail.com>
Date:   Wed, 19 Jun 2019 17:12:58 -0400
Message-ID: <CAPQ=hV+FmdqDBguU6pkevhRQeS3rEyA4HwmVjS-+5VSFTr_CrQ@mail.gmail.com>
Subject: . components in paths (gitattributes and git hash-object --path)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First of all, the man page for git hash-object doesn't specify whether
--path should be relative to the root of the tree or relative to the
current directory after git -C.  Current behavior seems to be the
latter, which is sensible enough and usually works.  While ..
components seem to be handled correctly, . components seem to get
matched literally in both gitattributes patterns and git hash-object
--path arguments.  On a related note, the man page for git hash-object
doesn't specify how a leading --path argument with a leading ./ should
be treated.  Given current behavior, I think a leading ./ should
indicate the current directory.

I can try to work up a patch, but I'd like some confirmation that this
is not actually intended behavior.

Cheers,
Oliver



#!/bin/sh

git init --quiet git-bug-test
cd git-bug-test
git config filter.line1.clean 'sed -e 1cclean'
git config filter.line1.smudge 'sed -e 1cdirty'
mkdir sub
cd sub
printf '# prefix\n'
git rev-parse --show-prefix

printf '# reference dirty object\n'
printf 'dirty\n' | git hash-object -w --stdin
printf '# reference clean object\n'
printf 'clean\n' | git hash-object -w --stdin

printf 'sub/* filter=line1\n' > ../.gitattributes
printf '# case 1: sub/* filter; --path=file\n'
printf 'dirty\n' | git hash-object -w --stdin --path=file
printf '# case 2: sub/* filter; --path=./file\n'
printf 'dirty\n' | git hash-object -w --stdin --path=./file
printf '# case 3: sub/* filter; --path=sub/file\n'
printf 'dirty\n' | git hash-object -w --stdin --path=sub/file
printf '# case 4: sub/* filter; --path=./sub/file\n'
printf 'dirty\n' | git hash-object -w --stdin --path=./sub/file
printf '# case 5: sub/* filter; --path=../sub/file\n'
printf 'dirty\n' | git hash-object -w --stdin --path=../sub/file
printf '# case 6: sub/* filter; --path=../sub/./file\n'
printf 'dirty\n' | git hash-object -w --stdin --path=../sub/./file

printf 'sub/./* filter=line1\n' > ../.gitattributes
printf '# case 7: sub/./* filter; --path=file\n'
printf 'dirty\n' | git hash-object -w --stdin --path=file
printf '# case 8: sub/./* filter; --path=./file\n'
printf 'dirty\n' | git hash-object -w --stdin --path=./file
printf '# case 9: sub/./* filter; --path=sub/file\n'
printf 'dirty\n' | git hash-object -w --stdin --path=sub/file
printf '# case 10: sub/./* filter; --path=./sub/file\n'
printf 'dirty\n' | git hash-object -w --stdin --path=./sub/file
printf '# case 11: sub/./* filter; --path=../sub/file\n'
printf 'dirty\n' | git hash-object -w --stdin --path=../sub/file
printf '# case 12: sub/./* filter; --path=../sub/./file\n'
printf 'dirty\n' | git hash-object -w --stdin --path=../sub/./file

# EOF



Observed output:

$ git --version
git version 2.22.GIT
$ ./git-bug-test.sh
# prefix
sub/
# reference dirty object
6e5aa7ceca195942768e6e0997c3a0271b07fffc
# reference clean object
83126302079c10762b29692dc322e430472a5360
# case 1: sub/* filter; --path=file
83126302079c10762b29692dc322e430472a5360
# case 2: sub/* filter; --path=./file
6e5aa7ceca195942768e6e0997c3a0271b07fffc
# case 3: sub/* filter; --path=sub/file
6e5aa7ceca195942768e6e0997c3a0271b07fffc
# case 4: sub/* filter; --path=./sub/file
6e5aa7ceca195942768e6e0997c3a0271b07fffc
# case 5: sub/* filter; --path=../sub/file
83126302079c10762b29692dc322e430472a5360
# case 6: sub/* filter; --path=../sub/./file
6e5aa7ceca195942768e6e0997c3a0271b07fffc
# case 7: sub/./* filter; --path=file
6e5aa7ceca195942768e6e0997c3a0271b07fffc
# case 8: sub/./* filter; --path=./file
83126302079c10762b29692dc322e430472a5360
# case 9: sub/./* filter; --path=sub/file
6e5aa7ceca195942768e6e0997c3a0271b07fffc
# case 10: sub/./* filter; --path=./sub/file
6e5aa7ceca195942768e6e0997c3a0271b07fffc
# case 11: sub/./* filter; --path=../sub/file
6e5aa7ceca195942768e6e0997c3a0271b07fffc
# case 12: sub/./* filter; --path=../sub/./file
83126302079c10762b29692dc322e430472a5360
