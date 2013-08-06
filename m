From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] Update built-in parseopt macros
Date: Tue,  6 Aug 2013 16:31:25 -0700
Message-ID: <1375831889-9610-1-git-send-email-gitster@pobox.com>
References: <7viozihh26.fsf@alter.siamese.dyndns.org>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 07 01:31:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6qj3-00033x-Go
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 01:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756058Ab3HFXbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 19:31:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61317 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755935Ab3HFXbc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 19:31:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93D1236D19;
	Tue,  6 Aug 2013 23:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ysZX
	Vex9YWGgah/kio4SNecfpHY=; b=XY1dTThpqVj1gHKTcbAmxfZn4icq0P4KJYXI
	WaRIvTxmNGBk8GR8E1nInSLRzyckQPPkkWqrpyplaaVFVzvRzEu7l73urmuL+4Mf
	5yng+64d+WZStq3lLaIx4Dik/mNOLyh1E6uOlH6egPLNLoS1OTZW9ilUNWrxp6rn
	fBjU1fM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	RMf4SBrF0+9SPfjRXLs44jANLclzBnpleeXdlr0wZeKOYp9a20rqgQRyKnVzWvn+
	wXW4gd0Tif5ZNdPWaonLWG35qtJq9Jn6ewE4x2kdB5P5n4//3bZiHmQDmrZVDWR9
	dx0aVmSuYlxN/rrCOXd6OdNk35+hyg+PQ4KAgOp6OPc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A0D136D18;
	Tue,  6 Aug 2013 23:31:31 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5F0636D17;
	Tue,  6 Aug 2013 23:31:30 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc1-210-gf6d87e2
In-Reply-To: <7viozihh26.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 52BBF5AA-FEF0-11E2-A733-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231795>

As a follow-up to Stefan's series, we may want to think about the
following as well:

 - OPT__VERBOSE() is defined in terms of OPT_BOOLEAN().  I think we
   use it to represent increasing levels of verbosity, so we cannot
   turn this into OPT_BOOL().  Its implementation has to become
   OPT_COUNTUP().

 - OPT__QUIET() is defined in terms of OPT_BOOLEAN().  I offhand do
   not know if we have increasing levels of quietness.  The users
   need auditing before we can decide to turn this into either
   OPT_COUNTUP() or OPT_BOOL().

 - OPT__DRY_RUN() should probably become OPT_BOOL().

 - OPT_FORCE(); do we have levels of forcefulness?  If so
   OPT_COUNTUP(), otherwise OPT_BOOL().

And here is my attempt.  The last one is iffy as I didn't bother
auditing the existing callers.

Junio C Hamano (4):
  OPT__QUIET(): switch from count-up to true bool
  OPT__VERBOSE(): clarify its expected use by using OPT_COUNTUP
  OPT__DRY_RUN(): use OPT_BOOL, not OPT_BOOLEAN
  OPT__FORCE(): clarify its expected use by using OPT_COUNTUP

 parse-options.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
1.8.4-rc1-210-gf6d87e2
