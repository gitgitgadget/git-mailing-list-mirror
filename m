From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 1/2] git-gui: Unstaging a partly staged entry didn't update
 file_states correctly
Date: Sat, 02 Jan 2010 17:58:23 +0100
Message-ID: <4B3F7B2F.8020701@web.de>
References: <4B3F7AE2.10007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 02 17:58:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NR7J8-0003G7-EP
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 17:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807Ab0ABQ60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 11:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752752Ab0ABQ60
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 11:58:26 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:36448 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938Ab0ABQ60 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 11:58:26 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 579FA14AF7088;
	Sat,  2 Jan 2010 17:58:25 +0100 (CET)
Received: from [80.128.99.24] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NR7J1-0001W4-00; Sat, 02 Jan 2010 17:58:23 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <4B3F7AE2.10007@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19LI1zFg8Y+dIqZ2R52ws5GUjR48ZFrhtS/Zkxn
	Suajxw+8JaSBrKVCu3cbjYxaW4PmcHnppGUvjbnNk4SFgay0N4
	INCm7/lzR45IsufSlFxg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136032>

When unstaging a partly staged file or submodule, the file_states list
was not updated properly (unless unstaged linewise). Its index_info part
did not contain the former head_info as it should have.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 git-gui/git-gui.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 718277a..e0dd5b5 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1613,6 +1613,9 @@ proc merge_state {path new_state {head_info {}} {index_info {}}} {
 	} elseif {$s0 ne {_} && [string index $state 0] eq {_}
 		&& $head_info eq {}} {
 		set head_info $index_info
+	} elseif {$s0 eq {_} && [string index $state 0] ne {_}} {
+		set index_info $head_info
+		set head_info {}
 	}

 	set file_states($path) [list $s0$s1 $icon \
-- 
1.6.6.339.g7cacc
