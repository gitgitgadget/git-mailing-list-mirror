From: elton sky <eltonsky9404@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Wed, 4 Apr 2012 18:26:21 +1000
Message-ID: <CAKTdtZm4JFkWOq7D=tHC-t8C5yd=AG6MEkKD46z5D7fCRDEfZQ@mail.gmail.com>
References: <CAKTdtZmLOzAgG0uCDcVr+O41XPX-XnoVZjsZWPN-BLjq2oG-7A@mail.gmail.com>
	<CACsJy8C=4WaN4MZrZMaD3FqZrF2jCP5sm0F0SpDvzQnYfka9Ew@mail.gmail.com>
	<CAKTdtZkpjVaBSkcieojKj+V7WztT3UDzjGfXyghY=S8mq+X9zw@mail.gmail.com>
	<CACsJy8D85thmK_5jLC7MxJtsitLr=zphKiw2miwPu7Exf7ty=Q@mail.gmail.com>
	<CAKTdtZkx+7iU5T4oBNDEx-A5cgZCLU9ocdXmC9jRbD39J1zb3Q@mail.gmail.com>
	<87iphrjv23.fsf@thomas.inf.ethz.ch>
	<CACsJy8AqQdWO4E2oYTMLbpYhxobH8iXE-jXPoj2BcEGtfh+T=Q@mail.gmail.com>
	<CAKTdtZnxSRffZ5xAq+SgW6fmy+b3P2Fu3AZmBB1jmGca6HmJAw@mail.gmail.com>
	<CACsJy8BjYLAKqFDeGRyUj+SDKOTRbjW8shomhnhORM082HM9yw@mail.gmail.com>
	<CAKTdtZkSEs7Z+0NrfEaFDt-LJEPCLg5FhHgSGAsF32gqQB+DCg@mail.gmail.com>
	<20120402123146.GA24813@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 10:26:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFLY5-0000zM-IP
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 10:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754311Ab2DDI02 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Apr 2012 04:26:28 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:43018 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239Ab2DDI0W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2012 04:26:22 -0400
Received: by vcqp1 with SMTP id p1so4264vcq.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 01:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=ivV5nvvyDvrqPloeq2NvFVrcetkwlqNx/Z1ipw3uUwE=;
        b=JcIYk3W0UI9Ik1uxl1jBz9eUMBkyIVrRM/p8eJbEt3HK9dqY5DAYO0WmGbVagFIQH+
         wAaqpyoLZBEYwmdWXN5JoKsd66ppZlr2ZhCxQ4TGXkMwcoakkwT4YX0ghgVGqpTQXNCs
         9x3ch5ufjVgqd+Mvno6XP+bNEr+FWIOzNH8Vaj586Dd+ai7px6iE3wo8qvb9EDH87P4l
         nGqhX1eToNbRCa2GNT9S78WuLYq4U6TJC/MucYLd+syevPub1AYuOz9C7NkRtY3DJE0z
         vpdzYoiaNkqHHK/g4a0hrqL+9pIhJXxe2D9R6FIra20QIGu+QoJ4vNEKLFaccNc3jeAC
         3V4Q==
Received: by 10.52.22.8 with SMTP id z8mr6316961vde.5.1333527981659; Wed, 04
 Apr 2012 01:26:21 -0700 (PDT)
Received: by 10.52.182.233 with HTTP; Wed, 4 Apr 2012 01:26:21 -0700 (PDT)
In-Reply-To: <20120402123146.GA24813@do>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194686>

Hi Nguyen,

A few questions,

> -- 8< --
> GIT index format
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This format replaces the old "DIRC" format. Compared to the old
> format, which is essentially a sorted list of pathnames, this one:
>
> =A0- is tree-based
> =A0- use crc32 as checksum
> =A0- only verify integrity on parts that git accesses, instead of who=
le
> =A0 file
> =A0- append changes to the end
> =A0- allow index versioning
>
> Updates can be made directly to the index by appending to the end. Th=
e
> index traversed by locating the root tree block from the trailer. Whe=
n
> a path is updated, all related tree blocks are updated and appended t=
o
> the end, then a new trailer (with generation increased by one) is
> written to conclude the index.
>
> The index size will increase continuously. At some point, we will nee=
d
> to repack it. Let assume a tree block is 64k on average and a path
> generally consists of 3 path components. =A0That means an entry updat=
e
> adds 192k and we can do about 80 updates before index reaches 16M (in
> addition to initial index size).
>
> At 16M or when trailer generation hits a limit (the limit can be
> configurable), we rewrite the index to reduce its size. Some heavy
> operations can also be used to rewrite index, such as checkout or
> reset.
>
> The index integrity is verified by crc32. One crc32 covers header and
> trailer. Each block has its own crc32. When the index is found
> corrupt, we could try to roll back to latest good version by looking
> for trailers from bottom up. Even when the index is not corrupt, user=
s
> can still look back this way for older index versions.
>

I am not sure how the trailer works.
I assume there can be multiple trailers, each update will generate a
new one. Every trailer will point to the root tree (i.e. all trailers
point to the same block?). So if there are some changes to root, like
rename, trailers all point to the latest root block?

Is the index looks like :
| HEADER | TREE BLOCKS | TRAILER | =A0TREE BLOCKS | TRAILER | TREE
BLOCKS | TRAILER | ...

Blocks and trailers are interleaved. The index starts from a few
blocks (git add file1 file2 file3 ..) and expands as it goes. If file1
is updated, the tree block containing file1 is updated and appended.
(At this point, 2 versions of tree blocks containing file is in index
?) How do you organize these 2 block in a tree ?

Appended blocks are also a tree or just a list. If it's a list, it
needs O(n) read time. If it's like a sub tree, I assume it's small,
because I guess there won't be many changes each time. If it's too
small then lgn -> n, and in total read time -> n.

