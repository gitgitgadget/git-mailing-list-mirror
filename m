From: Eric Wong <normalperson@yhbt.net>
Subject: Re: v1.5.4 plans
Date: Wed, 12 Dec 2007 10:40:22 -0800
Message-ID: <20071212184022.GB28377@untitled>
References: <7vy7d43ptc.fsf@gitster.siamese.dyndns.org> <7vabpg9x5k.fsf@gitster.siamese.dyndns.org> <7vy7cwsi3p.fsf@gitster.siamese.dyndns.org> <7vk5o6jbq9.fsf@gitster.siamese.dyndns.org> <7v63zjgoel.fsf@gitster.siamese.dyndns.org> <7vsl2i6ea4.fsf@gitster.siamese.dyndns.org> <7vhcixtnm4.fsf@gitster.siamese.dyndns.org> <7vfxye4yv7.fsf@gitster.siamese.dyndns.org> <7vve78qhtf.fsf@gitster.siamese.dyndns.org> <7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	"David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Wed Dec 12 19:42:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2WX1-0000jI-5m
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 19:42:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755846AbXLLSkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 13:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756124AbXLLSkZ
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 13:40:25 -0500
Received: from hand.yhbt.net ([66.150.188.102]:57786 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755700AbXLLSkX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 13:40:23 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 935947DC025;
	Wed, 12 Dec 2007 10:40:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68084>

Junio C Hamano <gitster@pobox.com> wrote:
> People might have noticed that I've been ignoring most of the new
> topics/enhancements for the past few days.  Here is what I want to see
> happen until we declare v1.5.4.
> 
> First, stabilize 'master' enough and tag v1.5.4-rc0 soon.

>  * Eric's sanely-compact mapping from SVN rev-ids to git commits saw a
>    positive feedback.  I haven't carefully read that patch but it seemed
>    sane and I'd like to have it in v1.5.4.

It's looking good for most users, I think it's safe enough for 1.5.4

>  * I've seen t9119-git-svn-info.sh fail in my k.org private repository
>    and have been skipping the test, but this needs to be diagnosed and
>    fixed [*1*].  It could be just that the code is fine and the test is
>    not rejecting SVN that is too-old. I dunno.

I wouldn't mind dropping this test for now.

100% output compatibility with SVN is too difficult to achieve
and IMHO not worth it for commands like `info' and `log'.

David:

I also noticed some race-conditions on this test when running this on my
Centrino laptop (my fastest box, but I rarely use it for git
development) and having git on my USB thumb drive.  I'm pretty sure
these were caused by inconsistencies in handling timestamps on symlinks
vs timestamps on the files they link to.

> *1* t9119 first fails at the 6th test.  Perhaps the test needs to check
> svn version first and stop testing this feature.  This test does not
> fail on my personal box that has svn 1.4.2.
> 
> * expecting success:
>         (cd svnwc; svn info file) > expected.info-file &&
>         (cd gitwc; git-svn info file) > actual.info-file &&
>         git-diff expected.info-file actual.info-file
> 
> diff --git a/expected.info-file b/actual.info-file
> index b1d57f4..997c927 100644
> --- a/expected.info-file
> +++ b/actual.info-file
> @@ -10,6 +10,5 @@ Last Changed Author: junio
>  Last Changed Rev: 1
>  Last Changed Date: 2007-12-10 22:18:12 +0000 (Mon, 10 Dec 2007)
>  Text Last Updated: 2007-12-10 22:18:13 +0000 (Mon, 10 Dec 2007)
> -Properties Last Updated: 2007-12-10 22:18:13 +0000 (Mon, 10 Dec 2007)
>  Checksum: 5bbf5a52328e7439ae6e719dfe712200
> 
> * FAIL 6: info file
> 
>                 (cd svnwc; svn info file) > expected.info-file &&
>                 (cd gitwc; git-svn info file) > actual.info-file &&
>                 git-diff expected.info-file actual.info-file
> 
> : hera t/master; svn --version
> svn, version 1.3.2 (r19776)

-- 
Eric Wong
