From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] upload-pack: Initialize the exec-path.
Date: Tue, 12 Feb 2008 12:28:01 +0100
Message-ID: <47B182C1.60006@viscovery.net>
References: <51419b2c0802111822k4600e06bp4167a09b30bf947a@mail.gmail.com> <m31w7iegk6.fsf@localhost.localdomain> <47B15ADC.8080309@viscovery.net> <alpine.LSU.1.00.0802121028290.3870@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 12 12:28:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOtJf-0000uO-0F
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 12:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760224AbYBLL2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 06:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760190AbYBLL2J
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 06:28:09 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:51359 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759610AbYBLL2H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 06:28:07 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JOtIb-00016m-6s; Tue, 12 Feb 2008 12:27:41 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DB30D6B7; Tue, 12 Feb 2008 12:28:01 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.LSU.1.00.0802121028290.3870@racer.site>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73651>

From: Johannes Sixt <johannes.sixt@telecom.at>

Since git-upload-pack has to spawn git-pack-objects, it has to make sure
that the latter can be found in the PATH. Without this patch an attempt
to clone or pull via ssh from a server fails if the git tools are not in
the standard PATH on the server even though git clone or git pull were
invoked with --upload-pack=/path/to/git-upload-pack.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
Johannes Schindelin schrieb:
> Hi,
> 
> On Tue, 12 Feb 2008, Johannes Sixt wrote:
>> The problem is that git-upload-pack (which is not a built-in) does not
>> call setup_path() and so does not extend PATH to contain the special
>> installation location. Now, when git-upload-pack tries to exec
>> git-pack-objects, it fails since this is not in PATH.
> 
> So, let's make git-upload-pack a builtin, no?

How about this (almost) one-liner instead?

-- Hannes

 upload-pack.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 7e04311..51e3ec4 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -620,6 +620,9 @@ int main(int argc, char **argv)

 	if (i != argc-1)
 		usage(upload_pack_usage);
+
+	setup_path(NULL);
+
 	dir = argv[i];

 	if (!enter_repo(dir, strict))
-- 
1.5.4.rc3.24.g25a9a
