From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH] Documentation: start to explain what git replace is for
Date: Tue, 11 Jan 2011 18:08:12 -0600
Message-ID: <20110112000812.GA31950@burratino>
References: <746745466.20110111134101@mail.ru>
 <m3lj2rbmq5.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?0JDQu9C10LrRgdC10Lkg0KjRg9C80LrQuNC9?= <zapped@mail.ru>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 12 01:08:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcoGW-0003J1-83
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 01:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756382Ab1ALAIe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jan 2011 19:08:34 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61774 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584Ab1ALAId convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jan 2011 19:08:33 -0500
Received: by qwa26 with SMTP id 26so17462qwa.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 16:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=LjH5sHlRd+S5UI1Z7vj5IOvGXUhYVzcBExLnROXF23Y=;
        b=ZoMRNWzjRoWbrV78MjnyHA7paOSmrKmiO7VgdnpxIIByw8QYXozqFwQncDdcC3xd38
         UXCRCGmKLrQ8W7SDB6F7iGieWQNsEcyBHns8SwpQPFvj0RsxNQWqhqmGL+TMjsCEDbL6
         No5ilatNiOAMfG6NGTppGq1Ed9qBrj5BDBidI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=DlSVOglCqMcId9nKWx0Jorv1eSZcT0flmltA7UeohBCV4BMw8Ml9pq+20nIUW+06xN
         7rJeg9AvaG8zqp5q9nK/GfayXzwVWiNlcbOtLqeYJ3m997ErZhvn1WH/kaI1swavmL3c
         stUSbbiiKLp5E4h8SNvJCQGwTzbgrDKgzbNC4=
Received: by 10.229.91.3 with SMTP id k3mr237606qcm.84.1294790912125;
        Tue, 11 Jan 2011 16:08:32 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id q12sm41820qcu.6.2011.01.11.16.08.30
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 Jan 2011 16:08:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m3lj2rbmq5.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164998>

Jakub Narebski wrote:

> P.S. This probably should made it into Documentation/howto

Or even better, the git-replace manpage.  How about something like
this?  Still very rough.  I'd be happy if someone else can pick this
up and make it into something better (for example, with an addition
to the test suite to make sure we are not telling lies).

-- 8< --
Subject: Documentation: start to explain what git replace is for

With an example from =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=D0=B9 =D0=A8=D1=
=83=D0=BC=D0=BA=D0=B8=D0=BD <zapped@mail.ru>.

Based-on-message-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-replace.txt |  106 +++++++++++++++++++++++++++++++--=
--------
 1 files changed, 80 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.=
txt
index fde2092..02e5de8 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -14,38 +14,29 @@ SYNOPSIS
=20
 DESCRIPTION
 -----------
-Adds a 'replace' reference in `.git/refs/replace/`
=20
-The name of the 'replace' reference is the SHA1 of the object that is
-replaced. The content of the 'replace' reference is the SHA1 of the
-replacement object.
+The `git replace <object> <replacement>` command adds a ref in the
+`refs/replace/` hierarchy requesting that requests for <object> be
+handled by retrieving <replacement> instead.  This is most commonly
+used to replace one commit by another.
=20
-Unless `-f` is given, the 'replace' reference must not yet exist in
-`.git/refs/replace/` directory.
+The name of this 'replace' reference is the object id for the object
+that is replaced.  Unless `-f` is given, the 'replace' reference must
+not already exist in the `refs/replace/` hierarchy.
=20
-Replacement references will be used by default by all git commands
-except those doing reachability traversal (prune, pack transfer and
-fsck).
+Replacement references will be used by default by most git commands,
+with the notable exception of reachability calculations.  This
+exception means that replacements do not affect the result of 'git gc'
+or 'git clone', ensuring that (1) it is always safe to remove a
+replacement reference without harming repository integrity and
+(2) replacements do not change the meaning of 'have' lines during
+pack transfer, so the client and server do not need to have the same
+replacements during object transfer for it to succeed.
=20
 It is possible to disable use of replacement references for any
 command using the `--no-replace-objects` option just after 'git'.
