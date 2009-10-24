From: Bernt Hansen <bernt@norang.ca>
Subject: [PATCH 0/2] gitk: Fix error display when Tcl is too old
Date: Sat, 24 Oct 2009 16:20:38 -0400
Message-ID: <1256415640-10328-1-git-send-email-bernt@norang.ca>
Cc: Paul Mackerras <paulus@samba.org>, Bernt Hansen <bernt@norang.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 24 22:21:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1n7P-00056k-EP
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 22:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbZJXUVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 16:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752194AbZJXUVc
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 16:21:32 -0400
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49855 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbZJXUVb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 16:21:31 -0400
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-02-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <bernt@norang.ca>)
	id 1N1n7H-000MX7-Pm; Sat, 24 Oct 2009 20:21:35 +0000
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX196N7MTzIRzbR84n9yCI9K0
Received-SPF: none (mail.norang.ca: bernt@gollum.intra.norang.ca does not designate permitted sender hosts) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=gollum.intra.norang.ca; envelope-from=bernt@gollum.intra.norang.ca; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.14.3/8.14.3/Debian-5) with ESMTP id n9OKLVNL011955
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 24 Oct 2009 16:21:32 -0400
Received: from gollum.intra.norang.ca (localhost [127.0.0.1])
	by gollum.intra.norang.ca (8.14.3/8.14.3/Debian-5) with ESMTP id n9OKLV2E010410;
	Sat, 24 Oct 2009 16:21:31 -0400
Received: (from bernt@localhost)
	by gollum.intra.norang.ca (8.14.3/8.14.3/Submit) id n9OKLVIw010409;
	Sat, 24 Oct 2009 16:21:31 -0400
X-Mailer: git-send-email 1.6.5.1.69.g36942
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131178>

The following patch series cleans up error message reporting when your
version of Tcl is too old.

The old code checked the Tcl version first and then tried to report
the error with show_error.  show_error uses msgcat for translation but
msgcat is not yet initialized when we are checking the Tcl version
requirement.

The first patch moves the initialization of msgcat before the check
for the Tcl version.  This version will fail is msgcat is not
available.

The second patch handles the case where the msgcat package is not
available by providing a default mc procedure than just returns the
argument text unchanged (essentially bypassing message text
translation).

This lets us continue to use show_error as-is.

Bernt Hansen (2):
  gitk: Initialize msgcat before first use
  gitk: Provide a default mc function if msgcat is not available

 gitk |   46 ++++++++++++++++++++++++++--------------------
 1 files changed, 26 insertions(+), 20 deletions(-)
