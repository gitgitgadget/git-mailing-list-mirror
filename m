From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Possible regression in ref advertisement
Date: Tue, 26 Feb 2013 16:04:29 +0100
Message-ID: <1361891069.9005.11.camel@flaca.cmartin.tk>
References: <1361811516.3212.14.camel@centaur.cmartin.tk>
	 <7vvc9gxn2y.fsf@alter.siamese.dyndns.org>
	 <1361819916.24515.5.camel@centaur.cmartin.tk>
	 <7vip5gxkgy.fsf@alter.siamese.dyndns.org>
	 <1361822092.30765.12.camel@centaur.cmartin.tk>
	 <7v1uc4ximl.fsf@alter.siamese.dyndns.org>
	 <1361824519.31692.12.camel@centaur.cmartin.tk>
	 <7vfw0kt7qc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 16:05:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAM5W-0002sj-6f
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 16:05:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759491Ab3BZPEg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Feb 2013 10:04:36 -0500
Received: from hessy.cmartin.tk ([78.47.67.53]:54891 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1759232Ab3BZPEf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 10:04:35 -0500
Received: from [87.77.57.197] (z39c5.pia.fu-berlin.de [87.77.57.197])
	by hessy.dwim.me (Postfix) with ESMTPSA id 4E28880616;
	Tue, 26 Feb 2013 16:04:33 +0100 (CET)
In-Reply-To: <7vfw0kt7qc.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.6.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217136>

On Mon, 2013-02-25 at 13:16 -0800, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> >> As packed-refs file is expected to be a text file, it is not
> >> surprising to get an undefined result if the it ends with an
> >> incomplete line.
> >
> > I guess that depends on what you mean by incomplete.
>=20
> I used that word in the POSIX sense, i.e.
>=20
>   http://pubs.opengroup.org/onlinepubs/9699919799/xrat/V4_xbd_chap03.=
html#tag_21_03_00_67

Huh, I must revise my POSIX. Sure, in that sense it's incomplete.

>=20
> Unless the user edited the file, an incomplete line may indicate
> that the file has been truncated when (or after) it was written, and
> we have to suspect not just that the last "line" may have been
> truncated (in this case, not having the full 40-hex object name),
> but other records that should have been after that line were lost.
>=20
> We may want to detect such corruption at runtime, at least at
> strategic places; making it a hard runtime error will make it
> difficult to use Git itself to recover from such an corruption
> (e.g. you may have a healty mirror from which you can recover refs
> with "fetch --mirror").

Since the libgit2 parser seems to work with it, it's perfectly possible
I did mess about with the file and then promptly forgot. An error would
definitely not help here, but I do think a warning should be issued if
the file isn't quite as it should be. It seems the parser can already
detect this, so it could be as easy as adding a fprintf(stderr, "...").

>=20
> We should at least refrain from running repack/gc to make things
> worse, for example.
>=20

Sounds sensible, yep.

   cmn
