From: Junio C Hamano <gitster@pobox.com>
Subject: Re: When does git check for branch-X being uptodate with origin/branch-X?
Date: Mon, 21 Mar 2016 15:42:44 -0700
Message-ID: <xmqqlh5bjvvf.fsf@gitster.mtv.corp.google.com>
References: <CA+39Oz4izkhtxbUH8cQoD5-DLKAtv9KnC9OkG_ZhFw6Ysg0+gw@mail.gmail.com>
	<20160321202810.GD32071@sigill.intra.peff.net>
	<CA+39Oz4Atuv3N0QNj8o1SYgHzMUyES1QHUsWh-MdNiNr-xPM_w@mail.gmail.com>
	<20160321205043.GA436@sigill.intra.peff.net>
	<CA+39Oz51SaKAWsJ027fzhR3CRDfqmy1Dp7qcpx-k9-HrzGKcwg@mail.gmail.com>
	<CAGZ79kabn+pA4Fs2Y4E6Mwy-dKW6SZZ+LZK7_LjhqagcVc-xDg@mail.gmail.com>
	<xmqq1t73lciw.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaUY86nUiG9urgDhVGZ5yc1=63nvJGufw7K8TAc3ytmdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Adam <thomas.adam22@gmail.com>, Jeff King <peff@peff.net>,
	git list <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 23:42:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai8XD-0003PK-FB
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 23:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695AbcCUWmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 18:42:47 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58988 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751877AbcCUWmr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 18:42:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EEFB64E3BD;
	Mon, 21 Mar 2016 18:42:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SfxcukkAROwlYQzB+VVXmAqwpdg=; b=gVU8FL
	c987pWlqyUIdhT8zu9lV8JOWpGP+TsHAdEuZ50g2OvbKrib8ed9R+iiss8s1kLGx
	gUJkj9ReQJNwv2ilXh+ho2rrGB1AnUg6spYKHfU0U8zqe+NqhfmrXeRW1xr3kMYP
	MePTbW5QlwXq4h1V+76BYPQa9YaP3lBw3p4go=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YZ7t3KhJObo1C3YqKKAI1jxHf2ubg0UQ
	le3VlR2O5NjN+1pkxv0M/o+9vhOr+1KuoggJgZWW8fE5d+O4J6saqgcsk0WEZV5z
	isEnPlBkV5VgFbgnZNQYQ8nrZWx8M61eQxnX46hhMdws2Pke/Us3A6hrB1tm9CDG
	xHhBin1H8KE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E5FCD4E3BC;
	Mon, 21 Mar 2016 18:42:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 682104E3BA;
	Mon, 21 Mar 2016 18:42:45 -0400 (EDT)
In-Reply-To: <CAGZ79kaUY86nUiG9urgDhVGZ5yc1=63nvJGufw7K8TAc3ytmdA@mail.gmail.com>
	(Stefan Beller's message of "Mon, 21 Mar 2016 15:11:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3ACED9D0-EFB6-11E5-8F24-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289474>

Stefan Beller <sbeller@google.com> writes:

> On> 494398473714dcbedb38b1ac79b531c7384b3bc4 Stefan Beller
> <sbeller@google.com> 1455150849 -0800 rebase -i (start): checkout
> origin/master: fast-forward
>
> I do understand the "fetch --append origin fast-forward", (I assume
> they are coming from regular fetches). But the "rebase -i (start):
> checkout origin/master: fast-forward" seems to have recorded there in
> error as I never rebased origin/master itself, but only other stuff on
> top of origin/master.
> Why would we have such an entry in there?

You tell us--what did you do back then?  ;-)

It indeed looks strange.  You shouldn't be able to check out a
remote-tracking branch, so any log for local operation would be in
HEAD's reflog, but not in remotes' reflog.

I was curious to see what kind of entries I have and I do not seem
to have anything strange.

$ find .git/logs/refs/remotes/ -type f -print0 |
  xargs -0 sed -Ee '
    s/^[0-9a-f]{40} [0-9a-f]{40} [^>]*> [0-9]* [-+][0-9]{4}       //
  ' |
  sort -u
fetch --append l10n: fast-forward
fetch git-gui: fast-forward
fetch -v git-svn: fast-forward
fetch -v paulus: fast-forward
pull git-svn: fast-forward
pull git-svn: forced-update
pull -s subtree paulus: fast-forward
pull -v git-svn ks/svn-pathnameencoding-4: storing head
update by push

Puzzled...
