From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] filter-branch: do not forget the '@' prefix to force
 git-timestamp
Date: Mon, 09 Jul 2012 16:56:17 -0700
Message-ID: <7vobnoij4u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 01:56:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoNoc-0006ZD-7G
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 01:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754955Ab2GIX4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 19:56:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48357 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754949Ab2GIX4V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 19:56:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB51896C4;
	Mon,  9 Jul 2012 19:56:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=5
	Hlyg2VWKLl32pxlaT+QRLVpgWk=; b=WBfHyBMcEKTo7Kx84ww/a/+MKlkvnlppZ
	myqghReW4gGVwPxwwKV4P/QQSljWWdD8KeeZSzlqUK3YQKuNk6vAx1YKXiayFGTE
	6VD0Bjk9jfaQWbChGCaTNdASf3UW8whSsbrWkXOpmFJvYvSmnaEgawbQ1w39uPPX
	gJAZjAmR2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=H3D
	1D72qSwZ6C3ex21Ne3j1NIDyhn+JSFzj2/h9tygysraiwanD5SHQIm9srY8xzPLc
	Kr9ek70yzInac00dAIbkROLjaZm7F8N/8xok64yXe8Vq/kwJh9iLfpyORiQ/uN5M
	i7nctOqMwTFlPiMCpVYH7Vy5G4CvBqCT+PUM5SKA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A18A396C3;
	Mon,  9 Jul 2012 19:56:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F09D696C2; Mon,  9 Jul 2012
 19:56:18 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD69D0D0-CA21-11E1-909F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201235>

For some reason, this script reinvents, instead of refactoring the
existing one in git-sh-setup, in the ident logic, and it was missed
when git-sh-setup was updated with 2c733fb (parse_date(): '@' prefix
forces git-timestamp, 2012-02-02).

Teach the script that it is OK to have a way ancient timestamp in
the commits that are being filtered.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-filter-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 804a7f4..b9cded5 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -84,7 +84,7 @@ set_ident () {
 			s/.*/GIT_'$uid'_EMAIL='\''&'\''; export GIT_'$uid'_EMAIL/p
 
 			g
-			s/^'$lid' [^<]* <[^>]*> \(.*\)$/\1/
+			s/^'$lid' [^<]* <[^>]*> \(.*\)$/@\1/
 			s/'\''/'\''\'\'\''/g
 			s/.*/GIT_'$uid'_DATE='\''&'\''; export GIT_'$uid'_DATE/p
 
-- 
1.7.11.1.294.gf7b86df
