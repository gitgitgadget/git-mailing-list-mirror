Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D217C35240
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5DB2082E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meBXFbLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgA3P0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:26:10 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:42063 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgA3P0J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 10:26:09 -0500
Received: by mail-wr1-f46.google.com with SMTP id k11so4526680wrd.9
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 07:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=zvo6GoE+SISQk+EgNXEY/4ZTkvlsZIi4Jj5ehddhE0g=;
        b=meBXFbLGlsNaUPrUZSrDXtHVj7x5+fVY8sLyrhuAR9SutAzmgPDx32AsmNJikGIoys
         c6T4qp4n1VqU5vnMv1S97QS7SIqTpBcvf9m0rZ8+lncaArk4flr9zxa+qa8W7LTXjD0d
         inot1q1+q9AtA9ceQzpX4O8Yd5gpajVPMaFeEpFhaetXzUdQn9us2IS0BKaPom21Y8Y6
         H5NB26BnMuGl7ZXxJjYV4f2tvDfNp/87MDY9SAW5QDg8XQJt/8nvbLfSRohqqi25p6z8
         eFWzwto0z0IeL02DhhCSC2T6JfvOol+0skw3MJm6hJ4b5oxFUNRaWO+ZerbT5HVc+8kV
         g1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=zvo6GoE+SISQk+EgNXEY/4ZTkvlsZIi4Jj5ehddhE0g=;
        b=Xwt/QK62XJoyufbgGDdztOf+9Jp/dE6W764by1vQ9/eKhbZJZXg78LCYPpmb6U96I9
         g3Be1ai1YVnnw9iFrOt9pP5l3dWRM9I03Ef4BFebbDKlo5XySqf60h0WGpWqBW7G1Wf4
         fxP6dc5IdaEhq3SWOVISdKqtwcRDwobYeISV0+I5GQWsnHa5vwWe8s5i7BEYpx9PhJUa
         ZkdVIOK48ZPok4AheuGhU6pmIj6XD5sjQYRDWbeBRyOZecBeuhKQ/RqrSg8FUz6KhkI0
         Y+3o/jyXriPGErJIffXfPB1GhlOzcVq8baW4e/wR184AZ8ri18PArpLdYrwQtklwkDkp
         nB/A==
X-Gm-Message-State: APjAAAWaF4BR/k17F/IKmjnlUayYCyUUBmDFmKzz/I/m+c3kekxEEXsS
        zeyGeQCP4M+nTt6jjmNIHjJyWW8iL/Fg4ARHZOvjkFsF
X-Google-Smtp-Source: APXvYqzSXWOZhfrprBaTvOjAgA8qR1hI+TtvNolG8laxxgdeUVTpLDbESkx3EwZ7rPj6kWr/uWUyMvfuvBbNgVixUI4=
X-Received: by 2002:a5d:6802:: with SMTP id w2mr6082988wru.353.1580397968020;
 Thu, 30 Jan 2020 07:26:08 -0800 (PST)
MIME-Version: 1.0
Reply-To: finnbryant@gmail.com
From:   Finn Bryant <finnbryant@gmail.com>
Date:   Thu, 30 Jan 2020 15:25:56 +0000
Message-ID: <CADSBhNbbO=aq-Oo2MpzDMN2VAX4m6f9Jb-eCtVVX1NfWKE9zJw@mail.gmail.com>
Subject: Sparse checkout inconsistency with non-folder paths between cone mode
 and full matching (2.5.0)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

With cone mode enabled for a sparse checkout, a pattern like the
following is accepted:

/*
!/*/
/a_file_or_folder/

As the name suggests, a_file_or_folder might be a file, or might be a
directory. If it's a directory, then this is a "valid" recursive match
for the directory and everything works as expected.
But if the path leads to an ordinary file, it appears that cone mode
will *exclude* the file from the worktree (ie, it'll have the
skip-worktree flag set).
This seems bizarre and unexpected behaviour.

My suspicion is that cone mode is supposed to be a pure subset of full
pattern matching, such that if cone mode is ever disabled, the
sparseness of the worktree will be unchanged. Clearly, this scenario
is breaking that pattern.

I think the correct behaviour is that recursive matches for a
potential directory do not have any effect on a non-directory file
with the same name. Alternatively, you could forbid any patterns which
match non-directory files instead (and downgrade to full pattern
matching), though I'd not be a fan of this, since it'd mean the
validity of a cone-mode sparse configuration file is dependent on the
contents of the repo, and is thus much harder to ascertain (scripts
can't simply prove if it's a valid cone mode file by parsing it,
they'd need to have access to any repo it may be applied to, and
inspect the type of any matching file/folder paths, and its validity
could be changed simply by replacing a folder with a file in the
repo).

If matching behaviour with full pattern mode is a non-goal for cone
mode, I'd still question the logic of this behaviour, though I suppose
it does have the benefit of (accidentally?) adding support for
excluding individual files from a sparse checkout, which I imagine
some could find useful. Personally I'd prefer that was instead added
with a more sane syntax, if needed.

Full test case:

$ git init test_repo
Initialized empty Git repository in [path]/test_repo/.git/
$ cd test_repo/
$ touch some_file a_file_or_folder
$ git add some_file a_file_or_folder
$ git commit -m "some files"
[master (root-commit) 80d5918] some files
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 a_file_or_folder
 create mode 100644 some_file
$ git sparse-checkout init --cone
$ git read-tree -mu HEAD
$ ls -1
a_file_or_folder
some_file
$ git sparse-checkout set a_file_or_folder
$ git read-tree -mu HEAD
$ ls -1
some_file
$ cat .git/info/sparse-checkout
/*
!/*/
/a_file_or_folder/
$


Right now I'm trying to integrate cone mode with my company's existing
manifest infrastructure, which doesn't differentiate between files and
folders, so this is forcing me to perform a lot of repo checks to
confirm we aren't accidentally excluding files we were supposed to
include. Just in case you needed another example of why this behaviour
is unhelpful.
