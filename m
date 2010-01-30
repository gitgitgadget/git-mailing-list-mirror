From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH] rpm packaging failure
Date: Sat, 30 Jan 2010 01:24:36 -0800
Message-ID: <7v8wbgueqz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 10:26:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb9bO-0004uK-Io
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 10:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654Ab0A3JYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 04:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752624Ab0A3JYo
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 04:24:44 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44151 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab0A3JYn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 04:24:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A59669560D;
	Sat, 30 Jan 2010 04:24:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=oA/t
	FcDptHpYuY6vSb20ucDtrZU=; b=IGo9EwcxtPPPd38xpOpgjPw66DhplTBg6yFY
	DH+mxCfKDXFo/doTji8KWOrcr3BTGPJ3u1uKZJ5rAQKPBq6R2+REq4KwwYqV5pgK
	sv2H/oOEhEkbxVNC8na0dPWWJYLkqZHy7NcLL3F0pc64NVv7psbtv4jPG1gVR38Y
	HJsEjr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	g8+GFFsWKDMWgYy6sGaKGz8FVaNVfvZ5SERi/42He5FljOelKi0eUCLuGBn4IBSl
	Gbg91vueORZqFtKNHByOVxU+MsSbFz8G44xSOsARl0HF0wOnMRyKBsrruPjY9Z8t
	bXAQhyirY9dvFm4ukt/aWOpIUz9gbmdo7+xzHUqYRKA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 81D5E9560C;
	Sat, 30 Jan 2010 04:24:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE3199560B; Sat, 30 Jan
 2010 04:24:37 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4B05F342-0D81-11DF-9B29-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138470>

Subject: [PATCH] experimental RPM spec change

"make rpm" with recent 'master' fails with:

    RPM build errors:
        Installed (but unpackaged) file(s) found:
       /usr/lib/python2.6/site-packages/git_remote_helpers-0.1.0-py2.6.egg-info
       /usr/lib/python2.6/site-packages/git_remote_helpers/__init__.py
       /usr/lib/python2.6/site-packages/git_remote_helpers/__init__.pyc
       /usr/lib/python2.6/site-packages/git_remote_helpers/git/__init__.py
       /usr/lib/python2.6/site-packages/git_remote_helpers/git/__init__.pyc
       /usr/lib/python2.6/site-packages/git_remote_helpers/git/git.py
       /usr/lib/python2.6/site-packages/git_remote_helpers/git/git.pyc
       /usr/lib/python2.6/site-packages/git_remote_helpers/util.py
       /usr/lib/python2.6/site-packages/git_remote_helpers/util.pyc

Here is an attempt to fix it, but help is very appreciated, as I don't
know what the accepted way is to ship Python modules is in the RPM world.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git.spec.in |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index ab224f7..1aeba90 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -121,6 +121,7 @@ find $RPM_BUILD_ROOT -type f -name perllocal.pod -exec rm -f {} ';'
 (find $RPM_BUILD_ROOT%{perl_vendorlib} -type f | sed -e s@^$RPM_BUILD_ROOT@@) >> perl-files
 %if %{!?_without_docs:1}0
 (find $RPM_BUILD_ROOT%{_mandir} $RPM_BUILD_ROOT/Documentation -type f | grep -vE "archimport|svn|git-cvs|email|gitk|git-gui|git-citool" | sed -e s@^$RPM_BUILD_ROOT@@ -e 's/$/*/' ) >> bin-man-doc-files
+(find $RPM_BUILD_ROOT%{_libdir}/python* -type f | sed -e s@^$RPM_BUILD_ROOT@@ -e 's/$/*/' ) >> bin-man-doc-files
 %else
 rm -rf $RPM_BUILD_ROOT%{_mandir}
 %endif
-- 
1.7.0.rc0
