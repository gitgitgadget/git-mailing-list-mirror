From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 09/19] documentation: add documentation for the bitmap format
Date: Fri, 25 Oct 2013 08:16:18 +0700
Message-ID: <CACsJy8DFisnZZiPOWjktuMC2J289AYGtgefZob=4YFAJAxBc6w@mail.gmail.com>
References: <20131024175915.GA23398@sigill.intra.peff.net> <20131024180347.GI24180@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Vicent Marti <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 25 03:16:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZW1G-0003ek-F1
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 03:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314Ab3JYBQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 21:16:49 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:55851 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115Ab3JYBQt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 21:16:49 -0400
Received: by mail-qa0-f42.google.com with SMTP id w8so228036qac.8
        for <git@vger.kernel.org>; Thu, 24 Oct 2013 18:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VShbhzlwzLwcakbtV47xNXZaXN9JUlHYSAh2L2f6w1Y=;
        b=hyV05xt7JKryA9CMOsZ08kT5nY0/KG5ZVJL09YvPpkbbcajmQf+BN4CIRRWd5aFQ1u
         4HSmaDbmmlQvBH4cttjILkMJ3TErMuc6I+UGjnYPHE/cFQgb1T/TpGR1oBpNWuTAs0Ja
         b+BXsbc0IFK8RfYXSZopbdZFOKhKxUFMaLrxRQbGahCpk9VIfp0Oa0mbgs1dq1IJqxee
         NMlx2BcaaeGlaFCC7nuNtjql1l1hDDO/WSgYpS9rQhHGnHmoSgN5z2V8EFpKLsUZ0K35
         zlY683Egz0Z+3O252AIpgcnriK5xj8QpnczGxE3gXGJ72VbunPH0kpvieMXGK2jqtU8s
         hMTg==
X-Received: by 10.224.7.194 with SMTP id e2mr8140347qae.46.1382663808645; Thu,
 24 Oct 2013 18:16:48 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Thu, 24 Oct 2013 18:16:18 -0700 (PDT)
In-Reply-To: <20131024180347.GI24180@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236640>

On Fri, Oct 25, 2013 at 1:03 AM, Jeff King <peff@peff.net> wrote:
> diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
> new file mode 100644
> index 0000000..c686dd1
> --- /dev/null
> +++ b/Documentation/technical/bitmap-format.txt
> @@ -0,0 +1,131 @@
> +GIT bitmap v1 format
> +====================
> +
> +       - A header appears at the beginning:
> +
> +               4-byte signature: {'B', 'I', 'T', 'M'}
> +
> +               2-byte version number (network byte order)
> +                       The current implementation only supports version 1
> +                       of the bitmap index (the same one as JGit).

I suppose this means if I want to extend pack bitmaps to be used on
shallow clones, I need to step version to 2 before adding the shallow
points in .bitmap file as there's no chance of modifying v1 anymore,
correct?

> +
> +               2-byte flags (network byte order)
> +
> +                       The following flags are supported:
> +
> +                       - BITMAP_OPT_FULL_DAG (0x1) REQUIRED
> +                       This flag must always be present. It implies that the bitmap
> +                       index has been generated for a packfile with full closure
> +                       (i.e. where every single object in the packfile can find
> +                        its parent links inside the same packfile). This is a
> +                       requirement for the bitmap index format, also present in JGit,
> +                       that greatly reduces the complexity of the implementation.
> +
> +               4-byte entry count (network byte order)
> +
> +                       The total count of entries (bitmapped commits) in this bitmap index.
> +
> +               20-byte checksum
> +
> +                       The SHA1 checksum of the pack this bitmap index belongs to.
> +
-- 
Duy
