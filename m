From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] rebasing changes that update submodules
Date: Thu, 31 Jan 2013 20:32:02 -0800
Message-ID: <1359693125-22357-1-git-send-email-gitster@pobox.com>
References: <20130130224904.GB1053@book.hvoigt.net>
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 01 05:32:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U18Ip-0002r0-AZ
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 05:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753600Ab3BAEcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 23:32:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57468 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492Ab3BAEcI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 23:32:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CFFEC7F1;
	Thu, 31 Jan 2013 23:32:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=43JC
	yd156gj+w28cPrqA+vrx8N0=; b=VBMLEDM3N4BEMQkC3ecV2fFJ7HCOA8P0th4M
	SiTsiIFpLXb4QKU46jXw1OeY2AwFG8ETRARWB7UwFT/9fm0OrWizIApuaqNApMa8
	8B7RBP49uDEo5mz89BB4QtWtQhogWKe3W2HX5eEJgGZ54sRnMebKaoZAnBJMvdsj
	QY+52Jk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	S58NcuYFFR3Z7/nq+IeRRmwbv6VtzBQVU+UvrgPzul5pNy4B7TVkG4Uf413TmIej
	HmvIfXdVN87cn5NSpdeR26nk1GzobT/OM8xQn3G4Ht4xTOeW1lkyK/7TGAcuPh7f
	EF/0q51bBYkh51X5PfrY7WX5AaylmMI9nJoxLqpPqX4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41D12C7F0;
	Thu, 31 Jan 2013 23:32:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF286C7EF; Thu, 31 Jan 2013
 23:32:06 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.612.g09f4be5
In-Reply-To: <20130130224904.GB1053@book.hvoigt.net>
X-Pobox-Relay-ID: 55B97134-6C28-11E2-9CD5-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215202>

"git rebase" used to use "format-patch --full-index" to generate a
series of patches and let "git am --rebase" reconstruct a fake
preimage tree by reading the object names from the "index" lines.

With a230949 (am --rebasing: get patch body from commit, not from
mailbox, 2012-06-26), we switched to use "diff-tree", but forgot
that without "--full-index", the information generated on the
"index" line is insufficient to recreate a preimage tree that
contains a submodule.

The first one is the real fix to this issue.

The other two falls into the niceties category; they are to issue a
better error messge when the machinery is fed an abbreviated object
name on the "index" line for a submodule.

Junio C Hamano (3):
  git-am: record full index line in the patch used while rebasing
  apply: simplify build_fake_ancestor()
  apply: diagnose incomplete submodule object name better

 builtin/apply.c             | 30 ++++++++++++++++--------------
 git-am.sh                   |  2 +-
 t/t7402-submodule-rebase.sh | 30 ++++++++++++++++++++++++++++--
 3 files changed, 45 insertions(+), 17 deletions(-)

-- 
1.8.1.2.612.g09f4be5
