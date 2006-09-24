From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
Subject: Re: [PATCH] Fixes git-cherry algorithmic flaws
Date: Sun, 24 Sep 2006 21:43:50 +0300 (EEST)
Message-ID: <Pine.LNX.4.58.0609242104080.32175@kivilampi-30.cs.helsinki.fi>
References: <Pine.LNX.4.58.0608071328200.22971@kivilampi-30.cs.helsinki.fi>
 <20060924000051.GI20017@pasky.or.cz> <7virjem3tp.fsf@assigned-by-dhcp.cox.net>
 <20060924111737.GL20017@pasky.or.cz> <7vodt59mxa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>,
	"Ilpo =?iso-8859-1?Q?J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 20:44:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRYxT-0002jJ-VU
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 20:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbWIXSoE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 14:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbWIXSoD
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 14:44:03 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:35795 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1752138AbWIXSoB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 14:44:01 -0400
Received: from kivilampi-30.cs.helsinki.fi (kivilampi-30.cs.helsinki.fi [128.214.9.42])
  (AUTH: PLAIN cs-relay, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by mail.cs.helsinki.fi with esmtp; Sun, 24 Sep 2006 21:43:59 +0300
  id 000ACFD8.4516D1EF.000079A3
Received: by kivilampi-30.cs.helsinki.fi (Postfix, from userid 50795)
	id 6DB0AEB2E3; Sun, 24 Sep 2006 21:43:59 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
	by kivilampi-30.cs.helsinki.fi (Postfix) with ESMTP id 51E03EAA27;
	Sun, 24 Sep 2006 21:43:59 +0300 (EEST)
X-X-Sender: ijjarvin@kivilampi-30.cs.helsinki.fi
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodt59mxa.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27689>

On Sun, 24 Sep 2006, Junio C Hamano wrote:

> Petr Baudis <pasky@suse.cz> writes:
> 
> > Hmm, well, what's curious is that the documentation says
> >
> > 	Every commit with a changeset that doesn't exist in the other branch
> > 	has its id (sha1) reported, prefixed by a symbol.  Those existing only
> > 	in the <upstream> branch are prefixed with a minus (-) sign, and those
> > 	that only exist in the <head> branch are prefixed with a plus (+)
> > 	symbol.
> >
> > which is in contradiction of Ilpo's description of the old algorithm
> > (and also your description of it). It would seem he just wants to fix it
> > according to the documented behaviour.
> >
> > I guess the documentation is what's broken then?
> 
> Ah I did not realize that, but yes the documentation is
> incorrect.

I was going to do a same conclusion but didn't send it just yet... :-) I 
found out what the documentation says when looking a tool to do a job. 
Then I wonder how such obvious bug could have passed unnoticed... Of 
course I have no clue what the "original purpose" is supposed to be... 
;-) Then I "fixed" it and as it is _so easy_ to send patches with git I 
thought I could contribute the "fix"... I was a bit turned down though 
from not receiving any reply or so, well, until now... :-) Though I 
remember now that I was wandering whether the tool was correct and that 
documentation is not... But since I thought that when I'm cherry-picking 
(and, e.g., cleaning up log messages) between topic-old and topic-cleaner, 
the patch id based _difference_ seems to be the most useful one... 

> I wonder if we can kill it by introducing a new rev notation and
> using regular rev-list family of commands instead.
> 
> What we want here is a way to say "give me commits that are in B
> but not in A, but before returning a commit see if there is an
> equivalent change in the set of commits that are in A but not in
> B, and filter it out".

I think that your formalization is very close to what I was expecting to 
get (sort of one-way definition)... However, my git-cherry way produces 
"difference" but on a higher level (than git-diff) since it includes both 
+ and - "changes". Of course, when I have then modified one of the 
changesets slightly, I have different patch id, and thus + and - with same 
log message (with verbose), which IMHO is a good thing to notice, 
especially if I return to the work after 2 weeks or so :-).  

A real life example: In a branch, I have changed tcp_packets_in_flight 
(~10 callers) to input sk instead of tp in a single changeset and >10 
minor changesets. I would love to see tcp_packets_in_fligth change 
information just once when doing diffing topic-old topic-new during cherry 
picking, instead of a lengthy diff full of search-and-replace "noise", 
which increases possiblity of an human error...

But anyway, I'm not claiming that your approach is less useful...


-- 
 i.
