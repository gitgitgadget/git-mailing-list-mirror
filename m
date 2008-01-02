From: David Kastrup <dak@gnu.org>
Subject: Trouble generating info documentation
Date: Wed, 02 Jan 2008 13:37:48 +0100
Message-ID: <86myrol7xf.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 02 13:38:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JA2ra-0003gs-4J
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 13:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479AbYABMiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 07:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753518AbYABMiA
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 07:38:00 -0500
Received: from main.gmane.org ([80.91.229.2]:47396 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881AbYABMh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 07:37:59 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JA2r6-0005SR-UF
	for git@vger.kernel.org; Wed, 02 Jan 2008 12:37:57 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Jan 2008 12:37:56 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Jan 2008 12:37:56 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:KNqtmRBpBm0I4zJFg6OCimI/oK0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69474>

--=-=-=


Hi,

in my version of docbook2x, the --to-stdout option is broken and
requires the following patch:


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline

diff -u -L /sudo:root@lola.quinscape.zz:/usr/bin/db2x_texixml -L /tmp/buffer-content-236002qn /tmp/tramp.23600D1t /tmp/buffer-content-236002qn
--- /tmp/buffer-content-236002qn
+++ /sudo:root@lola.quinscape.zz:/usr/bin/db2x_texixml
@@ -782,9 +782,11 @@
                 $openstr = '>-';
             }
         } else {
-            $openstr .= '> ' . shell_quote($filename);
-            print "$filename\n"
-                if $self->{options}->{'list-files'};
+	    if ($self->{options}->{'list-files'})
+	    {
+		$openstr .= '> ' . shell_quote($filename);
+		print "$filename\n";
+	    }
         }
     }
 

Diff finished.  Wed Jan  2 13:33:08 2008

--=-=-=


After fixing this (anybody got a clue how to get this upstream?) I get
the following problem upon make info:

makeinfo --no-split gitman.texi
gitman.texi:2462: Node `CO1-1' previously defined at line 1830.
gitman.texi:9205: Node `CO1-1' previously defined at line 1830.
gitman.texi:9206: Node `CO1-2' previously defined at line 2463.
gitman.texi:9207: Node `CO1-3' previously defined at line 2465.
gitman.texi:9229: Node `CO2-1' previously defined at line 1848.
gitman.texi:9230: Node `CO2-2' previously defined at line 1849.
gitman.texi:12904: Node `CO1-1' previously defined at line 1830.
gitman.texi:12905: Node `CO1-2' previously defined at line 2463.
gitman.texi:16075: warning: @strong{Note...} produces a spurious cross-reference in Info; reword to avoid that.
gitman.texi:18303: Node `CO1-1' previously defined at line 1830.
gitman.texi:18304: Node `CO1-2' previously defined at line 2463.
gitman.texi:18305: Node `CO1-3' previously defined at line 2465.
gitman.texi:18332: Node `CO2-1' previously defined at line 1848.
gitman.texi:18348: Node `CO3-1' previously defined at line 9254.
gitman.texi:18349: Node `CO3-2' previously defined at line 9255.
gitman.texi:18350: Node `CO3-3' previously defined at line 9256.
gitman.texi:18373: Node `CO4-1' previously defined at line 9277.
gitman.texi:18375: Node `CO4-2' previously defined at line 9278.
gitman.texi:18376: Node `CO4-3' previously defined at line 9279.
gitman.texi:18408: Node `CO5-1' previously defined at line 9301.
gitman.texi:18412: Node `CO5-2' previously defined at line 9302.
gitman.texi:22624: Node `CO1-1' previously defined at line 1830.
gitman.texi:22625: Node `CO1-2' previously defined at line 2463.
gitman.texi:22626: Node `CO1-3' previously defined at line 2465.
makeinfo: Removing output file `/rep/git/Documentation/gitman.info' due to errors; use --force to preserve.


-- 
David Kastrup

--=-=-=--
