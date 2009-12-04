From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v2 0/8] Remote helpers smart transport extensions
Date: Fri,  4 Dec 2009 17:55:58 +0200
Message-ID: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 16:57:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGaW6-0001oJ-V2
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 16:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbZLDP4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 10:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbZLDP4H
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 10:56:07 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:34336 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbZLDP4G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 10:56:06 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 0F2AFEF52A
	for <git@vger.kernel.org>; Fri,  4 Dec 2009 17:56:12 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A04C3D0AA6C; Fri, 04 Dec 2009 17:56:12 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id BCB9C1C6383
	for <git@vger.kernel.org>; Fri,  4 Dec 2009 17:56:10 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.288.g40e67
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134519>

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
- Actually test the intermediate states for gross errors.

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
 transport-helper.c                   |  258 +++++++++++++++++++++++++++++-----
 transport.c                          |  258 +++++++++++++++++++++++++++------
 transport.h                          |   32 ++++
 7 files changed, 534 insertions(+), 92 deletions(-)
