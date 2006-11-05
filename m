X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] Documentation: Two more git-rebase --onto examples
Date: Sat, 04 Nov 2006 17:08:12 -0800
Message-ID: <7vbqnmwvib.fsf@assigned-by-dhcp.cox.net>
References: <200611042205.58212.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 01:08:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611042205.58212.jnareb@gmail.com> (Jakub Narebski's message
	of "Sat, 4 Nov 2006 22:05:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30944>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgWUk-0001Bz-FR for gcvg-git@gmane.org; Sun, 05 Nov
 2006 02:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965770AbWKEBIO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 20:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965771AbWKEBIO
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 20:08:14 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:64642 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S965770AbWKEBIN
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 20:08:13 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061105010813.RMBB2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Sat, 4
 Nov 2006 20:08:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ip8H1V00a1kojtg0000000 Sat, 04 Nov 2006
 20:08:18 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> I asked for comments because I'm not native English speaker and I'm not
> sure about correctness of descriptions of added examples.

Ok.

> +More useful example of --onto option usage include transplanting feature
> +branch from one development branch to other, for example change to branch
> +based off "next" branch:

By "more" do you mean the following examples are more useful
than the one before, or having larger number of examples adds to
the usefulness of the document overall?

How about:

        Here is how you would transplant a topic branch based on one
        branch to another, to pretend that you forked the topic branch
        from the latter branch, using `rebase --onto`.

	First let's assume your 'topic' is based on branch 'next'.

        ------------
            o---o---o---o---o  master
                 \
                  o---o---o---o---o  next
                                   \
                                    o---o---o  topic
        ------------

	We would want to make 'topic' forked from branch
	'master', like this:

> +------------
> +    o---o---o---o---o  master
> +        |            \
> +        |             o'--o'--o'  topic
> +         \
> +          o---o---o---o---o  next
> +------------
> +
> +We can get this using the following command:
> +
> +    git-rebase --onto master next topic
> +
> +
> +Yet another example of use for --onto option is to rebase part of
> +branch. If we have the following situation:

This looks the same as the original example for --onto; I would
either drop it or replace it something of different flavor.

What I find myself doing more is to reorder without using StGIT.
When I have this:

	1---2---3---4 topic

and 2 is a bit half-baked, and I would want to have:

	1---3'--4'--2' topic

I would usually do this while on "topic":

	git tag -f CG	;# "commit goal"
	git rebase --onto CG~3 CG~2 ;# plant 3 4 on top of 1
        git cherry-pick CG~2
	git diff CG ;# verify that the result matches

In ascii art, that is:

	  3'--4'
	 /
	1---2---3---4 CG

then


	  3'--4'--2' topic
	 /
	1---2---3---4 CG
