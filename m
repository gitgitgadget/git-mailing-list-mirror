Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28537C77B7A
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 08:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjFAIfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 04:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjFAIeS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 04:34:18 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4BC10E2
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 01:32:41 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96fdc081cb3so68098166b.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 01:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1685608358; x=1688200358;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMPaT7b+oNqsoJQI+05kmHoXZ5M3NTPDIkbZx9xPf/E=;
        b=eNRSvMfkzUj6srkgBs5PvlbsRD0ojZ6IYLhUsPURa+xnUlfeNxhY0LR4tiDrac9R2m
         hqiMwVpuUsnKxpZ6+oq/GlshsRCp6gKeBa8NlzShbFVoIHlDAw8ZkudVjEmr52CBmsCF
         BIHgRWtHZeqdzIg+SuSTg0AQfFMBEwMsvi8r8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685608358; x=1688200358;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMPaT7b+oNqsoJQI+05kmHoXZ5M3NTPDIkbZx9xPf/E=;
        b=CbvSkLP4OPSF8uVkYrHeNU1/y3PKVjlntt6sWnh3ki7nGiJf9odmIzIPJRiftO+y+x
         lOjOfYw/IlXy7Kbya3cYIAcIuUM/JSw5ntwGfvvZ0zwlxk7louU/7YWJ9J9vtyQ0bwnn
         dUNiUiOSI96M8NUIl9AhhgDCrkhFtANIMxl2D0gP7L/OPacTPcPWqKhwLPF8DGmZNBHc
         3TO0lHCkyagq5H+9Dse3G/UWfv8vfyTjUBkc5WwNvVyp+UN3LZ2Gce+rkMPeoMzBWuDU
         hQ0FScc0HM6cDYxeKtRJox0hc+Vxijm+9id3epzhKw8e721mU6FrjVKpnoo8nljxEyr0
         W/2g==
X-Gm-Message-State: AC+VfDxTvLyxNDdMzOfqOzXupvyNyde5saiXrJM8lRH3OSN9oc1fhqrz
        14gGsKSv6+ftsQGluGsCGu3RXwoXkZ9RurxW2PuluQjzLDTG0d0rarr/Ag==
X-Google-Smtp-Source: ACHHUZ4F6zvZ0VU4NzEhbk9NtnIMZQIO3TumiKRPo/hnhuG6/kITPbD7jPznyjTwf78mlgWWeOrVgFmo5fbChRoOzfI=
X-Received: by 2002:a17:906:d553:b0:973:9857:b98a with SMTP id
 cr19-20020a170906d55300b009739857b98amr8764635ejc.55.1685608358283; Thu, 01
 Jun 2023 01:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpohHo2co7n_NjD9XntBs3DVU91Rqx8dmRrSWg=1eof+Rhw@mail.gmail.com>
In-Reply-To: <CAPMMpohHo2co7n_NjD9XntBs3DVU91Rqx8dmRrSWg=1eof+Rhw@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 1 Jun 2023 10:32:23 +0200
Message-ID: <CAPMMpoi9vy1xyvpAHE6qCwgazLSg=u4rR9eX098Gf9VL60XSOg@mail.gmail.com>
Subject: Re: When someone creates a new worktree by copying an existing one
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2023 at 8:59=E2=80=AFPM Tao Klerks <tao@klerks.biz> wrote:
>
> I think I can implement something reasonably effective with a pair of
> hooks (pre-commit and post-checkout look like good candidates), but
> I'm weirded out that something like this should need to be "custom".
>

FWIW, here's what that code has ended up looking like, in
post-checkout and pre-commit:

########################################################################
# WORKTREE GIT FILE PATH TO REPO WORKTREE GITDIR FILE PATH CONSISTENCY #
########################################################################
# (this code is duplicated across pre-commit and post-checkout)

WORKTREE_GIT_FILE_PATH=3D"$PWD/.git"
GITDIR_PREFIX=3D"gitdir: "
# Only run worktree consistency checks if it's a worktree - if .git is a fi=
le
if [[ -f "$WORKTREE_GIT_FILE_PATH" ]]; then
  WORKTREE_GIT_FILE_CONTENT=3D$(head -n 1 "$WORKTREE_GIT_FILE_PATH")
  WORKTREE_METADATA_FOLDER_PATH=3D${WORKTREE_GIT_FILE_CONTENT#"$GITDIR_PREF=
IX"}
  WORKTREE_GITDIR_FILE_PATH=3D"$WORKTREE_METADATA_FOLDER_PATH/gitdir"
  # if the gitdir file doesn't exist, git will complain loudly, no
need to interfere.
  if [[ -f "$WORKTREE_GITDIR_FILE_PATH" ]]; then
    WORKTREE_GITDIR_PATH=3D$(head -n 1 "$WORKTREE_GITDIR_FILE_PATH")
    # if the gitdir value doesn't match this worktree's git file path,
we have a problem.
    if ! [[ "$WORKTREE_GIT_FILE_PATH" -ef "$WORKTREE_GITDIR_PATH" ]]; then
      >&2 echo ""
      >&2 echo "***********************************************************=
*******************"
      >&2 echo "* WARNING: It looks like this worktree has moved or
been copied incorrectly! *"
      >&2 echo "***********************************************************=
*******************"
      >&2 echo ""
      >&2 echo "The git repo expects this worktree to be at:
$(realpath "$(dirname "$WORKTREE_GITDIR_PATH")")"
      >&2 echo ""
      >&2 echo "However, it is at: $(realpath "$(dirname
"$WORKTREE_GIT_FILE_PATH")")"
      >&2 echo ""
      >&2 echo "If you copied an existing worktree to create this one,
then the two worktrees"
      >&2 echo "will be badly 'linked', with changes in one affecting
the other. To resolve this,"
      >&2 echo "please delete one of the two, and run 'git worktree
repair' in the remaining one."
      >&2 echo "You can then properly create a new worktree using 'git
worktree add'. You"
      >&2 echo "should delete whichever worktree doesn't contain
uncommitted changes you"
      >&2 echo "want to keep, of course."
      >&2 echo ""
      >&2 echo "If you simply moved/renamed this worktree, then run
'git worktree repair' to"
      >&2 echo "make the git repo and worktree 'match up' again, and
resolve this warning."
      >&2 echo ""
      >&2 echo "***********************************************************=
*******************"
      >&2 echo ""
      # in post-checkout this exit code won't change git's behavior,
but git still "echoes" it to
      # the calling program, so it's still a useful signal that
something went wrong - which is
      # warranted under the circumstances.
      exit 1
    fi
  fi
fi
