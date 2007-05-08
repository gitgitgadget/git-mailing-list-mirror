From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: git-http-fetch Segmentation fault
Date: Tue, 8 May 2007 16:27:35 -0300
Organization: Mandriva
Message-ID: <20070508162735.6c530a70@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: boiko@mandriva.com.br
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 08 21:28:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlVM1-0005XP-BC
	for gcvg-git@gmane.org; Tue, 08 May 2007 21:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031321AbXEHT2F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 15:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031541AbXEHT2F
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 15:28:05 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:57038 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031321AbXEHT2E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 15:28:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 75BA417EC6
	for <git@vger.kernel.org>; Tue,  8 May 2007 16:28:00 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id fhEn4HyWU71y; Tue,  8 May 2007 16:27:53 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id C7C0117EBF;
	Tue,  8 May 2007 16:27:45 -0300 (BRT)
X-Mailer: Claws Mail 2.7.2 (GTK+ 2.10.9; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46608>


 Hi,

 A friend of mine reported an easy to reproduce segmentation fault
when cloning through http from his repository:

"""
~/ git clone http://people.mandriva.com/~boiko/mandrivamenu.git
got 299cdadd846913a052df361e973a947622f23198
walk 299cdadd846913a052df361e973a947622f23198
...
got 0ecd10d9d6ab020c2469a961777854afda705776
/home/lcapitulino/git//bin/git-clone: line 33: 22353 Segmentation fault      (core dumped) git-http-fetch $v -a -w "$tname" "$sha1" "$1"
"""

 Sometimes it shows up as a corrupted double-linked list, detected by
glibc:

"""
*** glibc detected *** git-http-fetch: corrupted double-linked list: 0x080a5680 ***
"""

 It's reproducible with Junio's master and maint branches (3082ac and
53a582 respectivelly).

 BTW, At line 406 (the trap command), git-clone script removes the
directory it was fetching. This removes the core dump file too.
We should not remove the directory if there's a core dump in there.

-- 
Luiz Fernando N. Capitulino
