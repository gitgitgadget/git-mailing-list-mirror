From: Johannes Schindelin <schindelin@wisc.edu>
Subject: [PATCH 0/6] Improve tag checking in fsck and with transfer.fsckobjects
Date: Thu, 28 Aug 2014 16:46:29 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 28 17:46:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN1uJ-0007KI-ME
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 17:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbaH1Pqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 11:46:35 -0400
Received: from wmauth3.doit.wisc.edu ([144.92.197.226]:39988 "EHLO
	smtpauth3.wiscmail.wisc.edu" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751090AbaH1Pqe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2014 11:46:34 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Aug 2014 11:46:34 EDT
Received: from avs-daemon.smtpauth3.wiscmail.wisc.edu by
 smtpauth3.wiscmail.wisc.edu
 (Oracle Communications Messaging Server 7.0.5.30.0 64bit (built Oct 22 2013))
 id <0NB000900U124700@smtpauth3.wiscmail.wisc.edu> for git@vger.kernel.org;
 Thu, 28 Aug 2014 09:46:32 -0500 (CDT)
X-Spam-PmxInfo: Server=avs-3, Version=6.0.3.2322014,
 Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2014.8.28.143920,
 SenderIP=0.0.0.0
X-Spam-Report: AuthenticatedSender=yes, SenderIP=0.0.0.0
Received: from s15462909.onlinehome-server.info
 (s15462909.onlinehome-server.info [87.106.4.80])
 by smtpauth3.wiscmail.wisc.edu
 (Oracle Communications Messaging Server 7.0.5.30.0 64bit (built Oct 22 2013))
 with ESMTPSA id <0NB000MFUUDID030@smtpauth3.wiscmail.wisc.edu>; Thu,
 28 Aug 2014 09:46:32 -0500 (CDT)
X-X-Sender: schindelin@s15462909.onlinehome-server.info
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256100>

This patch series introduces detailed checking of tag objects when calling
git fsck, and also when transfer.fsckobjects is set to true.

To this end, the fsck machinery is reworked to accept the buffer and size
of the object to check, and for commit and tag objects, we verify that the
buffers end in a NUL.

This work was sponsored by GitHub.

Johannes Schindelin (5):
  Refactor type_from_string() to avoid die()ing in case of errors
  fsck: inspect tag objects more closely
  Add regression tests for stricter tag fsck'ing
  Refactor out fsck_object_buffer() accepting the object data
  Make sure that index-pack --strict fails upon invalid tag objects

 builtin/index-pack.c     |   3 +-
 builtin/unpack-objects.c |  14 ++++--
 fsck.c                   | 109 ++++++++++++++++++++++++++++++++++++++++++++---
 fsck.h                   |   3 ++
 object.c                 |  13 +++++-
 object.h                 |   1 +
 t/t1450-fsck.sh          |  39 +++++++++++++++++
 t/t5302-pack-index.sh    |  19 +++++++++
 8 files changed, 188 insertions(+), 13 deletions(-)

-- 
2.0.0.rc3.9669.g840d1f9
