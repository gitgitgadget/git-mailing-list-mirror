From: Schuyler Duveen <sky@columbia.edu>
Subject: [RFC] submodule+shallow clone feature request
Date: Wed, 10 Feb 2010 16:39:08 -0500
Message-ID: <4B73277C.9010801@columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 22:58:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfKaA-0000mb-16
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 22:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755833Ab0BJV6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 16:58:44 -0500
Received: from serrano.cc.columbia.edu ([128.59.29.6]:64921 "EHLO
	serrano.cc.columbia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452Ab0BJV6n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 16:58:43 -0500
X-Greylist: delayed 1172 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Feb 2010 16:58:43 EST
Received: from [192.168.1.102] (cpe-69-203-12-132.nyc.res.rr.com [69.203.12.132])
	(user=sky mech=PLAIN bits=0)
	by serrano.cc.columbia.edu (8.14.3/8.14.3) with ESMTP id o1ALd8rr027045
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 10 Feb 2010 16:39:09 -0500 (EST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
X-No-Spam-Score: Local
X-Scanned-By: MIMEDefang 2.68 on 128.59.29.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139554>

My use case is deploying from a git repository, which would be even more
graceful with the following features:

1. When 'git clone' has both --recursive and --depth, then submodules
are also checked out shallow (for speed/bandwidth).

2. Some way to specify an override on .gitmodules sources.  This is
because our .gitmodules includes public, read-only sources (github),
rather than our local repos we would prefer to deploy from (for the
purpose of reliability).

The other use-case for feature #2 is the read-only vs. writable
repository sources.  Developers that are also working on the submodules
should be able to clone from separate repository sources.  Though this
could be (and perhaps is) satisfied with a pushurl= in .gitmodules, I'd
like to keep the push url non-public, and that still would leave us
unable to deploy from different urls.

For #2 maybe something like this:

$ git clone --recursive --depth 1 --modules foo.modules\
> git@example.com/foo.git
where foo.modules contains:
<begin>
[submodule "bar"]
	path = bar
	url = git@example.com/bar.git
[submodule "bar/baz"]
	path = bar/baz
	url = git@example.com/baz.git
<end>

Notice how the .gitmodules needs to be able to specify recursive sources
as well.  Presumably `git submodule init` would take --modules argument
as well (and maybe git submodule update, too).

I'm not well-versed in the git source code yet, but poking around
suggests that this is doable.  Would a patch be well received (or does
someone want to do it for me :-)

cheers,
sky
