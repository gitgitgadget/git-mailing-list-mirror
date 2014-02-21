From: Daniel Liew <delcypher@gmail.com>
Subject: [PATCH] git-remote-hg : Enable use of, $GIT_DIR/hg/origin/clone/.hg/hgrc
Date: Fri, 21 Feb 2014 15:17:16 +0000
Message-ID: <53076DFC.1000602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: felipe.contreras@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 21 16:17:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGrqu-00013Z-1O
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 16:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbaBUPRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 10:17:20 -0500
Received: from mail-wg0-f43.google.com ([74.125.82.43]:47168 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755941AbaBUPRT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 10:17:19 -0500
Received: by mail-wg0-f43.google.com with SMTP id a1so2578775wgh.34
        for <git@vger.kernel.org>; Fri, 21 Feb 2014 07:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=Es3TAs2VeyrawtMd64z7l88wEQ8xo8wvhyGLpoaB2Kc=;
        b=cxBAx/A7iDqkri8/2YoM6VtGsTNDZvVMdVt867bK6mM4wuk1HCaXDiXpNRaWeeL/8c
         nEUAGATP3h0v66YZCPkibTyZ9w/fBPNBcyqYJfZ0e16vlhkkhehpx1DJTz/vKFic8XXt
         acmNaQ+d8GJn3JSmyc6kWAVH3j+MsyLGTtmBfUwdiJyDvzf7TKbh7XdEOVa9r+WrAoUM
         +T+vaIe7vWf7YGKdAyjO3KKlfjODTy9dBlTlD7o4gsEzhr6/J+gyWdAEFKY72ERgmd49
         uAVTxwMlT2Cr0d56U5SahzXR/xYYlkiHaNWEU4LlFhSiQs9XBEdJtjXSVlAqVJBT7/Lu
         gk7Q==
X-Received: by 10.194.84.144 with SMTP id z16mr7700175wjy.23.1392995837777;
        Fri, 21 Feb 2014 07:17:17 -0800 (PST)
Received: from icarus.doc.ic.ac.uk (icarus.doc.ic.ac.uk. [146.169.15.49])
        by mx.google.com with ESMTPSA id r1sm8593484wia.5.2014.02.21.07.17.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Feb 2014 07:17:16 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242465>

git-remote-hg : Enable use of, $GIT_DIR/hg/origin/clone/.hg/hgrc

Use the hgrc configuration file in the internal mercurial repository in
addition to the other system wide hgrc files. This is done by using the
'ui' object from the 'repository' object which will have loaded the
repository hgrc file if it exists.

Prior to this patch the mercurial repository's hgrc file was ignored
which I consider to be a bug.

Signed-off-by: Dan Liew <delcypher@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg
b/contrib/remote-helpers/git-remote-hg
index eb89ef6..451842a 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -421,7 +421,7 @@ def get_repo(url, alias):

         repo = hg.repository(myui, local_path)
         try:
-            peer = hg.peer(myui, {}, url)
+            peer = hg.peer(repo._unfilteredrepo.ui, {}, url)
         except:
             die('Repository error')
         repo.pull(peer, heads=None, force=True)
-- 
1.9.0
