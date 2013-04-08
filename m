From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] decorate: document API
Date: Sun, 07 Apr 2013 23:13:43 -0700
Message-ID: <7v61zx35yg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 08:52:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5tB-0000sy-N0
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934869Ab3DHGNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 02:13:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45722 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934860Ab3DHGNq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 02:13:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4E051066E;
	Mon,  8 Apr 2013 06:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=w
	AwDZqUmU3Lxf8qUSCfi5ObtSqE=; b=qjaZq/yX+nBRLJUVFAtbu1LSOVMP5uzZu
	4PCs1Tta9Z7wZKpzuKsjUEbrpsq9+Sg92qF0qlm+7BS1OpkaFrtFw14rIDhneJJu
	t05x7UA7QbCIxYKYD13L21eeDOSWlTN5BZlS0E4+K/ClTQXh84qZxRdWLnRrt5JN
	2oiAAfusag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=BeO
	S5EqG+4oscCnjYJrrITZcEqHJwSGgSkLaO00nH40EwYEAtIW3MbZMiOUdIRB7Lot
	E6nB773XCaTh9oP0E3cABcVM3gWgrsC+tkY5laKFwkGLcm3CoQvSedzZAeonOONW
	ExjkV2qmBt6CMW58yApJwBP5pvaOEyUhhISQFB3Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC8251066D;
	Mon,  8 Apr 2013 06:13:45 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F3611066C; Mon,  8 Apr
 2013 06:13:45 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 78149708-A013-11E2-850A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220402>

Ever since 530e741c726a (Start preparing the API documents.,
2007-11-24) added a placeholder to describe the various APIs,
the decorate API was never documented.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/api-decorate.txt | 35 ++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-decorate.txt b/Documentation/technical/api-decorate.txt
index 1d52a6c..0cc2b64 100644
--- a/Documentation/technical/api-decorate.txt
+++ b/Documentation/technical/api-decorate.txt
@@ -1,6 +1,37 @@
 decorate API
 ============
 
-Talk about <decorate.h>
+The decoration API is a mechanism to create and use a simple
+append-only hashtable to keep auxiliary information keyed by in-core
+objects.
 
-(Linus)
+Initialization
+--------------
+
+Prepare `struct decoration deco` somewhere in-core and
+`memset(&deco, 0, sizeof(&deco))` it.  This holds your hashtable.
+
+
+Adding
+------
+
+`add_decoration(struct decoration *deco, const struct object *obj,
+void *decoration)` remembers `decoration` for the given `obj`.
+
+The function overwrites the old `decoration` for the `obj`
+registered in the hashtable with the given `decoration`, and returns
+the old value.
+
+The `decoration` can be of any type that can be casted to `void *`
+and it is a responsibility of the caller to typecast it to more
+appropriate type.
+
+Looking up
+----------
+
+`lookup_decoration(struct decoration *deco, const struct object *obj)`
+returns the decoration the last call to `add_decoration()` added for
+the `obj`.  You cannot tell if `obj` does not appear in the hashtable
+at all, or if `obj` has decoration whose value is NULL, so if you want
+to use the decoration API for "Did I see this object?" hashtable,
+use decoration value that is _not_ NULL.
-- 
1.8.2.1-450-gd047976
