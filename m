From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Enable 'check for copy and renames' (-C) also when path filtering
Date: Wed, 16 Aug 2006 14:11:26 -0700
Message-ID: <7vr6zg2xoh.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550608160206w606008ddv2da42ce49e98fa2b@mail.gmail.com>
	<7v8xlo4lht.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550608161349t29a678ccl4b211cb570a1217d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 23:12:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDSfz-0000lW-G7
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 23:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWHPVL3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 17:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWHPVL3
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 17:11:29 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:24000 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932231AbWHPVL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 17:11:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060816211127.SOAQ2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Aug 2006 17:11:27 -0400
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550608161349t29a678ccl4b211cb570a1217d@mail.gmail.com>
	(Marco Costalba's message of "Wed, 16 Aug 2006 22:49:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25529>

"Marco Costalba" <mcostalba@gmail.com> writes:

> On 8/16/06, Junio C Hamano <junkio@cox.net> wrote:
>> "Marco Costalba" <mcostalba@gmail.com> writes:
>>
>> > It seems that -C option of git-diff-tree it works only if the whole
>> > changeset is retrieved.
>>
>> Correct (sort of).  Pathspec works on the input side not on the
>> output side.  It's been specified and worked that way from the
>> beginning (check the list archive to see me arguing that it
>> would be easier to use on the output side, and Linus vetoing
>> because following a single file is not that interesting and the
>> cost outweighs the benefit of that uninteresting case).
>>
>> Always feeding the whole tree is wasteful, but if we are
>> interested in following a single file, we could do something
>> like:
>>
>>  - follow that file and that file only from the recent to past;
>>
>>  - notice when that file disappears -- that is the point the
>>    file was created.  it may have created from scratch, it may
>>    have been renamed or copied.
>>
>>  - on that commit that creates the file, look at the whole tree
>>    to see if we can find an origin.
>>
>>  - if we find that the file was created by renaming or copying
>>    another, keep following that other file from that point on.
>
> Yes, I was thinking about something like this, Thanks for point me out
> this, now I am quite sure it's the correct way to go ;-)

You may want to talk with Fredrik about this.  The above is not
entirely my making but was an outline brought up while we
discussed his "rename following revision walker" on the list
recently. 
