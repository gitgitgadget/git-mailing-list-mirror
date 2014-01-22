From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] Fix "repack --window-memory=4g" regression in 1.8.4
Date: Wed, 22 Jan 2014 11:58:03 -0800
Message-ID: <1390420685-18449-1-git-send-email-gitster@pobox.com>
References: <xmqqzjmprlbq.fsf@gitster.dls.corp.google.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Siddharth Agarwal <sid0@fb.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 20:58:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W63wG-0007S5-Pf
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 20:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbaAVT6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 14:58:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34001 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876AbaAVT6L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 14:58:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF1EF64362;
	Wed, 22 Jan 2014 14:58:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to; s=sasl; bh=cZTx9ZKnpTPDxPC
	ecZ8jCXUjFD8=; b=qS7qiU3wBFI0N+9SPgwQVg7BXUg/a6OHVFBoALQa6gb1FWT
	MYHaxdUVdAMHs2pYDTzIGJqmVoUSF6OGe0xu7OP3sZzsDAdCOswQABwvgqaNVuDw
	nqW3I97jaZph8T6nPwjmHSWYRMq6c84mfgKuNIgINjcghYMhius6anpDLj5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to; q=dns; s=sasl; b=U8l+oaKlU
	OjlFkhTL6V5fwI2nC9XmYWvol/m+4yGXEOTYuhK1jd1EkwlltyDba/W82GVKOkrT
	vOfC2ZacKhXIz9CO5DzjdzLIdosNtCo5sgO0Jn3FYYAKCdTZ1YJfBesZh8c2+Pbc
	pykRgSzsCRz5Ag3ToJQ8Zm/lVDcI6m1Bw4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D93A664361;
	Wed, 22 Jan 2014 14:58:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0484B6435F;
	Wed, 22 Jan 2014 14:58:09 -0500 (EST)
X-Mailer: git-send-email 1.9-rc0-151-ga5225c0
In-reply-to: <xmqqzjmprlbq.fsf@gitster.dls.corp.google.com>
X-Pobox-Relay-ID: 84ADC8CA-839F-11E3-9753-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240846>

The command line parser was broken when the command was
reimplemented in C in two ways.  It incorrectly limited the value
range of window-memory and max-pack-size to "int", and also stopped
grokking the unit suffixes like 2g/400m/8k.

These two patches apply on top of 35c14176 (Reword repack
documentation to no longer state it's a script, 2013-10-19) and
later can be merged down to maint-1.8.4 track and upwards.

Junio C Hamano (2):
  parse-options: refactor human-friendly-integer parser out of pack-objects
  repack: accept larger window-memory and max-pack-size

 builtin/pack-objects.c | 25 ++++---------------------
 builtin/repack.c       | 12 ++++++------
 parse-options.c        | 17 +++++++++++++++++
 parse-options.h        |  5 +++++
 4 files changed, 32 insertions(+), 27 deletions(-)

-- 
1.9-rc0-151-ga5225c0
