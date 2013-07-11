From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] upload-pack: Remove a piece of dead code
Date: Thu, 11 Jul 2013 19:08:14 +0700
Message-ID: <CACsJy8CazcJau0yTYSndbam_bUhZLS5f02p9WD0jjutHh1J6+A@mail.gmail.com>
References: <20130711105733.GG10217@login.drsnuggles.stderr.nl> <1373541954-16493-1-git-send-email-matthijs@stdin.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Thu Jul 11 14:08:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxFg2-0004Gz-U6
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 14:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754447Ab3GKMIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 08:08:46 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33622 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab3GKMIq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 08:08:46 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so9895007obb.0
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 05:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=857IgA27a1s0kXzNywvaxqkJG9qMpxXDoUK9fCMInBQ=;
        b=mEhaJfoxcXyYQidfyacwGMYmzx6RreSqVVYJpDxXfZw2YHEAOXAPTuaNV7nkO5C5R0
         CbMQ9qQIlrQcjeotKEc3MvK2VSli46AFTJTK1LD45Qi+C2I9Iqn6e8XNINSnCP41Ds0F
         ZeKJEhHwFHcJ5qxe6+D+bijoG+7H9w4tHT+eoC6JI0uYv4V0TwYw33zV3auT2WJ0kvMv
         DcyGs2ekrHGdbaLYUFFcUGWrU3RsH4n5W4v2NTNID5zAOdk96tZntq9GLK+onuNUaYMO
         Jp1ll3yANYj3exM3RmJmRYouA/obKM9x/tAg/YFrdNwfQ2s/Qf2spdJbrRm8BpTyQb6S
         ELwA==
X-Received: by 10.60.97.74 with SMTP id dy10mr31094100oeb.27.1373544525423;
 Thu, 11 Jul 2013 05:08:45 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Thu, 11 Jul 2013 05:08:14 -0700 (PDT)
In-Reply-To: <1373541954-16493-1-git-send-email-matthijs@stdin.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230095>

On Thu, Jul 11, 2013 at 6:25 PM, Matthijs Kooijman <matthijs@stdin.nl> wrote:
> Commit 682c7d2 (upload-pack: fix off-by-one depth calculation in shallow
> clone) introduced a new check in get_shallow_commits to decide when to
> stop traversing the history and mark the current commit as a shallow
> root.
>
> With this new check in place, the old check can no longer be true, since
> the first check always fires first. This commit removes that check,
> making the code a bit more simple again.

True. Ack-by: me.

> Signed-off-by: Matthijs Kooijman <matthijs@stdin.nl>
> ---
>  shallow.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/shallow.c b/shallow.c
> index cbe2526..8a9c96d 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -110,17 +110,12 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
>                                         continue;
>                                 *pointer = cur_depth;
>                         }
> -                       if (cur_depth < depth) {
> -                               if (p->next)
> -                                       add_object_array(&p->item->object,
> -                                                       NULL, &stack);
> -                               else {
> -                                       commit = p->item;
> -                                       cur_depth = *(int *)commit->util;
> -                               }
> -                       } else {
> -                               commit_list_insert(p->item, &result);
> -                               p->item->object.flags |= shallow_flag;
> +                       if (p->next)
> +                               add_object_array(&p->item->object,
> +                                               NULL, &stack);
> +                       else {
> +                               commit = p->item;
> +                               cur_depth = *(int *)commit->util;
>                         }
>                 }
>         }
> --
> 1.8.3.rc1
>
--
Duy
