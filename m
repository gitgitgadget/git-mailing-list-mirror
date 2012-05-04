From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Index format v5
Date: Fri, 4 May 2012 17:44:24 +0200
Message-ID: <20120504154424.GA923@tgummerer.unibz.it>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
 <CACsJy8B9p1Z_eW20mZwBLwRnFWHstEdRxmw7GujECpMKByfBEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	mhagger@alum.mit.edu, peff@peff.net, spearce@spearce.org,
	davidbarr@google.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 17:44:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQKgM-0003oA-Ov
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 17:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360Ab2EDPoa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 11:44:30 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:42626 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab2EDPo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 11:44:29 -0400
Received: by wibhj6 with SMTP id hj6so1491411wib.1
        for <git@vger.kernel.org>; Fri, 04 May 2012 08:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1AY6K0tQE/z1w6A5nnxAgSnQVwXSXbELFqnHN6FA89E=;
        b=aMMoKQasVxLjzrKd+KFOsc6BEwlbdGloehUxj3TyAIbAvXDQyIb71qSA4bGaQ0O9aT
         IGOcDEOyXoj1GfXNYI0W+jLi0hfHhNLSkEH1qIZruIavhG5u4G7JaWl8TBSCSHFlT77G
         zc2Dx/2a1z6CYOJNQ1jbGE3oKfb6b7t/QWapga+1aQ6qHlta9Brx39XHS6CsHfbuHitO
         xluyYT2/nVQdOmvAN8B/5y4J2n9QJeSYDzL+b2WJig0Vnonw6WQHTpc/BUdQxjpzWwOD
         bZSBnbGDBYszVOCgjBHhnC/nF2ac5NceEu238CVj8ksJY12meykd2ri0NGDMkls9Z8MY
         AXYg==
Received: by 10.216.138.135 with SMTP id a7mr4322203wej.19.1336146267570;
        Fri, 04 May 2012 08:44:27 -0700 (PDT)
Received: from localhost ([46.18.27.126])
        by mx.google.com with ESMTPS id gg2sm16139500wib.7.2012.05.04.08.44.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 May 2012 08:44:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8B9p1Z_eW20mZwBLwRnFWHstEdRxmw7GujECpMKByfBEg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197030>



On 05/04, Nguyen Thai Ngoc Duy wrote:
> On Fri, May 4, 2012 at 12:25 AM, Thomas Gummerer <t.gummerer@gmail.co=
m> wrote:
> > GIT index format
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > =3D The git index file has the following format
> >
> > =C2=A0All binary numbers are in network byte order. Version 5 is de=
scribed
> > =C2=A0here.
> >   ...
> > =C2=A0 - A number of directory offsets (see below). [1]
> >
> > =C2=A0 - A number of sorted directories (see below). [2]
> >
> > =C2=A0 - 32-bit crc32 checksum for the header, extension offsets an=
d directories.
>=20
> So we use one checksum for all dirs? I thought we could do checksum
> per dir, so if I'm interested in path/to/here only, I only need to
> verify data of three directories.

Good point. Not sure how they could exactly be implemented, but probabl=
y
one checksum for offset + directory data. I'll definitely think about t=
his.

> > =3D=3D Directory entry offsets
> >
> > =C2=A032-bit offset to the directory.
> >
> > =C2=A0This part is needed for making the directory entries bisectab=
le and
> > =C2=A0 =C2=A0thus allowing a binary search.
>=20
> How is this (I assume) array ordered? The same top-down depth-first
> with "Directory entry" section below? I can see ordering as
> top-down/breadth-first help bsearch though.

True, the breadth-first approach might be better, since we are using
prefix compression for the pathname. It will need some more offsets
(or calculation, but should still be faster)

> > =3D=3D Directory entry
> >
> > =C2=A0Directory entries are sorted in lexicographic order by the na=
me
> > =C2=A0of their path starting with the root.
> >
> > =C2=A0Path names (variable length) relative to top level directory =
(without the
> > =C2=A0 =C2=A0leading slash). '/' is used as path separator. '.' ind=
icates the root
> > =C2=A0 =C2=A0directory. The special patch components ".." and ".git=
" (without quotes)
> > =C2=A0 =C2=A0are disallowed. Trailing slash is also disallowed.
> >
> > =C2=A01 nul byte to terminate the path.
>=20
> I don't see it mention prefix compression here, nor in "file entry"
> section. Does it use it here? If so I don't think prefix compression
> plays well with bsearch (on path name). In the worst case you may hav=
e
> to process up to the first entry in order to get a path name (e.g. a
> directory with entries "a", "aa", "aaa", "aaaa"...)

I planned to use prefix compression here, which would benefit especiall=
y
the reader (we're reading more often then writing). By designing the
offsets carefully we should still be able to get log(n) (n =3D number o=
f
directories in the index) search time for a directory.

> > =C2=A0The entries are written out in the top-down, depth-first orde=
r. The
> > =C2=A0 =C2=A0first entry represents the root level of the repositor=
y, followed by
> > =C2=A0 =C2=A0the first subtree - let's call it A - of the root leve=
l, followed by
> > =C2=A0 =C2=A0the first subtree of A, ...
>=20
> So depth-first traversal becomes natural even without the help of
> directory offset table above. Nice.
>=20
> > =3D=3D File entry
> >
> > =C2=A0File entries are sorted in ascending order on the name field,=
 after the
> > =C2=A0respective offset given by the directory entries.
>=20
> I wonder if we need to keep file entry table separate from directory
> entry. It feels more natural to put the sequence of file entries of a
> directory right after the directory entry, might help read-ahead too
> during traversal. You save 4 bytes (for file entry offset) in each
> directory entry. You still have file offset table for random access.

The reason for this design choice is the fast searching of a directory,=
=20
(for partial reading or changing a single file in the index). Keeping
them separate also simplifies the reading of the cache-tree, which will
be included in the directory section. Instead of offsets to the first f=
ile
we'd need offsets to the next directory to enable fast reading of the
cache-tree.

> > =C2=A0File name (variable length). Nul bytes are not allowed in fil=
e names and
> > =C2=A0 =C2=A0they have no leading slash. They are 7-bit ASCII encod=
ed.
>=20
> Why can't it be 8-bit? I suppose file name is also prefix compressed?

I changed that, the file name can have UTF8 or ASCII encoding, as it wa=
s
allowed in the old index.

--
Thomas
