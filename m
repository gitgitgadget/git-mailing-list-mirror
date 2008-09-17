From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI,GITK) 2/8] git-gui: Add a menu of available encodings.
Date: Thu, 18 Sep 2008 01:07:33 +0400
Message-ID: <1221685659-476-3-git-send-email-angavrilov@gmail.com>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com>
 <1221685659-476-2-git-send-email-angavrilov@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 17 23:12:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg4Hq-0003CH-O4
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 23:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098AbYIQVJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 17:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753802AbYIQVJE
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 17:09:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:58531 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbYIQVI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 17:08:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2125232fgg.17
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 14:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6517uuMb9aNXnkSkEaJn9htY/yxQLOtasFzQLc63M+4=;
        b=uW/yCrF3cz6+tharqLt4NBJUAQnWtLCXCwTb30B9pOREYFGHm0TkfmIo5dQRzT/pi0
         fuqBaapZ4L36Yby29NxY2Q6v2Yi3R2D5xbW9jZlQkwxFuY2UCJMKHuHmyNWzsngRqEtQ
         arw6yRhiZiDdyz5gYlWKhB3XXxhhUux/nMbsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jqDyrjPdztgohHVbli8c6iG7BNThPygkVWwS90K8XxvxpThGhCDzFZEk3hSRqJTHJn
         2WNqu2jfe52uGCLuVUGpTEszcsw3aVoCvGlTxaBk9ccLuoQYTIiH8GGmgjfom5lcwF+G
         FOAm/WupIG2hd+YBP+PrfxigxLevXLz+kiJD8=
Received: by 10.180.204.10 with SMTP id b10mr2338015bkg.45.1221685737720;
        Wed, 17 Sep 2008 14:08:57 -0700 (PDT)
Received: from localhost.localdomain ( [92.255.85.78])
        by mx.google.com with ESMTPS id z10sm17426586fka.15.2008.09.17.14.08.56
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Sep 2008 14:08:57 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1221685659-476-2-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96138>

To make encoding selection easier, add a menu that
lists available encodings to the Options window.

Menu structure is borrowed from Firefox.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 lib/encoding.tcl |  133 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 lib/option.tcl   |   13 +++++-
 2 files changed, 142 insertions(+), 4 deletions(-)

