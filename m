From: david@lang.hm
Subject: Re: metastore
Date: Sun, 16 Sep 2007 13:19:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0709161316310.24221@asgard.lang.hm>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <Pine.LNX.4.64.0709152310380.28586@racer.site>
 <Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm> <7vwsur590q.fsf@gitster.siamese.dyndns.org>
 <85zlzn812s.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 22:20:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX0bI-0002e0-TA
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 22:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbXIPUUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 16:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbXIPUUK
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 16:20:10 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:51422
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbXIPUUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 16:20:09 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l8GKJV1t025477;
	Sun, 16 Sep 2007 13:19:31 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <85zlzn812s.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58342>

On Sun, 16 Sep 2007, David Kastrup wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Yes, I am very well aware that somebody already mentioned "there
>> is a window between the true checkout and permission tweaking".
>> If you need to touch the core level in order to close that
>> window, I am not interested.
>
> Doing this atomically involves creating the file in question by
> specifying the permissions on the creat system call already, and
> possibly wrap seteuid calls and similar around it for getting the
> right file/ownership.
>
> However, it is not really necessary to do this atomically: instead one
> can rather create the file using safe permissions (600) at first, then
> do fchown and fchmod (or chown/chmod) at some point in time afterwards
> as required.

the problem with this in /etc is if you do the wrong file as 600 you can 
cause lots of nasty problems to the system during the window. for some 
files/directories you will want to write the file to a temp name and then 
move the file atomicly to the final location.

git itself shouldn't need to worry about this, the external write routine 
I'm talking about is the correct place for this (at least until all the 
bugs get worked out and everyone is comfortable that everything is good, 
and doesn't impact the core git code badly)

David Lang
