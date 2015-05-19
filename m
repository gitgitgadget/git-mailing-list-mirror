From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v8 5/5] help: respect new common command grouping
Date: Mon, 18 May 2015 20:43:56 -0400
Message-ID: <20150519004356.GA12854@flurp.local>
References: <1431976697-26288-1-git-send-email-sebastien.guimmara@gmail.com>
 <1431976697-26288-6-git-send-email-sebastien.guimmara@gmail.com>
 <xmqqr3qda7kx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?S=E9bastien?= Guimmara 
	<sebastien.guimmara@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 19 02:44:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuVdh-000374-H7
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 02:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbbESAoF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 May 2015 20:44:05 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33296 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbbESAoD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 20:44:03 -0400
Received: by igbpi8 with SMTP id pi8so93587731igb.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 17:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6xx046Fmz2KgZUHCCUq1sJ5H5dcmraMjaKrhRy20qCM=;
        b=vigZbfpbLnumXUmcaeij3P4/OPH5AvAdQYD/5clCGSyOkJOQyTPIzccKmVNpgUHr/l
         eMtFNieaOEpXwK3uyodPG+/WVhZQv1+jkBlUGL2GGK6rQSiJdXWaVo8IqOe8lGaIUpA9
         diEqRdcPNQra2Zst8nMDKxY4U0qtedSNJAy2fTZCVeU8HlBLI3/oa83iYNW++TEMkI2H
         6X3s9+Hv7yJbJwMdaZ+y8pvBh7+8QL+JzrVxQaVa4Dz25ZpD0j+XRm9rS1/PXVy3EtJ9
         EVkRW21kn3UuNTTKDqnAbDKxSjtFkXvyY1pquuzbtQLKsk9nnwbYjr+1Lnf1swibzPBI
         BtUQ==
X-Received: by 10.50.85.113 with SMTP id g17mr17892041igz.46.1431996242491;
        Mon, 18 May 2015 17:44:02 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id d186sm7269399ioe.42.2015.05.18.17.44.01
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 17:44:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqr3qda7kx.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269336>

On Mon, May 18, 2015 at 02:39:42PM -0700, Junio C Hamano wrote:
> S=E9bastien Guimmara  <sebastien.guimmara@gmail.com> writes:
> > 'git help' shows common commands in alphabetical order:
> > [...]
> > without any indication of how commands relate to high-level
> > concepts or each other. Revise the output to explain their relation=
ship
> > with the typical Git workflow:
> > [...]
> > The typical Git workflow includes:
> >
> > Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> > Signed-off-by: S=E9bastien Guimmara <sebastien.guimmara@gmail.com>
>=20
> I cannot exactly pinpoint what bothers me, but "The typical Git
> workflow includes:" sounds a bit awkward.
> What does a workflow "include"? [...]
>=20
> Other than that, this round looks ready for 'next'.

I came to the same conclusion. FWIW, the entire series is:

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

> I am not absolutely sure if new dependency on "awk" will not present
> portability issues, though.  So far we only used it in scripts in
> the fringes and only a few tests.

The awk script restricts itself to POSIX, and I did test it on Linux,
Mac OS X, and FreeBSD, so it seems pretty portable. However, if it
worries you sufficiently, here's the equivalent Perl version:

--- >8 ---
=46rom: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/5] generate-cmdlist: parse common group commands

Parse the group block to create the array of group descriptions:

static char *common_cmd_groups[] =3D {
    N_("starting a working area"),
    N_("working on the current change"),
    N_("working with others"),
    N_("examining the history and state"),
    N_("growing, marking and tweaking your history"),
};

then map each element of common_cmds[] to a group via its index:

static struct cmdname_help common_cmds[] =3D {
    {"add", N_("Add file contents to the index"), 1},
    {"branch", N_("List, create, or delete branches"), 4},
    {"checkout", N_("Checkout a branch or paths to the ..."), 4},
    {"clone", N_("Clone a repository into a new directory"), 0},
    {"commit", N_("Record changes to the repository"), 4},
    ...
};

