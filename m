From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] rev-list --simplify-{merges,by-decoration}
 --first-parent
Date: Fri,  8 Jun 2012 15:53:26 -0700
Message-ID: <1339196009-14555-1-git-send-email-gitster@pobox.com>
Cc: Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 00:54:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd84V-00005d-7p
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 00:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922Ab2FHWxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 18:53:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51315 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752568Ab2FHWxe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 18:53:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B65D38B89;
	Fri,  8 Jun 2012 18:53:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=iHDj7T8qichueMwSeV/GulXQ+ok
	=; b=Qh/V5ii5FZxBuYX05jQvvkGNzbKbBFqmoW8d8qxX775Szk1PxN7HpQCXoUd
	vPVLBDnsnslT3MqDATurTzbIyUU/AJzhJ+e8EU/Cg9ppzkkJHhI28sHwsJja2Jos
	eTIP/IWy6UHcK8KVjkrJZyAgN5wrf2hj/cQ0AyTgBNQ8vI7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=O7qNGxCWf/k4yEHRJ4/tj
	XOBuSLQXPgKaCb7902r3LpxgeMhsRZIzzW4ZuSlMxyp0TmTN8tvTxdcFyBQLCKTy
	ZgRmn69hEhlRdqSKu8LN2OMqb96x5zNkLs0U6zQ6nQ+IJlKcfOiKW2zygse72wYT
	d1JDpKs+TZMUHVratkwV3c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADE828B88;
	Fri,  8 Jun 2012 18:53:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43DA58B87; Fri,  8 Jun 2012
 18:53:31 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc2.29.g85b30f3
X-Pobox-Relay-ID: C4E12704-B1BC-11E1-9B21-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199538>

The deeper history simplification using merge information (not to be
confused with "merge simplification") was not prepared to be used
with the --first-parent option, but it was possible to trigger this
combination from gitk.

The fix is fairly straight-forward.  When showing only first-parent
chain of history, the later parents won't matter in the result, so
we can just rewrite the parents and make the history a single strand
of pearls.

Showing first-parent-only history and then attempting to simplify
merges does not make much sense, but simplify-by-decoration may be a
valid thing to ask.

Junio C Hamano (3):
  revision: "simplify" options imply topo-order sort
  revision: note the lack of free() in simplify_merges()
  revision: cull side parents before running simplify-merges

 revision.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

-- 
1.7.11.rc2.29.g85b30f3
