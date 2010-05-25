From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCHv5 GSoC] gitweb: Move static files into seperate  subdirectory
Date: Tue, 25 May 2010 23:22:27 +0200
Message-ID: <201005252322.27443.chriscool@tuxfamily.org>
References: <1274714564-7553-1-git-send-email-pavan.sss1991@gmail.com> <AANLkTilqa8HAs9jHJQ5KxWic1IYOZxCj10f11KBRMA-b@mail.gmail.com> <201005250237.53529.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Greg Bacon <gbacon@dbresearch.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 25 23:22:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH1aG-0007Ar-Aw
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 23:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934261Ab0EYVWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 17:22:39 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:45585 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934212Ab0EYVWi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 17:22:38 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 797DC8181ED;
	Tue, 25 May 2010 23:22:29 +0200 (CEST)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP;
	Tue, 25 May 2010 23:22:27 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-20-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <201005250237.53529.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147727>

On Tuesday 25 May 2010 02:37:50 Jakub Narebski wrote:
> On Mon, 24 May 2010, Pavan Kumar Sunkara wrote:
> > On Tue, May 25, 2010 at 1:35 AM, Christian Couder 
<chriscool@tuxfamily.org> wrote:
> >> On Monday 24 May 2010 17:22:44 Pavan Kumar Sunkara wrote:
> >>>  gitweb/{ => static}/git-favicon.png |  Bin 115 -> 115 bytes
> >>>  gitweb/{ => static}/git-logo.png    |  Bin 207 -> 207 bytes
> >>>  gitweb/{ => static}/gitweb.css      |    0
> >>>  gitweb/{ => static}/gitweb.js       |    0
> >>
> >> The patch is supposed to move git-favicon.png and git-logo.png into
> >> gitweb/static but it doesn't.
> >>
> >>>  diff --git a/gitweb/gitweb.css b/gitweb/static/gitweb.css
> >>> similarity index 100%
> >>> rename from gitweb/gitweb.css
> >>> rename to gitweb/static/gitweb.css
> >>> diff --git a/gitweb/gitweb.js b/gitweb/static/gitweb.js
> >>> similarity index 100%
> >>> rename from gitweb/gitweb.js
> >>> rename to gitweb/static/gitweb.js
> >>
> >> Only gitweb.css and gitweb.js are moved into gitweb/static [...]
> >
> > I don't understand why the binary files aren't moving into static/ dir.
> > I haven't faced this type of problem before. Give me some time to figure
> > it out.
> 
> You have found a bug in git.  When you do a pure rename of a binary
> file, it doesn't show as a pure rename patch:
> 
>   $ git init
>   $ echo foo > foo
>   $ echo -e "bar\0" > bar
>   $ git add .
>   $ git commit -m 'Initial commit'
>   [master (root-commit) 4bd35b8] Initial commit
>    2 files changed, 1 insertions(+), 0 deletions(-)
>    create mode 100644 bar
>    create mode 100644 foo
>   $ mkdir sub
>   $ git mv bar foo sub/
>   $ git commit -m 'Moved to sub/'
>   [master 00356a5] Moved to sub/
>    2 files changed, 0 insertions(+), 0 deletions(-)
>    rename bar => sub/bar (100%)
>    rename foo => sub/foo (100%)
>   $ git show -C -C --raw --binary --stat
>   commit 00356a5ec458fa64ab3eca2c23ebc53e9f2d54ba
>   Author: Jakub Narebski <jnareb@gmail.com>
>   Date:   Tue May 25 02:23:26 2010 +0200
> 
>       Moved to sub/
>   ---
> 
>   :100644 100644 080090e... 080090e... R100       bar     sub/bar
>   :100644 100644 257cc56... 257cc56... R100       foo     sub/foo
> 
>    bar => sub/bar |  Bin 5 -> 5 bytes
>    foo => sub/foo |    0
>    2 files changed, 0 insertions(+), 0 deletions(-)
> 
>   diff --git a/foo b/sub/foo
>   similarity index 100%
>   rename from foo
>   rename to sub/foo
> 
> As you can see there is not
> 
>   diff --git a/bar b/sub/bar
>   similarity index 100%
>   rename from bar
>   rename to sub/bar
> 
> and that adding '--binary' option doesn't help

I bisected this bug to the following commit:

commit 3e97c7c6af2901cec63bf35fcd43ae3472e24af8
Author: Greg Bacon <gbacon@dbresearch.net>
Date:   Thu Nov 19 15:12:24 2009 -0600

    No diff -b/-w output for all-whitespace changes

    Change git-diff's whitespace-ignoring modes to generate
    output only if a non-empty patch results, which git-apply
    rejects.

    Update the tests to look for the new behavior.

    Signed-off-by: Greg Bacon <gbacon@dbresearch.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

The following RFC patch seems to fix it. I will resend it perhaps with an added 
test case if no one complains.

----- >8 -----

From: Christian Couder <chriscool@tuxfamily.org>
Date: Tue, 25 May 2010 23:12:00 +0200
Subject: [PATCH] diff: fix "git show -C -C" output when renaming a binary file

A bug was introduced in 3e97c7c6af2901cec63bf35fcd43ae3472e24af8
(No diff -b/-w output for all-whitespace changes, Nov 19 2009)
that made the lines:

diff --git a/bar b/sub/bar
similarity index 100%
rename from bar
rename to sub/bar

disappear from "git show -C -C" output when file bar is a binary
file.
---
 diff.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 494f560..0b00271 100644
--- a/diff.c
+++ b/diff.c
@@ -1737,6 +1737,10 @@ static void builtin_diff(const char *name_a,
                                                textconv_one, textconv_two, 
o);
                        o->found_changes = 1;
                        goto free_ab_and_return;
+               } else if (diff_filespec_is_binary(one) &&
+                          diff_filespec_is_binary(two)) {
+                       fprintf(o->file, "%s", header.buf);
+                       strbuf_reset(&header);
                }
        }

--
1.7.1.226.g770c5.dirty
