From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Followup: management of OO files - warning about "rezip" approach
Date: Sun, 14 Dec 2008 13:08:24 +0000 (UTC)
Message-ID: <loom.20081214T123442-862@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 14 14:11:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBqkR-0005kE-9v
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 14:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbYLNNIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 08:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752355AbYLNNIm
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 08:08:42 -0500
Received: from main.gmane.org ([80.91.229.2]:50551 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752183AbYLNNIl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 08:08:41 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LBqi2-0006mg-55
	for git@vger.kernel.org; Sun, 14 Dec 2008 13:08:36 +0000
Received: from host176-58-dynamic.19-79-r.retail.telecomitalia.it ([79.19.58.176])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 13:08:34 +0000
Received: from sergio.callegari by host176-58-dynamic.19-79-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 13:08:34 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 79.19.58.176 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.4) Gecko/2008111318 Ubuntu/8.10 (intrepid) Firefox/3.0.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103077>

Hi, some times ago, i considered ways to achieve a smarter management of
openoffice files with git.

The thread started at:

http://article.gmane.org/gmane.comp.version-control.git/95951

There, a "rezip" script was proposed to store OO files uncompressed into git
repos, so that the compression and delta machinery of git could operate at its
best with them.

Appartently, the script rose some interest.  In the following days I received
quite a few corrections/enhancements proposals for which all the posters I thank.

Also I was asked to upload the script and instructions relative to its adoption
together with .gitattributes to the git wiki.

This I didn't do (I do not know if someone else might have done it) because I
first wanted to be absolutely sure that the script would cause no problems to
anybody.

Unfortunately, I now see that there is an issue, so I am sending a warning.

The problem stems from the fact that ODF files, due to the zip compression also
might store pieces of info that are completely irrelevant.  For instance zip
stores ownership of member files.  This is why in the rezip script I initially
started to unzip files with -X.

Now, this seems to be looking for trouble when repos are passed from one user to
another one.

When we uncompress and ODF file for storing we should probably scrap away the
member ownership info alltogether. Note that this is not equivalent to not using
-X.  Not using -X would mean "changing" member owernership when an ODF file is
passed from one user to another one.  Using -X seemed to me the correct thing to
do as it allowed to leave untouched the member ownership.  However, -X fails
when user A has no permission to create files as user B.

I found out about this issue by having accounts on many hosts, where my
alphanumeric user ID maps to different numeric IDs.

I will look better at this as soon as I have time.  So far, please just be
careful.  My guess is that we should not use -X on "unzip" but use it on "zip".

E.g. patch the rezip script so that

PROFILE_UNZIP_ODF_UNCOMPRESS='-b -qq'
PROFILE_ZIP_ODF_UNCOMPRESS='-q -r -D -0 -X'
PROFILE_UNZIP_ODF_COMPRESS='-b -qq'
PROFILE_ZIP_ODF_COMPRESS='-q -r -D -6 -X'


Sergio
