From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] t/perf: make runner work even if Git is not installed
Date: Fri, 25 Sep 2015 02:31:37 +0200
Message-ID: <1443141097-4615-1-git-send-email-s-beyer@gmx.net>
Cc: Thomas Rast <trast@student.ethz.ch>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 25 02:33:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfGxH-0000Na-5m
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 02:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbbIYAde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 20:33:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:57941 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854AbbIYAdd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 20:33:33 -0400
Received: from fermat.fritz.box ([88.70.151.36]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MHX0m-1ZgNPi1jp6-003J1v; Fri, 25 Sep 2015 02:33:30
 +0200
X-Mailer: git-send-email 2.6.0.rc3.dirty
X-Provags-ID: V03:K0:MAZPFJ5OFaig+BMXx3ge0IahWN/fVe9HUmGLBGhJson2srygQoJ
 qbvlK47wyAZT770goErIoOIFBrOJSyB6C+osEw6r7UWKQnLR4lNlhalXUndUnZBKkqJN+RQ
 5PZdUxofSwIqdJ+eeJT6GjOSjQpnXodccL3ao6/FrwVFcEjLs3str8AQ/qsxnZ5wG1FzcRl
 NyIrg3+rPbYsPH+3CXeJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3lAm7TNAM/0=:feFHF0fs1iUk7+rVyGS+Ns
 Mpi0MKFd/viFUQL6eBbVAdU1zGB6gmqvoedmFgtZiWZpBtbjJuajDbUFnMM/xjHcPlGNnWTND
 fmjnEeMrGwL8togSUhwN319md6Zz75QcVsTfSX5lu8e4deVepz4YIUPB2qi33gsylfx+coTL3
 3uQjQL+9CZ7AxHbMkKkcx1PJwcCvXlLHmTztjOi2ywZMZ1zqQSd0FrzwThEinTr6n+RUU3Zsl
 J9KXX3PILVq/fM+XaextixVoSb/bkWqlDFMr3tHdBivAG/Jf3rXcTeSUCM78Vb6v5Bs8HproE
 MzZPSCVjB19LTp6E3kwYYM6jcHdG5pkeOgrJixpoCNMNcb1OiWATma5hvPsMOGTJbjuAQ2Bc1
 xZ8k5XQ5y3DfPODGn4OPffzp57h64uSQO03QDBSngfr/Q86aYcwmaClVdPzD7klvLrLPzeMtD
 CMhPz3NnwGYzbGKcldGrjM2O9xJDw/EiQGYgQO4fkylEGDRltlZ/fABTlWb3L7SS9/lLO+BC6
 1X0lbq0zaz4bVyb51yV8g2+zN6nEiSZ/EKmuu5IJfTV8N5rPBqpA4D+jmvJz9zBtjQHVyMiqJ
 ++Ez0s2AfqNMVvETUvmlYoFlX0crH9IoofeAukuhxehE/9KotSUEYXXh5iZOddadeEfMRp2bs
 tly25EOH8jC3e6C7nNz3e5nLntADOVAqtoaqiyUynFQ90aWmU7TGg0PV2cdc+pFeM968TSiSS
 Xned7g9XceJwHhXB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278640>

aggregate.perl did not work when Git.pm is not installed to a directory
contained in the default Perl library path list or PERLLIB.
This commit prepends the Perl library path of the current Git source
tree to enable this.

Note that this commit adds a hard-coded relative path

  use lib '../../perl/blib/lib';

instead of the flexible environment-based variant

  use lib (split(/:/, $ENV{GITPERLLIB}));

which is used in tests written in Perl.
The hard-coded variant is used because the whole performance test
framework does it that way (and GITPERLLIB is not set there).

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 t/perf/aggregate.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 15f7fc1..924b19d 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -1,5 +1,6 @@
 #!/usr/bin/perl
 
+use lib '../../perl/blib/lib';
 use strict;
 use warnings;
 use Git;
-- 
2.6.0.rc3.dirty
