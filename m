From: Dan Holmsand <holmsand@gmail.com>
Subject: [PATCH 2/6] Factor out color settings to cg-Xlib
Date: Thu, 09 Jun 2005 13:17:00 +0200
Message-ID: <42A8252C.8040805@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090006060207080201090107"
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Jun 09 14:36:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgLsB-00045G-Nr
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 14:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVFIMO5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 08:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVFIMO5
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 08:14:57 -0400
Received: from main.gmane.org ([80.91.229.2]:60351 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262367AbVFIMOm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 08:14:42 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DgLEn-0007Ij-J9
	for git@vger.kernel.org; Thu, 09 Jun 2005 13:30:18 +0200
Received: from 81-224-201-139-no45.tbcn.telia.com ([81.224.201.139])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 13:30:17 +0200
Received: from holmsand by 81-224-201-139-no45.tbcn.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 13:30:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 81-224-201-139-no45.tbcn.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------090006060207080201090107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[PATCH 2/6] Factor out color settings to cg-Xlib

setup_colors sets color variables from COGITO_COLORS, and
adds a sed script for diff colorization to color_rules.

Note that this changes the default colors a little from the
ones in cg-diff: in particular there's no bold any more. Bold
isn't really necessary if the "less search" thing in the new
cg-diff/cg-log is used (and bold is really ugly in
gnome-terminal :-) ).

Signed-off-by: Dan Holmsand <holmsand@gmail.com>
---


--------------090006060207080201090107
Content-Type: text/plain;
 name="2-setupcolors.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2-setupcolors.patch.txt"

 cg-Xlib |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -136,6 +136,29 @@ print_help () {
 	exit
 }
 
+setup_colors() {
+	local C="header=32:author=36:signoff=33:committer=35:files=34"
+	C="$C:commit=34:date=32:trim=35"
+	C="$C:diffhdr=34:diffhdradd=32:diffadd=32:diffhdrmod=35"
+	C="$C:diffmod=35:diffhdrrem=31:diffrem=31:diffhunk=36"
+	C="$C:diffctx=34:diffcctx=33:default=0"
+	[ -n "$COGITO_COLORS" ] && C="$C:$COGITO_COLORS"
+
+	C=${C//=/=\'$'\e'[}
+	C=col${C//:/m\'; col}m\'
+	#coldefault=$(tput op)
+	eval $C
+
+	color_rules="
+s,^+++.*,$coldiffhdradd&$coldefault,
+s,^---.*,$coldiffhdrrem&$coldefault,
+s,^[+].*,$coldiffadd&$coldefault,
+s,^[-].*,$coldiffrem&$coldefault,
+s,^\\(@@.*@@\\)\\(.*\\),$coldiffhunk\\1$coldiffctx\\2$coldefault,
+s,^=*$',$coldiffhdr&$coldefault,
+s,^\\(Index:\\|===\\|diff\\) .*,$coldiffhdr&$coldefault,"
+}
+
 for option in "$@"; do
 	if [ "$option" = "-h" -o "$option" = "--help" ]; then
 		print_help ${_cg_cmd##cg-}

--------------090006060207080201090107--

