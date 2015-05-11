From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/2] Retry attempts to acquire the packed-refs lock
Date: Mon, 11 May 2015 12:35:24 +0200
Message-ID: <1431340526-24288-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 12:35:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrl3y-0006qH-Dk
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 12:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbbEKKfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 06:35:50 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:46821 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752921AbbEKKfp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 06:35:45 -0400
X-AuditID: 12074412-f79e46d0000036b4-92-555085f474ce
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id FA.0F.14004.4F580555; Mon, 11 May 2015 06:35:32 -0400 (EDT)
Received: from michael.fritz.box (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BAZTPD021833
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 06:35:31 -0400
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsUixO6iqPulNSDUoG+lhkXXlW4mi4beK8wW
	T+beZba4vWI+s8WPlh5mi82b21kc2Dz+vv/A5LFgU6nHw1dd7B7Pevcwely8pOzxeZNcAFsU
	t01SYklZcGZ6nr5dAnfGobZGloKrbBXzThk2MPaydjFyckgImEhcaJzCCGGLSVy4t56ti5GL
	Q0jgMqPEiVmHmSGc40wSfUeWMYNUsQnoSizqaWYCsUUE1CQmth1iASliFljPKHHs2nSwhLCA
	m8Svm6fAxrIIqEocfHYAqIiDg1fARaL1uiXENjmJ88d/Mk9g5F7AyLCKUS4xpzRXNzcxM6c4
	NVm3ODkxLy+1SNdMLzezRC81pXQTIyRohHYwrj8pd4hRgINRiYfX4IJ/qBBrYllxZe4hRkkO
	JiVR3raqgFAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrycjUA53pTEyqrUonyYlDQHi5I478/F
	6n5CAumJJanZqakFqUUwWRkODiUJXiZgdAgJFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWW
	lmTEgwI9vhgY6iApHqC97CDtvMUFiblAUYjWU4y6HHem/F/EJMSSl5+XKiXO+7QFqEgApCij
	NA9uBSxFvGIUB/pYmDcTpIoHmF7gJr0CWsIEtMQxDmxJSSJCSqqBMWqn8upjH/ifJYrHHJ0W
	EZjOxcz7+/4Z5/KPadK+DPcMrnrPVVfOZ9H/uyrun+mNmbZr5yz0evvqsai5iGS2SH/7JZFm
	XnefpAu6SVULK6b/ODElaZl7qmdxqrXg/l5t/57r0pxGYUtXW3V1qPv+dha5+P6r 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268768>

This is a re-roll of [1]. The only change is the addition of a "wait"
in the test to avoid an unlikely race between the lockfile-removing
subprocess and the attempt by the outer layer of the test to delete
the test directory.

Thanks to Hannes, Stefan, and Peff for their comments about v1.

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/268137

Michael Haggerty (2):
  lockfile: allow file locking to be retried with a timeout
  lock_packed_refs(): allow retries when acquiring the packed-refs lock

 Documentation/config.txt |  6 ++++
 lockfile.c               | 79 ++++++++++++++++++++++++++++++++++++++++++++++--
 lockfile.h               | 16 ++++++++--
 refs.c                   | 12 +++++++-
 t/t3210-pack-refs.sh     | 17 +++++++++++
 5 files changed, 125 insertions(+), 5 deletions(-)

-- 
2.1.4
