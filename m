From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Stg AssertionError in sink command
Date: Sat, 15 Sep 2007 23:37:21 +0100
Message-ID: <b0943d9e0709151537k51f2f8d5w5a9bbfef84f82747@mail.gmail.com>
References: <9e4733910709131308la9b3e44le70e1fac2b339189@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 00:37:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWgGU-0004kk-R5
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 00:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbXIOWhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 18:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752938AbXIOWhW
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 18:37:22 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:6239 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660AbXIOWhV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 18:37:21 -0400
Received: by rv-out-0910.google.com with SMTP id k20so985420rvb
        for <git@vger.kernel.org>; Sat, 15 Sep 2007 15:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=1ANznLEtft5A1FBCnLuIxHbdfIZkje1q1JfQUxj4qEw=;
        b=i/s5BLlcbzA927cpYC1JRnjS2g5WkXp3H7eP5yY1pscHh/YCTfLwR8bqU7gxyne/vOQlo3Aj9GUubn5xlCsEKwEwYbRC9l8v4jhbrhLUgge1qavar+UdKQlHyOzj4E5OYLiOIUgLaJlQ/jSadIRP0hX7xccXGt4Ueqmeh9T7Stk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IVyofxIiTq1ydghI4bCA2R/k5SmeAfhEfHTeuuSFnfb7T9NavPq9i4UbebhZYUtDY61oboGGO/y6BU96xAKR2FB6gMIhKuYPgnDbecuM0XFb15YwMflfJfmDAIomNG5wTK6SpYfH1hePrcaUFn0FzO6Sh3iSmZrlNVLDONfa1/o=
Received: by 10.141.52.5 with SMTP id e5mr359030rvk.1189895841105;
        Sat, 15 Sep 2007 15:37:21 -0700 (PDT)
Received: by 10.140.158.1 with HTTP; Sat, 15 Sep 2007 15:37:21 -0700 (PDT)
In-Reply-To: <9e4733910709131308la9b3e44le70e1fac2b339189@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58274>

On 13/09/2007, Jon Smirl <jonsmirl@gmail.com> wrote:
> Patch 008 was hidden and I used unhide to bring it back. But the
> hide/unhide process moved it to the top of the stack. I need to sink
> it back down to where it came from. Shouldn't hide/unhide preserve the
> patch position in the stack?

I now got the time to read this thread in more detail.

The initial implementation of hide/unhide was to preserve the patch
position in the stack. This behaviour was really confusing for people
since pushing a patch after the hidden one actually forced the pushing
of the hidden patch, which isn't normally shown by 'series'. I decided
afterwards to create a third category of patches - 'hidden' (the other
two being applied and unapplied). This cleared the unpredictable
behaviour when pushing since hidden patches cannot be pushed.

Karl's patch does the correct thing of raising an error if sinking
below an unapplied patch.

I implemented the hidden patches feature just to hide some patches I
no longer need (various tests or early prototypes of some patches) but
I still want to keep them around in case I have to look again.

Regarding the reordering of the unapplied patches, at the moment you
can (but I *don't* recommend) edit .git/patches/<branch>/unapplied.
Maybe the 'float' and 'sink' functionality could be modified to also
act on unapplied patches (with a --unapplied option). I don't think a
separate command would be needed as it duplicates a lot of
functionality from the above.

-- 
Catalin
