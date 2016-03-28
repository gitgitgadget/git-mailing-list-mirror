From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/11] saving and replaying multiple variants with rerere
Date: Mon, 28 Mar 2016 15:42:11 -0700
Message-ID: <1459204942-26601-1-git-send-email-gitster@pobox.com>
References: <1442275050-30497-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 00:42:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akfrp-0005Di-Uc
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 00:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481AbcC1Wma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 18:42:30 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54857 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755360AbcC1WmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 18:42:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 044224FF96;
	Mon, 28 Mar 2016 18:42:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=NZij
	I9jtlawrvIe7T93kr+ioRPY=; b=BCkqmjxZD9iYtYzraRpzu/dkRU1WMmIxbNLk
	2EdxiT/DBZnhq8ot7Fh1iSKZoExNOaHqqP/Jy2oAFC7V3PRUv4fbtD3qfeiQFILR
	M8Bh0mGF5U6aiIUs2w5qtesiFLhnq6lXGjCPhKw7cqeZcsskaZgzUWptO7rZOD4l
	XBU9m+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=tTccoe
	vXPyvx1omZdqBMmKy7EKP4E2LgmjgAUJkvR3z28U9qArzKgdmKlCFMB/+DFV32rt
	Dp1o41HCALY3FLNLYWAvMOjNtTGk9Rloigh/Fs0EhuyL+vuRTPk2AI/xLe5HGsy9
	S7kei4o0AX8imw1cKrfj9qtCzFWJ3YtG/Caxc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EEC254FF95;
	Mon, 28 Mar 2016 18:42:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 754604FF94;
	Mon, 28 Mar 2016 18:42:23 -0400 (EDT)
X-Mailer: git-send-email 2.8.0-215-g046a488
In-Reply-To: <1442275050-30497-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 569E8B4E-F536-11E5-B232-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290068>

Take two after several months.  That is what you get when you end up
running a busy project, instead of staying to be an individual
contributor ;-).

The previous round starts at the message this is a response to and
is found at http://thread.gmane.org/gmane.comp.version-control.git/277878

The previous round completed the basic "record and replay", while
leaving "gc" and "forget" as known-to-be-stale bits.  This round
attempts to complete them. 

Junio C Hamano (11):
  rerere: split conflict ID further
  rerere: scan $GIT_DIR/rr-cache/$ID when instantiating a rerere_id
  rerere: handle leftover rr-cache/$ID directory and postimage files
  rerere: delay the recording of preimage
  rerere: allow multiple variants to exist
  t4200: rerere a merge with two identical conflicts
  rerere: do use multiple variants
  rerere: gc and clear
  rerere: move code related to "forget" together
  rerere: split code to call ll_merge() further
  rerere: adjust 'forget' to multi-variant world order

 rerere.c          | 626 +++++++++++++++++++++++++++++++++++++-----------------
 rerere.h          |   4 +-
 t/t4200-rerere.sh | 159 +++++++++++++-
 3 files changed, 593 insertions(+), 196 deletions(-)

-- 
2.8.0-215-g046a488
