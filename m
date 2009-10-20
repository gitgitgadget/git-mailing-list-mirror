From: Eugene Sajine <euguess@gmail.com>
Subject: Re: ident hash usage question
Date: Tue, 20 Oct 2009 14:59:53 -0400
Message-ID: <76c5b8580910201159i75a90f28pb882e83f0c7c40ae@mail.gmail.com>
References: <76c5b8580910201024x58ffdd3bs6f4cc6932ac31868@mail.gmail.com>
	 <81b0412b0910201116s694d7877rda872b368f1ae09a@mail.gmail.com>
	 <81b0412b0910201119w7583487ag276cf964d0a85e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eugene Sajine <euguess@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 21:00:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0JwC-0000vC-2P
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 21:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbZJTS7u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 14:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbZJTS7u
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 14:59:50 -0400
Received: from mail-gx0-f212.google.com ([209.85.217.212]:49616 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbZJTS7t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 14:59:49 -0400
Received: by gxk4 with SMTP id 4so4973701gxk.8
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 11:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7ViCvRg6vLPCf4z7vsmDaeFbr1txxEjTS0CyWfoaKZg=;
        b=grvP/6+Tph3UHS1wQ+Sq3cGT3pMwYctljfhLmKXwt/7jw5CapRz6BlCqbbbdU40Ggn
         LjReZHTKe4sbA5lZsXq8rVOGQkRe1e4NHUjVO925zOXxt5eEeowz3Ha2IhD/CRgW4aQj
         RCaU4WOoQy0I1TQEve30uOmGlMdH0fv1itBAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=perAd21WIAcRXnDGRTBh+HepS7/6BTg+jeLMPZ7DJ/NLmtx03HL9tmcccCFQWTcI2S
         wwLXptQPl7oiutyMrpvpwF4A68gSskJij5HNEJXhBNYLndOXvlgeaH88BVkmzW96wEwH
         7JTwUJSzE7TUaVooVE5W4URnfDzUKyBFj+XhM=
Received: by 10.91.45.22 with SMTP id x22mr7071553agj.120.1256065194019; Tue, 
	20 Oct 2009 11:59:54 -0700 (PDT)
In-Reply-To: <81b0412b0910201119w7583487ag276cf964d0a85e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130825>

>
> Well, not exactly impossible, but you can end up with multiple paths,
> some of which may not have anything to do the original path.
>
> Just run git log --no-abbrev --raw --all and grep for the SHA-1
>

This is exactly what I was looking for! Thank you!

I understand that in some cases this can give me two paths instead of
one, but it will only demonstrate that I have absolute copy of a file
inside my repo, which is also good to diagnose (because the
probability of having two meaningful files with the same hash, but
different content is way too low).

So, this means that after few little tricks the keyword expansion
problem may be resolved by only using $Id$ keyword.
Because after having this hash one can build up all necessary info from=
 it:

#finding blobs with SHA indicated in $Id$ keword
$ git log --no-abbrev --raw --all | grep SHA-1

# little script or regexp here (don=E2=80=99t have it)
$ pull out path from result

# last commit for the path with all corresponding info
$ git log -1 HEAD path

So, this seems to cover most of the needs of people who would like to
use keywords expansion, if they are not ready to forget about them=E2=80=
=A6

Does it make sense?

Thanks,
Eugene
