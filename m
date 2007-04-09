From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] git-archive: document CWD effect
Date: Mon, 9 Apr 2007 21:37:21 +0100
Message-ID: <200704092137.22781.andyparkins@gmail.com>
References: <esc64d$d2u$1@sea.gmane.org> <7virc68nc1.fsf@assigned-by-dhcp.cox.net> <461A55FB.6070600@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <junkio@cox.net>,
	Nick Williams <njw@jarb.freeserve.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 03:13:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb0cK-00014o-CW
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 22:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbXDIUhd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 9 Apr 2007 16:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965338AbXDIUhd
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 16:37:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:31420 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965095AbXDIUhc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Apr 2007 16:37:32 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1603550uga
        for <git@vger.kernel.org>; Mon, 09 Apr 2007 13:37:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NUZQjKnGAw1X9lZCUmFTctRzvot51mUmXDybfYaa2+Bec0SIetVvyx6KVurLseS30TVxoxp/pq1ET7hLhKihnWI0HK0+K4C0IvHXNeZwUoHylO87QpmND29Ghu5pK1RB9D4i2k/ARBFTzpp3lTXYEb8CCVkVoaJ+VYO6t6Xca7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=W0dambRm0Cyx6PsHt58pK6dlpU236ZyIJugCQCu8Zrtsz8iTElDKtdRJNngY8rMUYFYhNcg4DBhMCGnjUUQt+W4M1X9wlCRWmTjPMGBBfkE2yWqrLcFzCi0CNpqVFep0j6QK6vhLl+LQsbroSgmX5IrknVTcFyuAdktCt0SmgSs=
Received: by 10.67.117.18 with SMTP id u18mr4246389ugm.1176151050890;
        Mon, 09 Apr 2007 13:37:30 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id j1sm9304770ugf.2007.04.09.13.37.29;
        Mon, 09 Apr 2007 13:37:30 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <461A55FB.6070600@lsrfire.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44094>

On Monday 2007, April 09, Ren=C3=A9 Scharfe wrote:

> I agree with (1) and (3), meaning that we are free to change the
> behaviour.  I don't agree with (2), though.  I'd find it strange if
> changing the working directory wouldn't change the archive contents.
>
> We should keep consistency with the rest of git here.  Since
> git-archive is just a fancy git-ls-tree, I think we should mirror its
> behaviour with respect to the working directory.  (Which is what the
> current code does. Modulo bugs, of course.)

I don't agree with the supposition that git-archive is a fancy=20
git-ls-tree.  If it were, then you'd be right.  It's not though.  It's=20
more like a git-read-tree or git-checkout-index; those both don't care=20
where you are in the working tree.

Argument 1)
git-archive should have nothing to do with a working tree in fact; it's=
=20
perfectly reasonable to expect that it would work in a bare repository=20
in fact - that's almost the definition of a command that shouldn't be=20
working directory aware.

Argument 2)
Consider the --remote option.  What "working path" should be relevant=20
when "--remote" is passed?  For consistency, git-archive should always=20
refer to the repository root.

Argument 3)
git-archive is similar to other VCS's "export" command; and for those=20
the export command in it's default form will work without a local=20
checkout and they export from the repository root.

Argument 4)
What if the repository has multiple root commits, similar to git's html=
=20
and todo branches.  Now, use git-archive and reference one of those=20
commits.  The working directory you're in now has no relevance at all=20
to the commit your targeting - it need not even exist.  The same=20
problem exists of course if you are now in a directory that didn't=20
exist in the past.



Andy
--=20
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
