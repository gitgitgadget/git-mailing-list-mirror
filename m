From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] Bulk check-in
Date: Fri, 28 Oct 2011 16:54:07 -0700
Message-ID: <1319846051-462-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 29 01:54:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJwFk-0002Xd-1V
	for gcvg-git-2@lo.gmane.org; Sat, 29 Oct 2011 01:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933850Ab1J1XyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 19:54:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57551 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753447Ab1J1XyN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 19:54:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15CC76AD7
	for <git@vger.kernel.org>; Fri, 28 Oct 2011 19:54:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=UGa8lWcMulLN0UV0dNw7lI9snak
	=; b=rnhORm/cU5E6opDZXqsojQESF3U2N4/Q56Ket3xS8TdtXb1XYp50JvFx4Ad
	EWLcY8hj3pb4sGfLCg9c97UBnInYvfVsQu+A47YJ8TrcaJ/UALXKinBBHXAKcl1d
	YPuyYM2dAb0yadGCc4qnL5emB4chbd3vnaDC+0BekSIBY6vE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=LQFPJbnJO1Jy0z84Gf0sZTMm+Yo6v
	IonaIdzUcFz0DIeDdS614AfIFIcNL41Ncj3x40fyVbKUvWdx6jZUp5/7g19EIGG7
	vS6a4qOesB7W2V2zAxxgrA7B2OjN9RVNp+fa/T/hcy9Dz1yzFsjGm4H8WAT3yoHO
	6GRb4c2FTZm2L0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CB716AD6
	for <git@vger.kernel.org>; Fri, 28 Oct 2011 19:54:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9253E6AD5 for
 <git@vger.kernel.org>; Fri, 28 Oct 2011 19:54:12 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.1.573.ga40d2
X-Pobox-Relay-ID: 22BE9DFA-01C0-11E1-8936-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184440>

This miniseries is a continuation of the "large file" topic from 1.7.6
development cycle.

The first three are moving existing code around for better reuse.  The
last one serves two purposes: to lift the one-pack-per-one-large-blob
constraint by introducing the concept of "plugging/unplugging" (i.e. you
plug the drain and throw many large blob at index_fd(), and they appear in
a single pack when you unplug it), and to stop using fast-import in this
codepath.

Only very lightly tested.

Junio C Hamano (4):
  write_pack_header(): a helper function
  create_tmp_packfile(): a helper function
  finish_tmp_packfile(): a helper function
  Bulk check-in

 Makefile               |    2 +
 builtin/add.c          |    5 ++
 builtin/pack-objects.c |   56 +++++------------
 bulk-checkin.c         |  159 ++++++++++++++++++++++++++++++++++++++++++++++++
 bulk-checkin.h         |   16 +++++
 pack-write.c           |   53 ++++++++++++++++
 pack.h                 |    6 ++
 sha1_file.c            |   67 +-------------------
 t/t1050-large.sh       |   26 ++++++--
 9 files changed, 282 insertions(+), 108 deletions(-)
 create mode 100644 bulk-checkin.c
 create mode 100644 bulk-checkin.h

-- 
1.7.7.1.573.ga40d2
