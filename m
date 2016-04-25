From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] How to pass Git config command line instructions to
 Submodule commands?
Date: Mon, 25 Apr 2016 10:02:53 -0700
Message-ID: <CAGZ79kYmAr-O6_Jw2KO9eZEfZQ+_WBiERF=nhOYLJCZpUjSSyA@mail.gmail.com>
References: <60724588-B06E-47E8-9302-8709C4601826@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 19:03:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aujuV-0005Cd-FN
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 19:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933115AbcDYRC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 13:02:56 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36827 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754393AbcDYRCz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 13:02:55 -0400
Received: by mail-ig0-f169.google.com with SMTP id u10so16926069igr.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 10:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=eocWAAS79YS/nx0m2k5+MKvOd6lrZhEDW3mgr7AF9qo=;
        b=Oy1JTw7WZrCGjgOFhYgGbVoRiEMcOjU/KoDAl6/+5LsB/ChkAwinUiVLdPwD3TI5lB
         HMiF4gq5e3jti2s3AhS9tQHS3ePqtWRFU01fi80O1t/NbgZfsR40GSyxB+OziPvjLkIM
         uV++jOEkAG7mmAXEsZHBZPqXHas9VxHxCs90T9NXaGiSAJcvnC9ILM0ld/enGWvSfzaW
         pJAXSpMmAx4wg6Hb39uWUx9M+LVrEZqW2P2DqesOSv5bTdEt1HzX/IjuAeCb1UPNr0wn
         IkCpn2cRVOMof+aUk7K8sN2LmZs5yoAt8dFJSDSdDtT0DIha+zLNUVdFSaLPOX2xt7bX
         W1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=eocWAAS79YS/nx0m2k5+MKvOd6lrZhEDW3mgr7AF9qo=;
        b=G6q0+nUDQZYwsVKN0ZmeMEKYui48N9BQbmg9kYAC0X3/hjdwlyZTKsATlxvYT2c9vu
         u6KJvIh7Am9CalBnW4rX3n4neHafWYgE3XHs+S3uiMepMwceacyOqihBQvtM3I2SxQNo
         Gw+5MSpWT/5Ryk8FkPvn4/MdV8YbUMm0p8OXz4puLiej8mJMYzagGrLKaftK7SixjtB3
         yvjqdRE/vE3ZwF3K8rTMvcnKhF/wUwoo9ICBjB7nBO0uBCCuSrLiDQwLkStoSGz36RSr
         EChLwR5EKKqTaH3w1BNLr71ThMxSg06mJOHHrgM/Cvy3ucY+WeE+Ta4kMqODxaS3n92d
         3cfg==
X-Gm-Message-State: AOPr4FUZnC2KS0qdzwm0sNn0i9TdA2a36Ku2KGgJn+9ae0BQoeW/g92RYilpoB1FjFqUC9VYzq3zQJ0SpVENF9+o
X-Received: by 10.50.111.15 with SMTP id ie15mr14365638igb.94.1461603773827;
 Mon, 25 Apr 2016 10:02:53 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 25 Apr 2016 10:02:53 -0700 (PDT)
In-Reply-To: <60724588-B06E-47E8-9302-8709C4601826@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292524>

On Mon, Apr 25, 2016 at 3:39 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> Hi,
>
> a few folks from the Git LFS project and I try to make cloning of repositories
> with a lot of LFS files faster.
>
> The core problem is that Git LFS uses a Git smudge filter to replace LFS
> pointers with the actual file content. Right now, a smudge filter can only
> be executed on an individual file which makes the operation slow for many
> files [1].
>
> We solved this issue by temporarily disabling the smudge filter for the clone
> command via Git config (optimized in 1a8630 [2]):
>
>     git -c filter.lfs.smudge= -c filter.lfs.required=false clone <url> <path>
>
> Afterwards Git LFS runs a special command to download and replace all LFS
> content in bulk [3]. This works great for LFS repositories.
>
> However, I noticed that git config command line instructions such as
> "-c filter.lfs.smudge=" are not passed to Git submodule operations. Thus
> this does not work as expected:
>
>     git -c filter.lfs.smudge= -c filter.lfs.required=false clone --recursive <url> <path>

I have cc'd Jacob Keller, who authored origin/jk/submodule-c-credential,
which does work in that area (deciding which config option to pass down
into the submodule commands).

>
> I tried to work around that by copying the relevant pieced from the Git
> Submodule command [4] and applying the command line Git config
> manually (look closely at the modified checkout command):
>
>     git -c filter.lfs.smudge= -c filter.lfs.required=false clone $@
>     if [[ -z $2 ]]; then
>         CLONE_PATH=$(basename ${1%.git});
>     else
>         CLONE_PATH=$2;
>     fi
>     pushd "$CLONE_PATH"
>         git submodule init
>         wt_prefix=$(git rev-parse --show-prefix)
>         git submodule--helper list --prefix "$wt_prefix" | {
>             while read mode sha1 stage sm_path
>             do
>                 name=$(git submodule--helper name "$sm_path") || exit
>                 url=$(git config submodule."$name".url)
>                 if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
>                 then
>                     git submodule--helper clone --prefix "$wt_prefix" --path "$sm_path" --name "$name" --url "$url"

The init and then clone should be covered by
"git submodule--helper update-clone", which may be better named as
"list-and-clone-if-necessary", then you get parallel cloning for free
as well. ;)

>                     pushd "$sm_path"
>                         git -c filter.lfs.smudge= -c filter.lfs.required=false checkout -q $sha1 || exit
>                         git-lfs pull || exit
>                     popd
>                 fi
>             done
>         }
>     popd
>
> Do you see an easier way to pass command line Git config instructions to the
> underlaying Git Submodule commands? If not, do you think a patch adding this
> would be worth working on?

I would build on top of origin/jk/submodule-c-credential at least, and using
"git submodule--helper update-clone" (origin/sb/submodule-parallel-update)

>
> I also started a discussion about that on the Git LFS issue page [5].

Unrelated to this, but about LFS:
Currently it is only possible to store the big blobs at a $VENDOR hosting site.
How would you backup you whole repository including all binariers?

I think we should add an option to store one blob in a dedicated ref
(refs/lfs/$blobsha1 or such). That way you can make a backup of the
repository including all large files using "git clone --mirror" and
you don't have
to rely on the $VENDOR hosting your files.

Thanks,
Stefan

>
> Thanks,
> Lars
>
>
> [1] https://github.com/github/git-lfs/issues/931
> [2] https://github.com/git/git/commit/1a8630dc3b1cc6f1361a4e5d94630133c24c97d9
> [3] https://developer.atlassian.com/blog/2016/04/git-lfs-12-clone-faster/
> [4] https://github.com/git/git/blob/6a6636270fbaf74609cd3e1bd207dd2c420d640a/git-submodule.sh#L686-L731
> [5] https://github.com/github/git-lfs/issues/1172
>
