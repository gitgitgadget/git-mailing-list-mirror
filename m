From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Keeping unreachable objects in a separate pack instead of  loose?
Date: Mon, 11 Jun 2012 16:44:29 +0200
Message-ID: <87vcixaoxe.fsf@thomas.inf.ethz.ch>
References: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
	<bb7062f387c9348f702acb53803589f1.squirrel@webmail.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Theodore Ts'o <tytso@mit.edu>, <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>
To: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Mon Jun 11 16:44:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se5rE-0002xU-TC
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 16:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294Ab2FKOod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 10:44:33 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:19158 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754981Ab2FKOod (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 10:44:33 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 11 Jun
 2012 16:44:30 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 11 Jun
 2012 16:44:30 +0200
In-Reply-To: <bb7062f387c9348f702acb53803589f1.squirrel@webmail.uio.no>
	(Hallvard B. Furuseth's message of "Mon, 11 Jun 2012 01:24:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199653>

"Hallvard B Furuseth" <h.b.furuseth@usit.uio.no> writes:

> On Sun, June 10, 2012 14:31, Theodore Ts'o wrote:
>> I recently noticed that after a git gc, I had a huge number of loose
>> objects that were unreachable.  In fact, about 4.5 megabytes worth of
>> objects.
>
> I got gigabytes once, and a full disk.  See thread
> "git gc == git garbage-create from removed branch", May 3 2012.
>
>> When I packed them, via:
>>
>>    cd .git/objects ; find [0-9a-f][0-9a-f] -type f | git pack-objects pack
>>
>> the resulting pack file was 244k.
>>
>> Which got me thinking.... the whole point of leaving the objects loose
>> is to make it easier to expire them, right?   But given how expensive it
>> is to have loose objects lying around, why not:
>>
>> a)  Have git-pack-objects have an option which writes the unreachable
>>     objects into a separate pack file, instead of kicking them loose?
>
> I think this should be the default.  It's very unintuitive that
> gc can eat up lots of disk space instead of saving space.
>
> Until this is fixed, this behavior needs to be documented -
> along with how to avoid it.

Starting with v1.7.10.2, and in the v1.7.11-rc versions, there's a
change by Peff: 7e52f56 (gc: do not explode objects which will be
immediately pruned, 2012-04-07).  Does it solve your problem?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
