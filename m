From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH 0/2] Allow using ':' in git:// hostname.
Date: Tue, 26 Jan 2010 20:24:40 +0200
Message-ID: <1264530282-4783-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 19:25:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZq6Z-0005Wt-5y
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 19:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831Ab0AZSYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 13:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754812Ab0AZSYq
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 13:24:46 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:47189 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821Ab0AZSYp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 13:24:45 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 0DAA48C918
	for <git@vger.kernel.org>; Tue, 26 Jan 2010 20:24:44 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A02045B647F; Tue, 26 Jan 2010 20:24:43 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id EF43641BEA
	for <git@vger.kernel.org>; Tue, 26 Jan 2010 20:24:42 +0200 (EET)
X-Mailer: git-send-email 1.6.6.1.439.gf06b6
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138068>

This series fixes two problems with using addresses containing ':'
(e.g. IPv6 numeric addresses) with git://:

1) ':' in hostname makes vhost headers impossible to parse

If there is ':' in address, the vhost headers become impossible
to parse because ':' is also splits host and port and port is
optional. Change git-daemon to be able to perform address unwrapping
so there is uniquely parseable syntax for hostnames containg
':' (this is compatible to how git-remote-gits encodes such vhost
headers and how git-daemon2[1] decodes them).

2) Client double-unwraps addresses

With git://, the addresses are unwrapped twice, which breaks
address parsing for addresses enclosed by [], which in turn is
required for hostnames containing ':'.  This is changed to unwarp
the addresses only once. This also changes wrapped addresses to
be sent as wrapped for vhost headers (the first patch adds ability
to parse this).

[1] The reference implementation of gits:// server daemon.

Ilari Liusvaara (2):
  Support addresses with ':' in git-daemon
  Allow use of []-wrapped addresses in git://

 connect.c |   10 ++++++++--
 daemon.c  |   34 ++++++++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 6 deletions(-)
