From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9010: svnadmin can fail even if available
Date: Thu, 06 Jan 2011 12:16:18 -0800
Message-ID: <7vpqs9aiul.fsf@alter.siamese.dyndns.org>
References: <4D25E818.5050909@gmail.com> <20110106165958.GA11190@burratino>
 <4D25F9C5.6030503@gmail.com> <20110106180051.GC11346@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 21:16:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PawGD-0004U9-TO
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 21:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745Ab1AFUQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 15:16:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab1AFUQa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 15:16:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D8F662522;
	Thu,  6 Jan 2011 15:17:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o6LC+XAC+c63AwwK4gPxU1goeac=; b=cY0LOh
	zJpXKPxGLBPRWTvejUxanjPcu5OaBmhoAQcpvKlIdCVrxMmLRWbRNYt5qRLE5A+l
	IZRiN7DN93fhfKKnuK+2hfnTrFup1VIw6zla01pQykJ5COchuOXUhf93JBJDktOi
	2MQs/FAtC+WHwDlpmDHNc05dGP/qS7mWWTlFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uWz6ZU90gmsZj7JgDEWtMhwHPLRah+Di
	yKG8dg/eJt5St9vtmMygk6ydRhe4FPr3amV1Jb3LxWJtDQZkg/YOYwxCeloWZ555
	WsaQQEWaTljgvZV6OGsz08JHL9AVw5sXY5KlE9mfQNbFmwwkU8TLeznfpRB2JcdT
	E/yzc1L9mF4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A64632520;
	Thu,  6 Jan 2011 15:17:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 758B8251F; Thu,  6 Jan 2011
 15:16:57 -0500 (EST)
In-Reply-To: <20110106180051.GC11346@burratino> (Jonathan Nieder's message of
 "Thu\, 6 Jan 2011 12\:00\:51 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EBD2A22C-19D1-11E0-A3AE-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164666>

Jonathan Nieder <jrnieder@gmail.com> writes:

> If svn is built against one version of SQLite and run against
> another, svnadmin (needlessly) errors out during t9010:
>
>  <<< Started new transaction, based on original revision 1
>       * adding path : branches ... done.
>       * adding path : trunk ... done.
>  svnadmin: Couldn't perform atomic initialization
>  svnadmin: Couldn't perform atomic initialization
>  svnadmin: SQLite compiled for 3.7.4, but running with 3.7.3
>
> Work around this by putting the svn invocations into a single test
> that builds a repo to compare the test-svn-fe result against.  This
> test would always pass but only set the new SVNREPO test prereq if svn
> succeeds; and the test using that repo gets an SVNREPO prerequisite so
> it only runs with working svn installations.
>
> This seems like the right thing to, anyway: the test script is meant
> to test the version of git just built, not the installed svn.

Yes, and I understand that this will prevent the mailing list from getting
spammed by useless "bug reports" that should have been directed to distros
that packaged broken subversion, which is a plus.

But I am somewhat unhappy because I do not think we want to cater to all
the broken installations of system tools.  When tests fail because
somebody's "mkdir -p" (just a random example I picked from your patch)
does not work correctly, we would just say "Your system is broken, and
here is a nickle; get a better computer".  Why is svnadmin so special?

Also isn't the breakage not just this test, but also in all the tests that
try to run "svnadmin load"?  Shouldn't we somehow hoist this logic out of
t9010 and put it in t/lib-vcs-svn.sh or somewhere?

As far as I understand, svn interoperability bits (git-svn and vcs-svn) do
not rely on svnadmin at runtime, so a breakage in the system's svnadmin
would not be a reason to omit building and installing them.  It however
somehow feels wrong to install something we cannot even test.  I do not
have a good solution to this offhand, though.
