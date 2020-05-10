Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE935C38A2A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 12:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8673A20820
	for <git@archiver.kernel.org>; Sun, 10 May 2020 12:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="CG+zRz7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgEJMDY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 08:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728071AbgEJMDY (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 May 2020 08:03:24 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9159FC061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 05:03:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w19so722097wmc.1
        for <git@vger.kernel.org>; Sun, 10 May 2020 05:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTkoVOZRfqRTUOIlcunJaJjD1b58Ffll1XD2/Gy4se8=;
        b=CG+zRz7/3kpTS61mc7/9s8ggBLHJk/oK0jPi9mNbMiSRH1pj3l5ZahmR30WkZbwW1/
         v3koos7dx63gftp34HbHgPD3UAYfFJF5zWhtcUdHmSh2tQalmX/BPtoNPhv0BhbqSZ5B
         sIXbaLqg5AJlLA0SdHCBOfi5zRBR2LBRSMj0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTkoVOZRfqRTUOIlcunJaJjD1b58Ffll1XD2/Gy4se8=;
        b=Rveyaer3sq06EgyZd8jVg8Qm6ORvNlbuPZ0GvKBijbe0GlG1XS3M6IQdh87swjSQQu
         +FmJs5DhXFtxo7M4arvlWTzAmYmftts3JgkJbiwnChyQx2gu1jmmeR5lY9O9YFBafyh4
         QSM2kXD8FvFi4X4lKJOIw2lo9sPVzLBpui00y5kWD7DnFdW6ddCxuSRXbbBxB632brcW
         AOGp6D6jSwT1rBkYZLkKZmmc0iiwWY/NNHnW4YuTHAChbFfDvCssj1TFw3GB3h28mEFt
         MaP2C8IUGH0r26UjDwlpsVkDIbbBPVDeE5Oo9nP/xswFws21yKZzNSyiCGGZzDC2BRl+
         4Qyw==
X-Gm-Message-State: AGi0PuYer5piBFFVhj6vcshQpz6nfvRwmW9+LzFLl5JfWIJcMRiragtU
        6l7e+Cd2xjg9EdpDEvgavfgSdloCkrwua4M9T13M6A==
X-Google-Smtp-Source: APiQypJepCfIad1SadI4NZqXM3wl5ioEK/YZz5eTCzZrIKEcoIXGvMlhb4W8TrnHWVgjlz+1rJPPDKPVRLRXijQyEhE=
X-Received: by 2002:a7b:c205:: with SMTP id x5mr3810446wmi.135.1589112202090;
 Sun, 10 May 2020 05:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200510101650.50583-1-andrew@adoakley.name>
In-Reply-To: <20200510101650.50583-1-andrew@adoakley.name>
From:   Luke Diamand <luke@diamand.org>
Date:   Sun, 10 May 2020 13:03:11 +0100
Message-ID: <CAE5ih793qKyOSE-hkOw7+nFmM3XTRxxrXv0FD2+WWXjGbVHkoQ@mail.gmail.com>
Subject: Re: [PATCH v3] git-p4: recover from inconsistent perforce history
To:     Andrew Oakley <andrew@adoakley.name>
Cc:     Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 10 May 2020 at 11:17, Andrew Oakley <andrew@adoakley.name> wrote:
>
> Perforce allows you commit files and directories with the same name, so
> you could have files //depot/foo and //depot/foo/bar both checked in.  A
> p4 sync of a repository in this state fails.  Deleting one of the files
> recovers the repository.
>
> When this happens we want git-p4 to recover in the same way as perforce.

Looks good to me.

Perforce changed their server to reject this kind of thing in the
2017.1 version:

    Bugs fixed in 2017.1
    #1489051 (Job #2170) **
       Submitting a file with the same name as an existing depot
       directory path (or vice versa) will now be rejected.

(Of course people will still have damaged repos even today).

I tried your test with both the 2015.1 and the 2020.1 versions, and it
worked in both cases - shouldn't it be impossible to get into the
state that git-p4 now recovers from with a newer p4d?

Luke


