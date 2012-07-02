From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 00/18] Extending the shelf-life of "git describe" output
Date: Mon,  2 Jul 2012 15:33:51 -0700
Message-ID: <1341268449-27801-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 00:34:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlpCl-000320-S5
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 00:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756039Ab2GBWeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 18:34:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39588 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755159Ab2GBWeL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 18:34:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 517CC9060
	for <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=ap5LaQhoSQFlgUxlREDMqEtwCt0
	=; b=PAK7mxCStpUHMIk8njWEpXD1r3nXK3Fw02rUXdkD/Cn+sb8+WG7oasGIJpH
	7ajoQZSpGIMBQ004iiPCEfRijY6LfBFNvIy5ngUmQIuk14xSklDtMJM1eGyrCutV
	5p9drpIYCTm0b0r1vdOXsF/sjgA4LosTT11FS8rSqC/Xfryo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=WAl62gGRrX6MtMymIzx7h13IfbbV9
	B/xrCLbTbjA8sPHn42ihKfDpcKiBALwJ23QKQSm4I+XUkeROFtoS6X0fKVxIu1la
	2vJFkxXzNmDDIbeMB6aSf3TsoAVYWdkTRYPH3walu1DfhFZHViMPmbshSQrInqCH
	g6Wp3Z8pf8Qr1g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48FB7905F
	for <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D13E9905E for
 <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:10 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.212.g52fe12e
X-Pobox-Relay-ID: 0B20E466-C496-11E1-AA0B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200869>

This is take 4.  The earlier rounds were $gmane/200165, 200387, and
200506.

Compared to the previous round, it has more patches in the clean-up
phase.  Most notably, patch 03/18 gets rid of get_sha1_with_mode_1()
and replaces the only external caller of it with a call to a more
straightforward die_on_misspelt_object_name().  The test suite added
by patch 12/18 has more patterns that we can potentially improve on.

The disambiguation logic can now be asked to pick only committish,
which can be used in places like "git commit -C deadbeef".  It also
knows that A and B in "git log A..B" can only be committishes.

Adding support for treeish, if anybody is tempted to do so, should
now be pretty straightforward.

Junio C Hamano (18):
  sha1_name.c: indentation fix
  sha1_name.c: hide get_sha1_with_context_1() ugliness
  sha1_name.c: get rid of ugly get_sha1_with_mode_1()
  sha1_name.c: get rid of get_sha1_with_mode()
  sha1_name.c: clarify what "fake" is for in find_short_object_filename()
  sha1_name.c: rename "now" to "current"
  sha1_name.c: refactor find_short_packed_object()
  sha1_name.c: correct misnamed "canonical" and "res"
  sha1_name.c: restructure disambiguation of short names
  sha1_name.c: allow get_short_sha1() to take other flags
  sha1_name.c: teach get_short_sha1() a commit-only option
  sha1_name.c: get_describe_name() by definition groks only commits
  sha1_name.c: get_sha1_1() takes lookup flags
  sha1_name.c: many short names can only be committish
  sha1_name.c: teach lookup context to get_sha1_with_context()
  sha1_name.c: introduce get_sha1_committish()
  revision.c: allow handle_revision_arg() to take other flags
  revision.c: the "log" family, except for "show", takes committish

 builtin/cat-file.c                  |   2 +-
 builtin/log.c                       |   3 +
 builtin/pack-objects.c              |   2 +-
 cache.h                             |  18 +-
 commit.c                            |   2 +-
 revision.c                          |  38 ++--
 revision.h                          |   5 +-
 setup.c                             |   8 +-
 sha1_name.c                         | 383 ++++++++++++++++++++++++------------
 t/t1512-rev-parse-disambiguation.sh | 208 ++++++++++++++++++++
 10 files changed, 509 insertions(+), 160 deletions(-)
 create mode 100755 t/t1512-rev-parse-disambiguation.sh

-- 
1.7.11.1.212.g52fe12e
