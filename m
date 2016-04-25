From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 49/83] builtin/apply: move 'lock_file' global into 'struct apply_state'
Date: Mon, 25 Apr 2016 03:50:39 -0400
Message-ID: <CAPig+cRSe8oOjo2h6SuJQyD+he_Q7zHfF4TivZ0amhAu4HLQ+g@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-50-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 09:50:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aubI5-0001MK-8i
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 09:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700AbcDYHul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 03:50:41 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:36482 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbcDYHuk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 03:50:40 -0400
Received: by mail-ig0-f196.google.com with SMTP id c3so2858999igl.3
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 00:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=VxXhrA4seB967ZGS5sDhOb2nGvc3agF8HIbP/qK7lVY=;
        b=WxiqgWqy9KJupMEL363hGaDpKm1kdLUnq+e9li86Vbawp+qGjdveTvYulWDHg9qbNp
         kaziQBvhh5kAAoshi8wAxM6B3ZwWMdzs/msZpgJjvJCIKN6U6LwR1qlvAdRlZ+8/g4TZ
         msHj+LF9wVTcLgNJ74tsFWQCq00Va6UFCrQKa4U86+GfhqcYnrU2KNMBZx0fDk4nA0Jf
         oM6RnPMxhxoEZNS0qKt8YMHqTti+KzchaTGQDLgEyR3R01kyK7r4VYWLzYTvOYsz95/B
         rKsRJa3FK/cv5ZMua1tHkdr1SJshlw9XdF8D1PfZzRPcBbPppr7FoAjQby1I6aIZ0rF9
         uabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=VxXhrA4seB967ZGS5sDhOb2nGvc3agF8HIbP/qK7lVY=;
        b=TIujJPVv+yCkk9QBiZjkr4aaciN5Rxm0HfsGcvX6bstV+zMSz2395pSkHU/TtlTuIc
         YcjJL23DSrlLhLYzj5EixrYWjHosRCzpOJuQIPCv5Ujxwoyou2hbxFbV61sqU/yKfl4C
         MTSYu9o+omsevpAWoqraCFk97XcBhIcYtAPSHjAZqS9Z6Gsl8dG+gTLtKHnimErBICkM
         62T4jRa3xJza+/YRfNwuqRwiHqu3MYix0tM41puGhdv+tC99gzaUPvgtXPYwVBG1VOEY
         ESwJNC2vDbMFN/zlqW2fqrC5HA6kl4OfxWUdZ5bxuY7dX4gUlZLpBPTNVJTH/HpzTjmb
         WtwA==
X-Gm-Message-State: AOPr4FXkIoeMKBDmlxT1niCIwpzIe8Jg8O2k9U71aZ44r9b2I0fINFS+JGJKi9wu7y9M2gfRwoE7ew20bbaXTw==
X-Received: by 10.50.189.233 with SMTP id gl9mr10250263igc.73.1461570639358;
 Mon, 25 Apr 2016 00:50:39 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 25 Apr 2016 00:50:39 -0700 (PDT)
In-Reply-To: <1461504863-15946-50-git-send-email-chriscool@tuxfamily.org>
X-Google-Sender-Auth: vBYOLGiyZLu0_9nX5d59j9TENgo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292455>

On Sun, Apr 24, 2016 at 9:33 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> We cannot have a 'struct lock_file' allocated on the stack, as lockfile.c
> keeps a linked list of all created lock_file structures.

By talking about "the stack" here, I suppose you mean that your
initial idea was to move the global lock_file into cmd_apply() or
something?

> So let's make the 'lock_file' variable a pointer to a 'struct lock_file'
> and let's alloc the struct when needed.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/builtin/apply.c b/builtin/apply.c
> @@ -52,6 +52,12 @@ struct apply_state {
> +       /*
> +        * Since lockfile.c keeps a linked list of all created
> +        * lock_file structures, it isn't safe to free(lock_file).
> +        */
> +       struct lock_file *lock_file;

Is there ever a time when lock_file is removed from the list (such as
upon successful write of the index), in which case it would be safe to
free() this?

> @@ -4515,8 +4521,6 @@ static int write_out_results(struct apply_state *state, struct patch *list)
>         return errs;
>  }
>
> -static struct lock_file lock_file;

Does the static lock_file in build_fake_ancestor() deserve the same
sort of treatment? (I haven't traced the code enough to answer this.)

>  #define INACCURATE_EOF (1<<0)
>  #define RECOUNT                (1<<1)
