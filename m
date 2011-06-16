From: James Blackburn <jamesblackburn@gmail.com>
Subject: Re: git log --follow doesn't follow a rename over a merge
Date: Thu, 16 Jun 2011 19:41:14 +0100
Message-ID: <BANLkTikMNYyV40XM26rc6Ov6ZYO643mukA@mail.gmail.com>
References: <BANLkTimjEp0ntq80qttT9uZN2YGuhsnZBw@mail.gmail.com>
	<m362o5vrhd.fsf@localhost.localdomain>
	<BANLkTik1-UvEXqzgdXwcK3x6_o8fDiwB7g@mail.gmail.com>
	<20110616173451.GB6584@sigill.intra.peff.net>
	<7vy611hd38.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 20:41:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXHVJ-0000eP-Dl
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 20:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283Ab1FPSlQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jun 2011 14:41:16 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:36717 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638Ab1FPSlP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jun 2011 14:41:15 -0400
Received: by qyg14 with SMTP id 14so949116qyg.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 11:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HqzEvGWUy9Sddy9NG1IU2T95mOwQR/8dahyFnXWmumE=;
        b=NNY2q8BXoZXblta6FQcLvDeGAgBaj//BI9ZyB5Fm9tTOV2ncWWeqExSUVjpgD0+WVc
         Flobo57l6KVZ6dbisWx8/c10+BHN7Hqtl+QDkW56mgXy9y15xK592b0hBh3Qy+eBK2qK
         S0zkY6uLauwH06QTui0bLrke4Gsp5T6/ik4K8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lJFV4pZqXIyUvpYeCzvcawuQpRo4IgyILQwGiqVRICkz6f4YoteTSJBI8Dp2dtN3tS
         WWyQeDeo3oDvjmK2R8Tt92zdKK0+/86ndlAL4BEaHzuiBecPBbo3Sj61AxtuiML//f+O
         qQrLZniY5jfR8tNgEu5lXtjk5f9CMlKi09tDo=
Received: by 10.229.41.211 with SMTP id p19mr736407qce.117.1308249674886; Thu,
 16 Jun 2011 11:41:14 -0700 (PDT)
Received: by 10.229.214.203 with HTTP; Thu, 16 Jun 2011 11:41:14 -0700 (PDT)
In-Reply-To: <7vy611hd38.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175914>

On 16 June 2011 18:59, Junio C Hamano <gitster@pobox.com> wrote:
> =A0 past ---o----o-----o-----o-----o-----o-----o-----o--- now
> =A0 =A0 =A0 =A0 =A0 =A0\ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0/
> =A0 =A0 =A0 =A0 =A0 =A0 o----*----o----o----*----o
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0^added =A0 =A0 =A0 =A0 ^removed
>
> then the merges are simplified away and you would not see it.
>
> Perhaps simplify-merges option may help.

Magic, that works!

What I don't get is that I believe the file is removed in the 'merge'
commit 'X', which is reachable from master, not in the feature branch:

 2002 ---o----o-----o-----o-----X-----o-----o-----o--- 2011         (CD=
T)
                                    /
 2006 ---o----o-----o-----o--   (2009)                                 =
 (DSF)

> git log --simplify-merges --oneline -- plugins/org.eclipse.dd.dsf.deb=
ug/src/org/eclipse/dd/dsf/debug/service/IBreakpoints.java
2f1c904 [memory] DSDP-DD -> CDT initial commit
5b47187 Migrated DSF and DSF-GDB to the CDT project.
10580b5 Updated copyright statements.
=2E..

So 5b48718 is X, and the file exists in the DSF parent of X: c1e6da2

I think 2f1c904 is entirely wrong too -- it's another graft I've done,
to a different repo, which isn't to do with DSF, and doesn't contain
IBreakpoints.java:
 > git show 2f1c904:plugins/org.eclipse.dd.dsf.debug/src/org/eclipse/dd=
/dsf/debug/service/IBreakpoints.java
fatal: Path 'plugins/org.eclipse.dd.dsf.debug/src/org/eclipse/dd/dsf/de=
bug/service/IBreakpoints.java'
does not exist in '2f1c904'

Given the file was removed during my 'merge' graft in commit X,
shouldn't it be visible  in log without --simplify-merges?

Cheers,
James
