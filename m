From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion.bash: add support for path completion
Date: Mon, 17 Dec 2012 11:42:04 -0800
Message-ID: <7vzk1clb3n.fsf@alter.siamese.dyndns.org>
References: <1355693080-4765-1-git-send-email-manlio.perillo@gmail.com>
 <7vy5gxnuy1.fsf@alter.siamese.dyndns.org> <50CEFF3A.4050802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 20:42:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkga2-0001iD-KJ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 20:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551Ab2LQTmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 14:42:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35842 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752956Ab2LQTmH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 14:42:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE04BABC7;
	Mon, 17 Dec 2012 14:42:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bitYYXFoZ228xMqs0G2EMbFj0Jk=; b=EuJ9xX
	g1DzVcJCyvkT31q2Vreqb/OClKYnbYdGaMAP14H0w3xGNG7YwAtJ4lQPTrZ6w+uB
	OFuGvAU5UKzWn/Kg5PV2d4zYC1SUW0t46PNpiOTtR4Lhg5XVmuLF0bvs5sUTJtqU
	UQYtYgF4jRLg8uNH2b8X+8XHrVaXXNKbRPoRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WhYmqyXcyj0krH9eajz5+YYqSrs5O81C
	U9iSCpIymOUwu5f7K/nPOSRXVS04KCsjiUWJLqd+4tdOgmTG40YgLZS3xM13iv8j
	6hgnw9323co11BKB17LoGYc44NzfQLMQ/0RfR+qgNQGPnMhR+AxlaG6BJkaTrT/I
	E8jc5iVPSXY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB512ABC6;
	Mon, 17 Dec 2012 14:42:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A52CABC5; Mon, 17 Dec 2012
 14:42:06 -0500 (EST)
In-Reply-To: <50CEFF3A.4050802@gmail.com> (Manlio Perillo's message of "Mon,
 17 Dec 2012 12:17:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D69CD626-4881-11E2-9E7F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211693>

Manlio Perillo <manlio.perillo@gmail.com> writes:

>> As long as all of the above stops completion at directory boundary,
>> I think the above sounds like a sensible thing to do.  e.g. when
>> "ls-files" gives Documentation/Makefile and Documentation/git.txt,
>> "git cmd Doc<TAB>" first would give "git cmd Documentation/" and
>> then the second <TAB> would offer these two paths as choices.  That
>> way, the user can choose to just execute "git cmd Documentation/"
>> without even looking at these individual paths.
>
> Right, this is what bash usually do.
> However I don't know how to implement this with git.

That sounds like a regression to me.

>> I am not sure how you would handle the last parameter to "git mv",
>> though.  That is by definition a path that does not exist,
>> i.e. cannot be completed.
>
> Right, the code should be changed.
> No completion should be done for the second parameter.

I deliberately wrote "the last" not "the second", as you can do

	$ mkdir X
        $ git mv COPYING README X/.

You do need to expand the second parameter to README when the user
types

	git mv COPYING REAMDE X

then goes back with \C-b to "M", types \C-d three times to remove
"MDE", and then finally says <TAB>, to result in

	git mv COPYING README X
