From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: RFD: Handling case-colliding filenames on case-insensitive filesystems
Date: Wed, 23 Feb 2011 14:07:35 -0500
Message-ID: <AANLkTi=MyqXYi=zNZ+MFcUW2p-_icwg0m_aMQpVioT8J@mail.gmail.com>
References: <201102231811.45948.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Feb 23 20:08:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsK4M-0000rH-NL
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 20:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419Ab1BWTII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 14:08:08 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33993 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932417Ab1BWTIH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 14:08:07 -0500
Received: by iyb26 with SMTP id 26so2979579iyb.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 11:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=5Ku1u0zuEeRqKDLdbIngbp0v+kyQB2GsbgQxlhzggO0=;
        b=gsEm/RONxZ/VPla3nBjkFCaP/bylLo77+fgj8qC27mnEwtwv0Q/U+YRtpoU65Z6lAj
         9nbf1gXAwQo9TfaGbMCDTRE5kQFclD2KVLzrsmy8tzSpaIiI4BS7Qv6NkFw8DDDMCl+r
         x7qtveo9zPxM57y8H8NWuBXK6d3/kIDaxxXsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qVBAhUmSJPHbsdn0EfDHulUPxr55ZiZKorZS2wRR6u3jjzqQbwPBD0+IKQyA+4672p
         lPm4vtxq0p4z49Z0HBYEW7SLhwDbPIHl5XFn+j+2uiTLwxzmTB2Y2YyXReNm00bfo9lK
         fKYwSfvPVjVErvONkQDg1B7wLFWM9BI/BzjeU=
Received: by 10.231.30.139 with SMTP id u11mr3501480ibc.92.1298488086121; Wed,
 23 Feb 2011 11:08:06 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Wed, 23 Feb 2011 11:07:35 -0800 (PST)
In-Reply-To: <201102231811.45948.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167712>

On Wed, Feb 23, 2011 at 12:11 PM, Johan Herland <johan@herland.net> wrote:
> A colleague suggested instead that Git should notice that the collision
> will occur, and work around the failure to represent the repository
> objects in the file system with a one-to-one match. Either by checking
> out only _one_ of the colliding files, or by using a non-colliding name
> for the second file. After all, Git already has functionality for
> manipulating the file contents on checkout (CRLF conversion). Doesn't
> it make sense to add functionality for manipulating the _directory_
> contents on checkout as well? Even if that makes sense, I'm not sure
> that implementing it will be straightforward.
>
> Are there better suggestions on how to deal with this?

The general problem is aliasing in the working-tree, of which
case-insenitivity is the most common form, but it also happens due to
HFS's use of NFD. A search on gmane for "insensitive" or "nfd" will
return many hits.

I think the argument against remapping filenames is that it doesn't
really help the user.

Let's say (for the sake of argument) that git supported remapping
between the index and the working-tree. Further, my repo has:

$ cat Foo.c
#include "Foo.h"

$ cat foo.c
#include "foo.h"

And on a case-insensitive file-system, git has remapped foo.[ch] to
foo~2.[ch] for the purposes of avoiding collisions on checkout.

The checkout can't be compiled correctly, so what's the point of even
allowing it?

(I'm not saying this is right/wrong, just that's been one of the
arguments against remapping.)

j.
