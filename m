From: Junio C Hamano <gitster@pobox.com>
Subject: size_t vs "unsigned long"
Date: Wed, 03 Oct 2007 13:30:04 -0700
Message-ID: <7vabr0djqr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 22:30:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdArM-0002Tg-0e
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 22:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757446AbXJCUaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 16:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757911AbXJCUaM
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 16:30:12 -0400
Received: from rune.pobox.com ([208.210.124.79]:53208 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757132AbXJCUaK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 16:30:10 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 5A0B0140FE6;
	Wed,  3 Oct 2007 16:30:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id CCF85140F92;
	Wed,  3 Oct 2007 16:30:28 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59881>

Traditionally, inside git, we have used the length of things
with "unsigned long" for pretty much anything, except where we
wanted the length exactly sized we used int32_t, uint64_t and
friends.

A few places pass pointer to unsigned long as the second
parameter to strbuf_detach(), triggering type mismatch warnings.
An easy way out is to change strbuf_detach() to take a pointer
to ulong but I think it is going backwards.  Most places that
use "unsigned long" can safely be converted (and made more
correct) to use size_t.

Any opinions?
