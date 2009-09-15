From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] Colouring whitespace errors in diff -B output
Date: Mon, 14 Sep 2009 23:15:02 -0700
Message-ID: <1252995306-32329-1-git-send-email-gitster@pobox.com>
Cc: Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 08:15:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnRKD-00057k-9n
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 08:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580AbZIOGPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 02:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754643AbZIOGPO
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 02:15:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42399 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbZIOGPN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 02:15:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A61EB32A53;
	Tue, 15 Sep 2009 02:15:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=0dNzPtFKt1JUF6DvF73jaNv+QkI
	=; b=ydO12gblMCTQcg7brPsnByEjUZ8Qstc1/8R8/HUqXJxps74PSCgc5HA7lgq
	KXmXNtVVIPMXJ4a2Sw0rTPLqS2YILaRCnPQHfLZZPhVraCPeBhoyNPFN+lNJm8as
	rTov5JzHhykKi05uZiGq8MxGsOqgvFBXkTyTDy3u4iMzSm4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=uKnW7S26loZa6WSvfbIq1
	rPeIwNvtTJAi3EVvvEXobbjRomI5joK06T55Hen63IVDsuadFC0zXOGpZEuH3SLY
	+IRBTOH0IWKv5yygoGxi6sOnjrwfGII6TOWKc7SZV6FC0W5cEXiij/ooiOVZxxZg
	ArTl9G122a15rY/YOQhM1U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 757CA32A51;
	Tue, 15 Sep 2009 02:15:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F29E332A4D; Tue, 15 Sep
 2009 02:15:07 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.rc1.54.g4aad
X-Pobox-Relay-ID: 1FF2F2C8-A1BF-11DE-95A7-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128513>

Here is a 4-patch miniseries to teach "diff -B" output routines to detect
and colour whitespace errors like we do for normal patches.

The first three patches are only about moving code around without changing
anything.

The last one hooks "diff -B" logic to the per-line output routines in a
way that mimicks how the normal patches are fed to them better, in order
to take advantage of all the existing whitespace error detection and
colouring logic.

Junio C Hamano (4):
      diff.c: shuffling code around
      diff.c: split emit_line() from the first char and the rest of the line
      diff.c: emit_add_line() takes only the rest of the line
      diff -B: colour whitespace errors

 diff.c |  327 +++++++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 180 insertions(+), 147 deletions(-)
