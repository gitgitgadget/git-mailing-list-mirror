From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 04/24] expire_reflog(): it's not an each_ref_fn anymore
Date: Fri, 12 Dec 2014 10:09:55 -0800
Message-ID: <CAGZ79kZOa77DKLnvinhgAVwCeRRXWMD5Krk8QK6N170+oqA-xA@mail.gmail.com>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
	<1418374623-5566-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 12 19:11:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzUgH-0005aL-0r
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 19:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935022AbaLLSJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 13:09:57 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:41291 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbaLLSJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 13:09:56 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so7353726ieb.21
        for <git@vger.kernel.org>; Fri, 12 Dec 2014 10:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cZA3eMsiPZAjWK2tRN51gFD5M1JApfyU2MeFZPrKgFI=;
        b=I70OQWPPj03wHM7fUFVQtb1tTEgal7brL0MdICOFKTPaHF1rOI3Dbd2HtraZpe4LRx
         rgekzRHmbD9MfHaYH3t7W2Dvve4mz7UsqnttkqM2SfnLLwAo2iArV673Dxz0xPVzi6tL
         Qdz4eimcpT7cTFjYCRVvTlI8QEyCdurFZlWQ8Wh9A02H1qZlsTUIWc8tAZJMZDQ5iE4K
         SHB+U+Gn6WWqx8Z0FipBLTaL3YsfGVbvIvfbXS3t4eQQgLOZHoySHZgP2NGWn4PhmBw6
         OvCA+yDYdrtjIdpYEb5NCQkfzwSiKDLokILPGlBxLEy0q9iDlni/0bW+6zgFrqg/bNGm
         Yipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=cZA3eMsiPZAjWK2tRN51gFD5M1JApfyU2MeFZPrKgFI=;
        b=Bg/52Ww1WCCEEW/dekehjW/n020pzWsZOmFHM2TDZpxICXk2BPO+E77uQuQjh2qDF1
         gkLTr77PC1tuDRxyeUuVT7nKnrX4SjwIz/jIbgtKg4h/Thnx8BWm8xMkHNUuTk4kxK9R
         EGpntGDRgg1toJ1ChuZMKqxipeWttDlJ2SpLjfwai1zWktF3AydtcJIXpGlF0etmvsyX
         UO80Jf8ucrHEgFSy4M7KXVubC/odtNbiMFahj79iDMR5xWrwI8fRerZiEGdPzQ6WE1l+
         nz3kBJvdsNIDj/Lk/3A/RyzkXKs2fnTbRxmgi0PTjkXedpvhGXCjZwxUH8xg+ls8/JKl
         0GkA==
X-Gm-Message-State: ALoCoQnBSKha//bPAsxooA7z1S3eo39zqLXh0xuwXS2Tlqyq4HnDsIypxBNYN4NJkDVV1sBc4sEq
X-Received: by 10.107.25.74 with SMTP id 71mr9705394ioz.70.1418407795966; Fri,
 12 Dec 2014 10:09:55 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Fri, 12 Dec 2014 10:09:55 -0800 (PST)
In-Reply-To: <1418374623-5566-5-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261351>

On Fri, Dec 12, 2014 at 12:56 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Prior to v1.5.4~14, expire_reflog() had to be an each_ref_fn because
> it was passed to for_each_reflog(). Since then, there has been no
> reason for it to implement the each_ref_fn interface. So...
>
> * Remove the "unused" parameter (which took the place of "flags", but
>   was really unused).
>
> * Declare the last parameter to be (struct cmd_reflog_expire_cb *)
>   rather than (void *).
>
> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Reviewed-by: Stefan Beller <sbeller@google.com>

> ---
>  builtin/reflog.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 2d85d26..160541a 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -349,9 +349,9 @@ static int push_tip_to_list(const char *refname, const unsigned char *sha1, int
>         return 0;
>  }
>
> -static int expire_reflog(const char *ref, const unsigned char *sha1, int unused, void *cb_data)
> +static int expire_reflog(const char *ref, const unsigned char *sha1,
> +                        struct cmd_reflog_expire_cb *cmd)
>  {
> -       struct cmd_reflog_expire_cb *cmd = cb_data;
>         struct expire_reflog_cb cb;
>         struct ref_lock *lock;
>         char *log_file, *newlog_path = NULL;
> @@ -663,7 +663,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
>                 for (i = 0; i < collected.nr; i++) {
>                         struct collected_reflog *e = collected.e[i];
>                         set_reflog_expiry_param(&cb, explicit_expiry, e->reflog);
> -                       status |= expire_reflog(e->reflog, e->sha1, 0, &cb);
> +                       status |= expire_reflog(e->reflog, e->sha1, &cb);
>                         free(e);
>                 }
>                 free(collected.e);
> @@ -677,7 +677,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
>                         continue;
>                 }
>                 set_reflog_expiry_param(&cb, explicit_expiry, ref);
> -               status |= expire_reflog(ref, sha1, 0, &cb);
> +               status |= expire_reflog(ref, sha1, &cb);
>         }
>         return status;
>  }
> @@ -748,7 +748,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
>                         cb.expire_total = 0;
>                 }
>
> -               status |= expire_reflog(ref, sha1, 0, &cb);
> +               status |= expire_reflog(ref, sha1, &cb);
>                 free(ref);
>         }
>         return status;
> --
> 2.1.3
>
