From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] send-email: drop misleading function prototype
Date: Sun, 31 Mar 2013 18:40:41 -0700
Message-ID: <1364780442-6015-2-git-send-email-gitster@pobox.com>
References: <7vr4ivni5g.fsf@alter.siamese.dyndns.org>
 <1364780442-6015-1-git-send-email-gitster@pobox.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 01 03:41:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMTkN-0000nz-8J
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 03:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755867Ab3DABkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 21:40:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57184 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755805Ab3DABkr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 21:40:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F404CED63;
	Mon,  1 Apr 2013 01:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=TI2C
	ebVeoRpZzquYWix3yh02eMQ=; b=YpirrxbWbpwZ+8q5s86C1/EifGC6S44ITVN0
	sfJsbjX2A972jlyWbtugHc3d+RBRE9o0Q/PsWmLeDvlZpnYRzg06ROPKeOLnry1H
	K80+kQE94iTb4zCrjRujeYQeIABYaPWM1zmI5sjsoV5/4+zL9UPIZInPNmg21/Q/
	oEJJM9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	X1HtUvv9EU7adlMxTtL8vPVREbKYxq60W3x6PJSnCN2BYcC+VvIINvlX4lnLFqEZ
	17yHhGIxE5QfPjZINeEX2kXmdk7ETEVbBItBh0jD7sWQ2X+TbrzHS6VX8ft/iRQb
	sNMR9qFTLGktL0xXaaxdRJbNd5CLu+2/qNuZSz5YHbM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7BBEED62;
	Mon,  1 Apr 2013 01:40:46 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 766A5ED60; Mon,  1 Apr 2013
 01:40:46 +0000 (UTC)
X-Mailer: git-send-email 1.8.2-441-g6e6f07b
In-Reply-To: <1364780442-6015-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2C99EAA4-9A6D-11E2-9026-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219654>

From: Ramkumar Ramachandra <artagnon@gmail.com>

The subroutine check_file_rev_conflict() is called from two places,
both of which expects to pass a single scaler variable and see if
that can be interpreted as a pathname or a revision name.  It is
defined with a function prototype ($) to force a scaler context
while evaluating the arguments at the calling site but it does not
help the current calling sites.  The only effect it has is to hurt
future calling sites that may want to build an argument list in an
array variable and call it as check_file_rev_confict(@args).

Drop the misleading prototype, as Perlcritic suggests.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 79cc5be..86dd593 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -513,7 +513,7 @@ sub split_addrs {
 ($sender) = expand_aliases($sender) if defined $sender;
 
 # returns 1 if the conflict must be solved using it as a format-patch argument
-sub check_file_rev_conflict($) {
+sub check_file_rev_conflict {
 	return unless $repo;
 	my $f = shift;
 	try {
-- 
1.8.2-441-g6e6f07b
