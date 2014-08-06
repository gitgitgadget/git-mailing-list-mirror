From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Two fixes to "git apply"
Date: Wed,  6 Aug 2014 15:58:02 -0700
Message-ID: <1407365885-1628-1-git-send-email-gitster@pobox.com>
References: <xmqq8un1ml7e.fsf@gitster.dls.corp.google.com>
Cc: Peyton Randolph <prandolph@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 00:58:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFA9z-0001VE-TF
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 00:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703AbaHFW6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 18:58:16 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58468 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753533AbaHFW6P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 18:58:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F1E353076E;
	Wed,  6 Aug 2014 18:58:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=JuBS
	F7LJfERSHgFC3eHoNaTlBM4=; b=VxyWZ2iGeN0T3riTXkNEUlIjGfDrSmXmZg3Z
	JyAoA28tLPalcoBwEKqCbRjHbLS0HuCHA448d9UDLIFPzikzOlNxDibZ4ybRdd95
	sI8qDgqWMhU5NvHBtAvrGWNJbU7d4B9O1Epbs6nYPFB+cyM4rAfTrlQsCgELPgH/
	t1vJt7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	sBJ0IXN3cUpJR2UKmUO27OPWfyOCTWdIVhNJKpUh4GnXOASDzitXnv+NIyLtv1ts
	FhFWN9GjV8xIp3o1uYlA3sLhXy1nWJIsu0f1jLvOq1c/iXCW7uCf2zusdZ6XQL8V
	uM/att1PIaDFIOEQ56IIifFHH0+OTFYBwkAguRJymbQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E8F5F3076D;
	Wed,  6 Aug 2014 18:58:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6E7D73075E;
	Wed,  6 Aug 2014 18:58:07 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-rc1-209-g4e1b551
In-Reply-To: <xmqq8un1ml7e.fsf@gitster.dls.corp.google.com>
X-Pobox-Relay-ID: 216B3C3A-1DBD-11E4-914E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254909>

This started as an attempt to fix a long-time bug, in which a
partial "git apply" with --exclude/--include still complained about
whitespace breakage in a part that was excluded from patch
application.  The final patch fixes it.

Restructuring of the code necessary to fix it revealing another
long-standing bug that is not related X-<, which turned out to be a
larger fix (patch 1).

Junio C Hamano (3):
  apply: use the right attribute for paths in non-Git patches
  apply: hoist use_patch() helper for path exclusion up
  apply: omit ws check for excluded paths

 builtin/apply.c          | 131 ++++++++++++++++++++++++-----------------------
 t/t4119-apply-config.sh  |  17 ++++++
 t/t4124-apply-ws-rule.sh |  11 ++++
 3 files changed, 96 insertions(+), 63 deletions(-)

-- 
2.1.0-rc1-209-g4e1b551
