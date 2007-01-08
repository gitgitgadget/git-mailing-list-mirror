From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Mon, 08 Jan 2007 03:19:48 -0800
Message-ID: <7vbql9ydd7.fsf@assigned-by-dhcp.cox.net>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
	<87ps9xgkjo.wl%cworth@cworth.org>
	<7virfprquo.fsf@assigned-by-dhcp.cox.net>
	<87odphgfzz.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Mon Jan 08 12:19:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3sXh-0005Uv-5u
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 12:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161216AbXAHLTu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 06:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161230AbXAHLTu
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 06:19:50 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:40127 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161216AbXAHLTt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 06:19:49 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070108111948.KSAY2628.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Mon, 8 Jan 2007 06:19:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8bL31W00U1kojtg0000000; Mon, 08 Jan 2007 06:20:04 -0500
To: git@vger.kernel.org
In-Reply-To: <87odphgfzz.wl%cworth@cworth.org> (Carl Worth's message of "Tue,
	02 Jan 2007 15:34:24 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36246>

Carl Worth <cworth@cworth.org> writes:

> On Tue, 02 Jan 2007 14:44:31 -0800, Junio C Hamano wrote:
> ...
>> In any case, I did this because I got tired of waiting for it to
>> happen (I thought you wanted to hack on this over the long
>> week^W yearend, so I deliberately stayed away from doing this)
>> and I was bored.  This will not be in 'next' in the current
>> shape.
> ...
> I don't actually prefer "no commit allowed". I just didn't want the
> user to have to explicitly disable the safety before being able to
> perform a checkout based on a tag.
>
> I am still interested in this feature,...

I decided to fast-track this one.  With a handful fix-ups, this
is now at the tip of 'next'.

The primary difference from the one we discussed, and then has
been sitting in 'pu', is that coming back from the detached HEAD
state is allowed only with '-f' or to a branch that is a
fast-forward of HEAD.

So you can do:

	git checkout v1.2.0 ;# detach
        ... look around ...
        git checkout v1.4.0 ;# still detached
        ... look around ...
        git checkout master ;# Ok, because v1.4.0 is an ancestor of master

but you would be warned and asked to say -f if you do:

        git checkout v1.4.0 ;# detach
        edit ...
        git commit -a -m 'some tweak'
	git checkout master ;# Not Ok -- you may lose that commit.

An alternative exit in this case is to create a new branch at
that point.  So this does work:

        git checkout v1.4.0 ;# detach
        edit ...
        git commit -a -m 'some tweak'
	git checkout -b maint-1.4.0 ;# start the maint-1.4.0 branch

Have fun.