>
>
> Signed-off-by: Andrew Oakley <andrew@adoakley.name>
> ---
>  git-p4.py                      | 43 ++++++++++++++++++++-
>  t/t9834-git-p4-file-dir-bug.sh | 70 ++++++++++++++++++++++++++++++++++
>  2 files changed, 111 insertions(+), 2 deletions(-)
>  create mode 100755 t/t9834-git-p4-file-dir-bug.sh
>
> diff --git a/git-p4.py b/git-p4.py
> index b8b2a1679e..d551efb0dd 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -3214,6 +3214,42 @@ def hasBranchPrefix(self, path):
>              print('Ignoring file outside of prefix: {0}'.format(path))
>          return hasPrefix
>
> +    def findShadowedFiles(self, files, change):
> +        # Perforce allows you commit files and directories with the same name,
> +        # so you could have files //depot/foo and //depot/foo/bar both checked
> +        # in.  A p4 sync of a repository in this state fails.  Deleting one of
> +        # the files recovers the repository.
> +        #
> +        # Git will not allow the broken state to exist and only the most recent
> +        # of the conflicting names is left in the repository.  When one of the
> +        # conflicting files is deleted we need to re-add the other one to make
> +        # sure the git repository recovers in the same way as perforce.
> +        deleted = [f for f in files if f['action'] in self.delete_actions]
> +        to_check = set()
> +        for f in deleted:
> +            path = decode_path(f['path'])
> +            to_check.add(path + '/...')
> +            while True:
> +                path = path.rsplit("/", 1)[0]
> +                if path == "/" or path in to_check:
> +                    break
> +                to_check.add(path)
> +        to_check = ['%s@%s' % (wildcard_encode(p), change) for p in to_check
> +            if self.hasBranchPrefix(p)]
> +        if to_check:
> +            stat_result = p4CmdList(["-x", "-", "fstat", "-T",
> +                "depotFile,headAction,headRev,headType"], stdin=to_check)
> +            for record in stat_result:
> +                if record['code'] != 'stat':
> +                    continue
> +                if record['headAction'] in self.delete_actions:
> +                    continue
> +                files.append({
> +                    'action': 'add',
> +                    'path': record['depotFile'],
> +                    'rev': record['headRev'],
> +                    'type': record['headType']})
> +
>      def commit(self, details, files, branch, parent = "", allow_empty=False):
>          epoch = details["time"]
>          author = details["user"]
> @@ -3222,11 +3258,14 @@ def commit(self, details, files, branch, parent = "", allow_empty=False):
>          if self.verbose:
>              print('commit into {0}'.format(branch))
>
> +        files = [f for f in files
> +            if self.hasBranchPrefix(decode_path(f['path']))]
> +        self.findShadowedFiles(files, details['change'])
> +
>          if self.clientSpecDirs:
>              self.clientSpecDirs.update_client_spec_path_cache(files)
>
> -        files = [f for (f, path) in ((f, decode_path(f['path'])) for f in files)
> -            if self.inClientSpec(path) and self.hasBranchPrefix(path)]
> +        files = [f for f in files if self.inClientSpec(decode_path(f['path']))]
>
>          if gitConfigBool('git-p4.keepEmptyCommits'):
>              allow_empty = True
> diff --git a/t/t9834-git-p4-file-dir-bug.sh b/t/t9834-git-p4-file-dir-bug.sh
> new file mode 100755
> index 0000000000..031e1f8668
> --- /dev/null
> +++ b/t/t9834-git-p4-file-dir-bug.sh
> @@ -0,0 +1,70 @@
> +#!/bin/sh
> +
> +test_description='git p4 directory/file bug handling
> +
> +This test creates files and directories with the same name in perforce and
> +checks that git-p4 recovers from the error at the same time as the perforce
> +repository.'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> +       start_p4d &&
> +       test_might_fail p4 configure set submit.collision.check=0
> +'
> +
> +test_expect_success 'init depot' '
> +       (
> +               cd "$cli" &&
> +
> +               touch add_file_add_dir_del_file add_file_add_dir_del_dir &&
> +               p4 add add_file_add_dir_del_file add_file_add_dir_del_dir &&
> +               mkdir add_dir_add_file_del_file add_dir_add_file_del_dir &&
> +               touch add_dir_add_file_del_file/file add_dir_add_file_del_dir/file &&
> +               p4 add add_dir_add_file_del_file/file add_dir_add_file_del_dir/file &&
> +               p4 submit -d "add initial" &&
> +
> +               rm -f add_file_add_dir_del_file add_file_add_dir_del_dir &&
> +               mkdir add_file_add_dir_del_file add_file_add_dir_del_dir &&
> +               touch add_file_add_dir_del_file/file add_file_add_dir_del_dir/file &&
> +               p4 add add_file_add_dir_del_file/file add_file_add_dir_del_dir/file &&
> +               rm -rf add_dir_add_file_del_file add_dir_add_file_del_dir &&
> +               touch add_dir_add_file_del_file add_dir_add_file_del_dir &&
> +               p4 add add_dir_add_file_del_file add_dir_add_file_del_dir &&
> +               p4 submit -d "add conflicting" &&
> +
> +               p4 delete -k add_file_add_dir_del_file &&
> +               p4 delete -k add_file_add_dir_del_dir/file &&
> +               p4 delete -k add_dir_add_file_del_file &&
> +               p4 delete -k add_dir_add_file_del_dir/file &&
> +               p4 submit -d "delete conflicting" &&
> +
> +               p4 delete -k "add_file_add_dir_del_file/file" &&
> +               p4 delete -k "add_file_add_dir_del_dir" &&
> +               p4 delete -k "add_dir_add_file_del_file/file" &&
> +               p4 delete -k "add_dir_add_file_del_dir" &&
> +               p4 submit -d "delete remaining"
> +       )
> +'
> +
> +test_expect_success 'clone with git-p4' '
> +       git p4 clone --dest="$git" //depot/@1,3
> +'
> +
> +test_expect_success 'check contents' '
> +       test_path_is_dir "$git/add_file_add_dir_del_file" &&
> +       test_path_is_file "$git/add_file_add_dir_del_dir" &&
> +       test_path_is_dir "$git/add_dir_add_file_del_file" &&
> +       test_path_is_file "$git/add_dir_add_file_del_dir"
> +'
> +
> +test_expect_success 'rebase and check empty' '
> +       git -C "$git" p4 rebase &&
> +
> +       test_path_is_missing "$git/add_file_add_dir_del_file" &&
> +       test_path_is_missing "$git/add_file_add_dir_del_dir" &&
> +       test_path_is_missing "$git/add_dir_add_file_del_file" &&
> +       test_path_is_missing "$git/add_dir_add_file_del_dir"
> +'
> +
> +test_done
> --
> 2.24.1
>
