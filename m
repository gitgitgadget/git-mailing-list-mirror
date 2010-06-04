From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 0/5] Patches to avoid reporting conversion changes.
Date: Thu, 3 Jun 2010 19:56:03 -0500
Message-ID: <20100604005603.GA25806@progeny.tock>
References: <cover.1275309129.git.grubba@grubba.org>
 <7vfx16oxmz.fsf@alter.siamese.dyndns.org>
 <Pine.GSO.4.63.1006031543340.22466@shipon.roxen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Henrik =?iso-8859-1?Q?Grubbstr=F6m?= <grubba@roxen.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 02:55:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKLCP-0001nJ-3I
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 02:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756903Ab0FDAzn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 20:55:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55638 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756821Ab0FDAzm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 20:55:42 -0400
Received: by iwn37 with SMTP id 37so463754iwn.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 17:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=oSmzxSGEYkcdCwjYV7oY25WQdnNh5zBSfxsJXV8n9sY=;
        b=jm3K60xjsrDLlpySVXmcI1ZuFq2grhzv40ff4SYvnmuqhgVIA1mUNIdGmqWg1ySq1Q
         H2NPzaVsJaOqbhnMzBkFMC/Clvyj/JL8nw4Ev6m2YL2JRljr9Iv3jX3EqJEsLbNOQ14P
         Ah9Bua7n0sE5P0BhiI4Vsesxs8uvwUdleSZgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=hYtm3YNT4ToWsr28ilxBeOIiHYTLaW4u+2mXKxqHVYBue2mAsqjHIWKRr11W9SwZCK
         X11yU5xgBresputSxm3a0+3XndK9DBQgZg3RG++poivZTgh6kw0BWjKznQqtmZgUNg3T
         9WjKcQa8i3E7lkcM1EOrKT/ZxFiMHjF3/egvs=
Received: by 10.231.121.18 with SMTP id f18mr140724ibr.176.1275612941718;
        Thu, 03 Jun 2010 17:55:41 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d9sm2684500ibl.10.2010.06.03.17.55.39
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 17:55:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.63.1006031543340.22466@shipon.roxen.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148375>

Hi Henrik,

Henrik Grubbstr=C3=B6m wrote:

> I believe that users typically aren't interested in if data in the
> repository is on normalized form or not (witness the autocrlf=3Dtrue
> discussion a few weeks ago, where one of the main complaints was
> that it required a renormalization (which fg/autocrlf attempts to
> solve for that specific case by not normalizing)), as long as they
> get the expected content on checkout.

I agree.  (In the case of autocrlf, it is also not very easy to
renormalize.  The usual recommendation I have seen is "git rm -r \
--cached . && git add .", which is not exactly simple.)

> This set of patches allows for an incremental, on-demand normalizatio=
n.
> Eg the user could switch the attributes for a group of files from
>
>   *.bat -crlf
>
> (let's assume *.bat files use crlf linebreaks) to
>
>   *.bat -crlf text eol=3Dcrlf
>
> and then have git normalize the individual files when there's
> actually a semantic reason for a change.

=2E.. but if I understand correctly, I don=E2=80=99t agree with this at=
 all.

Imagine someone with an old copy of git that does not do
normalization.  If you convert everything at once, she sees a single
enormous, semantically uninteresting cleanup patch (and she can check
the result with =E2=80=98diff -w=E2=80=99 or sed if suspicious).  If yo=
u wait for some
real change to piggy-back onto, on the other hand, then the per-file
normalization patches will make it hard to find what changed.

Of course, very few people use such old copies of git.  The real
problem is that git itself sees what this person would see; you are
asking to slow down everyone who tries to use diff or blame on your
repository by implicitly requiring the -w option.

> In my case, I have repositories containing files both requiring crlf
> and lf line endings, and additionally have expanded $Id$-strings
> that I want changed on first semantic change (but not before). To be
> able to use a
> git binary without this patchset I'd have to do a
>=20
>   git commit -a -m 'Normalized'
>=20
> as the first thing after a checkout.

The Right Thing would be to not set the relevant attributes until it
is time for the file to be normalized.  I can understand that that
might be hard and could require tool support.

This is not an argument against your patches, since I haven=E2=80=99t r=
ead
them (for all I know, they make everything better :)).

Regards,
Jonathan
