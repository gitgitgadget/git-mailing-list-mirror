Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA8CB1F576
	for <e@80x24.org>; Sat,  3 Mar 2018 09:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbeCCJaE (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 04:30:04 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33504 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbeCCJaD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 04:30:03 -0500
Received: by mail-qk0-f196.google.com with SMTP id f25so15031461qkm.0
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 01:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=teOzROGJ8RFnJPHI6Oi2bRctHGJT0NYgrAG/X4HVHiM=;
        b=uu47An3KE/5YBuFHZCgECAyEN7kebUJAGtYy1zvNaIYwm/TZcvZKYkZQgawi2voq8i
         F36MOqdDCAZzioPZVwSGoVQ+yD1ReKWPS4LKLOkjSiLXcudKHHrH5yOBZljxV9bYplBN
         +AuccN4qMWX/0R2iwVFV2szxR1HVBgECOPOQqkpADI09AoR20KcKNAeDYBFAEdsfbFl8
         ew7XwqXRgXq+rVLYYYGRzzG5c/l/JNj34MIfE8X5Jukzwja/VbdMnRwENadwHvk8FLgA
         V3+dHRveJVqhIuyiPOtR4JPcbCg0BiSmAM555VCQGjHEn32gkiLyifYwDJiWu2rdXXL4
         c6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=teOzROGJ8RFnJPHI6Oi2bRctHGJT0NYgrAG/X4HVHiM=;
        b=nRfzpc/VwP1Pn3jY7o5A3DiuJlDP2bAHFXwU5fV1+GSafXv6PyWKaXh2sp9nHSmoxK
         UZSVSqfzP63obqLoCc04GwPMEacG2gdRvVUm9JGGpu+4FjQXTb59iDYUo0K4v2zffm5n
         eXGXBSWRarqhhIJoFZcKgGOwNMsLBSmd6bU5/yYIc6BzcJYC30a7MfAx7J0TXFtp6KqU
         my/mljfRnY9ZEGkVdlKDZhrDTLPASTh/A0vGAyhUZjEd2Q6AxdPynLsFdpZQFSZFRudI
         zXLfMbJT0JHOQn8iXMf4XDQBz1XfmKdwKgAUH78ZcdW7t4J4yHKxFtTR0aIgpLJsZeld
         MXzA==
X-Gm-Message-State: AElRT7Hrof6H0pFC2H9IIky0tNDrc06vM3Cwte2pT4urkp8aGu5GmW83
        DBBByYaT09Kl2pP0QlJ8EujeumIs0DQHyhXsT5s=
X-Google-Smtp-Source: AG47ELvwdfgq3SN14QVT6j8w+TBORKbbJxEbjaDnqGgKmp0+a1ZIXHFGa7hF4A2yvWdM7jLYhliIEIdij4EP1gXeCHg=
X-Received: by 10.55.134.133 with SMTP id i127mr12568921qkd.275.1520069402200;
 Sat, 03 Mar 2018 01:30:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sat, 3 Mar 2018 01:30:01 -0800 (PST)
In-Reply-To: <20180303033918.15751-4-pclouds@gmail.com>
References: <20180303033918.15751-1-pclouds@gmail.com> <20180303033918.15751-4-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Mar 2018 04:30:01 -0500
X-Google-Sender-Auth: 5hJkBuvWpw1ekQbs1WnXxSQqxkE
Message-ID: <CAPig+cQG8yEqunNUjoEAPY-W9+TtzWADhgjdL6udnyrG0YEOVg@mail.gmail.com>
Subject: Re: [PATCH 3/3] worktree prune: improve prune logic when worktree is moved
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 2, 2018 at 10:39 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Worktree manual move support is actually gone in 618244e160 (worktree:
> stop supporting moving worktrees manually - 2016-01-22). Before that,
> this gitdir could be updated often when the worktree is accessed. That
> keeps the worktree from being pruned by this logic.

I had a bit of trouble digesting this paragraph. Possible rewrite:

    Automatic detection of worktree relocation by a user (via 'mv',
    for instance) was removed by 618244e160 (worktree: stop supporting
    moving worktrees manually - 2016-01-22). Prior to that,
    .git/worktrees/<tag>/gitdir was updated whenever the worktree was
    accessed in order to let the pruning logic know that the worktree
    was "active" even if it disappeared for a while (due to being
    located on removable media, for instance).

> "git worktree move" is coming so we don't really need this, but since
> it's easy to do, perhaps we could keep supporting manual worktree move a
> bit longer. Notice that when a worktree is active, the "index" file
> should be updated pretty often in common case. The logic is updated to
> check for index mtime to see if the worktree is alive.

Seems like a reasonable approximation of the pre-618244e160 way things work=
ed.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -101,6 +101,9 @@ static int prune_worktree(const char *id, struct strb=
uf *reason)
>         if (!file_exists(path)) {
>                 free(path);
>                 if (st.st_mtime <=3D expire) {

This st.st_mtime is that of 'gitdir'...

> +                       if (!stat(git_path("worktrees/%s/index", id), &st=
) &&
> +                           st.st_mtime > expire)

...and this st.st_mtime is of 'index'.

I wonder if it the 'gitdir' mtime check is really that useful anymore
considering that 'index' mtime will almost certainly be more recent.

> +                               return 0;
>                         strbuf_addf(reason, _("Removing worktrees/%s: git=
dir file points to non-existent location"), id);
>                         return 1;
