X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rename detection at git log
Date: Mon, 20 Nov 2006 02:07:11 -0800
Message-ID: <7vejry5t4g.fsf@assigned-by-dhcp.cox.net>
References: <200611201157.23680.litvinov2004@gmail.com>
	<200611200951.05529.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 10:07:33 +0000 (UTC)
Cc: git@vger.kernel.org, Alexander Litvinov <litvinov2004@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611200951.05529.andyparkins@gmail.com> (Andy Parkins's
	message of "Mon, 20 Nov 2006 10:50:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31893>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm63a-0004a4-7d for gcvg-git@gmane.org; Mon, 20 Nov
 2006 11:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965555AbWKTKHO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 05:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965556AbWKTKHN
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 05:07:13 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:63481 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S965555AbWKTKHM
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 05:07:12 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061120100711.MFKG9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Mon, 20
 Nov 2006 05:07:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id oy6i1V00m1kojtg0000000; Mon, 20 Nov 2006
 05:06:43 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> On Monday 2006 November 20 05:57, Alexander Litvinov wrote:
>
>> > PAGER=cat git log -M -C --pretty=oneline b/a
>
> I've come across this too.  Personally I'm not sure what use "-C" is.  From 
> the manpage, man git-diff-files (no, this isn't the place I'd look either).

The real issue here is because the b/a on the command line
applies on the input-side, and does not act as the output
filter.  This comes from _very_ early design decision and if you
dig the list archive you will see Linus and I arguing about
diffcore-pathspec (which later died off).

What it means is that "git log" will look at path that matches
b/a (that means b/a/c and b/a/d are looked at, if b/a were a
directory).  Since path "a" which is what the file was
originally at is not something the pattern b/a matches, there is
no way b/a is noticed as a rename from a.

I've been meaning to resurrect Fredrik's --single-follow=path
patch but haven't had time to recently, with all the other
interesting discussion happening on the list.

