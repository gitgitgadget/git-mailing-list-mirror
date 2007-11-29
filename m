From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] rebase -i: give rerere a chance
Date: Thu, 29 Nov 2007 10:59:12 +0100
Message-ID: <85y7ch5q4v.fsf@lola.goethe.zz>
References: <7vlk8q7hzg.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711221117590.27959@racer.site>
	<7v7ik129d4.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711290021280.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 29 10:59:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxgBC-0001ed-0M
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 10:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757696AbXK2J7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 04:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758057AbXK2J7O
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 04:59:14 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:48179 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757696AbXK2J7N (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Nov 2007 04:59:13 -0500
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 5DC4315C6D6;
	Thu, 29 Nov 2007 10:59:11 +0100 (CET)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 3951F345BE8;
	Thu, 29 Nov 2007 10:59:11 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-009-099.pools.arcor-ip.net [84.61.9.99])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id BECAF29D4E4;
	Thu, 29 Nov 2007 10:58:56 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 2A82C1C4D3AA; Thu, 29 Nov 2007 10:59:12 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.0711290021280.27959@racer.site> (Johannes
	Schindelin's message of "Thu, 29 Nov 2007 00:22:34 +0000 (GMT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4948/Wed Nov 28 21:42:33 2007 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66522>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Wed, 28 Nov 2007, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > @@ -166,13 +167,13 @@ pick_one_preserving_merges () {
>> >  			msg="$(git cat-file commit $sha1 | sed -e '1,/^$/d')"
>> >  			# No point in merging the first parent, that's HEAD
>> >  			new_parents=${new_parents# $first_parent}
>> > -			# NEEDSWORK: give rerere a chance
>> >  			if ! GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
>> >  				GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
>> >  				GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
>> >  				output git merge $STRATEGY -m "$msg" \
>> >  					$new_parents
>> >  			then
>> > +				git rerere
>> 
>> This comment is not about this rerere change, but output is a shell
>> function and I vaguely recall we had a discussion on "VAR=VAL cmd" form
>> of single-shot export not working for them as expected...
>
> Hmm.  What do you propose?  In the long run, I _want_ to have rebase as a 
> builtin, which would solve this problem, probably.  But in the short run?

Well, something like

if ! ( GIT_xxx=A; export GIT_xxx; output git merge ... )

should likely work.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
