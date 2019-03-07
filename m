Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C649720248
	for <e@80x24.org>; Thu,  7 Mar 2019 11:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfCGLHd (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 06:07:33 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:44818 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfCGLHd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 06:07:33 -0500
Received: by mail-qk1-f173.google.com with SMTP id r21so8713788qkl.11
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 03:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=SGYCtMI1mg3LKFIr8g+KZUKAxEp4+iRB+nLrSxuVH+c=;
        b=G4G6KAMkvMSgQOLC3GksiAi3kFMGxSDH0KZL6tzl5F3MqUeNr/ih5GklMNzCo5cs9+
         z5Mhxf4zG/i8/yztGsDJ/PVIDNUXFkMi6qGrSyl5zUY1zWoMYy+X5G0huUqTKn6Y5yAF
         RiaV/qJ+z1mrcWKNj2i5O70kYpU1OCV3SpuHHQBJ8INoiS+zoK5s3x9ugk87eNfKg7PN
         L5gJg98sGTiuynYyO5DJ1B8RCvVNLORD24njtN/0mymjBU79kg6fKXXRE20Nmp829NzB
         0BAKa+Oay1EC8ab0d14gA3JOQR2N/gBVFZv3GKScbOvD58Cdz1qVLyu9Cy0MpkrvHHG+
         PONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=SGYCtMI1mg3LKFIr8g+KZUKAxEp4+iRB+nLrSxuVH+c=;
        b=JEC8rCUHTleOVZKgMZ5HREfmZ1PSW0CPfAE0N6veYjscoX32w8XCs3VFJyvo9o0MQt
         mjwWa3O72NE58DaDToLDs9TxKCE82X4njasEdxs8gqoSQyKIJnYRnyWvL41S/IncHV8a
         sNPl3FlE7QnjKzhsV9lmJmNL3DPQinAfIfqKTJrM+7+zSi/tTWMJLvee9ZSSHVD7yh/y
         tKo1+13w+NyqRySS3AVcVr7MydVZiJvjoJLx8gU9RW+p532yj33QHcxXKBPF39Xn/lmE
         eLY718bVnvZ8CS1NEIc82lk0024Cvb0+ueiGWZByqCxQK4/F7e5xQMDxRDKv7jFiccDy
         YCtQ==
X-Gm-Message-State: APjAAAWPR/vVq+IuT4c/andq6fjiLU5K1sGphjs6RfIxqVhMfTyri1ip
        Ki/Ohe6FlbCqvvl14uEG/ChxPw9gJhzHC5lJPk9znP+m
X-Google-Smtp-Source: APXvYqzT6f1DkobR4wOqs4PwJK08xdZ/H1oo9WUubHyqc6oMZA5mfDI4oxwgU5sxmybsUCQn7QK7ddAmGH5vvHIn+6Q=
X-Received: by 2002:a37:3087:: with SMTP id w129mr8921197qkw.255.1551956852360;
 Thu, 07 Mar 2019 03:07:32 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Jesper_R=C3=B8nn=2DJensen?= <jesperrr@gmail.com>
Date:   Thu, 7 Mar 2019 12:07:21 +0100
Message-ID: <CAL-rKu6AcyHdrCsVikwQxTgKHgtV86+BeHOv_sTSu-jvwME75Q@mail.gmail.com>
Subject: Error fetching submodule from submodule
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi I think I may have found an error in the way git handles a
submodule's submodule. Read further for the example (extracted from a
real project).

* I have a main repository which has some submodules defined.
* One of the submodules is a common submodule which is also included
in one of the other submodules
* When running `git fetch --recurse-submodules` I get an error.

The error is "Could not access submodule 'common_submodule'"

```
$ git --version
git version 2.21.0
```

I created the following script to show (using Git-extras `git create`
to simplify):


```
#!/usr/bin/env bash

if [ "$FORCE" =3D 'true' ]; then
  rm -rf submodule_experiment
fi

if [ -e submodule_experiment ]; then
  echo FATAL: folder submodule_experiment must not exist. Remove with FORCE=
=3Dtrue
  exit 9
fi

mkdir submodule_experiment
pushd submodule_experiment

git setup common_submodule
pushd common_submodule
echo 'common file' > common.txt
git add common.txt
git commit -m 'a file in the common submodule'

popd

git setup other_submodule
pushd other_submodule
git submodule add ../common_submodule
git commit -m 'added submodule to other_submodule'

popd

git setup main_repos
pushd main_repos
git submodule add ../common_submodule
git commit -m 'added submodule to main_repos'

git submodule add ../other_submodule
git commit -m 'added other_submodule to main_repos'


# This line fails with error code 1 "Could not access submodule
'common_submodule'"
git fetch --recurse-submodules

```

Question:
Is this a bug in Git or am I declaring the common submodule in an incorrect=
 way?


--=20

Jesper R=C3=B8nn-Jensen
Nine A/S
Mobile: +45 2989 1822
Blog http://justaddwater.dk/
jesperrr@gmail.com (Private e-mail and Google Talk IM)
