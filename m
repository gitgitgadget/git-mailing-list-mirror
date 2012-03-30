From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] "commit --template" fixes
Date: Fri, 30 Mar 2012 12:45:16 -0700
Message-ID: <1333136719-12657-1-git-send-email-gitster@pobox.com>
References: <7vaa2ylzrm.fsf@alter.siamese.dyndns.org>
Cc: Adam Monsen <haircut@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 21:45:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDhlH-0002e0-PR
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 21:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760449Ab2C3TpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 15:45:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55914 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759645Ab2C3TpW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 15:45:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6C623421;
	Fri, 30 Mar 2012 15:45:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=D648
	ofN1BoZV9I6nAPJd8CeNTgM=; b=bWVzk+iCI/yii+1pTNi+vS9ydNtZyWSNi69a
	rKJaojCKtWUvQ+b12p2bmBRemCjqIihW6Y0YD6MZHs/Bno4u+fQNs+Nqku9BeJ+w
	S4ua1Lb8OostZI3Kj9RBIuv7SIAE6jjFo9cxY+M8iK8QuycngK1+CWNAzstwemOI
	mg5jkOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	MCabw6NH/xkSqAMGfOW1OAWYLfqd7XwTM4jUBfLvBKivN3IvtD8VZ3bPd/rIM0pq
	Ng9z22M+gcbIVVWdnkwmbHa/tvZR00nZcJt1nbFy/H1I4moRnC4zypJmCOG8uQKh
	eGzBqfyizhOQ3ljZRij5u209vrWqFAVvoxpnwEwTYzM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDEE53420;
	Fri, 30 Mar 2012 15:45:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5534A341D; Fri, 30 Mar 2012
 15:45:20 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.rc3.55.g06e99
In-Reply-To: <7vaa2ylzrm.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: E20BA76C-7AA0-11E1-9D30-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194388>

When the user exited editor without editing the commit log template given
by "git commit -t <template>", the commit was aborted (correct) with an
error message that said "due to empty commit message" (incorrect).  The
goal of this series is to fix this, which is the third patch.

While looking at this, I found another bug that the contents of the
template file is still used for error checking even when it is ignored
when the editor is populated for the user to edit.  The second patch
addresses this.

Junio C Hamano (3):
  t7501: test the right kind of breakage
  commit: do not trigger bogus "has templated message edited" check
  commit: rephrase the error when user did not touch templated log message

 builtin/commit.c  |   62 +++++++++++++++++++++++++++++++++++++----------------
 t/t7501-commit.sh |   14 ++++++++++++
 2 files changed, 57 insertions(+), 19 deletions(-)

-- 
1.7.10.rc3.55.g06e99
