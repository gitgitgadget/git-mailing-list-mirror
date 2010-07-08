From: Elijah Newren <newren@gmail.com>
Subject: Re: Question about git revert
Date: Wed, 7 Jul 2010 22:51:05 -0600
Message-ID: <AANLkTimcNThv2qJBcJKpj5qzoFzZtLHfVq_TwyqTIKAo@mail.gmail.com>
References: <20100708015019.GP10042@volcano.builtonlinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Hal Eisen <eisen@dunhackin.org>
X-From: git-owner@vger.kernel.org Thu Jul 08 06:51:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWj4s-0002QD-Dh
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 06:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335Ab0GHEvI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 00:51:08 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42591 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771Ab0GHEvH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jul 2010 00:51:07 -0400
Received: by vws5 with SMTP id 5so596151vws.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 21:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UC9eJDbp8B6m6F5qGlnIeCBsVlMFIWTE2KDQvntwMQ0=;
        b=rb4ccT7HsOubiykqbeEKL2yrM0ad/nHDXpyENHXYn7AH0zqvIZnIinP1P62/HVzNFr
         inDWWaum/r2wJNmSkE1OoEoAcnstBZkw4hOKtm//3hbpezmGJFwWNNPb9DmIL6pfkq1R
         oFxmwNSb+L5ZEDWtBY/LyOLwrwgzpt1D8TM7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Nmi6tCm3bPDqBR+sSj9NBRX8Me3aF4Q13UyvCK6r+AXqLVnOyI8nx0YpagBG2IYq53
         7LiOjsUiuTiWDPr6uN/2XJJpTFbTxrpERpE8TocNEqJujOnAnRnrXr6fSNc0hPgj9kOw
         qOw7h65sAMUZxwXpDZDpLop5W9bi5raKsDOOc=
Received: by 10.220.46.134 with SMTP id j6mr4007810vcf.24.1278564665941; Wed, 
	07 Jul 2010 21:51:05 -0700 (PDT)
Received: by 10.220.92.199 with HTTP; Wed, 7 Jul 2010 21:51:05 -0700 (PDT)
In-Reply-To: <20100708015019.GP10042@volcano.builtonlinux.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150535>

Hi,

On Wed, Jul 7, 2010 at 7:50 PM, Hal Eisen <eisen@dunhackin.org> wrote:
> I did a search of the archives for this mailing list, and couldn't
> find anything applicable.
>
> I am having the same problem as Joshua Cheek. =C2=A0He asked this que=
stion
> on StackOverflow about a month ago.
>
> http://stackoverflow.com/questions/2938301/git-remove-specific-commit
>
> There are no merges involved. =C2=A0I would be perfectly happy having
> another commit in my history which documents the reverting of a prior
> commit.
>
> The problem seems to stem from git-revert not properly calculating th=
e
> "cleanness" of the prior commit, and incorrectly thinking that later
> commits depend on the to-be-reverted commit.

Reverts will only be clean if you're undoing changes on lines that
haven't been touched in subsequent commits AND the 3 lines on both
sides of such changes have not been modified either.  (The 3 lines of
context means that in your example, later commits _do_ depend on the
to-be-reverted commit).  In your example, you're dealing with a file
with only three lines, one line added per commit.  Thus, in that
example, you can't revert any of the commits cleanly except the last.

> I have seen other web sites which suggest using git to manually
> generate a diff, and then applying it as a reverse patch, but that
> seems like a kludge.

This solution would have the exact same problem (unless you created a
patch with 0 lines of context).

> What is the best solution for this use case?

Manually fix the conflict.  Or see Christian's email about using
special strategies, if you can find or write one for this special case
that doesn't depend on context lines (a strategy that is usually not
desirable for source code).


Hope that helps,
Elijah
