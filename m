From: Marcus Better <marcus@better.se>
Subject: git-svn not fetching all revisions
Date: Tue, 10 Nov 2009 19:08:26 +0100
Message-ID: <4AF9AC1A.5000100@better.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 19:17:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7vHl-0001t5-Q6
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 19:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756222AbZKJSRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 13:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755244AbZKJSRe
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 13:17:34 -0500
Received: from vips.better.se ([79.99.3.21]:60711 "EHLO vips.better.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754394AbZKJSRd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 13:17:33 -0500
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Nov 2009 13:17:33 EST
Received: from [192.168.1.20] (unknown [80.169.182.16])
	by vips.better.se (Postfix) with ESMTPSA id C880420EC0D5
	for <git@vger.kernel.org>; Tue, 10 Nov 2009 19:08:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=better.se; s=mail;
	t=1257876508; bh=njiinhqqve+SAWXqO6l2vlmeAYy38OJDeMeOzSR184k=;
	h=Message-ID:Date:From:MIME-Version:To:Subject:Content-Type:
	 Content-Transfer-Encoding;
	b=FrFFwhJDC5X/CO4jxNgK4K5qr6tqbBTV8ZzIGt7u+Ays8+BdOs6eU4Ce+3clBx4Oq
	 DjG9+NDZnMGnCD4Ej1xc7rSwMsSIrckhLFN50CYio5Yo+Ed3DzCIWxVu51L3PSdAsQ
	 /d8rHbzTF5vcA50pe/xk9MVZVdCobHA5wALAV74o=
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20091109)
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132584>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I have trouble cloning a SVN repository with a somewhat weird history.
Its layout has been reorganised, and is currently using a standard
layout like this:

  project/
    trunk/
    branches/
    tags/
  otherproject/
    ...

The problem is that the trunk was replaced by a branch at some point.
When I do "git svn clone -s svn://host/repo/project" it only fetches the
"old" trunk up to the time of the switch, and then stops. Newer
revisions of the "new" trunk are not fetched and cannot be seen with
"find-rev".

The history of the repo is something like this: Initial layout is

  trunk/
    project/
    otherstuff/
  branches/

Then we had the following sequence:

1. commit stuff to trunk/project/...
2. create "branches/mybranch" from trunk/project
3. some commits on trunk and branches
4. moved trunk/project to branches/old_trunk
5. moved trunk/otherstuff to /otherstuff. /trunk is now empty (***)
6. removed /trunk directory
7. create /project
8. move branches/mybranch to project/trunk
9. commit stuff on project/trunk

(***) last commit seen in clone.

Now step 5 is the last revision that appears in the git svn clone. It
shows up as the last commit on remotes/trunk.

Apparently git svn has failed to follow the move from branches/mybranch
to trunk. The last commit seen on remotes/mybranch in the clone is from
before the move to trunk (step 3).

I have tried replaying the above steps with some variations in a new svn
repository, but apparently I'm missing something because I couldn't
reproduce the issue. I cannot publish the real svn repo.

I use git and git-svn 1.6.5.2 (Debian amd64 packages).

Cheers,

Marcus
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkr5rBkACgkQXjXn6TzcAQnRZQCgrAsQ72wLw/iWx33lHQHi6Di7
wWkAnioEAxJyM/vr802+vzRXq+ZeWjeA
=TW7j
-----END PGP SIGNATURE-----
