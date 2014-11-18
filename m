From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] refs.c: handle locking failure during transaction better
Date: Tue, 18 Nov 2014 15:34:29 -0800
Message-ID: <CAGZ79kbH=pqSizhUeuiCeYXZWk015K49Pj0F5pPvkOTqg4PMuQ@mail.gmail.com>
References: <1416352639-10150-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 00:34:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqsIA-0006fF-K6
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 00:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932871AbaKRXed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 18:34:33 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35445 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932494AbaKRXea (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 18:34:30 -0500
Received: by mail-ie0-f175.google.com with SMTP id at20so9904010iec.34
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 15:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=vFwKO7UU7HBenmVeuLtgXskdhGZIMiptai6zSfUasdQ=;
        b=LOeI2hwrxndLqBNMrxpA99vCNgI0yvMGpTW6nmt47J+tgXvv0XHrVUpqUiyU4MUthD
         K/hkM0V84MAvD+KL3QP6lh0KhBUg6KutqXarXiUYLDrnxsvkw7LCx30UUd+TpsUAblFk
         4MmYTuKdzNgBTwbMszwqFTD0yAseKwIKxOgGnrc++mIXLO8lPAjl/ym2fHqqIh7UC3Cm
         ZNGfWnXSktE0l8EXxEVitZEbIsWKG9KuW8SZnLluJShqp0HKz+XqnQVUZ6n9FblZqxRv
         iYilvqflVB1hdXKNq4QaQ9n4PIgOhrlcoyezzf3BS5Isamp+Zzey0I4rKGUEWzvZ2Al6
         DjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=vFwKO7UU7HBenmVeuLtgXskdhGZIMiptai6zSfUasdQ=;
        b=j8iedWWeIBRr4HmQW6MTbpqoF3fqN8AjuhmCSqNhJaEhGOt95bbrW0Ojcgyrjbuhij
         MsUeYdOUt7cl2vUaG3K16orlGBHi8enVSXf6Yu0uN7KjWM41wqNbZg20sZrPScZvknKe
         Piozt9ypjnRT/ugAswRxa5JcSiZAYbA/cIoTi/zf0pbTYCScaF1D8TmYBKR1TSKVod/g
         ckfJWNuGAGqMG2MHtFoJCJzchvUoXy1nGvkYij1xLSnqBpYQwZbObT0HFj8ejB1DbTyM
         OImF4Wxs4aBtiXzQvkoW/Dp++DIFo1L5w4QXSz+EwS3YXSQXA0dhNGtD7StC46aDQDrE
         /RYg==
X-Gm-Message-State: ALoCoQlSqVK9bNOnWIPuYMTQh9I5pfChxnNcTZNrqYqlFFBpPHQ1Y5qvOBddSBQq00mBAmCaoDR+
X-Received: by 10.42.212.83 with SMTP id gr19mr99635icb.95.1416353669386; Tue,
 18 Nov 2014 15:34:29 -0800 (PST)
Received: by 10.107.46.163 with HTTP; Tue, 18 Nov 2014 15:34:29 -0800 (PST)
In-Reply-To: <1416352639-10150-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I messed up authorship on this one.
This was of course found and authored by Ronnie.

On Tue, Nov 18, 2014 at 3:17 PM, Stefan Beller <sbeller@google.com> wrote:
> Change lock_ref_sha1_basic to return an error instead of dying,
> when we fail to lock a file during a transaction. This function is
> only called from transaction_commit() and it knows how to handle
> these failures.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Cherry-picked-to-master: Stefan Beller <sbeller@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  refs.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> This was part of the ref-transactions-rename series[1],
> but it makes sense to send this one as a separate patch.
>
> Thanks,
> Stefan
>
> [1] https://www.mail-archive.com/git@vger.kernel.org/msg60604.html
>
> diff --git a/refs.c b/refs.c
> index 5ff457e..0347328 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2318,6 +2318,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>
>         lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, lflags);
>         if (lock->lock_fd < 0) {
> +               last_errno = errno;
>                 if (errno == ENOENT && --attempts_remaining > 0)
>                         /*
>                          * Maybe somebody just deleted one of the
> @@ -2325,8 +2326,13 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>                          * again:
>                          */
>                         goto retry;
> -               else
> -                       unable_to_lock_die(ref_file, errno);
> +               else {
> +                       struct strbuf err = STRBUF_INIT;
> +                       unable_to_lock_message(ref_file, errno, &err);
> +                       error("%s", err.buf);
> +                       strbuf_reset(&err);
> +                       goto error_return;
> +               }
>         }
>         return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
>
> --
> 2.2.0.rc2.5.gf7b9fb2
>
