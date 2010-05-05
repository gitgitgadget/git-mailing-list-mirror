From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH] Set GIT_PATHNAME_PREFIX with aliases.
Date: Tue, 04 May 2010 20:25:22 -0400
Message-ID: <1273019122.16093.6.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 05 02:30:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9SVj-0007mS-Ad
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 02:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066Ab0EEAah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 20:30:37 -0400
Received: from mail-qy0-f191.google.com ([209.85.221.191]:58520 "EHLO
	mail-qy0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501Ab0EEAag (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 20:30:36 -0400
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 May 2010 20:30:36 EDT
Received: by qyk29 with SMTP id 29so6470586qyk.14
        for <git@vger.kernel.org>; Tue, 04 May 2010 17:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=6yU6ZC4p9oY5uHGRG9XJkr2kyiBEvEtdxfg53cKOwIY=;
        b=qkiQ4SfRTlQDjYb5ei9iDaP3YCB6rlu+eGR7/Z2yih/mUORMlLzaUUBw6igdgdvxvX
         v31WuMe1+1mkqfUneR9eBpT96KAH95Xt58Y8OQJBKooStxRcON8SIqV9D89jSrbq4yYf
         utQgDFrPhiueV+WcKb5WI2io3y4RZy2/3NV3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        b=QEIDFHxqmEl4VRhLX6z4Y24Mpoz5mB/EMnAyMXGLPrmn2a5Fe3aWpBPjZ0zo8l6jQn
         4cNPwI9UlRZM0c0b6X1YZzRDgLVfVO+fn3juQH8h5C5wUtlpIGcVYEqHQS0MhRthC35N
         9wo5UGRgx6yCdMZNDqg4LE/flhtpvUFN1d+zc=
Received: by 10.224.26.7 with SMTP id b7mr5086507qac.328.1273019124371;
        Tue, 04 May 2010 17:25:24 -0700 (PDT)
Received: from [192.168.1.106] (cpe-75-186-11-174.cinci.res.rr.com [75.186.11.174])
        by mx.google.com with ESMTPS id 5sm12969236qwg.30.2010.05.04.17.25.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 May 2010 17:25:23 -0700 (PDT)
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146360>

The environment variable GIT_PATHNAME_PREFIX passes on the
current working directory (where the git command was called from)
to shell aliases (aliases that begin with "!"). This allows these
shell aliases to know the directory that the git command was called
from.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 git.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index 6bae305..836f753 100644
--- a/git.c
+++ b/git.c
@@ -167,6 +167,9 @@ static int handle_alias(int *argcp, const char ***argv)
 				free(alias_string);
 				alias_string = buf.buf;
 			}
+			static char current_dir[PATH_MAX+1];
+			setenv("GIT_PATHNAME_PREFIX", getcwd(current_dir, sizeof(current_dir)), 1);
+
 			trace_printf("trace: alias to shell cmd: %s => %s\n",
 				     alias_command, alias_string + 1);
 			ret = system(alias_string + 1);
-- 
1.7.0.4
