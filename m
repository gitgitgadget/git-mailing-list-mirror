From: Russ Brown <pickscrape@gmail.com>
Subject: git-svn and a nested branches folder
Date: Tue, 04 Sep 2007 09:42:50 -0500
Message-ID: <46DD6EEA.9010304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 16:43:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISZcU-0008RS-4m
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 16:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067AbXIDOnE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 10:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753820AbXIDOnE
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 10:43:04 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:8051 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779AbXIDOnA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 10:43:00 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1818384wxd
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 07:43:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=iap03of8JnGBkcpfda89G/0NZ0cs2UWxpL/cGSXUDVgkCpMGRkFpBDW1cF+4jRtppTNqAXYpCNEvFlq0eIMf1Dsw/lwE5SOEWrd+f17S0LwjQ/gJe64Zx4XpSG/IVfLuHllEiQ4AR6C7ZruUQPPSaig1q23hEqkWCRSVAqrRyew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=N9jSaAcruzYNy3JtbWxM2U6TD3yLpl7GDjlueWCRNTEwhvwMMgSp6yUej2i6RuKtT5Wx85VbVGu/s3YsDS60WdmbPqaULeInsB5fk8USxnCaS5ToMZrKdZGA2rfQp+HdOvI5wf0y/8YHBLwpJBugvGf7DSDXLkD+Psyg5Qms8x0=
Received: by 10.90.93.6 with SMTP id q6mr1558187agb.1188916979190;
        Tue, 04 Sep 2007 07:42:59 -0700 (PDT)
Received: from ?192.168.0.100? ( [71.164.207.197])
        by mx.google.com with ESMTPS id 7sm5800023aga.2007.09.04.07.42.57
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 04 Sep 2007 07:42:58 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070807)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57582>

Hi,

I'm having some trouble with using git-svn to fetch a repository, and I
think it's because the repository doesn't store branches as a flat list
directly under the 'branches' directory.

Basically, we have a structure like this:

|
+-trunk
+-tags
+-branches
  + category-a
    + branch-a
    + branch-b
  + category-b
    + branch-c
    + branch-d

etc. category-a and category-b are simple directories created using svn
mkdir. The branches are created using svn cp.

It helps us to organise the branches better, but the rationale is
besides the point. The problem is that git-svn seems to want to treat
category-a and category-b as branches, which isn't right at all. As a
result, git-svn seems to skip most (if not all) revisions that occur in
these directories and creates a lot of entries in unhandled.log.

I've also encountered an index corruption in one of the
.git/svn/<branch>/index files which I think it probably related.

I've had a quick look at the source myself, but perl isn't my strong
point. What I think it should do is something like recurse down the tree
from the directory given looking for folders that copy from trunk (or
some other branch that already exists). That would work perfectly well
for the default flat branch storage method as well as the one we use.

The only other problem is in branch naming, which could clash if you
only use the outer-most directory name, so I'd suggest something that
involves concatenating the folders in the path relative to 'branches' to
keep them unique (if git can handle slashes in branch names then all the
better).

Thanks for reading.

-- 

Russ
