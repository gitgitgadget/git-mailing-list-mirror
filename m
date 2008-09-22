From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: [PATCH (GIT-GUI,GITK) 6/8] gitk: Port new encoding logic from git-gui.
Date: Mon, 22 Sep 2008 13:02:52 +0400
Organization: HOME
Message-ID: <200809221302.52424.angavrilov@gmail.com>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com> <200809221201.35507.angavrilov@gmail.com> <48D7554C.4020601@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 22 11:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhhMF-0006js-8p
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 11:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbYIVJES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 05:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbYIVJES
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 05:04:18 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:51793 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbYIVJER (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 05:04:17 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1461493fkq.5
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 02:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=NIPJxHs43OvrO3xonbHtvKL5g2EBwgfuudbR24VexKk=;
        b=f/toyuj98/YN2uHYl+2onaF5HpHWUy6JBHl9e/XuMg9t8XiTUl4mUNVyGCYla/glko
         YTIQhoZ/uDcHfuAzCDFgN4VJi4QplbBCVKiMQqjIb0EcM3VQ4PMUDGoKNHhH1+cDPQWL
         1Fo9/MZI3SCPFV/9Rq0uwgfH09ULjUrj2MErI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jnLVR8o050zkQcIZ6KcZCwHdBZpINOPmkowuTA1KotVt5f2aqP4UXJkRbHQfoBjXrd
         o1HdoLEP/Hoa2+iXMwa6OIybmZLPz8Kwhm73zJ07gqR31UL0VRUoewhFjKpSbTGVEOeu
         1AOU6AIvJ3+E/dEIWaHK+wy2shCRougRKNIcE=
Received: by 10.180.241.8 with SMTP id o8mr2041799bkh.60.1222074255774;
        Mon, 22 Sep 2008 02:04:15 -0700 (PDT)
Received: from keydesk.localnet ( [92.255.85.78])
        by mx.google.com with ESMTPS id 35sm4219415fkt.12.2008.09.22.02.04.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Sep 2008 02:04:15 -0700 (PDT)
User-Agent: KMail/1.10.1 (Linux/2.6.26.3-29.fc9.i686; KDE/4.1.0; i686; ; )
In-Reply-To: <48D7554C.4020601@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96463>

On Monday 22 September 2008 12:20:28 Johannes Sixt wrote:
> Alexander Gavrilov schrieb:
> > On Monday 22 September 2008 11:25:43 Johannes Sixt wrote:
> >> Alexander Gavrilov schrieb:
> >>> Subject: [PATCH] gitk: Implement batch lookup and caching of encoding attrs.
> >>>
> >>> When the diff contains thousands of files, calling git-check-attr
> >>> once per file is very slow. With this patch gitk does attribute
> >>> lookup in batches of 30 files while reading the diff file list,
> >>> which leads to a very noticeable speedup.
> >> This one does not work for me: The correct is not picked up anymore,
> >> neither in Patch mode nor Tree mode. (It works as expected without this
> >> patch.)
> >>
> > 
> > OOPS, I forgot to copy the line that removes leading whitespace:
> 
> Thanks, with this it works now. The delay for a 1000 file patch is
> bearable (on Windows, but y'know, Windows types are masochists :-).

You can also try applying this patch (originally made for git-gui). It may save
additional 0.3 sec, especially for obscure legacy encodings.

P.S. I do believe there is a place for a library shared between gitk & git-gui.
This code duplication is ugly and annoying; moreover, they have different
indentation conventions, which get messed up...

--- >8 --- 
From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH] git-gui: Optimize encoding name resolution using a lookup table.

Encoding menu construction does almost a hundred of encoding
resolutions, which with the old implementation led to a
small but noticeable delay.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |   84 ++++++++++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/gitk b/gitk
index 254faa1..1355aa2 100755
--- a/gitk
+++ b/gitk
@@ -9779,39 +9779,63 @@ set encoding_aliases {
     { Big5 csBig5 }
 }
 
-proc tcl_encoding {enc} {
-    global encoding_aliases
-    set names [encoding names]
-    set lcnames [string tolower $names]
-    set enc [string tolower $enc]
-    set i [lsearch -exact $lcnames $enc]
-    if {$i < 0} {
-	# look for "isonnn" instead of "iso-nnn" or "iso_nnn"
-	if {[regsub {^(iso|cp|ibm|jis)[-_]} $enc {\1} encx]} {
-	    set i [lsearch -exact $lcnames $encx]
+proc build_encoding_table {} {
+	global encoding_aliases encoding_lookup_table
+
+	# Prepare the lookup list; cannot use lsort -nocase because
+	# of compatibility issues with older Tcl (e.g. in msysgit)
+	set names [list]
+	foreach item [encoding names] {
+		lappend names [list [string tolower $item] $item]
+	}
+	set names [lsort -ascii -index 0 $names]
+	# neither can we use lsearch -index
+	set lnames [list]
+	foreach item $names {
+		lappend lnames [lindex $item 0]
+	}
+
+	foreach grp $encoding_aliases {
+		set target {}
+		foreach item $grp {
+			set i [lsearch -sorted -ascii $lnames \
+					[string tolower $item]]
+			if {$i >= 0} {
+				set target [lindex $names $i 1]
+				break
+			}
+		}
+		if {$target eq {}} continue
+		foreach item $grp {
+			set encoding_lookup_table([string tolower $item]) $target
+		}
 	}
-    }
-    if {$i < 0} {
-	foreach l $encoding_aliases {
-	    set ll [string tolower $l]
-	    if {[lsearch -exact $ll $enc] < 0} continue
-	    # look through the aliases for one that tcl knows about
-	    foreach e $ll {
-		set i [lsearch -exact $lcnames $e]
-		if {$i < 0} {
-		    if {[regsub {^(iso|cp|ibm|jis)[-_]} $e {\1} ex]} {
-			set i [lsearch -exact $lcnames $ex]
-		    }
+
+	foreach item $names {
+		set encoding_lookup_table([lindex $item 0]) [lindex $item 1]
+	}
+}
+
+proc tcl_encoding {enc} {
+	global encoding_lookup_table
+	if {$enc eq {}} {
+		return {}
+	}
+	if {![info exists encoding_lookup_table]} {
+		build_encoding_table
+	}
+	set enc [string tolower $enc]
+	if {![info exists encoding_lookup_table($enc)]} {
+		# look for "isonnn" instead of "iso-nnn" or "iso_nnn"
+		if {[regsub {^(iso|cp|ibm|jis)[-_]} $enc {\1} encx]} {
+			set enc $encx
 		}
-		if {$i >= 0} break
-	    }
-	    break
 	}
-    }
-    if {$i >= 0} {
-	return [lindex $names $i]
-    }
-    return {}
+	if {[info exists encoding_lookup_table($enc)]} {
+		return $encoding_lookup_table($enc)
+	} else {
+		return {}
+	}
 }
 
 proc gitattr {path attr default} {
-- 
1.6.0.20.g6148bc
