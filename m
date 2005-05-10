From: Jon Seymour <jon.seymour@gmail.com>
Subject: Core and Not-So Core
Date: Wed, 11 May 2005 01:00:33 +1000
Message-ID: <2cfc40320505100800426d38ca@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 10 16:55:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVW7V-0002aK-SK
	for gcvg-git@gmane.org; Tue, 10 May 2005 16:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVEJPBJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 11:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVEJPBI
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 11:01:08 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:33748 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261666AbVEJPAg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 11:00:36 -0400
Received: by rproxy.gmail.com with SMTP id j1so872885rnf
        for <git@vger.kernel.org>; Tue, 10 May 2005 08:00:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LxGMSDBN6Z+X0MxPp/Scypmt+4+gu++a5fA1D/VNB/XRDqdffQH+6kETCbYid6Z5AWHGKhEMYA2VGeoph4nj8P1BDxRUz1LTIcn6Nm7/MXkQKGaW5bv8QT0BhMtVX6kDQ+Qhg+NAWD2/B0sdYWkzKttmjoAWq83wxt4b4RxzOMM=
Received: by 10.38.78.47 with SMTP id a47mr1499400rnb;
        Tue, 10 May 2005 08:00:33 -0700 (PDT)
Received: by 10.38.104.59 with HTTP; Tue, 10 May 2005 08:00:33 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I have been experimenting with pure-Java implementation of GIT
concepts with a goal of eventually providing plugins to Eclipse to
allow the Eclipse GUI to interact with GIT repositories.

One thing I noticed when doing this is that the present index/cache
structure is rather arbitrary and the optimum index structure is
determined by the structure of the tools that use a GIT repository
rather than the structure of the GIT repository itself.

To give a concrete example: the cache currently contains most of the
posix stat structure primarily to allow quick change detection. In the
Java world, most of the posix stat structure is not directly
accessible via the pure-Java file system abstractions. However, for
most purposes detecting changes to files modification time and file
size would be enough. Given this is the case, a Java-GIT client
doesn't need to bother getting access to a posix stat structure and
could therefore get away with a simpler  index structure, provided it
doesn't need to interoperate with a 'C'-GIT client that shared the
same workspace. A Java-GIT client might also choose to represent an
index cache as a complex serialized Java object graph or (perhaps) an
XML document.

Another example: I can imagine a variant of the index file structure
that recorded all the parents which have been merged into the cache
and automatically include this information when performing the commit.

The point is that many different index file structures are possible
and will be determined in part by the tooling created in the porcelain
layer - there really is no one true index file format as there is a
one true repository format. Different tools can use different index
file formats and still interoperate at the repository level because
only the repository format needs to have a solid, unchanging
definition.

Currently the GIT stack is structured as follows:

cogito
git-core 

I think it would be worthwhile if care was taken to draw a distinction
between the repository and the cache aspects of the git core, perhaps
even going to the extreme of moving all knowledge of the  cache into
cogito itself. By clearly drawing this distinction, we will more
easily enable the creation of different kind of tools sets atop the
foundation of the GIT repository format.

e.g., either:

cogito
git-cache
git-respository

or:

cogito-tools
cogito-cache
git-repository

Anyway, I offer this as food for thought - chew or flame away as appropriate!

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
