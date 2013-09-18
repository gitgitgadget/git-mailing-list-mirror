From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/6] Removing the guesswork of HEAD in "clone"
Date: Tue, 17 Sep 2013 19:31:23 -0700
Message-ID: <1379471489-26280-1-git-send-email-gitster@pobox.com>
References: <20130906155608.GF12966@inner.h.apk.li>
Cc: Andreas Krey <a.krey@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 18 04:31:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM7YI-00066A-5f
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 04:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609Ab3IRCbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 22:31:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49337 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751546Ab3IRCbd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 22:31:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 978283914A;
	Wed, 18 Sep 2013 02:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=guVZ
	H4afO7e3IzqBDfP0GzsKiMU=; b=pkpc6A68kCgEtzCnh6IvFZsMA9F4FUcKQ5+V
	bni07w7NbzU3Eb9hR6HKH1Ua5Tgukt4p0K6i7v1kcgBi1bJ+DORm83epVXbcU74L
	yj+8mS16xgp0VIv15UAXkyHBDI5NvfMihyw1pZFgbXkqH2oQYijvWykV/5Jjms41
	rWU9V+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	bVy20kzkLh1UvKYFcIGdOJtQ/FB+aVrrczen9QifUtjcDl1ZGEi4cpB3/adX2FSL
	MNiHJ0sOmCW9uPr30VYJL9iEDpXH2onDXUsjmGd1hRhIKfkypbKiWidfwda/QMnU
	nonGV7WgEvRJUng3V4wBZCOmhSSgXimputE9C0+blDo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C54439148;
	Wed, 18 Sep 2013 02:31:32 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F013C39145;
	Wed, 18 Sep 2013 02:31:31 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-585-g8d1dcaf
In-Reply-To: <20130906155608.GF12966@inner.h.apk.li>
X-Pobox-Relay-ID: 6E15F798-200A-11E3-947C-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234941>

This reworks the old idea from 2008 ($gmane/102039) to teach
upload-pack to say where symbolic refs are pointing at in the
initial ref advertisement as a new capability "sym", and allow
"git clone" to take advantage of that knowledge when deciding what
branch to point at with the HEAD of the newly created repository.

Thanks go to Andreas Krey for reigniting the ember in a patch series
a few weeks ago.

I did not do anything more than just compile it once; all the bugs
in this round are mine (it is all new code after all).


Junio C Hamano (6):
  upload-pack.c: do not pass confusing cb_data to mark_our_ref()
  upload-pack: send symbolic ref information as capability
  upload-pack: send non-HEAD symbolic refs
  connect.c: make parse_feature_value() static
  connect: annotate refs with their symref information in get_remote_head()
  clone: test the new HEAD detection logic

 cache.h          |  1 -
 connect.c        | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 t/t5601-clone.sh | 11 ++++++++++
 upload-pack.c    | 51 +++++++++++++++++++++++++++++++++++++++------
 4 files changed, 118 insertions(+), 8 deletions(-)

-- 
1.8.4-585-g8d1dcaf
