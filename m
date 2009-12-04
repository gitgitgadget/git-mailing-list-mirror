From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v2 0/8] Remote helpers smart transport extensions
Date: Fri,  4 Dec 2009 17:55:59 +0200
Message-ID: <1259942168-24869-2-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 16:57:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGaW7-0001oJ-GE
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 16:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153AbZLDP4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 10:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753077AbZLDP4M
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 10:56:12 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:35777 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbZLDP4L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 10:56:11 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id C446EEBE60
	for <git@vger.kernel.org>; Fri,  4 Dec 2009 17:56:16 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A04C59C223F; Fri, 04 Dec 2009 17:56:16 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 02C5E1C6382
	for <git@vger.kernel.org>; Fri,  4 Dec 2009 17:56:13 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.288.g40e67
In-Reply-To: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134518>

This series is reroll of previous version of smart transport extensions,
with various technical nits addressed and some errors fixed. Also rebased
on top of latest next.

Major changes:
- Service names now have 'git-' prefix.
- Successful response to <connect> is "", not "OK".
- Removed <connect> "ERROR" response.
- <connect-r> renamed to <connect>.
- <invoke-r> removed. Pass service executable as option "servpath" instead.
- HTTP helpers are now hardlinked if possible (copied if not).
- Revert the changes to way helpers are invoked.[1]
- Actually test that all intermediate states compile.

[1] The current way seems to have all sorts of funky failure cases, but
I'm not touching it without fixing it properly.

Known issues (not caused by this code and does not need this code to be
visible):
- Segfaults when closing transports, caused by double-frees
- Funky error message if trying to use not-present helper.

Ilari Liusvaara (8):
  Pass unknown protocols to external protocol handlers
  Refactor git transport options parsing
  Support taking over transports
  Support remote helpers implementing smart transports
  Support remote archive from external protocol helpers
  Remove special casing of http, https and ftp
  Add remote helper debug mode
  Support mandatory capabilities

 .gitignore                           |    4 +
 Documentation/git-remote-helpers.txt |   33 ++++-
 Makefile                             |   24 +++-
 builtin-archive.c                    |   17 ++-
 transport-helper.c                   |  257 +++++++++++++++++++++++++++++-----
 transport.c                          |  258 +++++++++++++++++++++++++++------
 transport.h                          |   32 ++++
 7 files changed, 533 insertions(+), 92 deletions(-)
