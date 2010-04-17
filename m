From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2 5/6] http-fetch: Use index-pack rather than
	verify-pack to check packs
Date: Sat, 17 Apr 2010 12:30:10 -0700
Message-ID: <20100417193010.GB15911@spearce.org>
References: <201004152134.10555.j6t@kdbg.org> <1271366704-25262-1-git-send-email-spearce@spearce.org> <g2sbe6fef0d1004151955g6fa785c0id852c91c78584b06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 21:30:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Dj0-0002en-Ar
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 21:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150Ab0DQTaQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Apr 2010 15:30:16 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:50072 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357Ab0DQTaP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 15:30:15 -0400
Received: by gxk9 with SMTP id 9so2204261gxk.8
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 12:30:13 -0700 (PDT)
Received: by 10.150.131.9 with SMTP id e9mr3588263ybd.15.1271532612905;
        Sat, 17 Apr 2010 12:30:12 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 21sm1130994ywh.32.2010.04.17.12.30.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 12:30:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <g2sbe6fef0d1004151955g6fa785c0id852c91c78584b06@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145172>

Tay Ray Chuan <rctay89@gmail.com> wrote:
> > @@ -152,7 +152,6 @@ struct http_pack_request
> > =A0 =A0 =A0 =A0struct packed_git *target;
> > =A0 =A0 =A0 =A0struct packed_git **lst;
> > =A0 =A0 =A0 =A0FILE *packfile;
> > - =A0 =A0 =A0 char filename[PATH_MAX];
>=20
> Why this change? Just curious, nothing strong against it.

Split into a new patch.  I'll share my reasons in the commit message.
:-)
=20
> > + =A0 =A0 =A0 tmp_idx =3D xstrdup(preq->tmpfile);
> > + =A0 =A0 =A0 strcpy(tmp_idx + strlen(tmp_idx) - strlen(".pack.temp=
"),
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0".idx.temp");
>=20
> Could we use a strbuf here?

Doesn't seem worth it.  I just started trying to rework this with a
strbuf and I just don't see any benefit here.  We know the tmpfile
ends with ".pack.temp" when we created this request structure.  So
a strdup and overwrite of the tail just works.
=20
> > + =A0 =A0 =A0 if (move_temp_to_file(preq->tmpfile, sha1_pack_name(p=
->sha1))
> > + =A0 =A0 =A0 =A0|| move_temp_to_file(tmp_idx, sha1_pack_index_name=
(p->sha1))) {
>=20
> Hmm, when moving the pack index file, should we unlink() the old,
> downloaded one first?

Yup, good point, thanks.

--=20
Shawn.
