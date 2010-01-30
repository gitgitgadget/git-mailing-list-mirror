From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] rpm packaging failure
Date: Sat, 30 Jan 2010 09:10:14 -0800
Message-ID: <7vsk9nsemh.fsf@alter.siamese.dyndns.org>
References: <7v8wbgueqz.fsf@alter.siamese.dyndns.org>
 <20100130151921.GM29188@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 18:10:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbGqB-0002JZ-Nl
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 18:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371Ab0A3RK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 12:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752324Ab0A3RK3
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 12:10:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab0A3RK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 12:10:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D9C5395013;
	Sat, 30 Jan 2010 12:10:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=q5zVR1gilw5d88tXWX84PJ9Rock=; b=u4T6cHDMARqb3RW8KlmZbZG
	rHdEhj4fJO+fUD6N6aq/hB7bBrxjRilRbp4K9BIUzkFNdjaYg9P7bROwJS+urzxm
	D6bU6c5QprPjuMFNHieUxe6Iqpog2+sqIMCqCqmO2fYEZo1GDZwPX8NwiEUWbvwY
	UqiLaG1nhgs0lRmB86jQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=rMf5EZ91wddLaDVWNvviPRVjVsPWExqA00UTfjUQiORYA/1Px
	hGs+eAIFThh1ElWorNs9Na5FwbpEuUJxbM60qYmiv2MjKTZHwBUoIdKDXO2ZSCiu
	SCkDAkQrN1RvsS6Kdh5kyS73RHBi1PIFleB1fV3Y9f/KkzNTPR5+yyQU3U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A7E695012;
	Sat, 30 Jan 2010 12:10:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1B1395011; Sat, 30 Jan
 2010 12:10:15 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 589F13F8-0DC2-11DF-B099-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138486>

Todd Zullinger <tmz@pobox.com> writes:

> Junio C Hamano wrote:
>> Here is an attempt to fix it, but help is very appreciated, as I don't
>> know what the accepted way is to ship Python modules is in the RPM world.
>
> Perhaps this will work well.  I only tested it on Fedora 10, but I
> believe it should work on RHEL/CentOS and most other rpm-based
> distros.  We may well want to package the python bits in a subpackage,
> much as the perl modules are.  Anyone have thoughts on that?

Thanks.

The files that are problematic are only infrastructure bits to support
"remote helpers written in Python" (which we don't ship at all yet).

Once we start shipping real remote helpers, separating Python bits out
into its own package would make a lot of sense.  People who want to use
foreign scm helpers that happen to be written in Python would need it, and
all others don't.

But I suspect that a safer alternative at least for 1.7.0 would be to
leave these files out altogether.  As I understand the current state, it
is an unused but required package dependency on Python, a downside without
an upside.  Is it Ok with "remote helpers in Python" folks (I think Sverre
and Johan are principal parties), or did I miss some reason that these
need to be installed/installable, perhaps to support third party packages
that already exist?

And if the removal is the way to go for 1.7.0, is the following an Ok
approach to do that removal (this is asking an RPM help again to Todd)?



 git.spec.in |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index ab224f7..ec3451a 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -112,6 +112,7 @@ rm -rf $RPM_BUILD_ROOT
 make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" DESTDIR=$RPM_BUILD_ROOT \
      %{path_settings} \
      INSTALLDIRS=vendor install %{!?_without_docs: install-doc}
+rm -fr $RPM_BUILD_ROOT%{_libdir}/python*
 find $RPM_BUILD_ROOT -type f -name .packlist -exec rm -f {} ';'
 find $RPM_BUILD_ROOT -type f -name '*.bs' -empty -exec rm -f {} ';'
 find $RPM_BUILD_ROOT -type f -name perllocal.pod -exec rm -f {} ';'
@@ -190,6 +191,9 @@ rm -rf $RPM_BUILD_ROOT
 # No files for you!
 
 %changelog
+* Sat Jan 30 2010 Junio C Hamano <gitster@pobox.com>
+- We don't ship Python bits until a real foreign scm interface comes.
+
 * Mon Feb 04 2009 David J. Mellor <dmellor@whistlingcat.com>
 - fixed broken git help -w after renaming the git-core package to git.
 
