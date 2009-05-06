From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [BUG] git config: cygwin git version 1.6.1.2 does not deletes empty 
	sections
Date: Wed, 6 May 2009 19:50:43 +0400
Message-ID: <85647ef50905060850t2e6c2051jfa6d3596b680cc74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 17:51:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1jOY-0005QB-1J
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 17:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756081AbZEFPup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 11:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753949AbZEFPuo
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 11:50:44 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:57256 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404AbZEFPuo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 11:50:44 -0400
Received: by bwz22 with SMTP id 22so212819bwz.37
        for <git@vger.kernel.org>; Wed, 06 May 2009 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=fx07uzP/S3cmJNHdGWL0FcJW2VkRdMe0w3AJQeuH38g=;
        b=Lt/iXcS1q6nzUxSS9d0+3IXXwq2gxlEMchGZCIIJbNd18klX5dnjoyxdq6/6a50PgM
         trbEjx5/Wu8M0T+8F0KKdV0H8HYsE6OZOLXXmzNWiZui0g30jm9/wXPGX6ml/wHROU8W
         WbChRF1EUfZLCjeH862MbO3YJaC+6NR19WV40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Sqi876nMjDX2K+mCp9ixf1s62XkNy9hpWfC3lT72OZJ+hm3XttRVJop0w7C49UKTAS
         lLjlqXrWsiEk1+H16U3SmVDRj7VuYm4W/AXHeJQMouLpukPn1Dt/qCraqbvqnorWLVZN
         vcoVMb89GH+4DPwJdrtRSqPBGieDIY7p47mJo=
Received: by 10.204.62.135 with SMTP id x7mr1346882bkh.124.1241625043501; Wed, 
	06 May 2009 08:50:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118350>

I have encountered a bug related to git config in cygwin git version 1.6.1.2

The git config --unset might leave an empty section when the last
property is deleted. But consequent "git config key value" does not
uses this empty section. So the following script leaves a sequence of
empty sections "[a]". Looks like a disk space leak to me.

git config a.b a
git config --unset a.b
git config a.b a
git config --unset a.b
git config a.b a
git config --unset a.b
git config a.b a
git config --unset a.b

The resulting .git/config file:

[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
	ignorecase = true
[a]
[a]
[a]
[a]

Was this bug fixed in later versions?

Constantine