-
-For example if commit 'foo' has been replaced by commit 'bar':
-
-------------------------------------------------
-$ git --no-replace-objects cat-file commit foo
-------------------------------------------------
-
-shows information about commit 'foo', while:
-
-------------------------------------------------
-$ git cat-file commit foo
-------------------------------------------------
-
-shows information about commit 'bar'.
-
-The 'GIT_NO_REPLACE_OBJECTS' environment variable can be set to
-achieve the same effect as the `--no-replace-objects` option.
+Additionally, the 'GIT_NO_REPLACE_OBJECTS' environment variable can
+be set to achieve the same effect.
=20
 OPTIONS
 -------
@@ -62,6 +53,69 @@ OPTIONS
 	Typing "git replace" without arguments, also lists all replace
 	refs.
=20
+EXAMPLES
+--------
+. The following sequence replaces commit 'foo' with commit 'bar'
+and then views the replaced and unreplaced versions of 'foo'.
++
+------------------------------------------------
+$ git replace foo^{commit} bar^{commit}        <1>
+$ git --no-replace-objects cat-file commit foo <2>
+$ git cat-file commit foo                      <3>
+------------------------------------------------
++
+<1> request replacement
+<2> show information about the true commit 'foo'
+<3> show information about the replacement commit 'bar'
+
+. The following example comes from =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=
=D0=B9 =D0=A8=D1=83=D0=BC=D0=BA=D0=B8=D0=BD:
++
+1.5 years ago I had sources of a project in another version control
+system.  And I had two branches: v2.4 and v2.5.
+They differed enough at that moment and laid in two different folders.
+Then I learned about Git and I decided to try to use this DVCS.
+I created two git repositories: one for each branch.
+So v2.4 has its own git repo and v2.5 (and above) has another one.
++
+Now I'd like to merge them as v2.5 was a continuous branch from v2.4,
+but without rebasing (i.e. without a global change to the v2.5
+repository, which already has other branches).  It should look like
+the last commit of from the v2.4 branch is a parent of the first
+commit of v2.5.
++
+You can do this using grafts (and you can make history with grafts
+permanent using 'git filter-branch').  A better solution might be to
+use the more modern replace mechanism.  Below are untested step-by-ste=
p
+instructions.
++
+--------------------------------------------------
+$ git rev-list master --parents | grep -v ' '    <1>
+$ git rev-parse v2.4                             <2>
+$ git cat-file commit FIRST >tmp                 <3>
+$ sed -i "/^tree / a \\
+parent $(git rev-parse v2.4)" <tmp >new          <4>
+$ git hash-object -t commit -w new               <5>
+$ git replace FIRST <object id from hash-object> <6>
+$ git show FIRST
+$ git log --graph --oneline -3 FIRST             <7>
+--------------------------------------------------
++
+<1> Find all parentless commits in the 'master' branch;
+for 'master' read the branch holding v2.5 history.
+<2> Find the last commit of v2.4.
+<3> Save the current state of the first commit of v2.5 to a file.
+<4> Edit this file, adding 'parent' line between 'tree' and 'author'
+headers, so the header of this file looks like the following:
+  tree 13d050266e05f7c66000240814199fcf3b559d43
+  parent ada9983c4256f5a7bac1f7f0e29d52011741d6aa
+  author Jakub Narebski <jnareb@gmail.com> 1294231771 +0100
+<5> Add the newly created object to the repository.
+<6> Use it as a replacement.
+<7> Check that replacement works.
++
+Then anyone who fetches `refs/replace/*` will get the joined history,
+and those who doesn't will see it not connected.
+
 BUGS
 ----
 Comparing blobs or trees that have been replaced with those that
--=20
1.7.4.rc1
