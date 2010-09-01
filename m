From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] builtin: use builtin.h for all builtin/ commands
Date: Wed,  1 Sep 2010 16:23:27 +0000
Message-ID: <1283358207-3165-1-git-send-email-avarab@gmail.com>
References: <AANLkTinHtvHt0q=dK9KHtCX6JzymB5dx1NuaAZN_uu2R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 18:24:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqq6R-00087W-Tm
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 18:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639Ab0IAQXm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 12:23:42 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46862 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009Ab0IAQXl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 12:23:41 -0400
Received: by wwj40 with SMTP id 40so171664wwj.1
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 09:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=zJEFNgJjCZWRlCBYjxOhbENyIj1zjTgd+5Ui18aWKjE=;
        b=LugM/r3o4IizjLEIpB7Crkq/DvI/TLj0GqFIyIrg85hXhQTn+dybTLVccPnGivBWHm
         OOotB0zQsJX8xiG5fQCc4NhnbyiQ7adLPJ67abfhSHpwiAdP22wnsxVuGapZHW3L/6Y2
         n37yJxyHz9vquvPGNVt/a4rnFpQUq0wUgRJOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=as5hiwurt+pTGKqSOUFDlFs/gcIdzsP/k1D956l95ItHCteB3MK/lQubFcAhSdrF/m
         4lh9/zpSgLvEo4GE4n4pfZsXAiMZSCZK8yrXMO2rNux47RVVEftdBHnV2CGww58IW2PX
         0NfN2xQrm3mqY9OR7fvjIQ6/BZ59FnPiOHf+o=
Received: by 10.216.11.205 with SMTP id 55mr8105931wex.51.1283358220407;
        Wed, 01 Sep 2010 09:23:40 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k15sm5024347wer.23.2010.09.01.09.23.39
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 09:23:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.178.gd8a94.dirty
In-Reply-To: <AANLkTinHtvHt0q=dK9KHtCX6JzymB5dx1NuaAZN_uu2R@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155057>

Some builtin/*.c commands weren't using the builtin.h header, but
instead manually imported headers like cache.h and commit.h which
builtin.h would include for them.

This impeded my efforts to gettextize git, since I'd otherwise have to
add gettext.h to all of these, and using builtin.h is a good idea in
any case, since it's defining the prototypes for the cmd_* functions
that these files define.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

On Wed, Sep 1, 2010 at 14:56, Stephen Boyd <bebarino@gmail.com> wrote:
>  On 09/01/2010 07:17 AM, =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason wrote=
:
>> I'm working on gettextizing the 'mainporcelain common' commands now,
>> and I ran into this:
>>
> [snip]
>>
>> Anyway, I'll convert these to builtin.h where appropriate as part of
>> the series unless someone can find a good reason not to.
>
> Sparse warns about this too. "Prototype not found, should it be stati=
c?"
> for a few cmd_*'s. So sounds good to me.

This is a patch against master for this issue. It also affects the
skew.c and commands from the remote-ext series which are not on master.

I made this with:

    for i in $(perl -MArray::Diff -E 'chomp(my @hb =3D qx[ack -l builti=
n.h *.c]); my @c =3D glob "*.c"; my $d =3D Array::Diff->diff( \@c, \@hb=
 ); say for @{$d->deleted}'); do perl /tmp/builtin-munger.pl $i; done

Where builtin-munger.pl is:
   =20
    #!/usr/bin/env perl
    use 5.12.0;
    use strict;
    use autodie;
   =20
    my $f =3D shift;
   =20
    open my $out, ">", "$f.tmp";
    open my $in, "<", $f;
   =20
    while (<$in>) {
        chomp;
        say $out qq[#include "builtin.h"] if 1 .. /^#include/ and /^#in=
clude/;
        say $out $_ unless $_ ~~ [
            '#include "git-compat-util.h"',
            '#include "strbuf.h"',
            '#include "cache.h"',
            '#include "commit.h"',
            '#include "notes.h"',
            '#include "gettext.h"',
        ];
    }
    close $_ for $in, $out;
    rename("$f.tmp", $f);

 builtin/clone.c           |    3 +--
 builtin/fetch-pack.c      |    3 +--
 builtin/hash-object.c     |    2 +-
 builtin/index-pack.c      |    3 +--
 builtin/merge-index.c     |    2 +-
 builtin/merge-recursive.c |    3 +--
 builtin/merge-tree.c      |    2 +-
 builtin/mktag.c           |    2 +-
 builtin/pack-redundant.c  |    2 +-
 builtin/pack-refs.c       |    2 +-
 builtin/patch-id.c        |    2 +-
 builtin/receive-pack.c    |    3 +--
 builtin/remote.c          |    3 +--
 builtin/reset.c           |    3 +--
 builtin/send-pack.c       |    3 +--
 builtin/unpack-file.c     |    2 +-
 builtin/var.c             |    2 +-
 17 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index efb1e6f..f2a7a54 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -8,7 +8,7 @@
  * Clone a repository into a different directory that does not yet exi=
st.
  */
