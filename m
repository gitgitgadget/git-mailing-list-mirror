From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] refs.c: move reflog updates into its own function
Date: Mon, 24 Nov 2014 13:24:50 -0800
Message-ID: <CAGZ79kY8FagM_RPMZ9AchBmSK=BWR1A+4JQ7DiG2JmvyvtsPiw@mail.gmail.com>
References: <1416530282-13192-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 24 22:24:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt17v-0000ex-Uz
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 22:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbaKXVYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 16:24:52 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:61781 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbaKXVYv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 16:24:51 -0500
Received: by mail-ie0-f172.google.com with SMTP id tr6so2077957ieb.17
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 13:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=hkK1rv76+JWDvXROvKumocAgvAAHZA5kLKHm+MayIt4=;
        b=kBPlDKq7yp5ZOvDJjDXC9zoIrOPBBFjrLF7PEb7so09xvzUpoEg4o1ehx8hWq2WdgA
         vfKCalG4LYshAp7P56vg+QhQ79+B48Gf/4hat1QaXPeBGFMvpn9rDxLwwIb3XPN598ku
         56SEKgUfAs6bXq1Y6w8mhrw5K+Y/9mRfFhS6/RrwnNH6nvjFaJK/U2rFx9Vu7PE5XAwm
         OOhp1OwEGjg3mv5XcoDt1UMVlxLCzy+tICH95YplIu7inEmGLM1aIf5DKQoxQGyhDT88
         p+NGRiAtaYTlyioENeC5+tGvSYdIKNVUEJqiOt2qjVrDr8SVxMzL0R5LM4rprh26NVxe
         xNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=hkK1rv76+JWDvXROvKumocAgvAAHZA5kLKHm+MayIt4=;
        b=J+gIwge3iGB7ncBmbLS8kmuU4e+jBEzxVHmgmoTEeaZFqgtjHMnYyGyL7ZPVMa0UI2
         4GWvU15wFSoW9YgFvuyZjLAgX8lnO2thpT+UZT7C7vr+ENXFlVv3Vh+yc/fsWCv1/OnN
         HDSS2IW9LsXtkQGsjthk3BWoZ3ih6+Hr/ZxgCE7GRQgrGNiViFqg7rUdaAdgO1uh2eS+
         tf78C9Dgnhqwio2gSDH11F4UaSNzRwN6CwbBQKYBN0H2eF9SBPhtqg0yF9I0g6YFUH/G
         vqeohFuXH3PFAYFcH2ofngh1xtgjei+0FaklSjqFhHq4Yd/8J3CnqP2eL1kYJ7u0qhEG
         QwyQ==
X-Gm-Message-State: ALoCoQkacMtacu9Of+5lK3MabGxzbkOMHzFZUj6GtiA1/evbJP/Ek2+4OrqFEFTsF4AFNFpcntDN
X-Received: by 10.43.82.72 with SMTP id ab8mr5911228icc.76.1416864290586; Mon,
 24 Nov 2014 13:24:50 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Mon, 24 Nov 2014 13:24:50 -0800 (PST)
In-Reply-To: <1416530282-13192-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260150>

Anything holding this back?

On Thu, Nov 20, 2014 at 4:38 PM, Stefan Beller <sbeller@google.com> wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
>
> write_ref_sha1 tries to update the reflog while updating the ref.
> Move these reflog changes out into its own function so that we can do the
> same thing if we write a sha1 ref differently, for example by writing a ref
> to the packed refs file instead.
>
> No functional changes intended. We only move some code out into a separate
> function.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>  Examining the refs-transaction-reflog series a bit closer, this seems to be
>  one of the last independant patches, which make sense to rip out on a per-patch
>  basis.
>
>
>  refs.c | 60 +++++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 35 insertions(+), 25 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 005eb18..6837367 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3043,6 +3043,40 @@ int is_branch(const char *refname)
>         return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
>  }
>
> +static int write_sha1_update_reflog(struct ref_lock *lock,
> +       const unsigned char *sha1, const char *logmsg)
> +{
> +       if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
> +           (strcmp(lock->ref_name, lock->orig_ref_name) &&
> +            log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
> +               unlock_ref(lock);
> +               return -1;
> +       }
> +       if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
> +               /*
> +                * Special hack: If a branch is updated directly and HEAD
> +                * points to it (may happen on the remote side of a push
> +                * for example) then logically the HEAD reflog should be
> +                * updated too.
> +                * A generic solution implies reverse symref information,
> +                * but finding all symrefs pointing to the given branch
> +                * would be rather costly for this rare event (the direct
> +                * update of a branch) to be worth it.  So let's cheat and
> +                * check with HEAD only which should cover 99% of all usage
> +                * scenarios (even 100% of the default ones).
> +                */
> +               unsigned char head_sha1[20];
> +               int head_flag;
> +               const char *head_ref;
> +               head_ref = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
> +                                             head_sha1, &head_flag);
> +               if (head_ref && (head_flag & REF_ISSYMREF) &&
> +                   !strcmp(head_ref, lock->ref_name))
> +                       log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
> +       }
> +       return 0;
> +}
> +
>  /*
>   * Write sha1 into the ref specified by the lock. Make sure that errno
>   * is sane on error.
> @@ -3086,34 +3120,10 @@ static int write_ref_sha1(struct ref_lock *lock,
>                 return -1;
>         }
>         clear_loose_ref_cache(&ref_cache);
> -       if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
> -           (strcmp(lock->ref_name, lock->orig_ref_name) &&
> -            log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
> +       if (write_sha1_update_reflog(lock, sha1, logmsg)) {
>                 unlock_ref(lock);
>                 return -1;
>         }
> -       if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
> -               /*
> -                * Special hack: If a branch is updated directly and HEAD
> -                * points to it (may happen on the remote side of a push
> -                * for example) then logically the HEAD reflog should be
> -                * updated too.
> -                * A generic solution implies reverse symref information,
> -                * but finding all symrefs pointing to the given branch
> -                * would be rather costly for this rare event (the direct
> -                * update of a branch) to be worth it.  So let's cheat and
> -                * check with HEAD only which should cover 99% of all usage
> -                * scenarios (even 100% of the default ones).
> -                */
> -               unsigned char head_sha1[20];
> -               int head_flag;
> -               const char *head_ref;
> -               head_ref = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
> -                                             head_sha1, &head_flag);
> -               if (head_ref && (head_flag & REF_ISSYMREF) &&
> -                   !strcmp(head_ref, lock->ref_name))
> -                       log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
> -       }
>         if (commit_ref(lock)) {
>                 error("Couldn't set %s", lock->ref_name);
>                 unlock_ref(lock);
> --
> 2.2.0.rc2.23.gca0107e
>
