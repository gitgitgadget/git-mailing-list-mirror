From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH v2] t/.gitattributes: only ignore whitespace errors in test files
Date: Fri, 13 Jun 2008 09:49:33 +0200
Message-ID: <1213343373-24104-1-git-send-email-LeWiemann@gmail.com>
References: <20080613060629.GC26768@sigill.intra.peff.net>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 11:53:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K75yW-0005Gd-2V
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 11:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760306AbYFMJw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 05:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754840AbYFMJw0
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 05:52:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:64351 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866AbYFMJwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 05:52:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2715224fgg.17
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 02:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:from;
        bh=tcty47N4+1d1masegEOalJecPAWIGx5QsKtMwD5nSsM=;
        b=ib1sF39qWEpUTm2BowCBIwuI9tsrXvXG2EQU9wYBKTuXSnb5ysWGUwYyIL5DdBNxZv
         EYMTiTbKNYSugc6rETFVemv9jrcPTiPvDOxnHHWidxB3acaYLauCzensjasHrq9RoOeH
         Dz5Izry/ogu48NXD+0viucRY/latObhuXzLRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=RlXZCbQ8OLqOR7ZjwpnS0SrSXvyeb+cQXxH3SYiP0l+PIlRPexDmaR/bkZ2t1YIwXk
         Bbib9D8oaMRqgmfaZffLdK4jt/gmfAHzigBOiIlDU1LX3MsePgw3+rQmN3dcS6P6ZzJn
         AlUrKTSsSoRlJa2WKlHC5YmF51FueL+lYypzc=
Received: by 10.86.99.9 with SMTP id w9mr3637427fgb.70.1213350741355;
        Fri, 13 Jun 2008 02:52:21 -0700 (PDT)
Received: from fly ( [91.33.248.95])
        by mx.google.com with ESMTPS id d6sm5163965fga.2.2008.06.13.02.52.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Jun 2008 02:52:20 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K742P-0006HH-DK; Fri, 13 Jun 2008 09:49:33 +0200
X-Mailer: git-send-email 1.5.6.rc2.33.g0b5e3.dirty
In-Reply-To: <20080613060629.GC26768@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84858>

Only ignore whitespace errors in t/tNNNN-*.sh and the t/tNNNN
subdirectories (since they can contain test-relevant trailing
whitespace).  Other files (like test libraries) should still be
checked.

Also fix a whitespace error in t/test-lib.sh.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Jeff King wrote:
> What is the difference between test-lib.sh and tNNNN-*.sh that makes one
> subject to whitespace checking and the other not?

I thought that was obvious since they had been not been checked before
either (see the diff). :) Anyways, added explanation in parens in the
commit message; nothing else has changed since v1.

 t/.gitattributes |    3 ++-
 t/test-lib.sh    |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/.gitattributes b/t/.gitattributes
index 562b12e..ab6edbf 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -1 +1,2 @@
-* -whitespace
+t[0-9][0-9][0-9][0-9]-*.sh -whitespace
+t[0-9][0-9][0-9][0-9]/* -whitespace
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7a8bd27..e9c9081 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -168,7 +168,7 @@ trap 'die' exit
 # environment variables to work around this.
 #
 # In particular, quoting isn't enough, as the path may contain the same quote
-# that we're using. 
+# that we're using.
 test_set_editor () {
 	FAKE_EDITOR="$1"
 	export FAKE_EDITOR
-- 
1.5.6.rc2.33.g0b5e3.dirty
