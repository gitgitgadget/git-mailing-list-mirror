X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Do not ignore hidden refs
Date: Sun, 19 Nov 2006 01:48:17 +0100
Message-ID: <20061119004817.GT7201@pasky.or.cz>
References: <20061118041137.6064.75827.stgit@machine.or.cz> <7v8xi9fjw9.fsf@assigned-by-dhcp.cox.net> <20061118045323.GK7201@pasky.or.cz> <7vzmapdxki.fsf@assigned-by-dhcp.cox.net> <20061118192830.GP7201@pasky.or.cz> <7vejs0cz5s.fsf@assigned-by-dhcp.cox.net> <7vy7q8bjwn.fsf@assigned-by-dhcp.cox.net> <20061118231842.GS7201@pasky.or.cz> <7vmz6o9t3s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 19 Nov 2006 00:48:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vmz6o9t3s.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31818>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlarC-0007JX-9Z for gcvg-git@gmane.org; Sun, 19 Nov
 2006 01:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755463AbWKSAsU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 19:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755467AbWKSAsT
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 19:48:19 -0500
Received: from w241.dkm.cz ([62.24.88.241]:24294 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1755463AbWKSAsS (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 19:48:18 -0500
Received: (qmail 26824 invoked by uid 2001); 19 Nov 2006 01:48:17 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Sun, Nov 19, 2006 at 01:29:27AM CET, Junio C Hamano wrote:
> My understanding of your original plan was to use ".foo" as
> a private thing for Cogito to use to implement some cleverness
> when the user talks about the branch "foo" (just like StGIT
> uses "refs/bases/foo" to keep track of its private stuff related
> to user branch "foo").  When the user says "my 'foo' branch",
> you were going to munge that name into ".foo" and use both to
> implement that cleverness (just like StGIT uses "refs/bases/foo"
> in addition to "refs/heads/foo" when the user is talking about
> his branch "foo").

(Not a plan, that's what I do now. ;-)

Yes, that's correct, but it's not what I'm talking about anymore - sorry
for the confusion. The proper solution for this is of course to move
this around in the refs/ hierarchy out of heads to a more suitable
place. I'm going to do that in few moments.

What I'm talking about now are _real_ user-visible and user-created
refs, which should however stay local to the repository the user created
them in.

> I would rather think that it would actively be a bad thing to
> make the core level to consider heads/private/foo and heads/foo
> ambiguous.  When the user says "my 'foo' branch" that should
> mean the "foo" branch not the "private/foo" branch.
> 
> Which certainly suggests that heads/private/, as a user visible
> convention to keep developer-repository private stuff for local
> use, is too verbose.

I don't think the automatic lookup of the branch with private/ prepended
is too bad a thing, but if you have a better solution...

> StGIT's use of refs/bases (i.e. outside refs/heads) is probably
> sensible because it is not something the end user should
> directly muck with nor check out.  If Porcelains want some
> "special branch" for their own use to do their magic, however,
> the ref cannot be outside refs/heads for it to be pointed at by
> HEAD to become the "current branch" ("bisect" command comes to
> mind, and I suspect "cg-seek" would have similar issues).  But
> that kind of use is all under controll of the Porcelain, and I
> would imagine "too long to type" objection would not apply.

Yes, but what I have on mind are branches the _user_ wants to declare as
local.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
