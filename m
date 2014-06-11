From: "" <caleb@calebthompson.io>
Subject: [PATCH v4 0/4] commit: support commit.verbose and --no-verbose
Date: Wed, 11 Jun 2014 13:24:35 -0500
Message-ID: <1402511079-17735-1-git-send-email-caleb@calebthompson.io>
Cc: Jeff King <peff@peff.net>, Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Kastrup <dak@gnu.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 20:32:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WunKB-0003Po-Qc
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 20:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908AbaFKScg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 14:32:36 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:60429 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753254AbaFKSce (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2014 14:32:34 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 11C61635;
	Wed, 11 Jun 2014 14:25:09 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 11 Jun 2014 14:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=from:to:cc:subject:date:message-id; s=mesmtp; bh=rxyNz/SYE4GZ
	EXFJ3VMP1MSbkjM=; b=ZPH1fawxiNlB8SyaKkZuC7GzhvajHESiImhU/BQUGZTI
	9iFXdB6duzM+g2Wy+dm0tP3nK+JZ0QTqaTYMMsdR7Tws/++1gCrscTBJ6vEtqKGE
	F2ZVAd2zh6z1h+wkOc+w5DwfKgQE6+Y8qLG8c5w/+ZypZwDoha1PsvOrT1tXs84=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id; s=
	smtpout; bh=rxyNz/SYE4GZEXFJ3VMP1MSbkjM=; b=KSd7e2RjTw1L3m6ATgQm
	zIwWrseX+O2Zm/YI/7PdYiBwx+IZrvXUfGzPBaGcldMXZ+Qcc5i9VbcTI1zyzdpL
	B+nIWD9al74bPq/i/pcKRM6i2L7sZPYctWqM9eGy6zBm2Hc9gFfO5ulTi1MHyN1A
	ZrAIgckLCC/yqfYQIshjW8k=
X-Sasl-enc: 390vGjRqRhlpYEEAoIfh1aCGqPEvIKQ37rDrH0bV+/Tv 1402511109
Received: from localhost.localdomain (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9A811680252;
	Wed, 11 Jun 2014 14:25:08 -0400 (EDT)
X-Mailer: git-send-email 2.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251376>

This patch allows people to set commit.verbose to implicitly send
--verbose to git-commit. It also introduces --no-verbose to override the
configuration setting.

This version incorporates changes suggested by Eric Sunshine, Duy
Nguyen, and Jeremiah Mahler.

It introduces several cleanup patches to t/t7505-commit-verbose.sh to
bring it closer to the current state of the tests as Eric has explained
them to me, then adds the verbose config and --no-verbose flag.

Since the last version of this patch
(http://marc.info/?l=git&m=140113063517118&w=2), I've made the following
changes:

* Remove the $PWD => $(pwd) change, as it was a misunderstanding of
  t/README (Thank you to Johannes and David for pointing that out and
  clarifying)
* Use consistent test naming (Thanks to Jeremiah)
* Switch from <<-EOF to <<-'EOF' without manual escaping in write_script
  calls for the test editors check-for-diff and check-for-no-diff. The
  proposed <<-\EOF syntax did not properly prevent the parameter
  substitution on my machine, as both Eric and the documentation
  suggested it should, but the quoted version seems to work fine.
  (Thanks to Eric)
* Fix extra test_set_editor invocations and broken %%-chains created as a result
  of the test_set_editor changes. (Thanks again to Eric)

------------------------------------------------------

Caleb Thompson (4):
      commit test: Use test_config instead of git-config
      commit test: Use write_script
      commit test: test_set_editor in each test
      commit: support commit.verbose and --no-verbose

 Documentation/config.txt               |  5 +++++
 Documentation/git-commit.txt           |  8 +++++++-
 builtin/commit.c                       |  6 +++++-
 contrib/completion/git-completion.bash |  1 +
 t/t7507-commit-verbose.sh              | 64 +++++++++++++++++++++++++++++++++++++++++++++++-----------------
 5 files changed, 65 insertions(+), 19 deletions(-)
