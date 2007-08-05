From: David Kastrup <dak@gnu.org>
Subject: Re: possible bug in git apply?
Date: Sun, 05 Aug 2007 20:50:34 +0200
Message-ID: <853ayxiznp.fsf@lola.goethe.zz>
References: <Pine.LNX.4.64.0708041243070.6905@asgard.lang.hm>
	<alpine.LFD.0.999.0708042141510.5037@woody.linux-foundation.org>
	<7vvebuh8g8.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0708050949220.5037@woody.linux-foundation.org>
	<85hcndj2b5.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708051106020.5037@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, david@lang.hm,
	git@vger.kernel.org, rob@landley.net
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 20:51:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHlBs-0002Kd-MD
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 20:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758874AbXHESuj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 14:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758878AbXHESuj
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 14:50:39 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:34277 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758874AbXHESui (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 14:50:38 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id C1EA615C375;
	Sun,  5 Aug 2007 20:50:36 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id B070F2D29B9;
	Sun,  5 Aug 2007 20:50:36 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-057-031.pools.arcor-ip.net [84.61.57.31])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 6AB5E36E868;
	Sun,  5 Aug 2007 20:50:36 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 405AC1C3D500; Sun,  5 Aug 2007 20:50:34 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0708051106020.5037@woody.linux-foundation.org> (Linus Torvalds's message of "Sun\, 5 Aug 2007 11\:18\:19 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55054>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 5 Aug 2007, David Kastrup wrote:

[...]

>> > That said, if we really wanted to get it right, we should do this as
>> > a three-phase thing: (1) remove old files (2) create new files (3)
>> > for all removals and renames, try to remove source directories that
>> > might have become empty.
>> >
>> > That would fix it properly and for all cases.
>> 
>> Stupid question from someone without good background: why do we need
>> two passes in the first place?
>
> For example, a patch that removes a directory structure "x/..." and then 
> creates a file "x" in its place.
>
> In order for the patch ordering to not matter, you want to do the
> "remove old state" in an earlier phase.

But your proposed three passes won't work with a patch removing
"x/..."  and creating "x" in its place, since "x/" gets only removed
in pass 3, and "x" needs to created in pass 2 already.

If you had bothered reading my mail to the end: I explained exactly
that.  So your three pass scheme actually breaks the case for which
the two-pass scheme has been designed.

I propose you read my previous mail to its end: I explain a scheme
that will work in this case, but it would, as far as I understand
index processing, necessitate changing the index sort order, basically
having -depth order for deletion entries.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
