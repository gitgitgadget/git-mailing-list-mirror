From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Which freedesktop.org "design flaws" in git are still relevant?
Date: Fri, 29 Feb 2008 13:50:46 -0800
Message-ID: <7vmypjbfex.fsf@gitster.siamese.dyndns.org>
References: <51419b2c0802291232w166b3100yabd30ba30df6ef1f@mail.gmail.com>
 <m3hcfrjwnk.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Elijah Newren" <newren@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 22:51:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVD8l-0001Jd-9W
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 22:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761527AbYB2VvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 16:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761503AbYB2VvA
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 16:51:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60335 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761298AbYB2VvA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 16:51:00 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 57FDE1883;
	Fri, 29 Feb 2008 16:50:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8446E1882; Fri, 29 Feb 2008 16:50:51 -0500 (EST)
In-Reply-To: <m3hcfrjwnk.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Fri, 29 Feb 2008 13:11:15 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75570>

Jakub Narebski <jnareb@gmail.com> writes:

>> * git-fetch requires that the branch be named on both sides of
>>   the :. It should treat 'foo' as an alias for 'foo:foo'.
>
> So 'foo' is treated as 'foo:' (which means fetch, and not store), and
> not as 'foo:foo'. It is perhaps a bit strange, but backward
> compatibility would I think prohibit us to change it, even if it would
> make more sense to have it be shortcut for 'foo:foo' instead.

It is not strange nor b/c requirement at all.  If anything, it
could default to "foo:remotes/$remote/foo", not "foo:foo", but
even then, it shouldn't.

You are missing a bigger picture.  I think the list predates the
introduction of separate remotes, which has been the default for
more than a year.

You would have "fetch = refs/heads/*:refs/remotes/origin/*"
these days in the configuration by default.  What this means is
that you would have much less reason to run "fetch $there foo"
to begin with.  The only time you would fetch in that way is
when you want an unconfigured, single-shot fetch, in which case
you do _NOT_ want tracking.  So there is no valid reason to
default "foo" to "foo:<anything>", unless that <anything> is
empty.  Not to foo:foo, not to foo:remotes/$remote/foo.

Many of the remaining parts of the complaint list share the
misunderstanding coming from the lack of understanding of
separate remotes layout.