=20
-#include "cache.h"
+#include "builtin.h"
 #include "parse-options.h"
 #include "fetch-pack.h"
 #include "refs.h"
@@ -16,7 +16,6 @@
 #include "tree-walk.h"
 #include "unpack-trees.h"
 #include "transport.h"
-#include "strbuf.h"
 #include "dir.h"
 #include "pack-refs.h"
 #include "sigchain.h"
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index dbd8b7b..03abc30 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1,7 +1,6 @@
-#include "cache.h"
+#include "builtin.h"
 #include "refs.h"
 #include "pkt-line.h"
-#include "commit.h"
 #include "tag.h"
 #include "exec_cmd.h"
 #include "pack.h"
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 080af1a..8a5670f 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -4,7 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  * Copyright (C) Junio C Hamano, 2005
  */
-#include "cache.h"
+#include "builtin.h"
 #include "blob.h"
 #include "quote.h"
 #include "parse-options.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index fad76bf..e073bdb 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1,9 +1,8 @@
-#include "cache.h"
+#include "builtin.h"
 #include "delta.h"
 #include "pack.h"
 #include "csum-file.h"
 #include "blob.h"
-#include "commit.h"
 #include "tag.h"
 #include "tree.h"
 #include "progress.h"
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 2c4cf5e..adc2a6d 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "run-command.h"
 #include "exec_cmd.h"
=20
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index d8875d5..455fd28 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -1,5 +1,4 @@
-#include "cache.h"
-#include "commit.h"
+#include "builtin.h"
 #include "tag.h"
 #include "merge-recursive.h"
=20
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 9b25ddc..1991742 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "tree-walk.h"
 #include "xdiff-interface.h"
 #include "blob.h"
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 1cb0f3f..9148cc0 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "tag.h"
 #include "exec_cmd.h"
=20
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 41e1615..a15e366 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -6,7 +6,7 @@
 *
 */
=20
-#include "cache.h"
+#include "builtin.h"
 #include "exec_cmd.h"
=20
 #define BLKSIZE 512
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 091860b..39a9d89 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "parse-options.h"
 #include "pack-refs.h"
=20
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 5125300..33e9725 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "exec_cmd.h"
=20
 static void flush_current_id(int patchlen, unsigned char *id, git_SHA_=
CTX *c)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 760817d..f07b021 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1,11 +1,10 @@
-#include "cache.h"
+#include "builtin.h"
 #include "pack.h"
 #include "refs.h"
 #include "pkt-line.h"
 #include "sideband.h"
 #include "run-command.h"
 #include "exec_cmd.h"
-#include "commit.h"
 #include "object.h"
 #include "remote.h"
 #include "transport.h"
diff --git a/builtin/remote.c b/builtin/remote.c
index 48e0a6b..3cf3c6b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1,9 +1,8 @@
-#include "cache.h"
+#include "builtin.h"
 #include "parse-options.h"
 #include "transport.h"
 #include "remote.h"
 #include "string-list.h"
-#include "strbuf.h"
 #include "run-command.h"
 #include "refs.h"
=20
diff --git a/builtin/reset.c b/builtin/reset.c
index 1283068..3cbdf94 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -7,10 +7,9 @@
  *
  * Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
  */
-#include "cache.h"
+#include "builtin.h"
 #include "tag.h"
 #include "object.h"
-#include "commit.h"
 #include "run-command.h"
 #include "refs.h"
 #include "diff.h"
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 481602d..80b063b 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -1,5 +1,4 @@
-#include "cache.h"
-#include "commit.h"
+#include "builtin.h"
 #include "refs.h"
 #include "pkt-line.h"
 #include "sideband.h"
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 608590a..c905d80 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "blob.h"
 #include "exec_cmd.h"
=20
diff --git a/builtin/var.c b/builtin/var.c
index 70fdb4d..0c18196 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Eric Biederman, 2005
  */
-#include "cache.h"
+#include "builtin.h"
 #include "exec_cmd.h"
=20
 static const char var_usage[] =3D "git var (-l | <variable>)";
--=20
1.7.2.2.178.gd8a94.dirty
