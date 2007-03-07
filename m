From: James Cloos <cloos+vger-git@jhcloos.com>
Subject: git push failure over webdav if no trailing slash on URL
Date: Wed, 07 Mar 2007 12:59:49 -0500
Message-ID: <m33b4hylw3.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 19:02:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP0Sm-0002iG-Ey
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 19:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422759AbXCGSBK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 13:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422780AbXCGSBB
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 13:01:01 -0500
Received: from atl.uu.jhcloos.net ([207.210.96.115]:48501 "EHLO
	atl.uu.jhcloos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422759AbXCGSAo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 13:00:44 -0500
Received: by atl.uu.jhcloos.net (Postfix, from userid 10)
	id 881DDBB54A; Wed,  7 Mar 2007 18:00:42 +0000 (UTC)
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id D890533D1C7; Wed,  7 Mar 2007 18:00:12 +0000 (UTC)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAMnRFWHRUaXRsZQAvbWF4dG9y
 L2Nsb29zL2luY29taW5nLzIwMDQvMDIvUFdHL0pIQzE2LnBuZyJMlEwAAAAadEVYdFNvZnR3YXJl
 AEdOT01FIEljb24gRWRpdG9ynioKbAAAAHFJREFUeJzFk8EKwCAMQ1/ED9cvzw6iuM0N9WIvDTWE
 1KjAxmKnLBEBjLcEIBCeI2nccy5YKrjxwbbvAvZ37zlo4GB9iRMC/cq/AppItwmMyJ5I98wd9G7P
 xxgrSKlYS2lMrOcV13o95aVSKA7E5ndGXG+IIzcl4BNfAAAAAElFTkSuQmCC
Copyright: Copyright 2006 James Cloos
X-Hashcash: 1:23:070307:git@vger.kernel.org::1n/njbS3Zk9HR8+o:000000000000000000000000000000000000000000WBSk
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.0 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41683>

I just discovered a failure mode when pushing over webdav.

I did a clone akin to:

git clone http://NAME:PW@SITE/git/foo/bar

and was unable to push with just a

git push

I watched with ngrep and found that git-http-push authenticated
after the initial connect, got a 100 reply with a Location header
of /git/foo/bar/ (note the trailing slash), authenticated again,
got another 100 reply OKing the 2nd authentication and then failed
to continue.

If instead I ran:

git push http://NAME:PW@SITE/git/foo/bar/

(specifying that trailing slash) everything worked as expected.

This occured with each of git 1.4.2.1 and 1.5.0.2.  (In both cases
as packaged by debian.)

NB that the use of webdav wasn't my choice.

Nor was http rather than https.
