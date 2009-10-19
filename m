From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] nested expansion
Date: Mon, 19 Oct 2009 00:30:11 -0700
Message-ID: <1255937414-10043-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:30:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzmhE-0001MJ-DH
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 09:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615AbZJSHaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 03:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753726AbZJSHaM
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 03:30:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62568 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753760AbZJSHaL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 03:30:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BB33F5E7B5
	for <git@vger.kernel.org>; Mon, 19 Oct 2009 03:30:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=Kaleb+of61hAF5xkq7eqEfgQ/70
	=; b=YeGc7Q9Z7i1x1qZxogTGJpLpQkJcmDRYLbEapdnngR9a6Dp4YeoelR6RU82
	4I+gtp0520Nl+j/46XyrT9Uaz2/3LQ905YMfHbUMHGME82b0R402fT+OhRyorEXY
	ydjWpnx2oTOgrx2Z6Nw2qefAR6NaW7KdGbjTjXJbYbW2hHpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=SFiENfFe0E2uTFXg0LmInG7tBX9+P
	zMhz/ilDLvi2nYF0zkvq7pwkKHwAWyVKPhXxoHI8PN6hR1+29bhnevKQseMa/Wk5
	7+MD6eL4CNX985M3102CY5W4NDkP6VuX3YnZv/4JQeQl6pFRzRGHe9+MG6UKLsCN
	eS3DYVMyyDf10k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B7E515E7B4
	for <git@vger.kernel.org>; Mon, 19 Oct 2009 03:30:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53B975E7B3 for
 <git@vger.kernel.org>; Mon, 19 Oct 2009 03:30:15 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.1.95.g09fbd
X-Pobox-Relay-ID: 3EBFA944-BC81-11DE-8E3A-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130666>

This is a re-roll of the earlier "general syntax for applying functions to
pretty-print format output" series, rebased on two patches from Dscho to
implement strbuf_add_wrapped_text().  In other words, this will apply on
top of b4d784c (Add strbuf_add_wrapped_text() to utf8.[ch], 2008-11-10).

The first one is almost the same, except that it drops the unnecessary
cast (pointed out by Dscho) and instead changes the type of return value
from expand callback to ssize_t.

The second one has two changes:

 1. w() is renamed to wrap();
 2. it actually rewraps the text by using Dscho's strbuf_add_wrapped_text().

The third one is new.  It teaches wrap() to just indent without wrapping
when the width parameter is zero or negative.

Junio C Hamano (3):
  strbuf_nested_expand(): allow expansion to interrupt in the middle
  Add %[wrap(width,in1,in2)<<any-string>>%] implementation
  Teach --wrap to only indent without wrapping

 pretty.c |   80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 strbuf.c |   29 +++++++++++++++++-----
 strbuf.h |    5 ++-
 utf8.c   |   13 ++++++++++
 4 files changed, 115 insertions(+), 11 deletions(-)
