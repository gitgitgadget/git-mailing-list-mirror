From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Tue, 29 Jul 2008 17:48:11 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807291738280.3334@nehalem.linux-foundation.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com>  <200807260512.40088.zippel@linux-m68k.org>  <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>  <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain> 
 <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org>  <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>  <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>  <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain> 
 <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org>  <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain> <46a038f90807282015m7ce3da10h71dfee221c960332@mail.gmail.com> <Pine.LNX.4.64.0807291433430.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807291716060.3334@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 02:52:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNzvl-0007tw-H3
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 02:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473AbYG3AvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 20:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753412AbYG3AvZ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 20:51:25 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42142 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753157AbYG3AvY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2008 20:51:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6U0pAUE007016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Jul 2008 17:51:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6U0p9nE030984;
	Tue, 29 Jul 2008 17:51:09 -0700
In-Reply-To: <alpine.LFD.1.10.0807291716060.3334@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.406 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90719>



On Tue, 29 Jul 2008, Linus Torvalds wrote:
> 
>  - But the other huge mistake you make is EVEN MORE STUPID, because it's 
>    so ironic. That magical output you want, and claim is so perfect, and 
>    point out "thus you can still apply as much simplification as you want 
>    on top of it"? You know what? It already _exists_! It's exactly that 
>    --full-history case.

Put in other terms: what you ask for can be fairly trivially done as a 
filter on the _current_ git output (preferably merged into the tool that 
shows it graphically in the first place), with absolutely no downside.

In contrast, if somebody was really so _stupid_ as to go with your output 
format, then yes, he could further simplify it down to the current default 
format, but with a huge performance/interactivity downside.

See? Your preferred format is not actually the "best" format. Not at all. 
Quite the reverse. Your preferred format is much better off being a 
secondary post-processing format exactly because it can be generated from 
one of the primary formats easily enough.

But the reverse isn't true: the current primary formats cannot be 
generated from your preferred format without losing something important 
(performance).

But I'll make you a deal: if you actually write the filter in C form, I 
can pretty much guarantee that we can easily add it as a new flag. It 
really should be pretty easy to integrate it into the revision parsing 
machinery alongside --topo-order, since it's really the same kind of 
operation.

In fact, it's possible that the current --topo-order sorting could 
possibly be made to just do the simplification (conditionally, of course, 
since it has the latency problem). See the function

	void sort_in_topological_order(struct commit_list ** list, int lifo)

in commit.c - that's where it would hook in.

		Linus
