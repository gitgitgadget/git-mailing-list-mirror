X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/n] gitweb: Secure against commit-ish/tree-ish with the same name as path
Date: Wed, 01 Nov 2006 17:01:51 -0800
Message-ID: <7vac3awtj4.fsf@assigned-by-dhcp.cox.net>
References: <200610301953.01875.jnareb@gmail.com>
	<200610311753.20711.jnareb@gmail.com>
	<7vejsoovxu.fsf@assigned-by-dhcp.cox.net>
	<200611010140.56834.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 01:02:05 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30677>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfQxx-0005AA-J2 for gcvg-git@gmane.org; Thu, 02 Nov
 2006 02:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752433AbWKBBBy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 20:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752620AbWKBBBy
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 20:01:54 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:16579 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1752433AbWKBBBx
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 20:01:53 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061102010152.QIDG16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Wed, 1
 Nov 2006 20:01:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id hd1w1V00a1kojtg0000000 Wed, 01 Nov 2006
 20:01:57 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

>> [PATCH/RFC 1/n] gitweb: Better git-unquoting and gitweb-quoting of p...
>> 
>> Marked preliminary, perhaps need some discussion and rerolling
>> but I haven't looked at it.
>
> I'm not sure if without this patch (well, the unquote part) gitweb
> can work with filenames which git quotes using escape sequences,

I am reasonably sure it wouldn't, and it sounded like you wanted
to fix it better than the preliminary one, so I think we are in
agreement.

>> [PATCH 2/n] gitweb: Use '&iquot;' instead of '?' in esc_path
>> 
>> Discussed; we agreed that showing byte values in different
>> colors is preferable.  Waiting for re-roll.
>
> The problem with using text color or background color is that
> the filenames tends to be shown with different color and background
> color: "tree" view, parts of difftree, parts of diff header, etc.
> Perhaps text-decoration: overline;? Just kidding...

Use of overstrike may actually not be a bad thing.  It _is_
unusual situation after all.

>> [PATCH 3/n] gitweb: Use 's' regexp modifier to secure against filena...
>> 
>> I looked at it although haven't said anything yet.  Probably a
>> safe and good change but I wonder how LF at the end of the line
>> matches /...(.+)$/s pattern; iow, if we do not use -z does it
>> still do the right thing?  Otherwise I suspect you would perhaps
>> need to chomp?
>
> We always pass chomped lines. First chunk is unnecessary (we care only
> for type), without second "tree" view look strange for files with
> embedded newline in filename.

The codepath affected by the first chunk does not chomp, which
was what I was referring to.  So in the meantime will apply only
the second hunk.

>> [PATCH 4/n] gitweb: Secure against commit-ish/tree-ish with the same...
>> 
>> Good fix and even improves readability; will apply after
>> dropping -- from ls-tree args.

I just applied this.  I'll be pushing out a "master" update
sometime today, and do not expect to be able to get to your "n
turned out to be ten" series, so it might be worthwhile to
reroll the remaining bits that you still care about on top of
what I push out tonight to make sure we are on the same page.

Preferably:

 - you should avoid making a series out of more-or-less
   unrelated things;

 - if you are doing related things in one series, do not send
   half-baked early parts out until you are finished and are
   confident with it.  If you do not know how many patches you
   need to complete that logically single topic yet, that is a
   sure sign that you are not done.  Instead, finish writing and
   testing it, and if your test finds an earlier mistake,
   especially a trivial one, go back and fix it in the earlier
   patch in the series.  Everybody makes mistakes so fixing up
   before submission is a norm, and other people do not have to
   be forced to see your "oops" in the development history.

Thanks.