> =3D The git index file has the following format
>
> =A0 - A 8-byte header consisting of
>
> =A0 =A0 4-byte signature:
> =A0 =A0 =A0 The signature is { 'T', 'R', 'E', 'E' }
>
> =A0 =A0 4-byte version number:
> =A0 =A0 =A0 The current supported versions are 1.
>
> =A0 - A number of blocks of variable size
>
> =A0 =A0 =A01-byte block type
>
> =A0 =A0 =A03-byte content size in byte
>
> =A0 =A0 =A0block content
>
> =A0 =A0 =A04-byte crc32 of all above
>
> =A0 - A 18-byte trailer consisting of
>
> =A0 =A0 =A04-byte trailer signature:
> =A0 =A0 =A0 =A0The signature is { 'R', 'O', 'O', 'T' }
>
> =A0 =A0 =A02-byte generation:
> =A0 =A0 =A0 =A0 The first trailer is 0, the second 1 and so on.
>
> =A0 =A0 =A04-byte root block offset
>
> =A0 =A0 =A04-byte extension table offset:
> =A0 =A0 =A0 =A0Zero means no extension
>
> =A0 =A0 =A04-byte checksum:
> =A0 =A0 =A0 =A0CRC32 of the header and the trailer (excluding this fi=
eld)
>
> =3D=3D Tree block
>
> =A0A tree block contains a (maybe invalid) tree object and extra
> =A0information of its companion in working directory. Tree block has
> =A0block type 'T'.
>
> =A0Tree block content is basically the list of non-recursive entries =
in
> =A0specified path, with all attributes we store in the index now. The=
re
> =A0are a few changes though to intergrate cache-tree and allow
> =A0bsearch() on mmap'd block.
>
> =A0A tree block content consists of
>
> =A0- 4-byte tree object size
>
> =A0- 20-byte SHA-1 of the cached tree object
>
> =A0- a list attributes corresponding to tree object's item, in the sa=
me
> =A0 =A0order. =A0These attributes are the same as in DIRC entry forma=
t
> =A0 =A0except that entry name is removed, and a tree block offset is
> =A0 =A0added in case the item is a directory.
>
> =A0 =A032-bit ctime seconds, the last time a file's metadata changed
> =A0 =A0 =A0this is stat(2) data
>
> =A0 =A032-bit ctime nanosecond fractions
> =A0 =A0 =A0this is stat(2) data
>
> =A0 =A032-bit mtime seconds, the last time a file's data changed
> =A0 =A0 =A0this is stat(2) data
>
> =A0 =A032-bit mtime nanosecond fractions
> =A0 =A0 =A0this is stat(2) data
>
> =A0 =A032-bit dev
> =A0 =A0 =A0this is stat(2) data
>
> =A0 =A032-bit ino
> =A0 =A0 =A0this is stat(2) data
>
> =A0 =A032-bit mode, split into (high to low bits)
>
> =A0 =A0 =A04-bit object type
> =A0 =A0 =A0 =A0valid values in binary are 1000 (regular file), 1010 (=
symbolic link)
> =A0 =A0 =A0 =A0and 1110 (gitlink)
>
> =A0 =A0 =A03-bit unused
>
> =A0 =A0 =A09-bit unix permission. Only 0755 and 0644 are valid for re=
gular files.
> =A0 =A0 =A0Symbolic links and gitlinks have value 0 in this field.
>
> =A0 =A032-bit uid
> =A0 =A0 =A0this is stat(2) data
>
> =A0 =A032-bit gid
> =A0 =A0 =A0this is stat(2) data
>
> =A0 =A032-bit file size
> =A0 =A0 =A0This is the on-disk size from stat(2), truncated to 32-bit=
=2E
>
> =A0 =A0160-bit SHA-1 for the represented object if blobs or the offse=
t
> =A0 =A0 =A0to another tree block if trees
>
> =A0 =A0A 32-bit 'flags' field split into (high to low bits)
>
> =A0 =A0 =A01-bit assume-valid flag
>
> =A0 =A0 =A01-bit extended flag (must be zero in version 2)
>
> =A0 =A0 =A02-bit stage (during merge)
>
> =A0 =A0 =A012-bit name length if the length is less than 0xFFF; other=
wise 0xFFF
> =A0 =A0 =A0is stored in this field.
>
> =A0 =A0 =A01-bit skip-worktree flag (used by sparse checkout)
>
> =A0 =A0 =A01-bit intent-to-add flag (used by "git add -N")
>
> =A0 =A0 =A014-bit unused, must be zero
>
> =A0 =A0A 16-bit offset, relative to the beginning of this block, to t=
he
> =A0 =A0 =A0pathname of this entry. FIXME: make it 32-bit, relative to=
 the
> =A0 =A0 =A0beginning of the file, so that we can reuse pathnames from=
 other
> =A0 =A0 =A0(old) blocks?
>

It's nice to enable it for bsearch in a block by separate pathname.
If all names are shared by all blocks, this pathname tree will be
loaded for every operation. I guess the load&hash is expensive.

> =A0- a list of NUL-terminated pathnames, pointed to from the 16-bit o=
ffset
> =A0 =A0above. This list does not have to be of the same order as the =
attribute
> =A0 =A0list. The reason this is separated from the attribute list is =
to make
> =A0 =A0attribute list fixed size, searchable using bsearch().
>
> =3D=3D Extension table block
>
> =A0Extension table has block type 'X'. It consists of a series of 4-b=
yte
> =A0extension block offset.
>
> =3D=3D Extension block
>
> =A0Extension block has block type 'E'. Extension content is the same =
as
> =A0in the old format.
> -- 8< --
> --
> Duy

-Elton
