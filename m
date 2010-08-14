From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] reset: Better warning message on git reset --mixed
 <paths>
Date: Sat, 14 Aug 2010 16:05:06 -0500
Message-ID: <20100814210505.GA2372@burratino>
References: <1281814499-11797-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ralf Ebert <info@ralfebert.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 23:06:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkNwE-0006YY-LL
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 23:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755847Ab0HNVGl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 17:06:41 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41193 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755605Ab0HNVGk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Aug 2010 17:06:40 -0400
Received: by gwj17 with SMTP id 17so525177gwj.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 14:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=anNSPJVB847FC8ddkBlunHwleZ/18PemqkjqT6IvTEs=;
        b=s6lPtn2c5QPB24N/vpRXe333UkKrfO2dIZAxzp+F1tzVHmUEmMsKgcAK/IVeqI5JhW
         b+JzQ3yUS64trz1O/DhSuAu8H4j7um1rgIf77tBs/3S/v3rnK3Tdj2wGjaZ286scYbqa
         Jgx4NJPmlGxa3W0x0VRCdFJGIMYhdsF/nRSy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=HiONhe5kgKQEvkw4S2bALW1/pgiu2R16HHhVZuWr7cBdDkM/3r3ntNVQSzPSp8gg3g
         ACKqjGgTPgNkKBPyIm0V6ZDsNb9fkHfD7HWceUfob9cIU0sqL3QlRLpnZcvh2PRL4+O9
         j3d+XacaQuSYn1RpmL25eL9OF6oFOKEilT6/g=
Received: by 10.100.45.17 with SMTP id s17mr3781562ans.202.1281819999828;
        Sat, 14 Aug 2010 14:06:39 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id p12sm6795376ane.34.2010.08.14.14.06.38
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Aug 2010 14:06:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1281814499-11797-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153578>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Anyway, I think the warning could be better, here's a patch to
> implement that. We could also warn on a plain "git reset --mixed"
> since it's also redundant, but that would be adding something new so =
I
> haven't done that here.

That seems backwards --- it is not actually the redundancy that leads
to this warning (and I hope we never add such a warning to save people
typing).

Instead, I had assumed the idea was that some day =E2=80=9Cgit reset --=
mixed
<path>=E2=80=9D will be forbidden, eliminating a potential ambiguity in=
 that
argument and saving high-level scripts from needing -- at the end of
=E2=80=9Cgit reset --mixed <rev> --=E2=80=9D.

> +++ b/builtin/reset.c
> @@ -318,7 +318,7 @@ int cmd_reset(int argc, const char **argv, const =
char *prefix)
>  	 * affecting the working tree nor HEAD. */
>  	if (i < argc) {
>  		if (reset_type =3D=3D MIXED)
> -			warning("--mixed option is deprecated with paths.");
> +			warning("--mixed is redundant with paths, use 'git reset <paths>'=
 instead.");

Maybe:

 warning: --mixed with paths is deprecated; use 'git reset -- <paths>' =
instead
