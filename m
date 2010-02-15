From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: [PATCH v2] require_work_tree broken with NONGIT_OK
Date: Mon, 15 Feb 2010 10:44:56 -0500
Message-ID: <4B796BF8.7000408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 16:45:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh38M-0001zI-0Y
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 16:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755858Ab0BOPpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 10:45:08 -0500
Received: from mail-qy0-f200.google.com ([209.85.221.200]:57174 "EHLO
	mail-qy0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab0BOPpE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 10:45:04 -0500
Received: by qyk38 with SMTP id 38so322837qyk.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 07:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=QX8twc8yrc9LEjI3xTHIyKDVLcdaIsbzS1NwDTe7Xj0=;
        b=JI/O2HTOQlOkO3bxjcfAH0nCnzSExVQrxpjmIjiwQwxJbIFsCIyF9wvkQTG0o0d+/D
         W28Ay73ZaTmFngvdhfA96wIda6K/GM+/mOratgV9DpojBw3mfghqHMtmi7NKWoe+4V2d
         e3X/NlrEw9cyHLiRe/O3ojcCYJM5Rz9AVjDIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        b=PV6R3XHRv8SnWV9izJvtsRDJCIml9sHJzgKg+uyeP+YunYJtay3RkW3IvFD3hGka5G
         clPuUT6ga1UrRel9y5AO8gOEnNItfnXPawR6OOThFqLoMMWWSr0JVJOUrWTkWXWaQDLz
         rjTDUuo+mpwP+Pk4oRhP9GAN3tR6J+QVnUtqc=
Received: by 10.224.72.82 with SMTP id l18mr2702780qaj.45.1266248699107;
        Mon, 15 Feb 2010 07:44:59 -0800 (PST)
Received: from ?10.145.1.205? (smtpin.revolutionlinux.com [69.70.10.188])
        by mx.google.com with ESMTPS id 20sm4328276qyk.9.2010.02.15.07.44.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Feb 2010 07:44:57 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20100108 Lightning/1.0b1 Icedove/3.0
X-Enigmail-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140015>

Sourcing git-sh-setup: After having set NONGIT_OK, when calling the
function require_work_tree while outside of a git repository shows a
syntax error.
This is caused by the call to git rev-parse --is-inside-work-tree
printing nothing when it is called outside of a git repository.

Quoting the call removes the syntax error and sending stderr to
/dev/null removes duplicate error messages.
---

This is a fixup rollout after discussion on the patch:
 - Commit message better identifies the cause of the problem
 - the test was not working in v1. fixed this up

 git-sh-setup.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index d56426d..5e22440 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -128,7 +128,7 @@ cd_to_toplevel () {
 }
  require_work_tree () {
-	test $(git rev-parse --is-inside-work-tree) = true ||
+	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true ||
 	die "fatal: $0 cannot be used without a working tree."
 }
 -- 1.6.6
