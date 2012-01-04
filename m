From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] gitweb generates wrong links in grep search results
 (git_search_files)
Date: Tue, 03 Jan 2012 16:28:54 -0800
Message-ID: <7vhb0cqpix.fsf@alter.siamese.dyndns.org>
References: <CA+uOhx6i-07kW8K0y3Co++2ABD=Lmaq3r4h1hN4YLskAE+hR1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Perl <th.perl@gmail.com>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 04 01:29:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiEj1-0000aH-22
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 01:29:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212Ab2ADA26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 19:28:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43524 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755063Ab2ADA25 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 19:28:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 853E47675;
	Tue,  3 Jan 2012 19:28:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G2W+SWI7VcdkPo/bE9NZzGULp/Q=; b=LOR2k3
	Gjj4mT+5UhChgG+aw9dq6XzS2z7pzvPUcFulv7cmbJvv677FPX1KkY5S2LrJPl9L
	OWaA8k1Hpphl1u1CrkP7dtoC4kPt591qam4r+5eFwDccGd6JkBTnlQDXmZ+uAHgA
	e3z4BikmpgicQw+xxOTBIdNLtycORtmy8eIGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x5I547PPhmjNuBZbEE96Uo+iyVOJ3X3S
	FcJ/5jt0QYtXuZlqr3Bg14UZR1PvVdHRUz50kicZlDnelB87gc/gPBuZ+7TUuhvj
	PgUpCjTpnEdFzLe2LqRIQg6cCx1u/4SzzF3n8vRv+4FAl/jDz4YG6nxft6s6UehK
	m4D+atI5NyA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D5577674;
	Tue,  3 Jan 2012 19:28:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D1FD7673; Tue,  3 Jan 2012
 19:28:55 -0500 (EST)
In-Reply-To: <CA+uOhx6i-07kW8K0y3Co++2ABD=Lmaq3r4h1hN4YLskAE+hR1Q@mail.gmail.com> (Thomas
 Perl's message of "Mon, 2 Jan 2012 14:29:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1641FC36-366B-11E1-BBAF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187911>

Thomas Perl <th.perl@gmail.com> writes:

> I think I found a bug in gitweb when grep'ing for text in a branch
> different from "master". Here's how to reproduce it:

Thanks for a detailed report (and thanks for gpodder ;-).

Jakub, care to take a look?

>
> 1. Have a project with a master branch and a branch different from master
> 2. Start gitweb for that project (e.g. using "git instaweb") and open
> it in a web browser
> 3. Switch to the non-master branch (e.g.
> http://127.0.0.1:1234/?p=.git;a=shortlog;h=refs/heads/mynonmasterbranch)
> 4. In the top right search box, select "grep" in the combo box and
> enter a text that only appears in the non-master branch
> 5. Submit the search by pressing enter, you should be at:
> http://127.0.0.1:1234/?p=.git&a=search&h=refs%2Fheads%2Fmynonmasterbranch&st=grep&s=somesearchtext
>
> ACTUAL RESULT
> In that list of results, you should now see some files matching the
> search - note that the links for the file names and the line numbers
> go to e.g. http://127.0.0.1:1234/?p=.git;a=blob;f=somefile.txt for a
> file "somefile.txt". The links therefore go to the master branch,
> while the search results refer to the non-master branch.
>
> EXPECTED RESULT
> The link should (presumably) go to
> http://127.0.0.1:1234/?p=.git;a=blob;hb=refs%2Fheads%2Fmynonmasterbranch;f=somefile.txt
> so that when the link is clicked, the right file (somefile.txt in
> mynonmasterbranch) is shown.
>
> I also investigated a bit in where the problem happens, and nailed it
> down to: gitweb/gitweb.perl, sub git_search_files, line 5871 in commit
> 17b4e93d5b849293e6a3659bbc4075ed8a6e97e2 (current master tip of
> https://github.com/gitster/git). I haven't looked at the intrinsics of
> the "href" sub, but I believe that it should somehow get the "h"
> parameter from the original page and incorporate it into the final
> link (as "hb" parameter?) to the file. The same fix that is applied
> there then also needs to be applied at line 5891 (same commit, same
> file).
>
> No patch, because after several tries, I didn't get it to work, my
> Perl foo might not be up to the task, and I believe that someone more
> familiar with gitweb's code base might have an easier time to fix
> this.
>
> Thanks,
> Thomas
