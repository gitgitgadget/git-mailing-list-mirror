From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Sun, 22 Jul 2007 23:24:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707222302170.19212@reaper.quantumfyre.co.uk>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site>
 <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222223460.14781@racer.site>
 <Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222255010.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 00:24:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICjrF-0003GH-0K
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 00:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759298AbXGVWYy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 18:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757540AbXGVWYx
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 18:24:53 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:37501 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757483AbXGVWYx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 18:24:53 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 657FBC610F
	for <git@vger.kernel.org>; Sun, 22 Jul 2007 23:24:51 +0100 (BST)
Received: (qmail 30171 invoked by uid 103); 22 Jul 2007 23:24:48 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3722. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.033046 secs); 22 Jul 2007 22:24:48 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 22 Jul 2007 23:24:48 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <Pine.LNX.4.64.0707222255010.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53351>

On Sun, 22 Jul 2007, Johannes Schindelin wrote:

>>> - to make sure that the user cannot check out the same branch as in the
>>>  current repo, _or some other workdir of it_, and
>>
>> Since you can checkout any branch you like once you have the workdir,
>> this is really an artificial limitation - you are protected when you
>> create the workdir, but not after.
>
> Well, it is not really an artificial limitation.  IMHO it is much more
> likely that you keep in mind what you should not do, when you have to work
> around such a limitation if you really want to do.

Well, the point I was trying to make is that you _only_ protect them 
against the initial creation.  The user can then happily shoot themselves 
in the foot.  They can quite easily "work around" the limitation without 
realising that they are.  Say that you create a workdir for a new branch. 
Then a month later you want to do something to a branch you are working on 
in your main branch - but you are halfway through something complicated 
that you haven't checked in, but you think "aha! I still have that old 
workdir, I can just switch it over and use that" ...

You haven't made workdirs themselves safer - only the creation.  You still 
need a great big THIS CAN REALLY MESS THINGS UP warning.

>
>> If you want to have a workdir for an exisiting branch then you have to create
>> a new one, and then switch it over.  That seems like a really big usability
>> wart to me ... certainly it would make the option pretty much useless to me.
>> My original motivation for the new-workdir script was to give me the ability
>> to flatten out branches from a single repo for when I'm working on multiple
>> branches at the same time.
>
> Nowadays, we have separate remotes layout by default.  (Indeed, you cannot
> even disable it, as I found out recently).  Which means that you already
> have to branch off your local branch.  So the consequences are lesser.

This is true - yet I still find that 99% of the time I am using 
new-workdir to get an existing branch.  Probably because there is usually 
a delay between creating a local branch and needing to work on it in 
parallel.

Working pattern is something like:

start off with 0 workdirs - just using the original repo
... work using 1 working copy - switching branch as needed ...
need to do two things in parallel - 1 workdir
... work using 2 working copies - switching both/either as needed ...
need to do three things in parallel - 2 workdirs
... work using 3 working copies - switching any/all as needed ...

etc. (sometimes removing workdirs as they are no longer needed too)

>>> - to have finer grained lock control, as well as respecting has_symlinks.
>>
>> Not really sure what this means, since I am too tired to have read the
>> actual patch - is it referring to the fact that checkout is shell rather
>> than C?  If so, surely that is not really a good justification for
>> putting the option in the "wrong" command?
>
> Well, I am really not interested in shooting myself in the foot, and
> having that option in checkout would make that much more likely.  So I
> really, really want to have this in git-branch.

Fair enough.  Your patch - so you get to choose.  I don't have any strong 
objections (and no power to express any if I did :P) - just airing my POV 
;)

I just think that to a user it feels like a checkout operation ... and 
that would less confusing as an option to checkout.  Trying to explain 
that branch just creates a new branch, unless you give this option then it 
creates a working copy over there seems more compilcated than saying the 
checkout updates/creates this working copy, unless you use this option to 
create one over there.

> Once git-checkout is builtin, we can still come back and add this option
> to git-checkout (with a big fat red warning, to be sure); it is not like
> we have git-branch and git-checkout functionality well separated...

As I said I have been thinking from a user POV not an implementation one 
...

Assuming this patch goes in, then I'll probably update the new-workdir 
script to keep it's existing syntax, but use your new option as mechanism 
... so that will let me keep doing things the way I am anyway ... ;)

And as I said originally - you got my vote on this going into git proper 
_somewhere_ ...

-- 
Julian

  ---
When it is not necessary to make a decision, it is necessary not to
make a decision.
