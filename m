From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: [PATCH 3/7] gitk: Allow starting gui blame for a specific line.
Date: Sat, 25 Oct 2008 20:45:53 +0400
Organization: HOME
Message-ID: <200810252045.54010.angavrilov@gmail.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com> <200810241213.01337.angavrilov@gmail.com> <18691.2467.601039.480382@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Oct 25 18:53:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtmOV-0003Aw-98
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 18:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbYJYQr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 12:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbYJYQr4
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 12:47:56 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:50182 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbYJYQrz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 12:47:55 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1206238fkq.5
        for <git@vger.kernel.org>; Sat, 25 Oct 2008 09:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=uSWL8k+aMvjM0XemTQ+9iLMW6DEszpEkzOxmILLk1nM=;
        b=moxZvkrVhrXtWWouuCJald24fsV2SzAU18beBoIeU92gC1rcYUgqOmnp9vKpJWp6jQ
         5O2NrrRp1xwVOi2Xjvsufm80/rZMwTZMn8LyBXORCA9/Bk5dOa+kbeG7NaFIOFAeEQyO
         wB3nN+0AarHKKYdJiiyxxKCM0rBN5qcLZhync=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=v2qEoTLsyzUHOb0a9EWrRhcpIuZU7WACnV/tHpIub8sswQPOsGizGhYFeJKv1O4JYe
         tw+9WO1eAmYN7pU67V1Qyp5byI0xUJ4HoWrp1VreddWQpEvFhX97wKuM7XlY1xvAfThX
         GlHJChkK+LNRcYpM86pWHi0Hfr5vECVWUioeA=
Received: by 10.181.218.14 with SMTP id v14mr1310362bkq.48.1224953273805;
        Sat, 25 Oct 2008 09:47:53 -0700 (PDT)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id f31sm1789132fkf.0.2008.10.25.09.47.51
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 25 Oct 2008 09:47:52 -0700 (PDT)
User-Agent: KMail/1.10.1 (Linux/2.6.26.6-79.fc9.i686; KDE/4.1.2; i686; ; )
In-Reply-To: <18691.2467.601039.480382@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99115>

On Saturday 25 October 2008 15:57:23 Paul Mackerras wrote:
> > +    # Now scan the lines to determine offset within the hunk
> > +    set parent {}
> > +    set dline 0
> > +    set s_lno [lindex [split $s_lix "."] 0]
> > +
> > +    for {set i $line} {$i > $s_lno} {incr i -1} {
> > +	set c_line [$ctext get $i.0 "$i.0 + 1 lines"]
> > +	# Determine if the line is removed
> > +	set chunk [string range $c_line 0 [llength $base_lines]-2]
> 
> You need an [expr]:
> 
> set chunk [string range $c_line 0 [expr {[llength $base_lines] - 2}]]

Ugh. I guess I'll have to install docs from Tcl 8.4...
 
> > +	set removed_idx [string first "-" $chunk]
> > +	# Choose a parent index
> > +	if {$parent eq {}} {
> > +	    if {$removed_idx >= 0} {
> > +		set parent $removed_idx
> > +		incr parent
> > +	    } else {
> > +		set unchanged_idx [string first " " $chunk]
> > +		if {$unchanged_idx >= 0} {
> > +		    set parent $unchanged_idx
> > +		    incr parent
> > +		} else {
> > +		    # blame the current commit
> > +		    set parent 0
> > +		}
> > +	    }
> > +	}
> 
> I like this better than the previous version, but it would turn out a
> bit simpler if you use parent = -1 to indicate that we're blaming the
> current commit, and then increment it right at the end.

Yes, it's probably better to apply the following fixup.

Alexander


diff --git a/gitk b/gitk
index 6fbd6bb..68f07c2 100755
--- a/gitk
+++ b/gitk
@@ -3160,33 +3160,32 @@ proc find_hunk_blamespec {base line} {
 
     # Now scan the lines to determine offset within the hunk
     set parent {}
+    set max_parent [expr {[llength $base_lines]-2}]
     set dline 0
     set s_lno [lindex [split $s_lix "."] 0]
 
     for {set i $line} {$i > $s_lno} {incr i -1} {
 	set c_line [$ctext get $i.0 "$i.0 + 1 lines"]
 	# Determine if the line is removed
-	set chunk [string range $c_line 0 [llength $base_lines]-2]
+	set chunk [string range $c_line 0 $max_parent]
 	set removed_idx [string first "-" $chunk]
 	# Choose a parent index
 	if {$parent eq {}} {
 	    if {$removed_idx >= 0} {
 		set parent $removed_idx
-		incr parent
 	    } else {
 		set unchanged_idx [string first " " $chunk]
 		if {$unchanged_idx >= 0} {
 		    set parent $unchanged_idx
-		    incr parent
 		} else {
 		    # blame the current commit
-		    set parent 0
+		    set parent -1
 		}
 	    }
 	}
 	# then count other lines that belong to it
-	if {$parent > 0} {
-	    set code [string index $c_line $parent-1]
+	if {$parent >= 0} {
+	    set code [string index $c_line $parent]
 	    if {$code eq "-" || ($removed_idx < 0 && $code ne "+")} {
 		incr dline
 	    }
@@ -3197,7 +3196,8 @@ proc find_hunk_blamespec {base line} {
 	}
     }
 
-    if {$parent eq {}} { set parent 0 }
+    if {$parent eq {}} { set parent -1 }
+    incr parent
     incr dline [lindex $base_lines $parent]
     return [list $parent $dline]
 }
