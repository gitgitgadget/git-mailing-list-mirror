From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] worktree: don't use C99 feature
Date: Wed, 23 Sep 2015 08:01:25 -0700
Message-ID: <xmqq1tdpyybe.fsf@gitster.mtv.corp.google.com>
References: <56027FDC.1070905@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: GIT Mailing-list <git@vger.kernel.org>, rappazzo@gmail.com
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 17:01:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZelY4-0002E2-Vz
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 17:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170AbbIWPB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 11:01:28 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33303 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754784AbbIWPB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 11:01:27 -0400
Received: by pacex6 with SMTP id ex6so42860559pac.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5YL+qURl3HaNR75PzPu1uhhlVmccVwHfbjKxF0ISfRU=;
        b=LWaBQYPiPsvRkX5o21LSsfAHAfGbkJH1V6nctAG3yzaj3PjOP6lKzRMxDwkv4LWnqM
         ex/uHtNOk43/c38BWLQrPDSXtcb9qnTiWEhcSp2lJkvAZjpr4MPeDBos7eHOCYq5SI7p
         jHBvSG0pXVARdFmhFoIDg36rUhIh0w23QhGpAXUOWzHk3p0o/r5H7d1Nhe8zgCBb0Rkh
         xkdXlQTQpZ1FSl1prZCztLhMWpeC9nUyJyUQQwicJaKW2/njTuE+XieVXjT3TAkfWtA3
         6pFVoy97iCsCo+bCZ8c9EKAcLXvjkHqikHTJwH7wShfx2RBr5Ca0UbLhguq95P0rrP2a
         bTrg==
X-Received: by 10.68.130.71 with SMTP id oc7mr38158864pbb.29.1443020487134;
        Wed, 23 Sep 2015 08:01:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id fu4sm8482024pbb.59.2015.09.23.08.01.26
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 23 Sep 2015 08:01:26 -0700 (PDT)
In-Reply-To: <56027FDC.1070905@ramsayjones.plus.com> (Ramsay Jones's message
	of "Wed, 23 Sep 2015 11:33:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278487>

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Commits 9c0b9f6 ("worktree: add 'list' command", 18-09-2015) and
> 40ca3d3 ("worktree: add functions to get worktree details", 18-08-2015)
> both introduce the use of a C99 feature (declare the loop control
> variable in the loop header initializer section).
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Junio,
>
> The pu branch doesn't build for me. Do you have -std=c99 set somewhere?
>
> Could you please squash the relevant parts of this patch (or something
> like it) into the two commits mentioned above.
>
> Thanks!

Oh, this is embarrassing, as I do recall noticing this during the
review (in my MUA before running "git am") but somehow it slipped my
mind.

Thanks for catching.



> ATB,
> Ramsay Jones
>
>  builtin/worktree.c | 6 +++---
>  worktree.c         | 7 +++++--
>  2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index e6e36ac..b318c39 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -415,16 +415,16 @@ static int list(int ac, const char **av, const char *prefix)
>          usage_with_options(worktree_usage, options);
>      else {
>          struct worktree **worktrees = get_worktrees();
> -        int path_maxlen = 0;
> +        int i, path_maxlen = 0;
>  
>          if (!porcelain) {
> -            for (int i = 0; worktrees[i]; i++) {
> +            for (i = 0; worktrees[i]; i++) {
>                  int len = strlen(worktrees[i]->path);
>                  if (len > path_maxlen)
>                      path_maxlen = len;
>              }
>          }
> -        for (int i = 0; worktrees[i]; i++) {
> +        for (i = 0; worktrees[i]; i++) {
>              if (porcelain)
>                  show_worktree_porcelain(worktrees[i]);
>              else
> diff --git a/worktree.c b/worktree.c
> index 41c229e..d17b5b6 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -5,7 +5,9 @@
>  
>  void free_worktrees(struct worktree **worktrees)
>  {
> -    for (int i = 0; worktrees[i]; i++) {
> +    int i;
> +
> +    for (i = 0; worktrees[i]; i++) {
>          free(worktrees[i]->path);
>          free(worktrees[i]->git_dir);
>          free(worktrees[i]->head_ref);
> @@ -207,8 +209,9 @@ char *find_shared_symref(const char *symref, const char *target)
>      struct strbuf sb = STRBUF_INIT;
>      struct worktree **worktrees = get_worktrees();
>      int symref_is_head = !strcmp("HEAD", symref);
> +    int i;
>  
> -    for (int i = 0; worktrees[i]; i++) {
> +    for (i = 0; worktrees[i]; i++) {
>          if (!symref_is_head) {
>              strbuf_reset(&path);
>              strbuf_reset(&sb);
