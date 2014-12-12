From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 22/24] lock_any_ref_for_update(): inline function
Date: Fri, 12 Dec 2014 12:04:27 -0800
Message-ID: <CAGZ79kaw=BnZzAuP5+Krw_agY=vtocjAiVEFuuwYoNmMnQ6_qw@mail.gmail.com>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
	<1418374623-5566-23-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 12 21:04:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzWS0-00066k-Rp
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 21:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933853AbaLLUE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 15:04:29 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:65533 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933600AbaLLUE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 15:04:28 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so7583006ier.18
        for <git@vger.kernel.org>; Fri, 12 Dec 2014 12:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=c3GkLyPEoXyAFw2cJup1Chea73NHArzw0PZyTaRev8k=;
        b=N1vFqK/hdutD6tycxVBCLRtoZgpDmvyeGUN/uVrY4WXMWVk1YcrroEOgjsFZExQEUt
         HERJIzwI/nwqTi7BS1M/abF6cL4rv+mxwWDxyzKXZgHjWSU4qS0nJcdoKI62/fA/qSUI
         gB0x7xVrt+3rDSyfC1fj5f2Wt75vuD0/hHZpHheBSRTCEe9ImGmyK5kIFec/5KYnhwB9
         wHOBdc+vxaVB3Xk8/rGdcKbN9yGudi0IH+SQmfsaxBxWDu2Jq5yGWCjIwYBiC2VD9vEq
         WD8rb9Gy3MEpKKpbbKqWC39oEuwOJ526tt9a5shGaRAWTupfQ70qCZ18jD4mZcY5TVql
         z4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=c3GkLyPEoXyAFw2cJup1Chea73NHArzw0PZyTaRev8k=;
        b=XJk6t9kqZst9Al9CW17wQS8ShyyKkMGhAxo8BeXX2n4xlRtCpmkPtfdNd3bYJxltDQ
         DETgXDUY/RMkbZQxp3rg8lscYs1jKP7rWQzfk/Ul2Cc8M4nBWP3j5PiuAomUIZkZT8qm
         qM0rOIO+PMXw2B5SijzbugloEk8FrIJkYj6c6iLd4kBPe1BY+naCRdwEA74y1YvDG5rz
         8MW86OITSEM5I3N36jcawP9xNq0zZHFaO4Vrg9rGCfglOwSFFhKVIK3HU+7DH9C6Q7d4
         1weLnVIkUakOFrcvx0YV6zhBqPcOsDDd0nUXjz8olIM2R/8BPV9dvjYKkshlNIN8Kul5
         cQbA==
X-Gm-Message-State: ALoCoQnXiWEpOpA+lI/enXJAoik0Nt88+tJeKnqKMpL5wgw8oM+5UZ+dLVxOHWLrEE1tQZpTMZ6M
X-Received: by 10.107.170.162 with SMTP id g34mr17567445ioj.2.1418414667393;
 Fri, 12 Dec 2014 12:04:27 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Fri, 12 Dec 2014 12:04:27 -0800 (PST)
In-Reply-To: <1418374623-5566-23-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261366>

On Fri, Dec 12, 2014 at 12:57 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Inline the function at its one remaining caller (which is within
> refs.c) and remove it.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Reviewed-by: Stefan Beller <sbeller@google.com>
> ---
>  refs.c | 9 +--------
>  refs.h | 9 +--------
>  2 files changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 618ef9c..166c0f6 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2346,13 +2346,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>         return NULL;
>  }
>
> -struct ref_lock *lock_any_ref_for_update(const char *refname,
> -                                        const unsigned char *old_sha1,
> -                                        int flags, int *type_p)
> -{
> -       return lock_ref_sha1_basic(refname, old_sha1, NULL, flags, type_p);
> -}
> -
>  /*
>   * Write an entry to the packed-refs file for the specified refname.
>   * If peeled is non-NULL, write it as the entry's peeled value.
> @@ -4007,7 +4000,7 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
>          * reference itself, plus we might need to update the
>          * reference if --updateref was specified:
>          */
> -       lock = lock_any_ref_for_update(refname, sha1, 0, NULL);
> +       lock = lock_ref_sha1_basic(refname, sha1, NULL, 0, NULL);
>         if (!lock)
>                 return error("cannot lock ref '%s'", refname);
>         if (!reflog_exists(refname)) {
> diff --git a/refs.h b/refs.h
> index 4bb58b9..28e7834 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -181,8 +181,7 @@ extern int is_branch(const char *refname);
>  extern int peel_ref(const char *refname, unsigned char *sha1);
>
>  /*
> - * Flags controlling lock_any_ref_for_update(), ref_transaction_update(),
> - * ref_transaction_create(), etc.
> + * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
>   * REF_NODEREF: act on the ref directly, instead of dereferencing
>   *              symbolic references.
>   * REF_DELETING: tolerate broken refs
> @@ -191,12 +190,6 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
>   */
>  #define REF_NODEREF    0x01
>  #define REF_DELETING   0x02
> -/*
> - * This function sets errno to something meaningful on failure.
> - */
> -extern struct ref_lock *lock_any_ref_for_update(const char *refname,
> -                                               const unsigned char *old_sha1,
> -                                               int flags, int *type_p);
>
>  /*
>   * Setup reflog before using. Set errno to something meaningful on failure.
> --
> 2.1.3
>
