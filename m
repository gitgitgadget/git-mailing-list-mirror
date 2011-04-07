From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] Redoing the "add -u" migration plan
Date: Wed,  6 Apr 2011 18:16:32 -0700
Message-ID: <1302138996-10006-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 03:16:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7dq3-0006il-OB
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 03:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757181Ab1DGBQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 21:16:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44948 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756123Ab1DGBQm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 21:16:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3646C4C17
	for <git@vger.kernel.org>; Wed,  6 Apr 2011 21:18:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=2leNG1D8HIiZKu+6Ff4cqbR9KuQ
	=; b=EFgQwkh8pPKu2a9zVxSlAlQzQtdf6qEed15SuBUYkUKhZRWDx7aP1nl+4tc
	WrFWsyGbgYG5mu8n/1+9xfTWI/RbZOG4QP5+hn9AWNg3nQfbZ2b1bq77Gpkm/rUO
	3JfQrvIlu+0F3N2fq68xtvJkp1knCWcA33aX9gs+zkCBQVVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=Fa39T5QO2WhS3pRltJSVHBZCWIuA9
	XRu+lzGnSimXN9XTrMVp/XKTZrqeFeznQWwMv+NgFw+pJUVPhnid3Dtt5VRCJvG8
	Jqt7Y/o0lzXslUtgI1gTmhp+vQJZYpINpj1Z2t8RjqI832nuTtLlJVwH4S8Uwz4S
	da/EQDyTN1TQow=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 32DBC4C16
	for <git@vger.kernel.org>; Wed,  6 Apr 2011 21:18:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8E29F4C15 for
 <git@vger.kernel.org>; Wed,  6 Apr 2011 21:18:32 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.rc1
X-Pobox-Relay-ID: F45B24E4-60B4-11E0-96FC-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171034>

So here is the new migration plan to make "add -u" without pathspec to
default to the tree wide operation at 1.8.0 boundary.

The first patch is more or less the same as the "heads-up" version I sent
earlier to implement the magic ":/" pathspec at a wrong level as a hack,
but with some documentation updates.

It should apply on top of a91df69 (the parent of the first commit in the
"jc/add-u-migration" series).  Then merge the 33c33ca (the first commit in
the "jc/add-u-migration" series) to the result, and then apply the
remainder of this series.

The second patch gets rid of treewideupdate configuration variable, as we
no longer rely on user preference for this migration plan, and rewords the
warning message.  I did it this way only because the first commit in the
old series is already in 'next'; I will redo the series after 1.7.5 ships
so that we do not have to have this patch, nor "a configuration appears
and then disappears".

The third (step 2) patch is what should happen at 1.8.0 boundary by
flipping the default, but still keeps the warning for people who missed
the late 1.7.X series.

The last (step 3) patch is to remove the warning long after 1.8.0 boundary
when everybody got used to the new behaviour.

Junio C Hamano (4):
  magic pathspec: add tentative ":/path/from/top/level" pathspec support
  add -u: get rid of "treewideupdate" configuration
  add: make "add -u/-A" update full tree without pathspec (step 2)
  add: make "add -u/-A" update full tree without pathspec (step 3)
