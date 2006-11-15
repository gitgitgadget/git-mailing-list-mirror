X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 14 Nov 2006 20:33:03 -0800
Message-ID: <7vd57ps51c.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org> <20061114194707.GH7201@pasky.or.cz>
	<87d57pu4qa.wl%cworth@cworth.org>
	<7v3b8lv9c9.fsf@assigned-by-dhcp.cox.net>
	<20061115040852.GL7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 04:33:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061115040852.GL7201@pasky.or.cz> (Petr Baudis's message of
	"Wed, 15 Nov 2006 05:08:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31413>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkCSU-00023m-FQ for gcvg-git@gmane.org; Wed, 15 Nov
 2006 05:33:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966583AbWKOEdH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 23:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966586AbWKOEdG
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 23:33:06 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:55685 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S966583AbWKOEdF
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 23:33:05 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115043304.YSSH18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Tue, 14
 Nov 2006 23:33:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id msZA1V00m1kojtg0000000; Tue, 14 Nov 2006
 23:33:11 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> On Wed, Nov 15, 2006 at 01:31:50AM CET, Junio C Hamano wrote:
>> 
>> I am of two minds here.
>> 
>> I do not think the Porcelain-ish UI that is shipped with git
>> should be taken with the same degree of "authority" as git
>> Plumbing.
> ..snip passage about workflows..
>
> Controversy's fun, so...
>
> <Cogito maintainer hat _off_> (But yeah, it still looks silly that I'm
> saying this.)

It appears that you are not grumpy as you were anymore ;-).  I
mostly agree with what you said in your message.

> (i) Clearly divided porcelain/plumbing interface, so that you can
> really isolate the two UI-wise; endless confusion reigns there now. Is
> git-update-index porcelain or plumbing? _You_ call git-merge a proper
> porcelain? From my perspective, git-update-ref is as plumbing as it
> gets, but it's classified as porcelain. Etc, etc. This would be by far
> the most important advantage.

Yes.  The current "merge" started its life as Linus's porcelain
(we did not have fetch and pull infrastructure back then) but
quickly has become just a helper for pull to produce a merge
commit.  If anybody thinks its UI is good as a general end-user
level command, there is a need for "head examination".

As you say, update-ref is as plumbing as it gets and it should
not be listed as Porcelain; I am a bit surprised that it is
labelled as such myself.

No disagreement here, nor (ii) nor (iii).

>   (ii) The plumbing and porcelain would not share the same namespace,
> leading to clearer UI. (I'm just inflating (i).)
>
>   (iii) The documentation would not be a strange mix of porcelain and
> plumbing. (More (i) inflation.)
>
>   (iv) (i) is troublesome because I have a feeling that Junio declared
> several times that he doesn't care that much about stable API for
> porcelain compared to the plumbing. But with the current mix it's
> desirable to use some porcelain even in other porcelains and in scripts.

This is true and it is a problem.

While we encourage Porcelain writers to use plumbing in order to
give git Porcelain-ish more freedom to evolve to give better UI
for humans, not having a clear distinction between the two makes
it harder.

>   (v) Git would be properly libified by now. If you wanted to convert
> bits of porcelain to C, it would be at least much higher priority.

I am not sure about "libified" part and I do not know what bits
of porcelain wants to become C right now.  But I do not think
this point is important part of your list.

>   (vi) You wouldn't need to make the gruesome choice on what is the
> canonical workflow the _the_ Git porcelain supports (see the snipped
> passage). Or you would, but it would have less impact.

Yes.  This is really important.

Linus and me having done Porcelain-ish that supports integrator
role workflow better than other workflows such as contributor
role should not discourage people from working on alternative or
complementary Porcelains to help other workflows better (see the
snipped passage).

StGIT sets a great example, and efforts like it is encoraged
more.

I think both Linus and myself tried to make it clear that the
purpose of Porcelain-ish that comes with core git is 50% to make
plumbing (perhaps minimally) usable and the other 50% to serve
as an example for Porcelain writers to learn how to use the
plumbing, but we should probably have stressed the latter
better.
