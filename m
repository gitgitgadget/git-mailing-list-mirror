From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC 5/5] Support 'master@2 hours ago' syntax
Date: Wed, 17 May 2006 11:32:34 -0700
Message-ID: <7v7j4kec3h.fsf@assigned-by-dhcp.cox.net>
References: <20060517095609.GF28529@spearce.org>
	<7vbqtwhpum.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605170745270.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 20:33:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgQp6-0000YZ-21
	for gcvg-git@gmane.org; Wed, 17 May 2006 20:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWEQSch (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 14:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWEQSch
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 14:32:37 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:31474 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750876AbWEQScg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 14:32:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060517183236.BQLL19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 May 2006 14:32:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20219>

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 17 May 2006, Junio C Hamano wrote:
>> 
>> This does not allow '2006-05-17 00:00:00' as the timespec, and
>> the documentation carefully avoids giving that example, but I
>> think it is better to spell that limitation out.
>
> It doesn't? The "approxidate()" function should handle any reasonable date 
> specifier, and the above is certainly more than reasonable.
>
> Why doesn't approxidate handle it?

The way I read the code is that get_sha1() would first do its
magic at the first colon and feeds get_sha1_1() with prefix up
to the first colon.  This gets passed down to get_sha1_basic()
and what approxidate() is fed is the suffix of that prefix. It
ends up seeing stuff between '@' and ':'.  I.e.

	"master@2006-05-17 00:00:00:cache.h"

would ask for "00:00:cache.h" file in the "master" branch as of
timestamp "2006-05-17 00".
