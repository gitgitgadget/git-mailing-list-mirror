From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] @{u} updates
Date: Wed, 20 Jan 2010 01:38:40 -0800
Message-ID: <1263980322-4142-1-git-send-email-gitster@pobox.com>
References: <7vwrzmqypn.fsf@alter.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 10:38:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXX1d-0004sY-6r
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 10:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027Ab0ATJiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 04:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519Ab0ATJiv
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 04:38:51 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48097 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab0ATJiu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 04:38:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ABE5192068;
	Wed, 20 Jan 2010 04:38:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to; s=sasl; bh=hiLt6PxcUVlHGAM
	/5ne0Y9wdJQw=; b=aA2M6eIRBM56/VsPHAkwSOyYAdKIeGn5ifylkSPIGy0BGbd
	GjdEeurmpyAw3c3tBN9YNzOb5twI4Ay21prbPj6tlM6A22Vy/y8h52n7TZhBEKFM
	FaNmfNUklDqttkZt5OU+PW7TZB3cdPgSlfWlXxUw8EFuKl1oX4ud8ffhQ8Fk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to; q=dns; s=sasl; b=ckp+G7S+v
	kFEukF9/WIs6BGY2Dg0lQ3SuVf2+UWBUFqcqflzpbVJvOwKYj6PLOImyQdiF+udx
	3dTlDd7q5WiE9snUuEQKi/nLRFxeMHI7tkHh8Px/gXymfDyGDcDtYBdsvIL5/Gvi
	6qs4KKrHSPoKciA4m6SwzBsO+egA1HBMYQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 81B2692065;
	Wed, 20 Jan 2010 04:38:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3D1E92064; Wed, 20 Jan
 2010 04:38:43 -0500 (EST)
X-Mailer: git-send-email 1.6.6.513.g63f4c
In-Reply-To: <7vwrzmqypn.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 9B2037B6-05A7-11DF-8978-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137528>

Earlier I wondered if the approach Dscho's patch takes to teach the new
@{upstream} syntax to substitute_branch_name() (hence dwim_ref()) without
teaching it to interpret_branch_name() (hence strbuf_branchname()) was a
bad idea.  I thought about this a bit more; there are some downsides for
not doing so.

The first patch adds a handful of tests that show why strbuf_branchname()
callers may also want to learn about the new syntax.  The second patch
moves the logic to interpret_branch_name() to make them happier.

The name of the key function was changed from tracked_suffix() to
upstream_mark(), not only because the syntax talks about @{upstream}, but
because the parsing needs to recognize the @{u}/@{upstream} mark at the
beginning of the given string (that is a suffix to some other string), and
strip it (the earlier code wanted @{u} to be at the very end but the
callers need to have it at the beginning).


Junio C Hamano (2):
  t1506: more test for @{upstream} syntax
  Teach @{upstream} syntax to strbuf_branchanme()

 sha1_name.c                   |  116 ++++++++++++++++++++++++++---------------
 t/t1506-rev-parse-upstream.sh |   41 ++++++++++++++
 2 files changed, 115 insertions(+), 42 deletions(-)
