From: TJ <git@iam.tj>
Subject: [PATCH 0/1] Introduce new build variables INSTALL_MODE_EXECUTABLE
 and INSTALL_MODE_DATA.
Date: Thu, 31 Jan 2013 02:08:29 +0000
Message-ID: <5109D21D.8010701@iam.tj>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 31 03:18:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0jjj-00078C-55
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 03:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513Ab3AaCSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 21:18:25 -0500
Received: from yes.iam.tj ([109.74.197.121]:49805 "EHLO iam.tj"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753300Ab3AaCSY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 21:18:24 -0500
Received: from [10.254.251.193] (jeeves.iam.tj [82.71.24.87])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by iam.tj (Postfix) with ESMTPSA id 8A98F7C430
	for <git@vger.kernel.org>; Thu, 31 Jan 2013 02:08:30 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215087>

During a build/install cycle of the current HEAD whilst attempting to identify the cause of a bug in
git version 1.8.0.3 whilst doing:

GIT_CURL_VERBOSE=1 git clone -v https://git01.codeplex.com/typescript

* GnuTLS recv error (-9): A TLS packet with unexpected length was received.
* Closing connection #0
error: RPC failed; result=56, HTTP code = 200

I hit a local install failure whilst installing to the prefix /usr/local/ where the $(INSTALL)
command reported a Permission Denied error.

This was due to the $(INSTALL) modes being 755/644 but the file-system modes being 775/664.
In this case ownership and permissions are:

$ ls -ald /usr/local
drwxrwxr-x 13 root adm 4096 Sep 26 04:16 /usr/local

Users belonging to the 'adm' group have permission to install local packages.

The fix I've implemented is to convert the hard-coded 755/644 modes to variables which can
be over-ridden on the make command-line if necessary.
