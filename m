From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 3/8] git_remote_helpers: Force rebuild if python version
 changes
Date: Tue, 15 Jan 2013 22:58:05 +0000
Message-ID: <20130115225805.GA4574@serenity.lan>
References: <cover.1358018078.git.john@keeping.me.uk>
 <89f55d20da9a4c0a8490f95107cbf5d04219d0fb.1358018078.git.john@keeping.me.uk>
 <20130112233044.GB23079@padd.com>
 <20130113162605.GL4574@serenity.lan>
 <20130113171402.GA1307@padd.com>
 <20130113175238.GO4574@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 23:59:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvFTg-0008CA-Ee
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 23:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934317Ab3AOW6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 17:58:21 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:46390 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934142Ab3AOW6R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 17:58:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 2F0C96064CB;
	Tue, 15 Jan 2013 22:58:16 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q9ZRJJbZtzjt; Tue, 15 Jan 2013 22:58:15 +0000 (GMT)
Received: from aardwolf.aluminati.org (aardwolf.aluminati.org [10.0.7.189])
	by coyote.aluminati.org (Postfix) with ESMTP id 662976064B7;
	Tue, 15 Jan 2013 22:58:15 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by aardwolf.aluminati.org (Postfix) with ESMTP id 4884F330E47;
	Tue, 15 Jan 2013 22:58:15 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from aardwolf.aluminati.org ([127.0.0.1])
	by localhost (aardwolf.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6o08NNP+X0+O; Tue, 15 Jan 2013 22:58:15 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by aardwolf.aluminati.org (Postfix) with ESMTPSA id B1D7533002F;
	Tue, 15 Jan 2013 22:58:07 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130113175238.GO4574@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213683>

On Sun, Jan 13, 2013 at 05:52:38PM +0000, John Keeping wrote:
> On Sun, Jan 13, 2013 at 12:14:02PM -0500, Pete Wyckoff wrote:
>> john@keeping.me.uk wrote on Sun, 13 Jan 2013 16:26 +0000:
>>> On Sat, Jan 12, 2013 at 06:30:44PM -0500, Pete Wyckoff wrote:
>>> > john@keeping.me.uk wrote on Sat, 12 Jan 2013 19:23 +0000:
>>> >> When different version of python are used to build via distutils, the
>>> >> behaviour can change.  Detect changes in version and pass --force in
>>> >> this case.
>>> >[..]
>>> >> diff --git a/git_remote_helpers/Makefile b/git_remote_helpers/Makefile
>>> >[..]
>>> >> +py_version=$(shell $(PYTHON_PATH) -c \
>>> >> +	'import sys; print("%i.%i" % sys.version_info[:2])')
>>> >> +
>>> >>  all: $(pysetupfile)
>>> >> -	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build
>>> >> +	$(QUIET)test "$$(cat GIT-PYTHON_VERSION 2>/dev/null)" = "$(py_version)" || \
>>> >> +	flags=--force; \
>>> >> +	$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build $$flags
>>> >> +	$(QUIET)echo "$(py_version)" >GIT-PYTHON_VERSION
>>> > 
>>> > Can you depend on ../GIT-PYTHON-VARS instead?  It comes from
>>> > 96a4647 (Makefile: detect when PYTHON_PATH changes, 2012-12-18).
>>> > It doesn't check version, just path, but hopefully that's good
>>> > enough.  I'm imagining a rule that would do "clean" if
>>> > ../GIT-PYTHON-VARS changed, then build without --force.
>>> 
>>> I was trying to keep the git_remote_helpers directory self contained.  I
>>> can't see how to depend on ../GIT-PYTHON-VARS in a way that is as simple
>>> as this and keeps "make -C git_remote_helpers" working in a clean tree.
>>> 
>>> Am I missing something obvious here?
>> 
>> Not if it wants to stay self-contained; you're right.
>> 
>> I'm not thrilled with how git_remote_helpers/Makefile always
>> runs setup.py, and always generates PYLIBDIR, and now always
>> invokes python a third time to see if its version changed.
> 
> I don't think PYLIBDIR will be calculated unless it's used ('=' not
> ':=' means its a deferred variable).
> 
> I wonder if the version check should move into setup.py - it would be
> just as easy to check the file there and massage sys.args, although
> possibly not as neat.

For reference, putting the version check in setup.py looks like this:

-- >8 --

diff --git a/git_remote_helpers/setup.py b/git_remote_helpers/setup.py
index 6de41de..2c21eb5 100644
--- a/git_remote_helpers/setup.py
+++ b/git_remote_helpers/setup.py
@@ -3,6 +3,7 @@
 """Distutils build/install script for the git_remote_helpers package."""
 
 from distutils.core import setup
+import sys
 
 # If building under Python3 we need to run 2to3 on the code, do this by
 # trying to import distutils' 2to3 builder, which is only available in
@@ -13,6 +14,24 @@ except ImportError:
     # 2.x
     from distutils.command.build_py import build_py
 
+
+current_version = '%d.%d' % sys.version_info[:2]
+try:
+    f = open('GIT-PYTHON_VERSION', 'r')
+    latest_version = f.read().strip()
+    f.close()
+
+    if latest_version != current_version:
+        if not '--force' in sys.argv:
+            sys.argv.insert(0, '--force')
+except IOError:
+    pass
+
+f = open('GIT-PYTHON_VERSION', 'w')
+f.write(current_version)
+f.close()
+
+
 setup(
     name = 'git_remote_helpers',
     version = '0.1.0',
