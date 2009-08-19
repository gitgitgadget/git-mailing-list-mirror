From: =?VISCII?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Continue git clone after interruption
Date: Thu, 20 Aug 2009 00:23:54 +0200
Message-ID: <4A8C7B7A.6070700@lsrfire.ath.cx>
References: <1250509342.2885.13.camel@cf-48> <alpine.DEB.1.00.0908171430010.4991@intel-tinevez-2-302> <vpqskfphe2k.fsf@bauges.imag.fr> <1250578735.2885.40.camel@cf-48> <alpine.LFD.2.00.0908181246470.6044@xanadu.home> <m3fxbpneqe.fsf@localhost.localdomain> <alpine.LFD.2.00.0908181537360.6044@xanadu.home> <alpine.DEB.1.00.0908190022090.8306@pacific.mpi-cbg.de> <alpine.LFD.2.00.0908181936130.6044@xanadu.home> <alpine.DEB.1.00.0908190921360.5594@intel-tinevez-2-302> <alpine.LFD.2.00.0908191122020.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=VISCII
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Tomasz Kontusz <roverorna@gmail.com>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 20 00:24:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdtaC-0006Ye-It
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 00:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbZHSWYC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Aug 2009 18:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753328AbZHSWYB
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 18:24:01 -0400
Received: from india601.server4you.de ([85.25.151.105]:50847 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205AbZHSWYA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 18:24:00 -0400
Received: from [10.0.1.101] (p57B7F4CC.dip.t-dialin.net [87.183.244.204])
	by india601.server4you.de (Postfix) with ESMTPSA id EAD412F806D;
	Thu, 20 Aug 2009 00:24:00 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <alpine.LFD.2.00.0908191122020.6044@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126585>

Nicolas Pitre schrieb:
> 3) "git archive --remote=3Dgit://foo.bar/baz CLONE_HEAD" and store th=
e=20
>    result locally. Keep track of how many files are received, and how=
=20
>    many bytes for the currently received file.
>=20
> 4) if network connection is broken, loop back to (3) adding
>    --skip=3D${nr_files_received},${nr_bytes_in_curr_file_received} to
>    the git-archive argument list.  REmote server simply skips over=20
>    specified number of files and bytes into the next file.
>=20
> 5) Get content from remote commit object for CLONE_HEAD somehow. (?)

[...]

> - That probably would be a good idea to have a tgz format to 'git
>   archive' which might be simpler to deal with than the zip format.

Adding support for the tgz format would be useful anyway, I guess, and
is easy to implement.

And adding support for cpio (and cpio.gz) and writing an extractor for
it should be simpler than writing a tar extractor alone.

One needs to take a closer look at the limits of the chosen archive
format (file name length, supported file types and attributes, etc.) to
make sure any archive can be turned back into the same git tree.

The commit object could be sent as the first (fake) file of the archive=
=2E

You'd need a way to turn off the effect of the attributes export-subst
and export-ignore.

Currently, convert_to_working_tree() is used on the contents of all
files in an archive.  You'd need a way to turn that off, too.

Adding a new format type is probably the easiest way to bundle the
special requirements of the previous three paragraphs.

Ren=E9
