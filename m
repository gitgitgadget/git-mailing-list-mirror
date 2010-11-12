From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3 2/3] Add the 'fetch.recurseSubmodules' config setting
Date: Fri, 12 Nov 2010 22:58:20 +0100
Message-ID: <4CDDB87C.2030803@web.de>
References: <4CDB3063.5010801@web.de> <4CDB30D6.5040302@web.de> <20101111000216.GA14189@burratino> <4CDBA5FD.20802@web.de> <20101111082748.GA15525@burratino> <7v1v6rhfut.fsf@alter.siamese.dyndns.org> <20101111190053.GH16972@burratino> <4CDD2AF9.6040403@web.de> <20101112155210.GA15141@burratino> <4CDD9A02.6000507@web.de> <20101112201640.GB25248@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kevin Ballard <kevin@sb.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 12 22:58:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH1dc-00053R-6t
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 22:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607Ab0KLV6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 16:58:23 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:36726 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527Ab0KLV6W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 16:58:22 -0500
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 6DD5C16FF1FF4;
	Fri, 12 Nov 2010 22:58:21 +0100 (CET)
Received: from [93.240.101.21] (helo=[192.168.178.29])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PH1dV-0002yg-00; Fri, 12 Nov 2010 22:58:21 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20101112201640.GB25248@burratino>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/4v9+ImwQz6Gg3/ujOq5yac4to/9ESPh17ro3j
	Lgrz7TLnWqguofFS9ZbeAlEnffiEs+4p/FCXYwEw4CbKdlMW+c
	Qqs+Cseihuo1qudXnU1w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161364>

Am 12.11.2010 21:16, schrieb Jonathan Nieder:
> Jens Lehmann wrote:
>> There are people putting lots of large files in submodules for better
>> performance and they almost always never want to fetch (or even stat)
>> them, so (1) is for them and it's cool that their upstream can configure
>> that, avoiding to have every developer to repeat their "obvious" choice
>> after each clone again (and that might only be needed for some submodules,
>> so a repo-wide config doesn't necessarily help them).
> 
> Wouldn't (3) work for these people, too?

As I understand there are people who use submodules as something rather
unrelated to the superproject line of development and thus recursive on
demand fetch (and recursive checkout) would not be what they want (and
could take considerable time they don't want to spend).

> I think we are getting closer to an explanation.  I can look into
> adding documentation for this on top when finished.

That would be great! I had the same thing in mind so I would be happy
to help you with that if you want.

>> And when you are on a superproject branch actively developing inside a
>> submodule, you may want to increase fetch-activity to fetch all new
>> commits in the submodule even if they aren't referenced in the
>> superproject (yet), as that might be just what your fellow developers
>> are about to do. And the person setting up that branch could do that
>> once for all users so they don't have to repeat it in every clone.
> 
> This one seems less reasonable to me.  It seems like a way to
> remotely help developers get a nice setup, rather than a declaration
> about the content.

Yeah, I know this example is not as convincing as (1). But it was the
best I could come up with trying to illustrate the "treat-submodules-
as-if-everything-were-in-one-tree" model which some people use.
(And we use this model at my dayjob, but we would be fine setting the
global config option once on every developers computer. But hey, adding
that to the .gitmodules file would get rid of that too ;-)

> Let me take an unrelated example to illustrate what I mean.  Some
> projects might want all their developers to use branch.autosetuprebase,
> to avoid confusion since the update hook is going to reject mergy
> history anyway.  That seems like a perfectly reasonable desire to me,
> and I'd encourage them to add a script that sets everything up
> following the policies of their project.
> 
> Now git could even learn to read a .gitconfig file including settings
> like that one that do not have a security impact.  It would make lots
> of people happy, and individuals could override settings they really
> dislike in ~/.gitconfig.  Should we do it?

Hmm, I never thought of that. But you are right, this is the same
principle I'm using for .gitmodules.

> I think no, for reasons of intuitiveness and predictability.
> 
> On the other hand, scenarios like (1) might mean we have to support
> such things despite that downside.

Yup.

>> And
>> when switching away from that branch all those developers cannot forget
>> to reconfigure to fetch-on-demand, so not having that in .git/config is
>> a plus here too.
> 
> Yes, the "read .gitmodules first and then .git/config" is a very nice
> enhancement --- thanks!

You are welcome!

>> You have no other choice for hooks because of security concerns. But I
>> can't see any downsides in leaving upstream *the choice* to configure
>> default submodule behavior. Lots of people - including me - want that for
>> clone and checkout.
> 
> There is one setting that it is obvious to me for upstream should be
> able to set:
> 
> 	"these submodules are a necessary part of the project;
> 	 always (at clone time, fetch time, checkout, etc) make
> 	 sure they are available"
> 
> I could easily be convinced about others, but there ought to be a use
> case to outweigh the "subtle behavior changing behind my back" syndrome.

I don't have a problem with dropping 3/3 from this series if use case (1)
doesn't convince people. I added it to be consistent with the behavior of
the 'ignore' flag I added earlier and because I it is needed to support
more than one use case for submodules in the same superproject. But we
could wait if someone complains and add it if that happens ... I dunno.

> And again: thanks for doing all this work.  It's inspiring.  (Next step
> recursive push?)

Thanks a lot! (And nope, it's recursive checkout - thats why I started
recursive fetch, so that I do have something to check out ;-).

Jens
