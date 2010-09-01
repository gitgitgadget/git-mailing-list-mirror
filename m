From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] doc: technical details about the index file format
Date: Wed, 1 Sep 2010 20:54:20 +0200
Message-ID: <201009012054.20482.robin.rosenberg@dewire.com>
References: <1283334825-18309-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	srabbelier@gmail.com
To: =?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 21:22:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqstW-0000XN-2W
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 21:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036Ab0IATWo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 15:22:44 -0400
Received: from mail.dewire.com ([83.140.172.130]:13134 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752750Ab0IATWn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 15:22:43 -0400
X-Greylist: delayed 1698 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Sep 2010 15:22:42 EDT
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 316FE1469E2B;
	Wed,  1 Sep 2010 20:54:23 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PvBGePs-Nxyp; Wed,  1 Sep 2010 20:54:22 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id B11F3138BF5A;
	Wed,  1 Sep 2010 20:54:21 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-24-generic; KDE/4.4.2; i686; ; )
In-Reply-To: <1283334825-18309-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155071>

onsdagen den 1 september 2010 11.53.45 skrev  Nguy=E1=BB=85n Th=C3=A1i =
Ng=E1=BB=8Dc Duy:
> This bases on the original work by Robin Rosenberg:
>=20
> http://thread.gmane.org/gmane.comp.version-control.git/73471
No need for this. My name is enough
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
Add
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <robin.rosenbe=
rg@dewire.com>

> ---
>  I split index entry out so the overall format is clearer.
>=20
>  Other changes:
>  - mention of version 3
>  - added ino and mode
>  - added extended flags (v3)
>  - entry sort order
>=20
>  Again I don't realy know REUC extension, so only placeholder
>=20
>  Documentation/technical/index-format.txt |  139
> ++++++++++++++++++++++++++++++ 1 files changed, 139 insertions(+), 0
> deletions(-)
>  create mode 100644 Documentation/technical/index-format.txt
>=20
> diff --git a/Documentation/technical/index-format.txt
> b/Documentation/technical/index-format.txt new file mode 100644
> index 0000000..3e113ca
> --- /dev/null
> +++ b/Documentation/technical/index-format.txt
> @@ -0,0 +1,139 @@
> +GIT index format
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=3D The git index file has the following format
> +
> +  All binary numbers are in network byte order. Version 2 is describ=
ed
> +  here unless stated otherwise.
> +
> +   - A 12-byte header consisting of
> +
> +     4-byte signature:
> +       The signature is { 'D', 'I', 'R', 'C' }
> +
> +     4-byte version number:
> +       The current supported versions are 2 and 3.
> +
> +     32-bit number of index entries.
> +
> +   - A number of sorted index entries
> +
> +   - Extensions
> +
> +     Extensions are identified by signature. Optional extensions can
> +     be ignored if GIT does not understand them.
> +
> +     GIT currently supports tree cache and resolve undo extensions.
> +
> +     4-byte extension signature. If the first byte is 'A'..'Z' the
> +     extension is optional and can be ignored.
> +
> +     32-bit size of the extension
> +
> +     Extension data
> +
> +   - 160-bit SHA-1 over the content of the index file before this
> +     checksum.
> +
> +=3D=3D Index entry
> +
> +  Index entries are sorted with memcmp() by entry name. Entries with
> +  the same name are sorted by their stage.
Index entries are sorted in ascending order on the name field, interpre=
ted as
a string of unsigned bytes.

> +
> +  32-bit ctime seconds, the last time a file's metadata changed
> +    this is stat(2) data
> +
> +  32-bit ctime nanoseconds (modulo 1G)
> +    this is stat(2) data
> +
> +  32-bit mtime seconds, the last time a file's data changed
> +    this is stat(2) data
> +
> +  32-bit mtime nanoseconds (modulo 1G)
> +    this is stat(2) data
> +
> +  32-bit dev
> +    this is stat(2) data
> +
> +  32-bit ino
> +    this is stat(2) data
> +
> +  32-bit mode, split into (high to low bits)
> +
> +    4-bit object type
> +      valid values in binary are 1000 (blob), 1010 (symbolic link)
> +      and 1110 (gitlink)
> +
> +    3-bit unused
> +
> +    9-bit unix permission (only 0755 and 0644 are valid)
> +
> +  32-bit uid
> +    this is stat(2) data
> +
> +  32-bit gid
> +    this is stat(2) data
> +
> +  32-bit file size
> +    This is the on-disk size from stat(2)
> +
> +  160-bit SHA-1 for the represented object
> +
> +  A 16-bit field split into (high to low bits)
> +
> +    1-bit assume-valid flag
> +
> +    1-bit extended flag (must be zero in version 2)
> +
> +    2-bit stage (during merge)
> +
> +    12-bit name length if the length is less than 0x0FFF
> +
> +  (Version 3) A 16-bit field, only applicable if the "extended flag"
> +  above is 1, split into (high to low bits).
> +
> +    1-bit reserved for future
> +
> +    1-bit skip-worktree flag (used by sparse checkout)
> +
> +    1-bit intent-to-add flag (used by "git add -N")
> +
> +    13-bit unused, must be zero
> +
> +  Entry path name (variable length) relative to top-level directory
=2E..to the top level...
> +    (without leading slash). '/' is used as path separator. Special
The special...
> +    paths ".", ".." and ".git" (without quotes) are disallowed.
> +    Trailing slash is also disallowed.
Why would anyone even consider adding a trailing slash to a _file_ name=
?

   The exact encoding is undefined, but the '.', and '/' characters
   are encoded in 7-bit ASCII and the encoding cannot contain a nul byt=
e.
   Generally a superset of ASCII

> +
> +  1-8 nul bytes as necessary to pad the entry to a multiple ot eight=
 bytes
=2E..of eight bytes

A typo of mine.

> +  while keeping the name NUL-terminated.
> +
> +=3D=3D Extensions
> +
> +=3D=3D=3D Tree cache
> +
> +  Tree cache extension contains pre-computes hashes for all trees th=
at
> +  can be derived from the index
> +
> +  - Extension tag { 'T', 'R', 'E', 'E' }
> +
> +  - 32-bit size
> +
> +  - A number of entries
> +
> +     NUL-terminated tree name
> +
> +     Blank-terminated ASCII decimal number of entries in this tree
> +
> +     Newline-terminated position of this tree in the parent tree. 0 =
for
> +     the root tree
> +
> +     160-bit SHA-1 for this tree and it's children
> +
> +=3D=3D=3D Resolve undo
> +
> +  TODO
> +
> +  - Extension tag { 'R', 'E', 'U', 'C' }
> +
> +  - 32-bit size
