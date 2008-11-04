From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI 
 revamp
Date: Mon, 03 Nov 2008 16:44:38 -0800
Message-ID: <7vljw0tj49.fsf@gitster.siamese.dyndns.org>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz>
 <20081031003154.GA5745@sigill.intra.peff.net>
 <7v3ai9226q.fsf@gitster.siamese.dyndns.org>
 <20081103092507.GD13930@artemis.corp>
 <7v4p2ov0zt.fsf@gitster.siamese.dyndns.org>
 <20081104000207.GA29458@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Sam Vilain <samv@vilain.net>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>,
	"J.H." <warthog19@eaglescrag.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 01:46:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxA3x-000109-0o
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 01:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbYKDApO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 19:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753630AbYKDApO
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 19:45:14 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbYKDApM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 19:45:12 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EE27775E17;
	Mon,  3 Nov 2008 19:45:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 16FD675E13; Mon,  3 Nov 2008 19:44:46 -0500 (EST)
In-Reply-To: <20081104000207.GA29458@artemis.corp> (Pierre Habouzit's message
 of "Tue, 04 Nov 2008 01:02:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D49F4BD0-AA09-11DD-B20E-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100017>

Pierre Habouzit <madcoder@debian.org> writes:

>> Ok, I agree that may be a problem.
>> 
>> But that would not change if you only changed the default behaviour from
>> matching to _this branch_.  You need to also teach a new mode of operation
>> to send-pack/receive-pack pair, which is to "update the same branch as the
>> one I am on locally, but do not do anything if there is no such branch
>> over there".  I do not think we have such a mode of operation currently.
>
> You're right.

Perhaps "git push --no-create"?

In hindsight, _if_ we did not have to worry about backward compatibility
at all, I might agree that the way "git push" ought to work with least
surprise would be:

 * "git push" is the same as "git push origin" (override 'origin' with
   branch.$current_branch.remote);

 * "git push $remote" is the same as "git push --no-create $remote HEAD"
   (override 'HEAD' with remote.$remote.push);

 * "git push $remote $any_non_empty_refspec" does what it is told without
   configuration interfering.

Current behaviour satisfies the first one and the third one.  Instead of
the second, the current behaviour is:

 * "git push $remote" is the same as "git push $remote :" (override ':'
   with remote.$remote.push).

>> By the way, didn't we add a feature to let you say "git push $there :"
>> which is to do what "git push --matching $there" would do?
>
> I don't know, I thought git push --matching $remote would be the same as
> git push $remote ?

I think the point of "push --matching" (or an explicit "push $there :") is
so that you can defeat what you configured.  For example, you could have:

	[branch "master"]
        	remote = gitster
	[remote "gitster"]
        	url = gitster:/pub/git/git.git/
                push = HEAD

And with such a configuration, "git push" or "git push gitster" would only
push to the current branch.

You can countermand with "push gitster master next", of course, but you
would need a way to ask for the matching from the command line without
listing all the names, hence you would say "push gitster :".

I think you meant to give the  --matching option the same efffect.  My
comment is that you do not need a new option, as we already have that
feature.
