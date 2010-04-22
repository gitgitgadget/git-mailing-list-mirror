From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Useless error message?
Date: Thu, 22 Apr 2010 04:42:16 -0500
Message-ID: <20100422094153.GA504@progeny.tock>
References: <z2o3abd05a91004211417v263d5a0eg497341ddf7bd79a5@mail.gmail.com>
 <20100421221953.GA25348@progeny.tock>
 <7vwrw0573t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Aghiles <aghilesk@gmail.com>, git list <git@vger.kernel.org>,
	Kim Ebert <kd7ike@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 11:42:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4svK-0002Zd-9i
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 11:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840Ab0DVJmJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 05:42:09 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44397 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813Ab0DVJmF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 05:42:05 -0400
Received: by pwj9 with SMTP id 9so5810602pwj.19
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 02:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8GcJtRip+7NuAJgpgxaXQx0z/ZGN6raucA40NF+cxlc=;
        b=OebxMzrno9JpkQdN+OjDjcw/FLFrnC2xTxvqx7xnUs+OI3sl09/tzwbXeTmNl5Ewzi
         Gj0g3+huvu5NhepoQPiozE57Lzg6JzjNSIGhlzPEA4HOEt07iJkAvO3tpeUgcoif6uR2
         N7ucBhsPYYYxxIpQcRzn0OXfeA2SeFXEOqIf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ix9NtUyJtBrtm5wbdoiT4+qGRzGIECAOnDdXXflXPtY26NEFOhxZsTEmwTL9MNvY9U
         4iZz6KBcQb8eupLaNyneNGY5SGNYRHl7ve5tROAC4nS+v7jKEPPAnNzymliBpn1M6WRI
         M91m/szJr4c0l8mPtHGQN/Rpr46nkgAC3nvAo=
Received: by 10.142.9.17 with SMTP id 17mr4323194wfi.325.1271929325422;
        Thu, 22 Apr 2010 02:42:05 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm7257243iwn.10.2010.04.22.02.42.04
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 Apr 2010 02:42:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vwrw0573t.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145513>

Junio C Hamano wrote:

> The true story is a bit different.
>=20
> To avoid information leak to git-daemon clients, we deliberately choo=
se
> not to give detailed error messages, so that you cannot tell if an er=
ror
> means a user "u" does not exist or "u" does but ~u/repo.git repositor=
y
> does not exist.

Thanks for the clarification.  As I see it, these are two different
classes of problem:

1. The git daemon is very quiet, usually for good reason, as you
   mentioned [1] [2].

2. The git daemon and protocol helpers do not always send the datum =E2=
=80=9Ca
   controlled fatal error occured=E2=80=9D by writing some message (any
   message) to side band 3.

=46ixing the daemon=E2=80=99s share in both might require setting up a =
side band
very early.  If an RFC patch appears setting up the side band (or an
explanation for why that=E2=80=99s not possible), I would be happy to s=
tart
work building from there.

That has been the big obstacle for me experimenting with it, more than
the information disclosure.  But this is easy to say.  The doing is
more important.

Thanks again, and sorry for the noise.
Jonathan

[1] I do suspect that in the case of failing enter_repo() or missing
git-daemon-export-ok, saying =E2=80=9Ccannot read the specified repo=E2=
=80=9D would be
fine.  Most of the time, there is not much value in disclosing a more
detailed reason, anyway.

[2] Example fix for a problem in this class:
http://thread.gmane.org/gmane.comp.version-control.git/139029
