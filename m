From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Handling multiple parallel versions.
Date: Wed, 21 Jul 2010 11:59:52 -0500
Message-ID: <20100721165952.GA14144@burratino>
References: <4C471223.9050303@ianhobson.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ian Hobson <ian@ianhobson.co.uk>
X-From: git-owner@vger.kernel.org Wed Jul 21 19:01:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObcfK-0005lW-1L
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 19:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368Ab0GURAz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 13:00:55 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34627 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab0GURAy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 13:00:54 -0400
Received: by eya25 with SMTP id 25so1734324eya.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 10:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=JT0M682tBwIxTvhRka+OhZeAiWTgzYk3NtvKCWPv8Tw=;
        b=i5AR7hqvDkMRHpTAW3kdDNphGwLKm+ZFrnSXVyQw4N9Ho1Qhsl9yv2BDD3+aQpIlBx
         Xc0Yopiqp1Kq0AkBXFKGorRLrW9v6HnFDLwFOsYGCxAknahxB1ykBaPkQhH+7r2yu0eU
         AZsbGAoqCRQQdrMFsCTt1fDqREXN2b2H+iuug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=RrWhO1OXM5r+pNRm7SUw6y6A1z/3bcZYu97aW0NYgiiIadJ5P+PS/pHXQL5BCOILeT
         GD2Xqypacz1Fd/E35A3Ab8mpvIug2lL4I+KzKG3m2wONDXqFdwAyQT5baB3Jrfl14vPk
         nuBYx2ocOhqG4ZNfl5b22aTaVn2/vwLcLloNk=
Received: by 10.216.168.198 with SMTP id k48mr408829wel.105.1279731653021;
        Wed, 21 Jul 2010 10:00:53 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p45sm3523499weq.45.2010.07.21.10.00.50
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 21 Jul 2010 10:00:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C471223.9050303@ianhobson.co.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151406>

Hi Ian,

Ian Hobson wrote:

> O--O--O--O--O--O--O--many more--O--O--O--O--O--O--O--O  Master
> | \
> |  O--O--O--O--O--O--O--many more--O--O--O--O--O--O--O--O London
> |
> | \ O--O--O--O--O--O--O--many more--O--O--O--O--O--O--O--O Birmingham
> |
> | \ O--O--O--O--O--O--O--many more--O--O--O--O--O--O--O--O Glasgow
> |
> | \ O--O--O--O--O--O--O--many more--O--O--O--O--O--O--O--O Sheffield
> |
>  \ O--O--O--O--O--O--O--many more--O--O--O--O--O--O--O--O Cardiff
>=20
> All the rebase master's are taking an age (and involve many
> conflicts). They are taking linger than the development.
>=20
> So this solution is NOT working for maintaining parallel versions.

I like the train track guide.  My suggestion would be to take a step
back and consider what your requirements are.

=E2=80=98git rebase=E2=80=99 was designed to support a workflow in whic=
h individuals
are responsible for short patch series (up to 10 patches, say) that
have not been reviewed and accepted yet.  To save reviewers the
trouble of placing themselves in a mindset of the past, the patch
submitter occasionally =E2=80=9Crefreshes=E2=80=9D the patches to fit a=
n appropriately
modern codebase.

With this comes a downside: if the patch submitter immediately sends
the patches after doing this (bad submitter!), they are sending
untested code.  Furthermore, they make it very hard for /other people/
to develop code on top of their constantly shifting code.  So when
a patch series grows long enough that a simple read-through would be
unfeasible anyway, rebasing can be a very bad idea.

You may also be interested in
http://thread.gmane.org/gmane.comp.video.dri.devel/34739/focus=3D34744

Good luck,
Jonathan
