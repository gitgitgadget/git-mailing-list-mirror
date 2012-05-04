From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Index format v5
Date: Fri, 4 May 2012 20:20:38 +0700
Message-ID: <CACsJy8B9p1Z_eW20mZwBLwRnFWHstEdRxmw7GujECpMKByfBEg@mail.gmail.com>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	mhagger@alum.mit.edu, peff@peff.net, spearce@spearce.org,
	davidbarr@google.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 15:21:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQIRf-0001C6-CP
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 15:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757029Ab2EDNVL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 09:21:11 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:39338 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756361Ab2EDNVK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 09:21:10 -0400
Received: by wibhr7 with SMTP id hr7so1390363wib.1
        for <git@vger.kernel.org>; Fri, 04 May 2012 06:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=N/qCrZU7BTbx+whwNiXiY4uAKOU9+7YuVFl9Pyl7VsM=;
        b=StURmLxZs3JX2/qZAAMjH7eiVhk7J9WV0CsSJ+SnMQ3VPqTI0OtwYhOH3+KwuFKlVB
         bUcCFHTNbngb/Omq1mcOrv0Dc+rfZFXsW2/GLmoVFJBJpfGPvMDWboSxcJGqQHQbxb5k
         kGRZxNYaaAQUL0dhluBExbRBaCEjHGqLWmceSgKXAhTUcfd7yR22DTn8z69V4IKqQ4YJ
         V8YVKicfdPfzK2MvZDCU8S+pi8La4isTlmG8VvwWIdr1Ek1PuK++uWW9cRQlfE94QJ9E
         GUZzBZIs2sNTE+fBNtQjwZGzvIIU6S/jqnK0APqtV1a28qoJzUj1CXF7amc+VWnFt8MC
         Odqg==
Received: by 10.180.78.105 with SMTP id a9mr12839352wix.20.1336137668827; Fri,
 04 May 2012 06:21:08 -0700 (PDT)
Received: by 10.223.14.193 with HTTP; Fri, 4 May 2012 06:20:38 -0700 (PDT)
In-Reply-To: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197020>

On Fri, May 4, 2012 at 12:25 AM, Thomas Gummerer <t.gummerer@gmail.com>=
 wrote:
> GIT index format
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> =3D The git index file has the following format
>
> =C2=A0All binary numbers are in network byte order. Version 5 is desc=
ribed
> =C2=A0here.
>   ...
> =C2=A0 - A number of directory offsets (see below). [1]
>
> =C2=A0 - A number of sorted directories (see below). [2]
>
> =C2=A0 - 32-bit crc32 checksum for the header, extension offsets and =
directories.

So we use one checksum for all dirs? I thought we could do checksum
per dir, so if I'm interested in path/to/here only, I only need to
verify data of three directories.

> =3D=3D Directory entry offsets
>
> =C2=A032-bit offset to the directory.
>
> =C2=A0This part is needed for making the directory entries bisectable=
 and
> =C2=A0 =C2=A0thus allowing a binary search.

How is this (I assume) array ordered? The same top-down depth-first
with "Directory entry" section below? I can see ordering as
top-down/breadth-first help bsearch though.

> =3D=3D Directory entry
>
> =C2=A0Directory entries are sorted in lexicographic order by the name
> =C2=A0of their path starting with the root.
>
> =C2=A0Path names (variable length) relative to top level directory (w=
ithout the
> =C2=A0 =C2=A0leading slash). '/' is used as path separator. '.' indic=
ates the root
> =C2=A0 =C2=A0directory. The special patch components ".." and ".git" =
(without quotes)
> =C2=A0 =C2=A0are disallowed. Trailing slash is also disallowed.
>
> =C2=A01 nul byte to terminate the path.

I don't see it mention prefix compression here, nor in "file entry"
section. Does it use it here? If so I don't think prefix compression
plays well with bsearch (on path name). In the worst case you may have
to process up to the first entry in order to get a path name (e.g. a
directory with entries "a", "aa", "aaa", "aaaa"...)

> =C2=A0The entries are written out in the top-down, depth-first order.=
 The
> =C2=A0 =C2=A0first entry represents the root level of the repository,=
 followed by
> =C2=A0 =C2=A0the first subtree - let's call it A - of the root level,=
 followed by
> =C2=A0 =C2=A0the first subtree of A, ...

So depth-first traversal becomes natural even without the help of
directory offset table above. Nice.

> =3D=3D File entry
>
> =C2=A0File entries are sorted in ascending order on the name field, a=
fter the
> =C2=A0respective offset given by the directory entries.

I wonder if we need to keep file entry table separate from directory
entry. It feels more natural to put the sequence of file entries of a
directory right after the directory entry, might help read-ahead too
during traversal. You save 4 bytes (for file entry offset) in each
directory entry. You still have file offset table for random access.

> =C2=A0File name (variable length). Nul bytes are not allowed in file =
names and
> =C2=A0 =C2=A0they have no leading slash. They are 7-bit ASCII encoded=
=2E

Why can't it be 8-bit? I suppose file name is also prefix compressed?
--=20
Duy
