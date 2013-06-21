From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH 0/3] Handling overlapping refspecs slightly smarter
Date: Fri, 21 Jun 2013 12:04:08 +0200
Message-ID: <1371809051-29988-1-git-send-email-dennis@kaarsemaker.net>
References: <1371763424.17896.32.camel@localhost>
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 21 12:04:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpyCb-0005XH-GV
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 12:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100Ab3FUKEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 06:04:16 -0400
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:59335 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750725Ab3FUKEQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Jun 2013 06:04:16 -0400
Received: from cpsps-ews24.kpnxchange.com ([10.94.84.190]) by cpsmtpb-ews05.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Fri, 21 Jun 2013 12:04:13 +0200
Received: from CPSMTPM-TLF103.kpnxchange.com ([195.121.3.6]) by cpsps-ews24.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Fri, 21 Jun 2013 12:04:13 +0200
Received: from kaarsemaker.net ([82.168.11.8]) by CPSMTPM-TLF103.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Fri, 21 Jun 2013 12:04:12 +0200
Received: by kaarsemaker.net (sSMTP sendmail emulation); Fri, 21 Jun 2013 12:04:12 +0200
X-Mailer: git-send-email 1.8.3.1-619-gbec0aa7
In-Reply-To: <1371763424.17896.32.camel@localhost>
X-OriginalArrivalTime: 21 Jun 2013 10:04:12.0880 (UTC) FILETIME=[AE35BD00:01CE6E66]
X-RcptDomain: vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228587>

1/3 should be pretty sane, just adding a warning in documentation and 'git
remote add' about overlapping refspecs.

2/3 only makes sense if 3/3 is accepted, as it's a test for that change.

3/3 I'm not 100% sure about, though the approach feels reasonably ok. It changes
get_stale_heads to also detect overlapping refspecs and abort any prune action
if it finds them. What I'm not sure about is whether this is the right place to
do it, or to do it in the callers of get_stale_heads and exit(1) in this
situation.

Both 1/3 and 3/3 ignore exactly matching refspecs, as that's a supported thing
already, another test in t5505 broke before I made both ignore exactly matching
refspecs.


Dennis Kaarsemaker (3):
  remote: Add warnings about mixin --mirror and other remotes
  remote: Add test for prune and mixed --mirror and normal remotes
  remote: don't prune when detecting overlapping refspecs

 Documentation/git-remote.txt |  6 +++++-
 builtin/remote.c             | 17 +++++++++++++++++
 remote.c                     | 23 +++++++++++++++++++++++
 t/t5505-remote.sh            |  9 +++++++++
 4 files changed, 54 insertions(+), 1 deletion(-)

-- 
1.8.3.1-619-gbec0aa7
