From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] Propagating flags carefully from the command line
Date: Wed, 15 Jan 2014 15:59:42 -0800
Message-ID: <1389830384-22851-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 16 01:00:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3aNL-0002ju-GX
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 00:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbaAOX7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 18:59:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53812 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694AbaAOX7u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 18:59:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C72F64EC7;
	Wed, 15 Jan 2014 18:59:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=cZ+9L/Wp6abB4IGLxVc2IwUmZZA
	=; b=uafVgUIV+lblaaKCsUkQf60ucUT2mgXCzmxmlZ3Noe4yfLGL1Pw8RQP2VAA
	m9DwpW0ZkoX+kEo5hLCQKHq49TuMtbzk4Pkobu4J8aMKsPYj90Sf/GphJaHrVfLA
	DReiRu60W4k0Vov9n21lk2MD/D4d/Me0BFFwRjWfxzbxD66w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=UyCR64IQvT7j487ZSwInM
	ACXixeHD6HIX75zoqsVLHgNtLbtP5p9cVTVtTNI8KpsV1bGqZ7UlJy8MfZuPrZlS
	TZhwK5OmckeeyaFYylsY0/Vni1iYzCHcxIAVjbafVkunMrKwHrf3hconkjhRJSJb
	skD6vV3bKJ+2RccdLOCRLI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E7A664EC6;
	Wed, 15 Jan 2014 18:59:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E993964EC4;
	Wed, 15 Jan 2014 18:59:46 -0500 (EST)
X-Mailer: git-send-email 1.8.5.3-493-gb139ac2
X-Pobox-Relay-ID: 1CA2ED22-7E41-11E3-BA33-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240491>

So this is my second try.  The second one now gets rid of the call
to mark_blob_uninteresting() as Peff suggested, because the first
patch makes the function very well aware that it only should mark
the objects that are reachable from the object, and by definition
blobs do not reach anything.

Junio C Hamano (2):
  revision: mark contents of an uninteresting tree uninteresting
  revision: propagate flag bits from tags to pointees

 revision.c               | 29 +++++++++++++++++------------
 t/t6000-rev-list-misc.sh | 17 +++++++++++++++++
 2 files changed, 34 insertions(+), 12 deletions(-)

-- 
1.8.5.3-493-gb139ac2
