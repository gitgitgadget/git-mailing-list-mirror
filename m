From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Deletion of remote branches
Date: Mon, 01 Oct 2012 13:42:38 -0700
Message-ID: <7vhaqdc4ap.fsf@alter.siamese.dyndns.org>
References: <CC8F65C7.E79%jens.hausherr@xing.com>
 <7v1uhids5a.fsf@alter.siamese.dyndns.org>
 <583784AD1BE54FD582B1D58FE7F4CADA@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jens Hausherr" <Jens.Hausherr@xing.com>, <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Oct 01 23:00:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIn60-0004Fo-LK
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 23:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096Ab2JAUnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 16:43:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58393 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755333Ab2JAUmm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 16:42:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 699BD9FA6;
	Mon,  1 Oct 2012 16:42:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k85TisNG2yUpzWdL6diy5YzoOu8=; b=uiNOQM
	+SUYPxUcsQo4yfjFWfy4Dn5tiU2LD3t2K17QZgZOeqciqGZKKvrGsnMlid/4TMtY
	KuL3PyjgI3TpxjbiKRX6IwgTndtivb0RCZNhhTpp90N2+KOWaVa+7HKjCU/5r885
	MDd8rV7KL8JEKG6wxEq52u4RmiH6gJDRd2pvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LOAppLl9mqdbEJIdqd9AzivckuezHNSt
	AKK1nQ6o5u0TxjcSBVY4ybW14d7fGUYZYEzTnKoNWD1XEOyIlfbMWL20USUYLkBC
	2xTZg96NTmWhkR0dzEyKlifbzVuW33uZ/4Zym7VLaehLA/ZMB2DI6PvazzkqcZy0
	hPniVZCEU1A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 575759FA5;
	Mon,  1 Oct 2012 16:42:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF85C9FA4; Mon,  1 Oct 2012
 16:42:40 -0400 (EDT)
In-Reply-To: <583784AD1BE54FD582B1D58FE7F4CADA@PhilipOakley> (Philip Oakley's
 message of "Mon, 1 Oct 2012 21:12:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B15BEDA-0C08-11E2-8F30-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206767>

"Philip Oakley" <philipoakley@iee.org> writes:

>> All of the above are expected and working as designed.  Remote
>> tracking branches are local _copies_ of what you have over there at
>> the remote repository. The latter is the authoritative version, and
>> you asked "ls-remote" to go over the network to view them.
>>
> Is there a definitive naming convention for the two types of 'remote 
> branch'?
>
> IIRC (somewhere) the 'tracking' term was to be deprecated, though it is 
> still in common use. It is usually only the context that clarifies if it 
> is the local or the distant copy/repo.

That is somewhat different from what I recall:

 - "refs/remotes/$there/$that" is a copy of $that branch at the
   remote $there; we call that a "remote tracking branch".

   When people say "remote branch", they often mean $that branch at
   the remote $there, not your local copy of it.

   When you say "remote tracking branch", you are talking about
   something you locally have to track the corresponding "remote
   branch".  This use is not deprecated at all.  That is the only
   sane way to clarify which one of the two you are talking about.

 - If your branch "foo" always integrates with branch "bar" at the
   remote "xyzzy", you would often run

	git pull xyzzy bar
        git pull --rebase xyzzy bar

   after running "git chekcout foo".  You may even have this in your
   per-repository configuration:

	[branch "foo"]
		remote = xyzzy
                merge = refs/heads/bar

   In such a situation, some people (used to) say that "foo tracks
   bar from xyzzy".  While such a colloquial use is perfectly fine
   when it is clear that "foo" being discussed is your local branch,
   the verb "track" in that sentence is used to mean an entirely
   different kind of relationship between your "remotes/xyzzy/bar"
   and the branch "bar" at remote "xyzzy", where the former is the
   "remote tracking branch" for the latter, leading to confusion.
   This use of 'track' is what is discouraged these days.

I think we call the latter @{upstream} of "foo" these days.
