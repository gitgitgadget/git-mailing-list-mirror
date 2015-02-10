From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/8] lock_ref_sha1_basic(): do not set force_write for
 missing references
Date: Tue, 10 Feb 2015 15:24:47 -0800
Message-ID: <CAGZ79kbrFpgF6_dLYdgT2D0JjWggu8edjV2sgXER5btpmyjDNw@mail.gmail.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
	<1423473164-6011-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 11 00:24:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLKAm-00011O-Nr
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 00:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbbBJXYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 18:24:49 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34648 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbbBJXYs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 18:24:48 -0500
Received: by iery20 with SMTP id y20so192376ier.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2015 15:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bKXy2WH2d2oJAqKbSwpDSMMsq4s2jEHz3QHojtaHyUQ=;
        b=FUK91AUVAaKkkCCeMHCn1Ci0hdlvVT4kH+4yD5ePcFFzOKk32rgYR/cUE3QeDG5Xgl
         O5/Giny/xjCG+QRBt0M4+6rJgK4xzCDS+GwEBTH98gL9RgVoz+ayzh1jPWFN89G23em4
         tp+NfudSMcw0PaaBJolNAmV20w4pifpN4difEt2miBoz2gDaYFs80XacwPasLByBCSwo
         VwxhW4VzcK2tTBmcxPhvEQ0TqnnOrXZuY5csqS6Ip/QI5qNBZJbzB5r5VF6rkN4NLbyJ
         N/wSshltgGhsfOSGRIJpIPan3ZFis/3k34AIVINTG+J9V661tueQMj/UdV33eSkGaG5e
         6tQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bKXy2WH2d2oJAqKbSwpDSMMsq4s2jEHz3QHojtaHyUQ=;
        b=hrWa1ZrF+kwYJB0SBaNFLxn7a84KP70oDJhrnt5iqKi96jdpvX92/FjJoo6VJHt2/X
         l2X4UjjB/y6unWDT+81BsxNrYNMGjI/WYvG6pe9KT/FXlNHQrIgpb6qNHChXt0eOX9Xf
         7MfqZAJtlQcvcprKsu2yD99AFi9pHsOpFaf9Oy6isRwe+pwIVu00N+SCs2nSTY4Vvad3
         9mB3yb1rEzkLu7js7PkJPCtC/VTz78qFDSj+sZXxeiV5JGpi8ltYSvlNBLPFVMjl3Gvq
         XnZFqwuZELQYhTqi9g7QQYUHkpSkiuli+MCFIH2IaV998sSyeKiunlEz1F0qKwOak2dV
         yM6Q==
X-Gm-Message-State: ALoCoQmtG39zB3fGM7eu2lFuWSYDX5CrZBydAE3tKSG94VsisMNvG7M9YeuFFeieBIcUexqqTUGe
X-Received: by 10.107.137.17 with SMTP id l17mr14820529iod.33.1423610687409;
 Tue, 10 Feb 2015 15:24:47 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Tue, 10 Feb 2015 15:24:47 -0800 (PST)
In-Reply-To: <1423473164-6011-4-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263659>

On Mon, Feb 9, 2015 at 1:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> If a reference is missing, its SHA-1 will be null_sha1, which can't
> possibly match a new value that ref_transaction_commit() is trying to
> update it to. So there is no need to set force_write in this scenario.
>

This commit reverts half the lines of 5bdd8d4a3062a (2008-11, do not
force write of packed refs). And reading both commit messages, they
seem to contradict each other. (Both agree on  "If a reference is
missing, its SHA-1 will be null_sha1 as provided by resolve_ref", but
the conclusion seems to be different.)

On the other hand, there is more than 6 years difference, so I guess
the meaning and implications of some variables and functions may have
slightly changed.

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 651e37e..b083858 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2259,7 +2259,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>         int type, lflags;
>         int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
>         int resolve_flags = 0;
> -       int missing = 0;
>         int attempts_remaining = 3;
>
>         lock = xcalloc(1, sizeof(struct ref_lock));
> @@ -2298,13 +2297,13 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>                         orig_refname, strerror(errno));
>                 goto error_return;
>         }
> -       missing = is_null_sha1(lock->old_sha1);
> -       /* When the ref did not exist and we are creating it,
> -        * make sure there is no existing ref that is packed
> -        * whose name begins with our refname, nor a ref whose
> -        * name is a proper prefix of our refname.
> +       /*
> +        * When the ref did not exist and we are creating it, make
> +        * sure there is no existing packed ref whose name begins with
> +        * our refname, nor a packed ref whose name is a proper prefix
> +        * of our refname.
>          */
> -       if (missing &&
> +       if (is_null_sha1(lock->old_sha1) &&
>              !is_refname_available(refname, skip, get_packed_refs(&ref_cache))) {
>                 last_errno = ENOTDIR;
>                 goto error_return;
> @@ -2320,8 +2319,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>         lock->ref_name = xstrdup(refname);
>         lock->orig_ref_name = xstrdup(orig_refname);
>         ref_file = git_path("%s", refname);
> -       if (missing)
> -               lock->force_write = 1;
>         if ((flags & REF_NODEREF) && (type & REF_ISSYMREF))
>                 lock->force_write = 1;
>
> --
> 2.1.4
>
