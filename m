From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.6.4-rc2
Date: Fri, 24 Jul 2009 10:49:01 -0700
Message-ID: <7vk51ykm42.fsf@alter.siamese.dyndns.org>
References: <7vd47r298e.fsf@alter.siamese.dyndns.org>
 <20090724093847.GA20338@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mattias Nissler <mattias.nissler@gmx.de>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jul 24 19:49:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUOtY-000115-Ir
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 19:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbZGXRtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 13:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbZGXRtO
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 13:49:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53419 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbZGXRtN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 13:49:13 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C488E104FC;
	Fri, 24 Jul 2009 13:49:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 535CA104FB; Fri, 24 Jul 2009
 13:49:06 -0400 (EDT)
In-Reply-To: <20090724093847.GA20338@dcvr.yhbt.net> (Eric Wong's message of
 "Fri\, 24 Jul 2009 02\:38\:48 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4B9EC712-787A-11DE-8954-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123933>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>>  * git-svn updates, including a new --authors-prog option to map author
>>    names by invoking an external program, 'git svn reset' to unwind
>>    'git svn fetch', support for more than one branches, etc.
>
> I completely forgot the implications of a change made in commit
> 0b2af457a49e3b00d47d556d5301934d27909db8.  This change probably doesn't
> affect a lot of repos out there, but --minimize-url is no longer the
> default for new imports.
>
>
> The good thing is that access-limited repositories are easier to setup
> and import.  So if you only had access for a sub_project under the
> repository root in svn://example.com/big_project/sub_project,
> you won't need read permissions to / or /big_project, just
> /big_project/sub_project and everything under it.
>
>
> Unfortunately, this default breaks the case where a project is moved to
> a lower-level within the repository:
>
> svn://example.com/foo => svn://example.com/big_project/sub_project
>
> Without --minimize-url enabled, your clone would register
> "/big_project/sub_project" to track and not be able to find the history
> of "/foo".  With --minimize-url (the old behavior), you would've
> registered "/" to be able to track all subdirectories underneath the
> repository root (assuming the SVN repo is world-readable).
>
>
> While both cases are fairly rare, I've personally encountered the latter
> (and now broken-by-default) case more.  This is because I mainly use
> git/git svn to work on free software without read restrictions.
> However, with more and more free projects switching entirely to git,
> maybe leaving the default to be more friendly to people on restrictive
> setups will be more helpful than harmful.
>
> This change only affects the creation of new clones, existing repos
> are unaffected.
>
> Let me know if the above made sense, it's late and I nodded off
> several times while writing this.

Your description makes sense, and I suspect that the old default may be
easier to work with.

Minimally, a patch to git-svn.txt and RelNotes-1.6.4.txt in Documentation/
to describe the situation with a recipe (in the former) to allow people
the older behaviour would be in order.  It appears minimize-url is not
even documented as far as I can see in the current documentation set.
