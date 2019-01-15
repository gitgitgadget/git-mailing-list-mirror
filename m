Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AF731F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 22:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733228AbfAOWYQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 17:24:16 -0500
Received: from mail-it1-f170.google.com ([209.85.166.170]:33502 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730840AbfAOWYP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 17:24:15 -0500
Received: by mail-it1-f170.google.com with SMTP id m8so2208301itk.0
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 14:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=corthon-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=oCXH9WKXQsNu72JsePsTHaCDWQYLcTkkXVwwti6kDgM=;
        b=ZTpBGDwKTTLgVIDlxccgUOGyuy4zUegy23W2Zd9qu44ApaaXGpExUQCddLIyzWgCv7
         1t2BIxaT4eqVeqOkIbwdB3s4thuHrBlL1Jdl02MlmT7Njh1H4v8OQ4lr3BkrA0wFzlrs
         3I7TmWwtPV+Y01fehrDQCEKriiKwcuKzRfL/dfoVWiBGP2hEgZTfoDCEwSx4VFPyeJ1f
         3s7soLQz0aKagWTCokHWZtrCwhpJuL63QRKMjOgX7XTgCSHxzo0kC3J36D4zg/CFSnoj
         pBef6VW+q6HOR10AoZtGNoONLTPq6GxgJuAuUQyTcDp8hF4nYSCF/y+sJb7EsE1lGpaH
         fexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=oCXH9WKXQsNu72JsePsTHaCDWQYLcTkkXVwwti6kDgM=;
        b=c93hFf9gBlhojG1bmI8l6czJ3S7m9Yqq5UN3QTfYSfpGNDy3Hza8rxhtElL2/fGb0L
         c5VKDf3+2k1P5UIVQRy1RYSAUbJTZ0o7Fr7W2CN2ss4KnqvASsuKMPEO7AwVjqIImsyQ
         1xoOzZHVO7oV+geGA6H27XdFBsp95wrTb2dEUnvBJSgOx5dhy3gipnPrjEVxeBKwLfH3
         RppJx/SzBs3xNqhj9TA3XZwWoFgiugoc2FlUlJG4teSh4GRq+tcTOwuDX44sJ3QcDXSI
         unsK0iDFSDWe0qT2HfahG7tZqxUvltKsiFabIHZsMOt8YqgCMRztZhU/JF/u5bO45Iae
         uM9g==
X-Gm-Message-State: AJcUukdvTerAl5vzLah6BSswZUVe2oSjtJOegcV0vRLX5l0eG110NBXM
        f+xfd6ni245czpJveb1UswqoxjEc/UsyQ71Pvej7eDXh
X-Google-Smtp-Source: ALg8bN50qdfHlQEVyetvvKoimuekKiXUwevNA3lqZrQhku5V8DNoqflhT8oBrHdvgtEkkAtKt+1aUtBNOAbEdZNC0SA=
X-Received: by 2002:a24:3512:: with SMTP id k18mr3757127ita.83.1547591054559;
 Tue, 15 Jan 2019 14:24:14 -0800 (PST)
MIME-Version: 1.0
From:   Bret Barkelew <bret@corthon.com>
Date:   Tue, 15 Jan 2019 14:24:03 -0800
Message-ID: <CAGTkKagdG=85CVZbumVfXHTx6zgmbD6_PHmzPx4rFpdZ+c22Gg@mail.gmail.com>
Subject: Inconsistent Behavior using 'Reference'
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The repo/workspace (not the cache, the code we=E2=80=99re going to build) t=
hat
we=E2=80=99re trying to initialize uses several submodules. We=E2=80=99ve n=
otice that
if we use =E2=80=98clone=E2=80=99 first on the parent repository, then call=
 =E2=80=98git
submodule update --init --recursive --reference <path>=E2=80=99 inside the
parent repository, the same path is passed to all child and nested
child repositories.

However, if we call =E2=80=98git clone --recurse-submodules --reference
<path>=E2=80=99 and try to clone the parent and initialize submodules in on=
e
step, Git tries to append the submodule relative path (relative to the
parent) to each of the recursive calls, and since the reference repo
is bare, this fails.

CRITICAL - Cloning repo: https://github.com/Microsoft/mu_tiano_plus.git
INFO - Cmd to run is: git clone --recurse-submodules --reference
C:\src2\mu4\mu_basecore https://github.com/Microsoft/mu_tiano_plus.git
C:\src2\mu4\mu_basecore\Common\TIANO
INFO - ------------------------------------------------
INFO - --------------Cmd Output Starting---------------
INFO - ------------------------------------------------
INFO - Cloning into 'C:\src2\mu4\mu_basecore\Common\TIANO'...
Checking out files: 100% (3858/3858), done.
INFO - Submodule 'CryptoPkg/Library/OpensslLib/openssl'
(https://github.com/openssl/openssl) registered for path
'CryptoPkg/Library/OpensslLib/openssl'
INFO - fatal: submodule 'CryptoPkg/Library/OpensslLib/openssl' cannot
add alternate: path
'C:/src2/mu4/mu_basecore/.git/modules/CryptoPkg/Library/OpensslLib/openssl/=
'
does not exist
INFO - Failed to clone 'CryptoPkg/Library/OpensslLib/openssl'. Retry schedu=
led
INFO - fatal: submodule 'CryptoPkg/Library/OpensslLib/openssl' cannot
add alternate: path
'C:/src2/mu4/mu_basecore/.git/modules/CryptoPkg/Library/OpensslLib/openssl/=
'
does not exist
INFO - Failed to clone 'CryptoPkg/Library/OpensslLib/openssl' a second
time, aborting

As you can see, the parent path is
=E2=80=98'C:\src2\mu4\mu_basecore\Common\TIANO=E2=80=99, but when clone ini=
tializes
the submodule, it updates the =E2=80=98C:\src2\mu4\mu_basecore=E2=80=99 ref=
erence to
=E2=80=98C:/src2/mu4/mu_basecore/.git/modules/CryptoPkg/Library/OpensslLib/=
openssl/=E2=80=99,
as though the reference were a full repo and it was checking for the
submodule repo within the =E2=80=98.git=E2=80=99 directory.

If we do this same thing using a =E2=80=98clone=E2=80=99 first, and =E2=80=
=98submodule update=E2=80=99
second, the same =E2=80=98C:\src2\mu4\mu_basecore=E2=80=99 reference is pas=
sed to all
submodules (AND nested submodules).

Thoughts? Are these both expected behaviors? Will they be consistent
in future versions of git?

Thanks!

- Bret Barkelew
