From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 18 Jul 2008 02:58:26 -0700
Message-ID: <7vtzen7bul.fsf@gitster.siamese.dyndns.org>
References: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org>
 <7vlk01hqzz.fsf@gitster.siamese.dyndns.org>
 <20080718175040.6117@nanako3.lavabit.com>
 <20080718182010.6117@nanako3.lavabit.com>
 <20080718094404.GB32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jul 18 11:59:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJmkQ-0004RZ-Fg
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 11:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754392AbYGRJ6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 05:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754573AbYGRJ6f
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 05:58:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52027 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358AbYGRJ6f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 05:58:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B620831516;
	Fri, 18 Jul 2008 05:58:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 54F1331512; Fri, 18 Jul 2008 05:58:29 -0400 (EDT)
In-Reply-To: <20080718094404.GB32184@machine.or.cz> (Petr Baudis's message of
 "Fri, 18 Jul 2008 11:44:04 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 152F07B2-54B0-11DD-A918-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89024>

Petr Baudis <pasky@suse.cz> writes:

> On Fri, Jul 18, 2008 at 06:20:10PM +0900, Nanako Shiraishi wrote:
>> I do not know if "I do not understand what they did well enough" is the only reason people would want to use that feature. Isn't it better to let people decide that for themselves?
>
> It is dangerous to introduce new options just because we think someone,
> sometimes might find it useful, especially if they potentially encourage
> a bad workflow. Adding options and commands is expensive since it
> complicates the UI further, thus we should add further only when we have
> good reason for it.
>
>> > That also was the reason I did not add any documentation to it.
>
> I was actually looking for something like this based on some question on
> #git (about git pull -s theirs possibility), and did stumble upon these
> patches, but quickly gave up on them since it wasn't immediately clear
> for me from the patch description exactly how the workflow looks like
> (it doesn't really seem to work like the opposite of -s ours nor is it a
> separate strategy... huh) and the options were completely undocumented.

Heh, now you have some readings to do ;-)

I tried not to sound too negative when describing -Xours and -Xtheirs
there, but actually I think "-s theirs" is even worse.  It is how you
would discard what you did (perhaps because the other side has much better
solution than your hack), but that can be much more easily and cleanly
done with:

	$ git reset --hard origin

Some poeple might say "But with 'merge -s theirs', I can keep what I did,
too".  That reset is simply discarding what I did.

That logic also is flawed.  You can instead:

	$ git branch i-was-stupid
        $ git reset --hard origin

if you really want to keep record of your failure.

One big problem "-s theirs" has, compared to the above "reset to origin,
discarding or setting aside the failed history" is that your 'master'
history that your further development is based on will keep your failed
crap in it forever if you did "-s theirs".  Hopefully you will become a
better programmer over time, and you may eventually have something worth
sharing with the world near the tip of your master branch.  When that
happens, however, you _cannot_ offer your master branch to be pulled by
the upstream, as the wider world will not be interested in your earlier
mistakes at all.
