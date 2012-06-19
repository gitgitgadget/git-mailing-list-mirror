From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git branch' when origin branch with same name exists
Date: Tue, 19 Jun 2012 11:22:46 -0700
Message-ID: <7vd34v17rd.fsf@alter.siamese.dyndns.org>
References: <4FE091FB.7020202@desrt.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ryan Lortie <desrt@desrt.ca>
X-From: git-owner@vger.kernel.org Tue Jun 19 20:23:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh353-0000Ma-07
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 20:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237Ab2FSSWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 14:22:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49881 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752473Ab2FSSWt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 14:22:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C67D080EC;
	Tue, 19 Jun 2012 14:22:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X08adN6Lx4xrtmnfwgQDA0OVrCM=; b=e8mFJI
	BebRThGX9QVeA2aA5eXAv7F3SFjWJbAr7G7rlrST0PS5o0l2lyC3mNwgmNlXvZ5D
	WueDGOE0wtnCxNm3MeUs5EkLrY4GMWxSq4sYLwYh/5oo+sgGLIiCfAyFZ2AN7lk0
	q+NVm8xkS7WEzhYe7IsjcK4mW2JHDXe58Rg7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s5m6biRbmxj58TLwGq2xtyAnRfIC4y2c
	yT5mPDz4vTz4YBQRAL8UswwB7QD5fnxqBoFfMELXo01WgTC5cT3CQEuGBIwjxGZb
	NmwMlEAYtmo9l3gmUyDGfVFyYo8FXkLjBKEfpV17Xuj9wXWwKj+G+UJ4R0DNqTw1
	h/PV4i0AVxk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD58C80EB;
	Tue, 19 Jun 2012 14:22:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D9E480E8; Tue, 19 Jun 2012
 14:22:48 -0400 (EDT)
In-Reply-To: <4FE091FB.7020202@desrt.ca> (Ryan Lortie's message of "Tue, 19
 Jun 2012 10:51:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C5DD6172-BA3B-11E1-890A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200217>

Ryan Lortie <desrt@desrt.ca> writes:

> In this case, the user wanted to checkout a branch of a module.  They did:
>
>   git clone git://git.gnome.org/gtk+
>   cd gtk+
>   git branch gtk-3-4
>
> Obviously this is a user error, but it's a pretty innocent one, and
> puts the user in a bad state.  When they figure they should have typed
> "git checkout gtk-3-4" it is already too late -- they will be taken
> onto their locally-created copy of the master branch.
>
> So feature request: 'git branch' should not allow creating a local
> branch that has the same name as a branch that already exists on
> origin' (or any remote?) without some sort of --force flag.

I think "the same name" is missing the point.  It is perfectly fine
to have your own 'fix' branch that builds on top of what the remote
side calls 'master', with the intention of testing what you queue on
your 'fix' branch locally and cherry-picking proven-good ones to
your 'master' before pushing the result out, even when there happens
to be a 'fix' branch that your 'fix' branch does not have anything
to do with on the remote side.  After all, the remote side may start
using the 'fix' branch _long_ _after_ you start using your 'fix'
branch, so checking at the branch creation time does not help you
much, even if it were a problem that your local 'fix' (which you
have no intention to push it to the remote) and the 'fix' at the
remote does not have any common purpose.

The same can be said for the gtk-3-4 branch, depending on the
purpose of 'master' vs purpose of 'gtk-3-4' at the remote side.  If
'gtk-3-4' branch were the playground to come up with the next great
version, and 'master' is the continuation of the current version
with not so earth-shattering changes, it is perfectly normal for
different contributors to fork from 'master' for their next feature
that they hope eventually to go to 'gtk-3-4' at the remote, and
locally name the branch 'gtk-3-4', build their feature, and
depending on how disruptive the change is, choose to integrate the
result into either 'master' or'gtk-3-4' at the remote after it is
done.  So it is not immediately clear if "git branch gtk-3-4" in the
example is a problem to begin with.

Given that "git checkout gtk-3-4" with recent enough Git (since
1.7.0) DWIMs the command to do the equivalent of

	git checkout -t gtk-3-4 origin/gtk-3-4

that is, to fork, build on top of, and to be integrated with the
'gtk-3-4' branch at the 'origin', if you know with a reasonable
degree of certainty that the user should have typed "git checkout
gtk-3-4" when he typed "git branch gtk-3-4" in the example, then it
could be argued that "git branch" could offer an advice message, but
it is unclear how you can be sure if "git checkout gtk-3-4" was what
the user really wanted to do when he said "git branch gtk-3-4" in
the first place.
