From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: [PATCH] git-svn: URL-decode the left-hand side of an svn refspec
Date: Wed, 4 Aug 2010 08:37:51 -0400
Message-ID: <AANLkTi=5qEhYABJv8CBxXwOY-UKkRc05bO=kKYkborKq@mail.gmail.com>
References: <1280877685-4928-1-git-send-email-stevenrwalter@gmail.com>
	<20100804083840.GA19367@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Aug 04 14:38:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgdEN-0006ZZ-Cz
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 14:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692Ab0HDMhy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Aug 2010 08:37:54 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36627 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932654Ab0HDMhx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Aug 2010 08:37:53 -0400
Received: by bwz1 with SMTP id 1so2361209bwz.19
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 05:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cT1UZzk8fXT0Zy8+npiZ2C5Iic0bZG/EhFHiB26jTyA=;
        b=qCFHrudaWsOKBs3UFBQwpG38eI2+NXnTJ0FaImgMFUvTUkyPeyZYWSjVG2p7QOtH/F
         hykFzyrBPqE+ro2wG465Ec7gcQNX/58Tyb6Kex1ysK0X/gV7PjmeYygZAvvVrO3BXnNX
         DsFrNgtSmdwHOyqG8RLi/d6eFzkxkyrvld4r0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C7uPefD0QbL0npjAt/SNb+NKgxrZ0QMYy38YaqUq5ZDIFjPDbClTwqeDTFuy95BqYs
         uUeb90WjRE4VfzcMoUCgzb9vaNQFrgFkVjuwxvLE6O2c/BQszeWN1vLKmjOo9+4prQx3
         bIrOiB7i1fPQYZWp6fLRPLtH2hEnlYUv3J6yo=
Received: by 10.204.24.1 with SMTP id t1mr6169089bkb.178.1280925471679; Wed, 
	04 Aug 2010 05:37:51 -0700 (PDT)
Received: by 10.204.113.137 with HTTP; Wed, 4 Aug 2010 05:37:51 -0700 (PDT)
In-Reply-To: <20100804083840.GA19367@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152576>

On Wed, Aug 4, 2010 at 4:38 AM, Eric Wong <normalperson@yhbt.net> wrote=
:
> Thanks Steven.
>
> Since git-svn already has a uri_decode() function, we should use that=
=2E
> The decoding should apply to the local portion of branches/tags globs=
,
> too. =A0Does the following work for you?
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 8d2ef3d..34884b8 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1820,6 +1820,7 @@ sub read_all_remotes {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("svn-remote.$remot=
e: remote ref '$remote_ref' "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0. "must start =
with 'refs/'\n")
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unless=
 $remote_ref =3D~ m{^refs/};
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $local_ref =3D uri_deco=
de($local_ref);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$r->{$remote}->{fetch}=
->{$local_ref} =3D $remote_ref;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$r->{$remote}->{svm} =3D=
 {} if $use_svm_props;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} elsif (m!^(.+)\.usesvmprops=3D\s*(.*=
)\s*$!) {
> @@ -1832,6 +1833,7 @@ sub read_all_remotes {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("svn-remote.$remot=
e: remote ref '$remote_ref' ($t) "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0. "must start =
with 'refs/'\n")
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unless=
 $remote_ref =3D~ m{^refs/};
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $local_ref =3D uri_deco=
de($local_ref);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0my $rs =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0t =3D> $t,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0remote =3D> $r=
emote,
> --
> Eric Wong
>

Yes, this works.  Thanks!
--=20
-Steven Walter <stevenrwalter@gmail.com>
