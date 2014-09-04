From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] setup.c: set workdir when gitdir is not default
Date: Thu, 4 Sep 2014 17:53:34 +0700
Message-ID: <CACsJy8CS3jC54bTh8ySmpAmbQOycMvvnH=yMES0LJQ4zWkqLrA@mail.gmail.com>
References: <1409784120-2228-1-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Thu Sep 04 12:54:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPUgY-0005ff-DJ
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 12:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbaIDKyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 06:54:06 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:50282 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311AbaIDKyF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 06:54:05 -0400
Received: by mail-ig0-f179.google.com with SMTP id r2so847406igi.12
        for <git@vger.kernel.org>; Thu, 04 Sep 2014 03:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2iOHtOw7mTGp+KdkZn2Y9VUKZyYUH+7VtdnxxZrJO4U=;
        b=lcUYpl6/6R8RUlpFZuEc0+jflbuPZJg7yq2cjt+Qd16HPB02hRQIXFoNGEd+ZCcK4n
         7XxciqJ/gy3Sc1GRNkX0UIEqe9sFqDUH/c0U4Vl7IlgI4zBtacNVRqlk0ERKMzm9zxoe
         ju/AbAjn27MwHK3mvKs0lTC00oeLfThiPUYk0uLBS8dEabAr0uUFBTf2HbMv0JbS6hBd
         8EJ5n3lxSo0DY8LmLnOB3qj0aOgfgcBprrJABezASzqslR0FG3HL9hqwRX1AZXPpQGq3
         3wcg1bn2bNqB+ToPNVoU8KJ+1cl6p3BQ/i8+/Vana6KA6x/dCi78uJOpttpk2oM2EV78
         PIyg==
X-Received: by 10.42.109.79 with SMTP id k15mr4773934icp.42.1409828044525;
 Thu, 04 Sep 2014 03:54:04 -0700 (PDT)
Received: by 10.107.3.152 with HTTP; Thu, 4 Sep 2014 03:53:34 -0700 (PDT)
In-Reply-To: <1409784120-2228-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256436>

On Thu, Sep 4, 2014 at 5:42 AM, Max Kirillov <max@max630.net> wrote:
> diff --git a/setup.c b/setup.c
> index 0a22f8b..bcf4e31 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -508,8 +508,10 @@ static const char *setup_discovered_git_dir(const char *gitdir,
>
>         /* #0, #1, #5, #8, #9, #12, #13 */
>         set_git_work_tree(".");

I wonder if we should setenv(GIT_WORK_TREE_) from inside this function
instead. A quick glance over 'git grep set_git_work_tree' gives me the
impression that it's safe to do so, and could cover future bugs
similar to this.

> -       if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
> +       if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT)) {
>                 set_git_dir(gitdir);
> +               setenv(GIT_WORK_TREE_ENVIRONMENT, get_git_work_tree(), 1);
> +       }
>         inside_git_dir = 0;
>         inside_work_tree = 1;
>         if (offset == len)
-- 
Duy
