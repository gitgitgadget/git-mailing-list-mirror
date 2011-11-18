From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] bulk-checkin continued
Date: Thu, 17 Nov 2011 23:11:54 -0800
Message-ID: <1321600317-30546-1-git-send-email-gitster@pobox.com>
References: <1319846051-462-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 08:12:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRIcH-0007bl-V2
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 08:12:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181Ab1KRHMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 02:12:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001Ab1KRHMA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 02:12:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14A642302
	for <git@vger.kernel.org>; Fri, 18 Nov 2011 02:11:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=jlUI
	LbzdzBcDFW2FR9rTPICtvzw=; b=BIVVhaeM+9Tz0srxGBsePW2XieEpTh1m1seO
	LVJTt1Nw9AjNpAtKrH7iAQQjXJ7uoc54OCSmOxF3tzWz5cdgrdjDgItT7R6ewPmQ
	tl8N4AjWeKbf5Qdtf6r8/0hFy4ASHRQ1H5oUPBzW1PkCEmYEvOZxh70GrnXfD/hC
	9NDN84g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=egCGVk
	t6tKqbKUMFbIL9t1V5hPOG0YVCGGq+lJ6XOjNCYk/uRks7NflP9JT/nfwrLs9ynD
	dKjnkgspmFKIh4+c8WvNaluUdoAk0ldufCm9B9EbCOTPDcQfcCxlnOyvTqAdfi9j
	MtBC9G+FwoDwrhij0YRo68tNi9Xg1ASZsO4wI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C2A32301
	for <git@vger.kernel.org>; Fri, 18 Nov 2011 02:11:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 959732300 for
 <git@vger.kernel.org>; Fri, 18 Nov 2011 02:11:58 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc3.111.g7d421
In-Reply-To: <1319846051-462-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9AC52FEA-11B4-11E1-8EF4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185639>

This updates the earlier bulk-checkin series ($gmane/184440) to further
enhance the "large file" topic from 1.7.6 cycle.

The first one adds two API functions to allow truncating a checksummed
file that is being written. This is the same patch as the one I sent
earlier today.

The second one prevents the bulk-checkin code from writing the same object
twice to the stream, and the third one further makes it notice that the
object it has just written already exists in the repository. In either
case, the packfile is rewound using the new sha1file_checkpoint/truncate
API, and the packfile itself is removed if truncation results in an empty
output.

The next step is to add the "split-blob" entry in the packfile, but that
is a much larger task and will take longer.

Junio C Hamano (3):
  csum-file: introduce sha1file_checkpoint
  bulk-checkin: do not write the same object twice
  bulk-checkin: do not write an object that already exists

 bulk-checkin.c   |   40 +++++++++++++++++++++++++++++++++++-----
 csum-file.c      |   20 ++++++++++++++++++++
 csum-file.h      |    9 +++++++++
 fast-import.c    |   25 ++++++++-----------------
 t/t1050-large.sh |   38 ++++++++++++++++++++++++++++++--------
 5 files changed, 102 insertions(+), 30 deletions(-)

-- 
1.7.8.rc3.111.g7d421
