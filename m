From: Bill Lear <rael@zopyra.com>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Wed, 14 Nov 2007 14:16:45 -0600
Message-ID: <18235.22445.16228.535898@lisa.zopyra.com>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
	<20071112131927.GA1701@c3sl.ufpr.br>
	<Pine.LNX.4.64.0711121355380.4362@racer.site>
	<200711121719.54146.wielemak@science.uva.nl>
	<Pine.LNX.4.64.0711121624330.4362@racer.site>
	<vpq3avbv2ju.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121715090.4362@racer.site>
	<18232.35893.243300.179076@lisa.zopyra.com>
	<Pine.LNX.4.64.0711121727130.4362@racer.site>
	<vpq7iknqrtp.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121755460.4362@racer.site>
	<vpqy7d3pck0.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121804400.4362@racer.site>
	<vpqoddzpc88.fsf@bauges.imag.fr>
	<7v4pfr2kmh.fsf@gitster.siamese.dyndns.org>
	<87myth58r5.fsf@osv.gnss.ru>
	<7vfxz8hbcf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Sergei Organov <osv@javad.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 21:18:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsOgF-00066S-1Q
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 21:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764270AbXKNURc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 15:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764252AbXKNURb
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 15:17:31 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60438 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764166AbXKNUR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 15:17:27 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id lAEKGq228851;
	Wed, 14 Nov 2007 14:16:52 -0600
In-Reply-To: <7vfxz8hbcf.fsf@gitster.siamese.dyndns.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65006>

On Wednesday, November 14, 2007 at 11:32:32 (-0800) Junio C Hamano writes:
>Sergei Organov <osv@javad.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> His second point is also a real issue.  If you allowed cloning
>>> an empty repo (either bare or non-bare), then you and Bill can
>>> both clone from it, come up with an initial commit each.  Bill
>>> pushes his initial commit first.  Your later attempt to push
>>> will hopefully fail with "non fast forward", if you know better
>>> than forcing such a push, but then what?  You need to fetch, and
>>> merge (or rebase) your change on top of Bill's initial commit,
>>> and at that point the history you are trying to merge does not
>>> have any common ancestor with his history.
>>
>> Just a wild idea. Doesn't it make sense to introduce perfect ultimate
>> common ancestor of the universe, probably calling it "the NULL commit"?
>> At first glance it seems that it can help to avoid corner cases
>> automagically.
>...
>But cloning void to start the same project by multiple people
>and pushing their initial commits as roots to start a project
>indicates the lack of developer communication (besides, it just
>feels like a bad style, a hangover from centralized SCM
>mentality, but that is fine). ...

We have several users who have been using git for the past 9 months
and they each find this unreasonably complicated.  We realize it is
work, perhaps not of the highest importance, but it's also easy for
more experienced users to simply pooh-pooh the ideas that newer users
have as "silly" because instead of the two steps they would like, they
can "just" do the five "easy" steps.

Well, here's what we'd like:

% mkdir new_repo
% cd new_repo
% git --bare init

[on another machine:]
% git clone git://host/new_repo
% cd new_repo
% git init
[add content]
% git commit -a -m "Initial stuff"
% git push

So, this is hard work, and other priorities intrude.  Ok.

Instead, we have to 1) figure out how to do this right, because it's
difficult to remember and not intuitive, and 2) once we have "figured
it out", really figure it out, because there are a few gotchas:

% mkdir new_repo
% cd new_repo
% git --bare init

% mkdir new_repo
% cd new_repo
[add content]
% git commit -a -m "Initial stuff"
% git config remote.origin.url git://host/new_repo
% git push
[ach! fails!  what's up??]
[poke, read, poke some more, try other things..]
[try setting the remote.origin.fetch?  No, that doesn't work]
[try setting branch.master.remote?  Just edit by hand??]
% git push master
[fails again; read some more; think, think, think...]
% git push origin master
[aha! finally it works]

But now, I have a repo in which I cannot just say "git push" to update
my remote repo.

So, if we can't have clone "do the right thing", then it would be nice
if we had something to allow us to do this, perhaps an argument to git
init:

% mkdir new_repo
% cd new_repo
% git --bare init

[on another machine:]
% mkdir new_repo
% cd new_repo
% git init --mirror git://host/new_repo
[add content]
% git commit -a -m "Initial stuff"
% git push

Where 'git init --mirror <blah>' just sets up the config file
properly.

Something to think about ...


Bill
