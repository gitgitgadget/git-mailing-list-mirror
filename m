From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Fix installation paths with "make install-doc"
Date: Tue, 12 Feb 2013 14:57:25 -0800
Message-ID: <7vip5xdtt6.fsf@alter.siamese.dyndns.org>
References: <cover.1360700102.git.john@keeping.me.uk>
 <20130212222508.GG12240@google.com> <7vmwv9ducx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 23:57:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5OnQ-00054Y-D3
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 23:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601Ab3BLW53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 17:57:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61317 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752649Ab3BLW52 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 17:57:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5B21B124;
	Tue, 12 Feb 2013 17:57:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MKmHt9sfl6uG4EKukPoxP6LzUAk=; b=HstFKq
	MUsWxQlk+LNM/Fgx0lQh2fBIzUB4lBLkR4XRYxfj+ztRW4oc804FIWhlFjyMxl3Y
	WemQyqImo4Z+5sA5KAMr5E0d5jV2fBDH/LHnxCNmqZ4QqiggASRS6Wp9+znDLaDf
	9Y1bcGppGHhsiD/cKKg8tVZ+9VOglhcD2fj6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I/G32CxKcRDPy+RjhrTow93jaxGRvdXV
	AZAF/s+C2BEXVT4ZDYgSCxDDa5/jG0mN8Xo+PVDMwn9Ruv/S20BhnZ5iD8lAozOB
	pYZVNDhyRl9qHJlq77SvnaUyM2HpljibeXhJJAty+wcPt1VKFfclPu+yFMhM5pMN
	pk00UobOM3g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC5A2B123;
	Tue, 12 Feb 2013 17:57:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31A9EB11F; Tue, 12 Feb 2013
 17:57:27 -0500 (EST)
In-Reply-To: <7vmwv9ducx.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 12 Feb 2013 14:45:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 925C1BDA-7567-11E2-B297-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216215>

Junio C Hamano <gitster@pobox.com> writes:

> I _think_ exporting mandir/html/infodir from the top-level Makefile
> is wrong to begin with.  We should drop the "export mandir" from
> there.

Ah, it is this thing, isn't it?

commit d8cf908cb6012cd4dc3d1089a849daf646150c2e
Author: Junio C Hamano <gitster@pobox.com>
Date:   Sat Feb 2 17:58:49 2013 -0800

    config.mak.in: remove unused definitions
    
    When 5566771 (autoconf: Use autoconf to write installation
    directories to config.mak.autogen, 2006-07-03) introduced support
    for autoconf generated config.mak file, it added an "export" for a
    few common makefile variables, in addition to definitions of srcdir
    and VPATH.
    
    The "export" logically does not belong there.  The make variables
    like mandir, prefix, etc, should be exported to submakes for people
    who use config.mak and people who use config.mak.autogen the same
    way; if we want to get these exported, that should be in the main
    Makefile.
    
    We do use mandir and htmldir in Documentation/Makefile, so let's
    add export for them in the main Makefile instead.
    
    We may eventually want to support VPATH, and srcdir may turn out to
    be useful for that purpose, but right now nobody uses it, so it is
    useless to define them in this file.
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

config.mak.in shouldn't have exported mandir in the first place, and
the commit made it worse by moving that broken export to the main
Makefile, and also added an export to htmldir as well, which was
totally wrong.

Let me revert that bit first.

I still think making "mandir" to have the real path in both the
top-level Makefile and Documentation/Makefile and renaming the
variable that is used to form the -DGIT_MAN_PATH=<path> to
optionally compile in a path relative to an unspecified location
that is discovered at runtime to something else is the sane thing to
do, but that is a separate issue, I think.
