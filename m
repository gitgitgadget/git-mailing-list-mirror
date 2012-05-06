From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Index format v5
Date: Sun, 6 May 2012 17:23:58 +0700
Message-ID: <CACsJy8Ba3F45-gx90JVxyOscxX=-JKj5Kbjrd53q_NWXw-nPSg@mail.gmail.com>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	mhagger@alum.mit.edu, peff@peff.net, spearce@spearce.org,
	davidbarr@google.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 12:24:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQydm-0004ed-KR
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 12:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142Ab2EFKYa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 06:24:30 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:45050 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973Ab2EFKY3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2012 06:24:29 -0400
Received: by werb10 with SMTP id b10so720865wer.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 03:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=E/NwChnqqmRNiMYjwRY6O392IEgCNicm5gnC+cawjzI=;
        b=R2Gi40wkzbnTHYw2AtgJuUdQtm8EwhkyHqTv+ainEADYRbxau0aEaqDFL82V9ccBCM
         NqBjR+15S1KeMsF1LPxiiivqEOB0f2S71Ert3vWfbk5qNrLrhyMxrKiuT9QYeFSFtcPQ
         DnjvomJehH+UeUyj18jZJpPJ5x8pM1hgLFsW5YD/uBy6RktDdFKOAkznFedQdDvMyYCY
         F3Dcxv2MRVsWra1lfGyy8SkUL6ar4BY5y7ILEp3xoZ531tlty/jtQhhZRlsMP1a1GV6c
         CrCfk5vY7RnJIVsCS+rW7KtLzirxULwmCy6m++fc+vE/xjYgx0bEPhZvdSOKh8vNNM75
         eejw==
Received: by 10.180.104.137 with SMTP id ge9mr26427680wib.20.1336299868545;
 Sun, 06 May 2012 03:24:28 -0700 (PDT)
Received: by 10.223.14.193 with HTTP; Sun, 6 May 2012 03:23:58 -0700 (PDT)
In-Reply-To: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197162>

On Fri, May 4, 2012 at 12:25 AM, Thomas Gummerer <t.gummerer@gmail.com>=
 wrote:
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
>
> =C2=A032-bit offset to the first file of a directory
>
> =C2=A032-bit offset to conflicted/resolved data at the end of the ind=
ex.
> =C2=A0 =C2=A00 if there is no such data. [4]

If it's non-zero, how do we know how many conflict entries we have?

> =C2=A04-byte number of subtrees this tree has

let's name this nr_subtrees

> =C2=A04-byte number of entries in the index that is covered by the tr=
ee this
> =C2=A0 =C2=A0entry represents. (entry_count) (-1 if the entry is inva=
lid)

and this nr_entries.

So how do we know how many entries (including all dirs, files, staged
files) this directory has? I assume if enry_count !=3D -1, the number
would be nr_subtrees + nr_entries (or just nr_entries, depending on
your definition). When entry_count =3D=3D -1, how do we calculate this
number?

> =C2=A0160-bit object name for the object that would result from writi=
ng
> =C2=A0 =C2=A0this span of index as a tree.
>
> =C2=A0The last 24 bytes are for the cache tree. An entry can be in an
> =C2=A0 =C2=A0invalidated state which is represented by having -1 in t=
he entry_count
> =C2=A0 =C2=A0field. If an entry is in invalidated state, the next ent=
ry will begin
> =C2=A0 =C2=A0after the number of subtrees, and the 160-bit object nam=
e is dropped.
>
> =C2=A0The entries are written out in the top-down, depth-first order.=
 The
> =C2=A0 =C2=A0first entry represents the root level of the repository,=
 followed by
> =C2=A0 =C2=A0the first subtree - let's call it A - of the root level,=
 followed by
> =C2=A0 =C2=A0the first subtree of A, ...

Assume the command is "git diff -- path/to/h*", we don't need full
index, just stuff in "path/to/h*" from the index. I'm trying to see
how to load just those paths from index, not full index.

I assume again that you won't invent a new function and use
tree_entry_interesting() to do tree pruning while loading index.
t_e_i() is designed to read tree objects. But I think we can make it
read on-disk directory/file entries with a few small changes. t_e_i()
is recursive and fits quite well with depth-first directory layout in
the proposed index format.

I have difficulties figuring out how you skip subtrees though. Assume
we are at "path" and we are not interested in anything there until we
meet "path/to", how do you skip subtrees "path/abc" and "path/def"?
Processing directory entries sequentially will eventually get us to
"path/to", but that could be a lot of entries if "path/abc" is deep. A
file offset pointer to the next sibling directory entry might help.
Does such a pointer exist but I did not see it, or you have other
means to do this?

Also the file/dir separation makes it more difficult to match the last
"h*" part, if there are both "here" directory and "howto" file.
--=20
Duy
