From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-compat-util: do not step on MAC_OS_X_VERSION_MIN_REQUIRED
Date: Fri, 6 Feb 2015 05:00:59 -0500
Message-ID: <CAPig+cT0-ftZZyRORx-W2_Nit6XdgrpiyGS=pRjGtHoz1jW+Kg@mail.gmail.com>
References: <f2a35ed9fba20d48ef5736ee4564101@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 11:01:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJfin-0008Km-GB
	for gcvg-git-2@plane.gmane.org; Fri, 06 Feb 2015 11:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbbBFKBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2015 05:01:03 -0500
Received: from mail-yh0-f44.google.com ([209.85.213.44]:47441 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbbBFKBA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2015 05:01:00 -0500
Received: by mail-yh0-f44.google.com with SMTP id i57so5769401yha.3
        for <git@vger.kernel.org>; Fri, 06 Feb 2015 02:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=OKHZrjTLqDr6VHsskeYfkiB/SGfVEumYooPob6YC49Q=;
        b=mnoXxXCP9dfSshdYZtZox+pSDEbUk/WYAWUQR3IX0NxTDa9IRSzD3H5DqkeZ5lxDdo
         Peb52SVRx2HPH2qgPLbGdB+CBBCr48eAv/vOBzwTh5EKMdExD7NBDL2QbrduKyMe6jUT
         7AQDkLZ44ME6N/lp8Lozej981O9DuqiAMjz8f6Nt6lgzUBKZdQugNMHu7JCgqjjC1gDA
         1J4UImhkohe/t0q2gvmDCBhHpbnQu1iOLB/RSMCCArc9xxIuOGsY9KwGWtNfaiAVJRJE
         Z+qmZrGN7AnnmC2Yt1JVItgbEEL6cyrCrWBKcekCY7zcdgVb41s8YmhaAIgcFAceJmJS
         RaHQ==
X-Received: by 10.236.202.238 with SMTP id d74mr736660yho.166.1423216859961;
 Fri, 06 Feb 2015 02:00:59 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Fri, 6 Feb 2015 02:00:59 -0800 (PST)
In-Reply-To: <f2a35ed9fba20d48ef5736ee4564101@74d39fa044aa309eaea14b9f57fe79c>
X-Google-Sender-Auth: v9QgGG0M_ov0pBSfCF8hHDol8CE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263415>

On Fri, Feb 6, 2015 at 4:35 AM, Kyle J. McKay <mackyle@gmail.com> wrote:
> MAC_OS_X_VERSION_MIN_REQUIRED may be defined by the builder to a
> specific version in order to produce compatible binaries for a
> particular system.  Blindly defining it to MAC_OS_X_VERSION_10_6
> is bad.
>
> Additionally MAC_OS_X_VERSION_10_6 will not be defined on older
> systems and should AvailabilityMacros.h be included on such as
> system an error will result.  However, using the explicit value
> of 1060 (which is what MAC_OS_X_VERSION_10_6 is defined to) does
> not solve the problem.
>
> The changes that introduced stepping on MAC_OS_X_VERSION_MIN were
> made in b195aa00 (git-compat-util: suppress unavoidable
> Apple-specific deprecation warnings) to avoid deprecation
> warnings.
>
> Instead of blindly setting MAC_OS_X_VERSION_MIN to 1060 change
> the definition of DEPRECATED_ATTRIBUTE to empty to avoid the
> warnings.  This preserves any MAC_OS_X_VERSION_MIN_REQUIRED
> setting while avoiding the warnings as intended by b195aa00.
>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>

Tested on 10.10.2 (Yosemite) and 10.5.8 (Snow Leopard).

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

More below...

> ---
>  git-compat-util.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index eb9b0ff3..0efd32c4 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -212,12 +212,15 @@ extern char *gitbasename(char *);
>  #endif
>
>  #ifndef NO_OPENSSL
> +#ifdef __APPLE__
>  #define __AVAILABILITY_MACROS_USES_AVAILABILITY 0
> -#define MAC_OS_X_VERSION_MIN_REQUIRED MAC_OS_X_VERSION_10_6
> +#include <AvailabilityMacros.h>
> +#undef DEPRECATED_ATTRIBUTE
> +#define DEPRECATED_ATTRIBUTE
> +#undef __AVAILABILITY_MACROS_USES_AVAILABILITY
> +#endif
>  #include <openssl/ssl.h>
>  #include <openssl/err.h>
> -#undef MAC_OS_X_VERSION_MIN_REQUIRED
> -#undef __AVAILABILITY_MACROS_USES_AVAILABILITY

DEPRECATED_ATTRIBUTE is a fairly generic name. Do we want to be extra
careful and #undef it here to avoid potential unintended interactions
with other #includes (Apple or not)?

    #ifdef __APPLE__
    #undef DEPRECATED_ATTRIBUTE
    #endif

On the other hand, we've already mucked with it, so #undef may be superfluous.

>  #ifdef NO_HMAC_CTX_CLEANUP
>  #define HMAC_CTX_cleanup HMAC_cleanup
>  #endif
> --
