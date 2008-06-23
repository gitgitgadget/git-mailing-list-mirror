From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Bugfix for AIX tmpfile creation
Date: Mon, 23 Jun 2008 15:29:13 -0700
Message-ID: <7vy74vg4zq.fsf@gitster.siamese.dyndns.org>
References: <1214256821-3169-1-git-send-email-patrick.higgins@cexp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Patrick Higgins <patrick.higgins@cexp.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 00:30:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAuYP-0006oQ-Oo
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 00:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbYFWW32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 18:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbYFWW32
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 18:29:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40030 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbYFWW31 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 18:29:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 420D66310;
	Mon, 23 Jun 2008 18:29:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A9EFC630E; Mon, 23 Jun 2008 18:29:18 -0400 (EDT)
In-Reply-To: <1214256821-3169-1-git-send-email-patrick.higgins@cexp.com>
 (Patrick Higgins's message of "Mon, 23 Jun 2008 15:33:41 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D50F528A-4173-11DD-A200-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85946>

Hmm, we have quite a few calls to mkstemp(), so adding the workaround to
this specific call site does not scale well as a fix, I am afraid.

Some callers do not want to use the xmkstemp() (because the function
always dies upon failure), so working around this bug in xmkstemp() won't
solve it either, unfortunately.  We would probably need compat/mkstemp.c
that wraps problematic mkstemp() on platforms with broken mkstemp()
implementation.
