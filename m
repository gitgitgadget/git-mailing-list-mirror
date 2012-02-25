From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 0/3] parse-options: no- symmetry
Date: Sat, 25 Feb 2012 20:07:38 +0100
Message-ID: <4F49317A.3080809@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Geoffrey Irving <irving@naml.us>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 20:17:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1N7r-0002fG-Er
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 20:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757605Ab2BYTRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Feb 2012 14:17:41 -0500
Received: from india601.server4you.de ([85.25.151.105]:38117 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757591Ab2BYTRl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 14:17:41 -0500
Received: from [192.168.2.105] (p4FFD9274.dip.t-dialin.net [79.253.146.116])
	by india601.server4you.de (Postfix) with ESMTPSA id 6847A2F8042;
	Sat, 25 Feb 2012 20:07:49 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191545>

Boolean long options can be negated by adding a "no-" at the
beginning, unless the flag PARSE_OPT_NONEG is set.  There are
several options defined to start out with "no-" already (e.g.
format-patch --no-numbered).  Their negation with a second
"no-" looks a bit strange.

The flag PARSE_OPT_NEGHELP was introduced to avoid this
awkwardness.  It is used twice (in fast-export and grep) to
define option pairs (--data/--no-data and --index/--no-index)
whose negative part is shown in the help text.

However, PARSE_OPT_NEGHELP is strange as well.  Short options
defined with it do the opposite of what the help text says
(we currently don't have any).  And the multiple negations
are confusing.

This series adds the ability for users to negate options that
already start with "no-" by simply leaving it out.  The last
patch removes PARSE_OPT_NEGHELP as it isn't needed anymore at
that point.

  test-parse-options: convert to OPT_BOOL()
  parse-options: allow positivation of options starting with no-
  parse-options: remove PARSE_OPT_NEGHELP

 Documentation/technical/api-parse-options.txt |    3 +-
 builtin/fast-export.c                         |    4 +-
 builtin/grep.c                                |   15 +++----
 parse-options.c                               |   33 ++++++++------
 parse-options.h                               |    4 --
 t/t0040-parse-options.sh                      |   60 ++++++++++++++++++++++++-
 test-parse-options.c                          |   12 +++--
 7 files changed, 95 insertions(+), 36 deletions(-)

-- 
1.7.9.2