so that 'git help' can print those commands grouped by theme.

Only commands tagged with an attribute from the group block are emitted=
 to
common_cmds[].

[commit message by S=E9bastien Guimmara <sebastien.guimmara@gmail.com>]

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Makefile              |  4 ++--
 generate-cmdlist.perl | 50 +++++++++++++++++++++++++++++++++++++++++++=
+++++++
 generate-cmdlist.sh   | 23 -----------------------
 3 files changed, 52 insertions(+), 25 deletions(-)
 create mode 100755 generate-cmdlist.perl
 delete mode 100755 generate-cmdlist.sh

diff --git a/Makefile b/Makefile
index 5ed0acf..c133a96 100644
--- a/Makefile
+++ b/Makefile
@@ -1693,10 +1693,10 @@ $(BUILT_INS): git$X
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
=20
-common-cmds.h: ./generate-cmdlist.sh command-list.txt
+common-cmds.h: generate-cmdlist.perl command-list.txt
=20
 common-cmds.h: $(wildcard Documentation/git-*.txt)
-	$(QUIET_GEN)./generate-cmdlist.sh > $@+ && mv $@+ $@
+	$(QUIET_GEN)$(PERL_PATH) generate-cmdlist.perl command-list.txt > $@+=
 && mv $@+ $@
=20
 SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ)=
:\
diff --git a/generate-cmdlist.perl b/generate-cmdlist.perl
new file mode 100755
index 0000000..31516e3
--- /dev/null
+++ b/generate-cmdlist.perl
@@ -0,0 +1,50 @@
+#!/usr/bin/perl
+use strict;
+use warnings;
+
+print <<"EOT";
+/* Automatically generated by $0 */
+
+struct cmdname_help {
+	char name[16];
+	char help[80];
+	unsigned char group;
+};
+
+static char *common_cmd_groups[] =3D {
+EOT
+
+my $n =3D 0;
+my %grp;
+while (<>) {
+	last if /^### command list/;
+	next if (1../^### common groups/) || /^#/ || /^\s*$/;
+	chop;
+	my ($k, $v) =3D split ' ', $_, 2;
+	$grp{$k} =3D $n++;
+	print "\tN_(\"$v\"),\n";
+}
+
+print "};\n\nstatic struct cmdname_help common_cmds[] =3D {\n";
+
+while (<>) {
+	next if /^#/ || /^\s*$/;
+	my @tags =3D split;
+	my $cmd =3D shift @tags;
+	for my $t (@tags) {
+		if (exists $grp{$t}) {
+			my $s;
+			open my $f, '<', "Documentation/$cmd.txt" or die;
+			while (<$f>) {
+				($s) =3D /^$cmd - (.+)$/;
+				last if $s;
+			}
+			close $f;
+			$cmd =3D~ s/^git-//;
+			print "\t{\"$cmd\", N_(\"$s\"), $grp{$t}},\n";
+			last;
+		}
+	}
+}
+
+print "};\n";
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
deleted file mode 100755
index 9a4c9b9..0000000
--- a/generate-cmdlist.sh
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/bin/sh
-
-echo "/* Automatically generated by $0 */
-struct cmdname_help {
-    char name[16];
-    char help[80];
-};
-
-static struct cmdname_help common_cmds[] =3D {"
-
-sed -n -e 's/^git-\([^ 	]*\)[ 	].* common.*/\1/p' command-list.txt |
-sort |
-while read cmd
-do
-     sed -n '
-     /^NAME/,/git-'"$cmd"'/H
-     ${
-	    x
-	    s/.*git-'"$cmd"' - \(.*\)/  {"'"$cmd"'", N_("\1")},/
-	    p
-     }' "Documentation/git-$cmd.txt"
-done
-echo "};"
--=20
2.4.1.260.ga2776d4

--- >8 ---
