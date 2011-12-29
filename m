From: Bill Zaumen <bill.zaumen+git@gmail.com>
Subject: Re: Possible submodule or submodule documentation issue
Date: Wed, 28 Dec 2011 18:50:30 -0800
Message-ID: <1325127030.1681.35.camel@yos>
References: <1325013859.1987.65.camel@yos>  <4EFB725C.7030600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 29 03:50:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rg64p-000590-AX
	for gcvg-git-2@lo.gmane.org; Thu, 29 Dec 2011 03:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941Ab1L2Cuj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Dec 2011 21:50:39 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55278 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab1L2Cuh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2011 21:50:37 -0500
Received: by iaeh11 with SMTP id h11so22927701iae.19
        for <git@vger.kernel.org>; Wed, 28 Dec 2011 18:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=Xz0dOZ0UXv+HSiF7tzPj0JG4wqD/F9UW/x60qUQjkVM=;
        b=cYSlwKOsJtxcNALE7BrbXtFfz2US5+diDEPMKmNtYPmOcOL2640DxjComGJAD9onLN
         FF7WoUaL2HFXVPdTd/8IrgK1JjKVVHJi4S+wjJoSvm48wCH9MHMaxwa45Y7fmIhgr+k+
         hKRJvLuLLbGMC9FfCodlZ3iovezNAt+rbgKic=
Received: by 10.42.147.6 with SMTP id l6mr34675406icv.17.1325127037271;
        Wed, 28 Dec 2011 18:50:37 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id lu10sm54695831igc.0.2011.12.28.18.50.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Dec 2011 18:50:34 -0800 (PST)
In-Reply-To: <4EFB725C.7030600@web.de>
X-Mailer: Evolution 2.30.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187768>

On Wed, 2011-12-28 at 20:47 +0100, Jens Lehmann wrote:
> Am 27.12.2011 20:24, schrieb Bill Zaumen:
> > For the 'add' command, the man page for get-submodule states
> >=20
> > "<repository> is the URL of the new submodule=E2=80=99s origin repo=
sitory. This
> > may be either an absolute URL, or (if it begins with ./ or ../), th=
e
> > location relative to the superproject=E2=80=99s origin repository."
> >
=2E..

> I assume you did forget to add a "cd library-pkg" here.

Yes, sorry for miscopying.

>=20
> Hmm, the documentation says "the location relative to the
> superproject=E2=80=99s origin repository", not the directory containi=
ng
> it. This means you have to use ".." first to get out of the
> repository itself, no?

The problem is  that the documentation also says that "<repository>
is the URL of the new submodule's origin repository" and the wording
would not make sense if the superproject's origin repository was not
also named by a URL.  The rules for resolving relative URIs (a URL is
a specific type of URI) are given in
http://tools.ietf.org/html/rfc3986#section-5.4
which has some examples:  if you resolve ./g against http://a/b/c/d;p?q
you get http://a/b/c/g (the rules are purely syntactic and the syntax
does not indicate that ".../foo.git" is a directory, and even the
slashes do not definitively indicate directories in the sense of a
file-system directory although they often do).  Also, I've enclosed a
Java program illustrating the correct behavior (a method in the Java
class library can resolve URIs so this is an independent test).

import java.net.*;
public class Test {
    public static void main(String argv[]) {
	try {
	    URI base =3D new URI("file:///home/USER/Projects/test/repo.git");
	    URI relative =3D new URI("./submodule.git");
	    URI absolute =3D base.resolve(relative);
	    System.out.println(relative.toString() + " -> "
			       +absolute.toString());
	    relative =3D new URI("../submodule.git");
	    absolute =3D base.resolve(relative);
	    System.out.println(relative.toString() + " -> "
			       +absolute.toString());
	} catch (Exception e) {
	    e.printStackTrace();
	    System.exit(1);
	}
	System.exit(0);
    }
}
