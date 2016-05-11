From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 12/13] worktree.c: check whether branch is bisected in
 another worktree
Date: Wed, 11 May 2016 01:45:05 -0400
Message-ID: <CAPig+cTor7CaYDomyocA+GMGc9Jpye1MRfN_Mhtv1JALsn+w0Q@mail.gmail.com>
References: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
	<1461330096-21783-1-git-send-email-pclouds@gmail.com>
	<1461330096-21783-13-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 07:45:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0MxU-0004AN-E4
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 07:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbcEKFpI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2016 01:45:08 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36747 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbcEKFpH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2016 01:45:07 -0400
Received: by mail-io0-f194.google.com with SMTP id k129so4385784iof.3
        for <git@vger.kernel.org>; Tue, 10 May 2016 22:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=DXjIl0MNI64QXfJQB24Bk8SoGbyooKx9SH/UQO1paxY=;
        b=PatHnKNMJLcvbgjskswHf397w6m00ZDRfB4OUtBj9RxL/YBYS4S5m+6e5fydpVSOFz
         kLODKui9G6VnnHSCil83J4bC+0F60heV+RN+mRo/NSscgmZC7eexR3SHgogW8Tcm6YOB
         OzTSMb5uKt3zRRppzwU0pQ3jalZRsie0Nm/K29Yx0CMVT2CM17YGOUL7bLJ+P0JKg9Cc
         jAsKsp+wvPt/BzFlr9E0dPn0tiA2NVVzMzEvyIPoMixRJB/j6AtQHOail0CbggcQ4t3e
         RhRf4qaQLFoTPDYa8IV4QIuDcHEjAri4HeonoGSwPl7WhciDMOxQgSR5mCO4IUqGCOoP
         f74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=DXjIl0MNI64QXfJQB24Bk8SoGbyooKx9SH/UQO1paxY=;
        b=VAmeYWpGt9T20GgIkFfgrq+2OTaX+/DyHJfEhiB1lNpfuqVMFM0W906cYYXp4YqRM0
         7r+IG/XD9gtRrKYjLY8DNwYqAUiQR104UfxPhI3G12nti8uuLLvQd3uO+JdP8taa3T7m
         rybwnCbzdUfGmSq4f1cKnVEAnMnFsMmPobtdkNSoB1MGk8qLdBWshZ8Gblps3bvEBGZi
         H30uMMd4YL3sUzkLQCPBlR3Aey9OynFpumu0742Mv7rw4YfMFDsjod4K0pz9ZFuwCjlh
         //uDmUt49yKz78gPIjAQxlKKaAL7McGKXdsyAxoAvOnC2wG7C9axqo/Vcpa+WXTRsntc
         0Gsg==
X-Gm-Message-State: AOPr4FWYvGQ28drkqY+9mtW240623ob7u450KYTPjV5Ytspx9iyn4+7GvUNX6Map+t/nGzjDlcxl93oOgafvAg==
X-Received: by 10.36.31.65 with SMTP id d62mr872457itd.84.1462945505947; Tue,
 10 May 2016 22:45:05 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 10 May 2016 22:45:05 -0700 (PDT)
In-Reply-To: <1461330096-21783-13-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: ouOxIJ7D1GjIUDWcyyXpONJ8-1k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294227>

On Fri, Apr 22, 2016 at 9:01 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Similar to the rebase case, we want to detect if "HEAD" in some workt=
ree
> is being bisected because
>
> 1) we do not want to checkout this branch in another worktree, after
>    bisect is done it will want to go back to this branch
>
> 2) we do not want to delete the branch is either or git bisect will
>    fail to return to the (long gone) branch

I'm very far behind with my reviews and I see that this series is
already in 'next', so perhaps these comments are too late...

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> @@ -263,4 +263,17 @@ test_expect_success 'check out from current work=
tree branch ok' '
> +test_expect_success 'checkout a branch under bisect' '
> +       git worktree add under-bisect &&
> +       (
> +               cd under-bisect &&
> +               git bisect start &&
> +               git bisect bad &&
> +               git bisect good HEAD~2 &&
> +               git worktree list | grep "under-bisect.*detached HEAD=
" &&
> +               test_must_fail git worktree add new-bisect under-bise=
ct &&

Nit: I realize that the checking 'worktree add' is sufficient, but
it's a bit confusing to read in the commit message about how deleting
the branch would be bad, but then see it testing only 'add'.

> +               ! test -d new-bisect
> +       )
> +'
> diff --git a/worktree.c b/worktree.c
> @@ -234,6 +234,21 @@ static int is_worktree_being_rebased(const struc=
t worktree *wt,
> +static int is_worktree_being_bisected(const struct worktree *wt,
> +                                     const char *target)
> +{
> +       struct wt_status_state state;
> +       int found_rebase;

s/rebase/bisect/ perhaps?

> +       memset(&state, 0, sizeof(state));
> +       found_rebase =3D wt_status_check_bisect(wt, &state) &&
> +               state.branch &&
> +               starts_with(target, "refs/heads/") &&
> +               !strcmp(state.branch, target + strlen("refs/heads/"))=
;
> +       free(state.branch);
> +       return found_rebase;
> +}