diff --git a/lib/encoding.tcl b/lib/encoding.tcl
index e186b0c..2c1eda3 100644
--- a/lib/encoding.tcl
+++ b/lib/encoding.tcl
@@ -206,7 +206,7 @@ set encoding_aliases {
     { ISO-8859-16 iso-ir-226 ISO_8859-16:2001 ISO_8859-16 latin10 l10 }
     { GBK CP936 MS936 windows-936 }
     { JIS_Encoding csJISEncoding }
-    { Shift_JIS MS_Kanji csShiftJIS }
+    { Shift_JIS MS_Kanji csShiftJIS ShiftJIS Shift-JIS }
     { Extended_UNIX_Code_Packed_Format_for_Japanese csEUCPkdFmtJapanese
       EUC-JP }
     { Extended_UNIX_Code_Fixed_Width_for_Japanese csEUCFixWidJapanese }
@@ -240,6 +240,52 @@ set encoding_aliases {
     { Big5 csBig5 }
 }
 
+set encoding_groups {
+    {"" ""
+	{"Unicode" UTF-8}
+	{"Western" ISO-8859-1}}
+    {we "West European"
+	{"Western" ISO-8859-15 CP-437 CP-850 MacRoman CP-1252 Windows-1252}
+	{"Celtic" ISO-8859-14}
+	{"Greek" ISO-8859-14 ISO-8859-7 CP-737 CP-869 MacGreek CP-1253 Windows-1253}
+	{"Icelandic" MacIceland MacIcelandic CP-861}
+	{"Nordic" ISO-8859-10 CP-865}
+	{"Portuguese" CP-860}
+	{"South European" ISO-8859-3}}
+    {ee "East European"
+	{"Baltic" CP-775 ISO-8859-4 ISO-8859-13 CP-1257 Windows-1257}
+	{"Central European" CP-852 ISO-8859-2 MacCE CP-1250 Windows-1250}
+	{"Croatian" MacCroatian}
+	{"Cyrillic" CP-855 ISO-8859-5 ISO-IR-111 KOI8-R MacCyrillic CP-1251 Windows-1251}
+	{"Russian" CP-866}
+	{"Ukrainian" KOI8-U MacUkraine MacUkrainian}
+	{"Romanian" ISO-8859-16 MacRomania MacRomanian}}
+    {ea "East Asian"
+	{"Generic" ISO-2022}
+	{"Chinese Simplified" GB2312 GB1988 GB12345 GB2312-RAW GBK EUC-CN GB18030 HZ ISO-2022-CN}
+	{"Chinese Traditional" Big5 Big5-HKSCS EUC-TW CP-950}
+	{"Japanese" EUC-JP ISO-2022-JP Shift-JIS JIS-0212 JIS-0208 JIS-0201 CP-932 MacJapan}
+	{"Korean" EUC-KR UHC JOHAB ISO-2022-KR CP-949 KSC5601}}
+    {sa "SE & SW Asian"
+	{"Armenian" ARMSCII-8}
+	{"Georgian" GEOSTD8}
+	{"Thai" TIS-620 ISO-8859-11 CP-874 Windows-874 MacThai}
+	{"Turkish" CP-857 CP857 ISO-8859-9 MacTurkish CP-1254 Windows-1254}
+	{"Vietnamese" TCVN VISCII VPS CP-1258 Windows-1258}
+	{"Hindi" MacDevanagari}
+	{"Gujarati" MacGujarati}
+	{"Gurmukhi" MacGurmukhi}}
+    {me "Middle Eastern"
+	{"Arabic" ISO-8859-6 Windows-1256 CP-1256 CP-864 MacArabic}
+	{"Farsi" MacFarsi}
+	{"Hebrew" ISO-8859-8-I Windows-1255 CP-1255 ISO-8859-8 CP-862 MacHebrew}}
+    {mi "Misc"
+	{"7-bit" ASCII}
+	{"16-bit" Unicode}
+	{"Legacy" CP-863 EBCDIC}
+	{"Symbol" Symbol Dingbats MacDingbats MacCentEuro}}
+}
+
 proc tcl_encoding {enc} {
     global encoding_aliases
     set names [encoding names]
@@ -248,7 +294,7 @@ proc tcl_encoding {enc} {
     set i [lsearch -exact $lcnames $enc]
     if {$i < 0} {
 	# look for "isonnn" instead of "iso-nnn" or "iso_nnn"
-	if {[regsub {^iso[-_]} $enc iso encx]} {
+	if {[regsub {^(iso|cp|ibm|jis)[-_]} $enc {\1} encx]} {
 	    set i [lsearch -exact $lcnames $encx]
 	}
     }
@@ -260,7 +306,7 @@ proc tcl_encoding {enc} {
 	    foreach e $ll {
 		set i [lsearch -exact $lcnames $e]
 		if {$i < 0} {
-		    if {[regsub {^iso[-_]} $e iso ex]} {
+		    if {[regsub {^(iso|cp|ibm|jis)[-_]} $e {\1} ex]} {
 			set i [lsearch -exact $lcnames $ex]
 		    }
 		}
@@ -288,3 +334,84 @@ proc get_path_encoding {path} {
 	}
 	return $tcl_enc
 }
+
+proc build_encoding_submenu {parent grp cmd} {
+	global used_encodings
+
+	set mid [lindex $grp 0]
+	set gname [mc [lindex $grp 1]]
+
+	set smenu {}
+	foreach subset [lrange $grp 2 end] {
+		set name [mc [lindex $subset 0]]
+
+		foreach enc [lrange $subset 1 end] {
+			set tcl_enc [tcl_encoding $enc]
+			if {$tcl_enc eq {}} continue
+
+			if {$smenu eq {}} {
+				if {$mid eq {}} {
+					set smenu $parent
+				} else {
+					set smenu "$parent.$mid"
+					menu $smenu
+					$parent add cascade \
+						-label $gname \
+						-menu $smenu
+				}
+			}
+
+			if {$name ne {}} {
+				set lbl "$name ($enc)"
+			} else {
+				set lbl $enc
+			}
+			$smenu add command \
+				-label $lbl \
+				-command [concat $cmd [list $tcl_enc]]
+
+			lappend used_encodings $tcl_enc
+		}
+	}
+}
+
+proc popup_btn_menu {m b} {
+	tk_popup $m [winfo pointerx $b] [winfo pointery $b]
+}
+
+proc build_encoding_menu {emenu cmd {nodef 0}} {
+	$emenu configure -postcommand \
+		[list do_build_encoding_menu $emenu $cmd $nodef]
+}
+
+proc do_build_encoding_menu {emenu cmd {nodef 0}} {
+	global used_encodings encoding_groups
+
+	$emenu configure -postcommand {}
+
+	if {!$nodef} {
+		$emenu add command \
+			-label [mc "Default"] \
+			-command [concat $cmd [list {}]]
+	}
+	set sysenc [encoding system]
+	$emenu add command \
+		-label [mc "System (%s)" $sysenc] \
+		-command [concat $cmd [list $sysenc]]
+
+	# Main encoding tree
+	set used_encodings [list identity]
+	$emenu add separator
+	foreach grp $encoding_groups {
+		build_encoding_submenu $emenu $grp $cmd
+	}
+
+	# Add unclassified encodings
+	set unused_grp [list [mc Other]]
+	foreach enc [encoding names] {
+		if {[lsearch -exact $used_encodings $enc] < 0} {
+			lappend unused_grp $enc
+		}
+	}
+	build_encoding_submenu $emenu [list other [mc Other] $unused_grp] $cmd
+}
diff --git a/lib/option.tcl b/lib/option.tcl
index 40af44e..c80c939 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -152,7 +152,7 @@ proc do_options {} {
 		{i-1..99 gui.diffcontext {mc "Number of Diff Context Lines"}}
 		{i-0..99 gui.commitmsgwidth {mc "Commit Message Text Width"}}
 		{t gui.newbranchtemplate {mc "New Branch Name Template"}}
-		{t gui.encoding {mc "Default File Contents Encoding"}}
+		{c gui.encoding {mc "Default File Contents Encoding"}}
 		} {
 		set type [lindex $option 0]
 		set name [lindex $option 1]
@@ -182,6 +182,7 @@ proc do_options {} {
 				pack $w.$f.$optid.v -side right -anchor e -padx 5
 				pack $w.$f.$optid -side top -anchor w -fill x
 			}
+			c -
 			t {
 				frame $w.$f.$optid
 				label $w.$f.$optid.l -text "$text:"
@@ -194,6 +195,16 @@ proc do_options {} {
 				pack $w.$f.$optid.v -side left -anchor w \
 					-fill x -expand 1 \
 					-padx 5
+				if {$type eq {c}} {
+					menu $w.$f.$optid.m
+					build_encoding_menu $w.$f.$optid.m \
+						[list set ${f}_config_new($name)] 1
+					button $w.$f.$optid.b \
+						-text [mc "Change"] \
+						-command [list popup_btn_menu \
+							$w.$f.$optid.m $w.$f.$optid.b]
+					pack $w.$f.$optid.b -side left -anchor w
+				}
 				pack $w.$f.$optid -side top -anchor w -fill x
 			}
 			}
-- 
1.6.0.20.g6148bc
