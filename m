From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Sun, 11 Nov 2012 02:33:45 -0800
Message-ID: <7vzk2oo2d2.fsf@alter.siamese.dyndns.org>
References: <cover.1352431674.git.wking@tremily.us>
 <fb2d915cf60160c200b84df88c6112c1c2d4eefd.1352431674.git.wking@tremily.us>
 <7v390jqlep.fsf@alter.siamese.dyndns.org> <20121110184437.GC2739@mjolnir>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Nov 11 11:34:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXUrb-0007zl-8s
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 11:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696Ab2KKKdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 05:33:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32902 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750969Ab2KKKdt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 05:33:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DCD79115;
	Sun, 11 Nov 2012 05:33:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lM1ccDoerhWG+7Bg5Oqi9an8380=; b=U61CU/
	6zqNaRw5wxwbpr0+oQN1uCUxYFH/IxrXDO2PCzEAypoe6l5c4JETvtUCcQFrZrNH
	k0znvA/MIqpt0CDPMVkNmJEFANYE418MroN11V5QITMVnpohNOs1pNtiMRCTOaNr
	NVIiPJK8XCHlHfY6312jJVFqBcVqzSOSVkg6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z20MLWVmg0sICIMNLHK3+fySHVXDco18
	oiSPhrvf82TKEHar3OpbDkiG1V2uS+YlCNHLiv6ajQ5r+CokvWs3f+/nNUS65nTr
	Hco5RcndV7/RR+sa1noooZ9oAgkF18tBwlK74Q4aILVY3wuX4M37dhUU0/qFJO73
	b+coTj0JbhM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ACEC9114;
	Sun, 11 Nov 2012 05:33:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96C769113; Sun, 11 Nov 2012
 05:33:47 -0500 (EST)
In-Reply-To: <20121110184437.GC2739@mjolnir> (W. Trevor King's message of
 "Sat, 10 Nov 2012 13:44:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4698E27A-2BEB-11E2-ACE2-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209333>

"W. Trevor King" <wking@tremily.us> writes:

> On Thu, Nov 08, 2012 at 11:34:54PM -0800, Junio C Hamano wrote:
>
>> I would not object to "git config submodule.$name.branch $value", on
>> the other hand.  "git config" can be used to set a piece of data
>> that has specific meaning, but as a low-level tool, it is not
>> _limited_ to variables that have defined meaning.
>
> This is what I'm doing now:
>
>   $ git submodule add -b <branch> <repo> <path>
>   $ git config --file .gitmodules submodule.<path>.branch <branch>
>   $ git submodule foreach 'git checkout $(git config --file $toplevel/.gitmodules submodule.$name.branch) && git pull'
>
> With my second patch (Phil's config export), that becomes
>
>   $ git submodule add -b <branch> <repo> <path>
>   $ git config --file .gitmodules submodule.<path>.branch <branch>
>   $ git submodule foreach 'git checkout $submodule_branch && git pull'
>
> With my first patch, that becomes
>
>   $ git submodule add -rb <branch> <repo> <path>
>   $ git submodule foreach 'git checkout $submodule_branch && git pull'
>
> This seems pretty useful to me,...

Ah, this reminds me of another thing I noticed when I saw that
patch.  The change seems to think "branch" is the _only_ thing the
user might want to record per submodule upon "git submodule add".
As an interface to muck with an uninterpreted random configuration,
it squats on a good option name for setting one single and arbitrary
variable---quite a selfish change that is not acceptable.

Calling the option "--record-branch-for-submodule" or something more
specific might alleviate the problem, but then it would become even
less useful as a short-hand for "config submodule.$name.branch", I
would suspect.

On the other hand, if this were one small part of a series to define
the "tip following mode" where (at least)

 (1) "git submodule update [$path]" makes sure that the checkout of
     the submodule at $path matches the commit at the tip of the
     branch named by submodule.$name.branch in .gitmodules of the
     superproject, instead of the commit that is recorded in the
     index of the superproject; and

 (2) "git diff [$path]" and friends in the superproject compares the
     HEAD of the checkout of the submodule at $path with the tip of
     the branch named by submodule.$name.branch in .gitmodules of
     the superproject, instead of the commit that is recorded in the
     index of the superproject.

and the option were called something like "--follow-branch=$branch",
it would make much more sense for its initial implementation to set
the name of the branch to submodule.$name.branch variable.  Later
iterations of such a feature may want to do more than just setting
that single variable but that is a part of the implementation detail
of the tip following mode the users do not have to know about, just
like setting the submodule.$name.branch variable is.

So in that sense, too, I would be somewhat unhappy to see this
change in the current form to go in.
