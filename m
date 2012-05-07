From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Index format v5
Date: Mon, 7 May 2012 15:44:27 +0200
Message-ID: <20120507134427.GB6189@tgummerer>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
 <CACsJy8Ba3F45-gx90JVxyOscxX=-JKj5Kbjrd53q_NWXw-nPSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	mhagger@alum.mit.edu, peff@peff.net, spearce@spearce.org,
	davidbarr@google.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 15:44:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SROF1-0006uH-8D
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 15:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756553Ab2EGNoj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 09:44:39 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51417 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756519Ab2EGNoi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 09:44:38 -0400
Received: by obbtb18 with SMTP id tb18so8304697obb.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Zle1HEcK/Z51US2CxwmgT35wbKUJzokKSB73qduBxOM=;
        b=Ez+uBBqJWpnZweTqtUyW8vT0wTOlOb+I+beexzIG6GTODnW//6O+77y93YVnKYPJov
         igqxVU4Sr8noU30Q2fVksFYlKB6NFkmiR4DtaQR1Ji2TyHssQb9ijXs9XCN/Ro2x+EaJ
         PT/QstkNqLXNxaSXDszE0cbZPD67vOliCyAIgi6Kf32jNLWUUfBK62JOjq2EB7zm1xiN
         vlVCzhG1AAMJGpf06lAUtdfjTciA4M+qJrYRYmVbj3hSTX/wzH3qT4/e+aHb1dsjzNdh
         FXjc7+da/A4VcUlqWPTq8RehUoyPrq2kB8aysH7uCf5bXXyGnvcHn9VOHwhrJWXFSOc/
         tOhQ==
Received: by 10.60.23.138 with SMTP id m10mr11370438oef.12.1336398277664;
        Mon, 07 May 2012 06:44:37 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPS id m2sm18407446obk.9.2012.05.07.06.44.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 May 2012 06:44:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8Ba3F45-gx90JVxyOscxX=-JKj5Kbjrd53q_NWXw-nPSg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197271>





On 05/06, Nguyen Thai Ngoc Duy wrote:
> On Fri, May 4, 2012 at 12:25 AM, Thomas Gummerer <t.gummerer@gmail.co=
m> wrote:
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
> >
> > =C2=A032-bit offset to the first file of a directory
> >
> > =C2=A032-bit offset to conflicted/resolved data at the end of the i=
ndex.
> > =C2=A0 =C2=A00 if there is no such data. [4]
>=20
> If it's non-zero, how do we know how many conflict entries we have?

Right, I'll add this to the next version.=20

(32-bit number of conflicted/resolved data entries at the end of the
  index if the offset is non 0.)

> > =C2=A04-byte number of subtrees this tree has
>=20
> let's name this nr_subtrees
>=20
> > =C2=A04-byte number of entries in the index that is covered by the =
tree this
> > =C2=A0 =C2=A0entry represents. (entry_count) (-1 if the entry is in=
valid)
>=20
> and this nr_entries.
>=20
> So how do we know how many entries (including all dirs, files, staged
> files) this directory has? I assume if enry_count !=3D -1, the number
> would be nr_subtrees + nr_entries (or just nr_entries, depending on
> your definition). When entry_count =3D=3D -1, how do we calculate thi=
s
> number?

You're right. In order to maintain the bisectability we'll have to
keep the entry count up to date.

> > =C2=A0160-bit object name for the object that would result from wri=
ting
> > =C2=A0 =C2=A0this span of index as a tree.
> >
> > =C2=A0The last 24 bytes are for the cache tree. An entry can be in =
an
> > =C2=A0 =C2=A0invalidated state which is represented by having -1 in=
 the entry_count
> > =C2=A0 =C2=A0field. If an entry is in invalidated state, the next e=
ntry will begin
> > =C2=A0 =C2=A0after the number of subtrees, and the 160-bit object n=
ame is dropped.
> >
> > =C2=A0The entries are written out in the top-down, depth-first orde=
r. The
> > =C2=A0 =C2=A0first entry represents the root level of the repositor=
y, followed by
> > =C2=A0 =C2=A0the first subtree - let's call it A - of the root leve=
l, followed by
> > =C2=A0 =C2=A0the first subtree of A, ...
>=20
> Assume the command is "git diff -- path/to/h*", we don't need full
> index, just stuff in "path/to/h*" from the index. I'm trying to see
> how to load just those paths from index, not full index.
>=20
> I assume again that you won't invent a new function and use
> tree_entry_interesting() to do tree pruning while loading index.
> t_e_i() is designed to read tree objects. But I think we can make it
> read on-disk directory/file entries with a few small changes. t_e_i()
> is recursive and fits quite well with depth-first directory layout in
> the proposed index format.
>=20
> I have difficulties figuring out how you skip subtrees though. Assume
> we are at "path" and we are not interested in anything there until we
> meet "path/to", how do you skip subtrees "path/abc" and "path/def"?
> Processing directory entries sequentially will eventually get us to
> "path/to", but that could be a lot of entries if "path/abc" is deep. =
A
> file offset pointer to the next sibling directory entry might help.
> Does such a pointer exist but I did not see it, or you have other
> means to do this?

I have changed the index format slightly, not to use prefix compression
on the directory entries, so that binary search through the index gets
simple. Using the directory offsets, we can binary search to the
path/to. We always have log(n) (n is the number of directories) search
time for each path.

> Also the file/dir separation makes it more difficult to match the las=
t
> "h*" part, if there are both "here" directory and "howto" file.

It doesn't make it more difficult to find, since we can first just
check if there exists the directory with a binary search (and
possibly more directories, around it) and then search for the file
in the superdirectory (can you say that?) with another binary search.

--=20
Thomas
