From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Verify the objects fetch obtained before updating ref
Date: Thu,  1 Sep 2011 15:43:32 -0700
Message-ID: <1314917015-3587-1-git-send-email-gitster@pobox.com>
References: <7vpqjkw3nb.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 00:43:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzFz4-0000co-U1
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 00:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553Ab1IAWnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 18:43:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39889 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932202Ab1IAWnh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 18:43:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDA0B523F
	for <git@vger.kernel.org>; Thu,  1 Sep 2011 18:43:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=vBN4
	sVkgTmPy9tHWmFj/RuKmbXs=; b=DSGNqPKkLnGsTDZb7oymaRgtVMrzeCL0dXFn
	l3bdlFjhLjpTeOD4CKWyQpgfWUnjdZnCGXOS93mo0dv3v65oCpDQdB7mSHo+nMq4
	51A+vFBD4zgCddAyRtRVEXTfa6WbaQx9dXKA/W+vLmY0zFIcElOK0YpDhpyiwBzs
	VIG0iMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=MrWLgQ
	q2JkZhxcQblrZG1s6dJ7AvIJ382V9nXwcXbiGwDdOyGGK+tzFhW5V4g4cqEALm6w
	YnGzZVfPtnPAt79m6V+XlGhjoAHJMTBtuE1sByJZwaZpptnZT2pwIokskbPIyU0n
	fa4QSd+W1NUmvoIH231JgpcHK39XLkbL2HNSM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5E8C523E
	for <git@vger.kernel.org>; Thu,  1 Sep 2011 18:43:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6BA75523D for
 <git@vger.kernel.org>; Thu,  1 Sep 2011 18:43:36 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.72.g4b5ea
In-Reply-To: <7vpqjkw3nb.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: D4406588-D4EB-11E0-9E42-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180578>

So here is a series to make the client side a bit more careful.

These patches apply on top of jc/traverse-commit-list beba25a (revision.c:
update show_object_with_name() without using malloc(), 2011-08-17) in
'next'.

Junio C Hamano (3):
  list-objects: pass callback data to show_objects()
  rev-list --verify-object
  fetch: ensure we transferred everything we need before updating our
    ref

 builtin/fetch.c        |  119 +++++++++++++++++++++++++----------------------
 builtin/pack-objects.c |    4 +-
 builtin/rev-list.c     |   14 ++++-
 list-objects.c         |   28 +++++++----
 list-objects.h         |    5 +-
 revision.c             |    5 ++
 revision.h             |    1 +
 upload-pack.c          |    4 +-
 8 files changed, 105 insertions(+), 75 deletions(-)

-- 
1.7.7.rc0.72.g4b5ea
