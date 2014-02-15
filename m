From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: Re: Bug: Problem with CRLF line ending in git-diff with coloring
Date: Sat, 15 Feb 2014 08:21:58 +0100
Organization: -no organization-
Message-ID: <20140215072158.GK7560@pille.home>
References: <20140209110155.GB16189@scotty.home>
 <20140214164709.GI7560@pille.home>
 <52FE8847.8020101@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Feb 15 08:22:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEZaH-0006mn-CW
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 08:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbaBOHWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Feb 2014 02:22:18 -0500
Received: from moutng.kundenserver.de ([212.227.17.9]:65217 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbaBOHWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Feb 2014 02:22:16 -0500
Received: from pille.home (port-92-205-53-192.dynamic.qsc.de [92.205.53.192])
	by mrelayeu.kundenserver.de (node=mreue003) with ESMTP (Nemesis)
	id 0MKMjK-1WCv9B0AK6-001gT3; Sat, 15 Feb 2014 08:22:03 +0100
Received: from pille.home (localhost [127.0.0.1])
	by pille.home (8.14.4/8.14.4/Debian-4) with ESMTP id s1F7M0oB006372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Feb 2014 08:22:00 +0100
Received: (from hs@localhost)
	by pille.home (8.14.4/8.14.4/Submit) id s1F7Lwri006371;
	Sat, 15 Feb 2014 08:21:58 +0100
X-Authentication-Warning: pille.home: hs set sender to stefan.hahn@s-hahn.de using -f
Content-Disposition: inline
In-Reply-To: <52FE8847.8020101@kdbg.org>
X-Mailer: Mutt http://www.mutt.org/
X-Editor: GNU Emacs http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
X-GPG-Public-Key: gpg --keyserver keys.gnupg.net --recv-keys E4FCD563
X-GPG-Fingerprint: 0xE4FCD563 / EF09 97BB 3731 7DC7 25BA 5C39 185C F986 E4FC
 D563
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:NgiEfQfHnY3MImznZDeoXDzVvd9YPfde6IzqbCHPRix
 Wa4WMvaa2lOwWsvbRvqbNJsUlInm9Sz5+1q0UdLPSqAXpR+7j3
 DLMNw6ko1dQYuGESXWaZqQVW62UoNGfot7Py2v9JxhOJf89yjg
 k+VHVHveh8NTLE+wrFQ21c7PWmHrvcZ8QX4n0Su8dBUPzgziws
 Dq2/qfczc0XOuY8zxFiHZUXJHWBtThDDYCvoYiZQzvRiyBAtBh
 gPaT6PWu8MP2xWP3WM4IUn3H8aGYWhFU3OuYIFKicUcx1ICtNa
 WSThFIAeAqr6ERr3Ros1bp92KG3HPGe+QdzReQruGvKST7E6hX
 1vY4509auPkTGXNZgj78=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242177>

Mail von Johannes Sixt, Fri, 14 Feb 2014 at 22:19:03 +0100:

Good morning,

> Am 14.02.2014 17:47, schrieb Stefan-W. Hahn:
> >> It's the right solution. IOW, you should place something like this in
> >> your .gitattributes:
> >>  *.html whitespace=cr-at-eol
> > 
> > Sorry, but this is not possible, because I have files of both sorts (mainly
> > C/C++) files in my repository and cannot change the files as I wish.
> 
> I'm confused. This setting does not change your files, but instructs git
> diff and git apply to not report the trailing CR as white-space error.
> Didn't you try it?

You are right, if I configure

        git config core.whitespace cr-at-eol

then the CR is not highlighted.

I try to work with it; I hope there are no other traps with it.

I changed the test to regard this, here it is.

With kind regards,
Stefan

#!/bin/sh
#
# Copyright (c) 2014 Stefan-W. Hahn
#

test_description='Test coloring of diff with CRLF line ending.

'
. ./test-lib.sh

get_color ()
{
	git config --get-color "$1"
}

test_expect_success setup '
        git config color.diff.plain black &&
        git config color.diff.meta blue &&
        git config color.diff.frag yellow &&
        git config color.diff.func normal &&
        git config color.diff.old red &&
        git config color.diff.new green &&
        git config color.diff.commit normal &&
	c_reset=$(git config --get-color no.such.color reset) &&
	c_plain=$(get_color color.diff.plain) &&
	c_meta=$(get_color color.diff.meta) &&
	c_frag=$(get_color color.diff.frag) &&
	c_func=$(get_color color.diff.func) &&
	c_old=$(get_color color.diff.old) &&
	c_new=$(get_color color.diff.new) &&
	c_commit=$(get_color color.diff.commit) &&
	c_whitespace=$(get_color color.diff.whitespace)
'

# Test cases
# - DOS line ending
#   - change one line
#   - change one line ending to UNIX
# - UNIX line ending
#   - change one line (trivial not tested here)
#   - change one line ending to DOS

tr 'Q' '\015' << EOF > x
Zeile 1Q
Zeile 2Q
Zeile 3Q
EOF

git update-index --add x

tr 'Q' '\015' << EOF > x
Zeile 1Q
Zeile 22Q
Zeile 3Q
EOF

tr 'Q' '\015' << EOF > expect
diff --git a/x b/x
index 3411cc1..68a4b2c 100644
--- a/x
+++ b/x
@@ -1,3 +1,3 @@
 Zeile 1Q
-Zeile 2Q
+Zeile 22Q
 Zeile 3Q
EOF

tr 'Q' '\015' << EOF > expect_color
${c_meta}diff --git a/x b/x${c_reset}
${c_meta}index 3411cc1..68a4b2c 100644${c_reset}
${c_meta}--- a/x${c_reset}
${c_meta}+++ b/x${c_reset}
${c_frag}@@ -1,3 +1,3 @@${c_reset}
${c_plain} Zeile 1${c_reset}Q
${c_old}-Zeile 2${c_reset}Q
${c_new}+${c_reset}${c_new}Zeile 22${c_reset}Q
${c_plain} Zeile 3${c_reset}Q
EOF

git -c color.diff=false diff > out
test_expect_success "diff files: change line in DOS file without color" '
        test_cmp expect out'

git -c color.diff=always -c core.whitespace=cr-at-eol diff > out
test_expect_success "diff files: change line in DOS file with color" '
        test_cmp expect_color out'


tr 'Q' '\015' << EOF > x
Zeile 1Q
Zeile 2Q
Zeile 3Q
EOF

git update-index --add x

tr 'Q' '\015' << EOF > x
Zeile 1Q
Zeile 2
Zeile 3Q
EOF

tr 'Q' '\015' << EOF > expect
diff --git a/x b/x
index 3411cc1..c040c67 100644
--- a/x
+++ b/x
@@ -1,3 +1,3 @@
 Zeile 1Q
-Zeile 2Q
+Zeile 2
 Zeile 3Q
EOF

tr 'Q' '\015' << EOF > expect_color
${c_meta}diff --git a/x b/x${c_reset}
${c_meta}index 3411cc1..c040c67 100644${c_reset}
${c_meta}--- a/x${c_reset}
${c_meta}+++ b/x${c_reset}
${c_frag}@@ -1,3 +1,3 @@${c_reset}
${c_plain} Zeile 1${c_reset}Q
${c_old}-Zeile 2${c_reset}Q
${c_new}+${c_reset}${c_new}Zeile 2${c_reset}
${c_plain} Zeile 3${c_reset}Q
EOF

git -c color.diff=false diff > out
test_expect_success "diff files: change line ending in DOS file to LF ending without color" '
        test_cmp expect out'

git -c color.diff=always diff > out
test_expect_success "diff files: change line ending in DOS file to LF ending with color" '
        test_cmp expect_color out'

tr 'Q' '\015' << EOF > x
Zeile 1
Zeile 2
Zeile 3
EOF

git update-index --add x

tr 'Q' '\015' << EOF > x
Zeile 1
Zeile 2Q
Zeile 3
EOF

tr 'Q' '\015' << EOF > expect
diff --git a/x b/x
index a385875..63416d7 100644
--- a/x
+++ b/x
@@ -1,3 +1,3 @@
 Zeile 1
-Zeile 2
+Zeile 2Q
 Zeile 3
EOF

tr 'Q' '\015' << EOF > expect_color
${c_meta}diff --git a/x b/x${c_reset}
${c_meta}index a385875..63416d7 100644${c_reset}
${c_meta}--- a/x${c_reset}
${c_meta}+++ b/x${c_reset}
${c_frag}@@ -1,3 +1,3 @@${c_reset}
${c_plain} Zeile 1${c_reset}
${c_old}-Zeile 2${c_reset}
${c_new}+${c_reset}${c_new}Zeile 2${c_reset}Q
${c_plain} Zeile 3${c_reset}
EOF

git -c color.diff=false diff > out
test_expect_success "diff files: change line ending in UNIX file to CRLF ending without color" '
        test_cmp expect out'

git -c color.diff=always -c core.whitespace=cr-at-eol diff > out
test_expect_success "diff files: change line ending in UNIX file to CRLF ending with color" '
        test_cmp expect_color out'

test_done


-- 
Stefan-W. Hahn                          It is easy to make things.
                                        It is hard to make things simple.
