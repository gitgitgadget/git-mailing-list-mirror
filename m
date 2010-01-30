From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [RFH] rpm packaging failure
Date: Sat, 30 Jan 2010 10:19:21 -0500
Message-ID: <20100130151921.GM29188@inocybe.localdomain>
References: <7v8wbgueqz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 16:19:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbF6o-000113-6b
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 16:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752Ab0A3PTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 10:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753440Ab0A3PTb
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 10:19:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab0A3PTa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 10:19:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8965695325;
	Sat, 30 Jan 2010 10:19:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=iirxrOqvBuYs5fBai+SZQTq2330=; b=RWQLSGa
	bD/KWon2mQyCQvKxVww5ApJ4MUr2Od0q9bxdKrQjPQknLeTf8+prWqnLRqDyZeWO
	zmRWCgz4XSQk9GIpRqglhA74sn93jLuDedr1snIytRI7ALFt3grc65Ikmunx4UeR
	zZ3PmiuzJ6EeRHMGhifs1Ungycylo1GXKEuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=ictv2WxIeg0FwlJHAH371gecma30b8tjb
	CmWLjUVlf4RYo226fb2bdevTDAF3rqHy1p6xX2RRikReTBJplTh3CYvNiQmzcSww
	aOcf4rBDt/4bi4UHchgN4KkX/rMA7wU0vFhy3mlHRJWItvBQI6lUnzAYIRFYz+hJ
	JieD7jL/oI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 62AAC95322;
	Sat, 30 Jan 2010 10:19:25 -0500 (EST)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDDB995320; Sat, 30 Jan
 2010 10:19:22 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v8wbgueqz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: D9CBDA3E-0DB2-11DF-B6F8-6AF7ED7EF46B-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138476>

Junio C Hamano wrote:
> Here is an attempt to fix it, but help is very appreciated, as I don't
> know what the accepted way is to ship Python modules is in the RPM world.

Perhaps this will work well.  I only tested it on Fedora 10, but I
believe it should work on RHEL/CentOS and most other rpm-based
distros.  We may well want to package the python bits in a subpackage,
much as the perl modules are.  Anyone have thoughts on that?

-->8--
Subject: [PATCH] RPM spec: Package git_remote_helper python files

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 git.spec.in |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index ab224f7..575156c 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -1,4 +1,5 @@
 # Pass --without docs to rpmbuild if you don't want the documentation
+%{!?python_sitelib: %global python_sitelib %(%{__python} -c "from distutils.sysconfig import get_python_lib; print get_python_lib()")}
 
 Name: 		git
 Version: 	@@VERSION@@
@@ -9,6 +10,7 @@ Group: 		Development/Tools
 URL: 		http://kernel.org/pub/software/scm/git/
 Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.tar.gz
 BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel, expat-devel, gettext  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
+BuildRequires:	python
 BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
 
 Requires:	perl-Git = %{version}-%{release}
@@ -134,6 +136,7 @@ rm -rf $RPM_BUILD_ROOT
 %doc README COPYING Documentation/*.txt
 %{!?_without_docs: %doc Documentation/*.html Documentation/howto}
 %{!?_without_docs: %doc Documentation/technical}
+%{python_sitelib}/*
 
 %files svn
 %defattr(-,root,root)
@@ -190,6 +193,9 @@ rm -rf $RPM_BUILD_ROOT
 # No files for you!
 
 %changelog
+* Sat Jan 30 2010 Todd Zullinger <tmz@pobox.com>
+- Include git_remote_helper python files
+
 * Mon Feb 04 2009 David J. Mellor <dmellor@whistlingcat.com>
 - fixed broken git help -w after renaming the git-core package to git.
 
-- 
1.6.6

-- 
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Don't hit a man when he's down -- kick him; it's easier.
