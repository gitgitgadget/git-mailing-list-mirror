From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH 0/3] Propagating push options to remote hooks
Date: Sat, 30 Jan 2016 19:28:07 +0100
Message-ID: <1454178490-17873-1-git-send-email-dennis@kaarsemaker.net>
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 19:34:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPaLl-0007L8-J0
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 19:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932810AbcA3SeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 13:34:18 -0500
Received: from koekblik.kaarsemaker.net ([141.138.139.206]:53719 "EHLO
	koekblik.kaarsemaker.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932455AbcA3SeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 13:34:16 -0500
Received: from spirit.home.kaarsemaker.net (unknown [145.132.209.114])
	by koekblik.kaarsemaker.net (Postfix) with ESMTP id E9BB4828B1;
	Sat, 30 Jan 2016 19:28:18 +0100 (CET)
X-Mailer: git-send-email 2.7.0-91-gf04ef09
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285124>

I have a few pre-receive hooks that are meant to catch mistakes. They are
fairly strict, as the mistakes it catches can have some serious bad effects.
However, sometimes they get it wrong (and can't really get it right) and it
would be really useful to override them.

Currently I do this by parseing the commit message, looking for 'Force: true',
but it would be very useful if --force were propagated to the hook. Obviously,
making --force skip all remote hooks would be a very bad way of doing this.
Hooks should decide whether --force is respected or not.

Instead of that, we can pass options to receive-pack using a new capability,
and receive-pack can make it available to hooks in their environment. That way
we don't change behaviour of existing hooks and each hook can decide for itself
whether it respects these options.

The initial implementation only passes on --quiet and --force. I've been
thinking of allowing the user of push to specify arbitrary values, but don't
see the value of that yet. It would be easy to add though.

Dennis Kaarsemaker (3):
  connect.[ch]: make parse_feature_value non-static
  receive-pack: add a capability for hook options
  send-pack: propagate --force and --quiet to remote hooks

 Documentation/technical/protocol-capabilities.txt |  9 ++++++
 builtin/receive-pack.c                            | 19 ++++++++++--
 connect.c                                         |  3 +-
 connect.h                                         |  1 +
 send-pack.c                                       | 10 ++++++
 t/t5544-push-hook-options.sh                      | 37 +++++++++++++++++++++++
 6 files changed, 75 insertions(+), 4 deletions(-)
 create mode 100755 t/t5544-push-hook-options.sh

-- 
2.7.0-91-gf04ef09
