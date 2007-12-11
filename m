From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Building git-1.5.3.7 on HP-UX 11.00
Date: Tue, 11 Dec 2007 00:26:48 -0800
Message-ID: <7vfxy9fxh3.fsf@gitster.siamese.dyndns.org>
References: <20071204130922.731c407a@pc09.procura.nl>
	<Pine.LNX.4.64.0712041343040.27959@racer.site>
	<20071204140326.14d9e7a0@pc09.procura.nl>
	<Pine.LNX.4.64.0712041439590.27959@racer.site>
	<20071204150102.7f3ec3e9@pc09.procura.nl> <47556EE2.6040105@op5.se>
	<20071204152240.6cb6018e@pc09.procura.nl>
	<Pine.LNX.4.64.0712041536180.27959@racer.site>
	<20071204155655.053f4fb4@pc09.procura.nl>
	<7vve7e49or.fsf@gitster.siamese.dyndns.org>
	<20071210145123.7c34af6d@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Dec 11 09:27:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J20T3-0001eL-DM
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 09:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbXLKI1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 03:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbXLKI1L
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 03:27:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbXLKI1J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 03:27:09 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D1D844FC;
	Tue, 11 Dec 2007 03:27:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C213E44E4;
	Tue, 11 Dec 2007 03:26:50 -0500 (EST)
In-Reply-To: <20071210145123.7c34af6d@pc09.procura.nl> (H. Merijn Brand's
	message of "Mon, 10 Dec 2007 14:51:23 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67824>

"H.Merijn Brand" <h.m.brand@xs4all.nl> writes:

> Summary of the changes:
>
> 1 Added a section for HP-UX in the Makefile. Note that this will
>   cover most of HP-UX, but might need several changes for both
>   newer HP-UX versions and 64bit environments. Will come to that
>   once I've got it all running
>
> 2 HP-UX does not have <sys/select.h>. I mentioned this before

Unfortunate.  It is even in POSIX.
But nothing "make -DNO_SYS_SELECT=Unfortunately" cannot fix.

> 3 I am willing to believe that HP_UX' vsnprintf () is broken, or
>   at least does not conform to the expectations in the GNU world,
>   but chickening out like the way strbuf_addf () does is maybe a
>   bit too rude, so I forced a minimum of 64bytes available. That
>   fixes a lot!
>
>   but it still breaks t4013 :(

I think Shawn had something similar for Solaris, and if it is a small
cost to help portability, it does not feel so bad.

> 4 'tr' doesn't like '\0', but wants '\000' instead.
> 5 'tr' cannot deal with character classes

Ok, that's odd (and not old fashioned, which makes even odder), but
"\000" is not too bad (unless we have to do that million places).

> 6 I don't know how to attack another HP specific problem: HP has
>   a system command called 'patch' and it is *very* incompatible
>   with GNU patch. Very.

I do not think there is any reason for us to rely on "GNU patch"
anymore.  4109 can have precomputed test vector instead of comparing our
output with what GNU patch of the day happens to do.

> 7 What do you expect for LOCALE's?

I am not opposed to a change that makes these tests to conditionally
skip on systems (not necessarily "platforms" but individual
"installations") that do not have locales necessary to run tests
installed, just like cvs or svn tests are skipped when they are not
installed.  Especially you are not using iconv...

> + git-index-pack -o tmp.idx test-2-7f8ead892057e78576c0329a70cc83afb113f117.pack
> fatal: serious inflate inconsistency

That sounds like a broken zlib X-<.
