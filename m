From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD/BUG?] git show with tree/commit
Date: Tue, 12 Apr 2016 09:50:57 -0700
Message-ID: <xmqqzisyrcsu.fsf@gitster.mtv.corp.google.com>
References: <570D154D.6090006@drmicha.warpmail.net>
	<20160412163420.GA23462@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 12 18:51:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq1Ws-000381-7Y
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 18:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757213AbcDLQvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 12:51:01 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61730 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757206AbcDLQvA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 12:51:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E5BC055074;
	Tue, 12 Apr 2016 12:50:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ksTiFjXTltjqlZ828NUohmyXMNE=; b=CdNjwA
	Hm9R1s5FSXsa1HJYtpHJNZ8cNHP4OfWO7TQogMFbNWUCPmkjLRjMvLQqtjZgN6nD
	LaLXoubDjasfIcY9O739QJpcYS8kXNgnAsJwz1GOgjiCqo+bFMnA+TSZvq87aktF
	pU2aK4WduL14Tfx8sWw8HPYoHEZdb3HanqCdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lYPYqA5nJD0egEckVrZjh78cp9EZIFF1
	m0IJhgKM22IKYqbrAzwj4v5YYzJpUtl9LqM28LHI6Yc6eKiS7GJ75JEjqtntYYF5
	wYx88l+FWXQuK6lAnKkjdNVOH5DZg5d6m97/iZ3bKwvsDtbeyQD7zrL2Pq8SULSx
	WkBiWaUtTHo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DDE5C55073;
	Tue, 12 Apr 2016 12:50:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5C1EB55072;
	Tue, 12 Apr 2016 12:50:58 -0400 (EDT)
In-Reply-To: <20160412163420.GA23462@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 12 Apr 2016 12:34:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BB1D4846-00CE-11E6-A7F7-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291279>

Jeff King <peff@peff.net> writes:

> On Tue, Apr 12, 2016 at 05:33:33PM +0200, Michael J Gruber wrote:
>
>> $ git show cab2cdadfda8e8e8631026443b11d3ed6e7ba517:
>> tree cab2cdadfda8e8e8631026443b11d3ed6e7ba517:
>> 
>> .gitattributes
>> .gitignore
>> .mailmap
>> ...
>
> As Junio pointed out, the colon here is not syntactic, but from the
> original object name you gave it. But here...
>
>> $ git show 04050d37b1676ba8da277be1902513049b45413a:
>> tree 04050d37b1676ba8da277be1902513049b45413a
>> 
>> .gitattributes
>> .gitignore
>> .mailmap
>> ...
>
> ...it is missing. Did you mean to omit it from the command-line?

I suspect that is cut-and-paste something.  I see:

    $ git show 04050d37b1676ba8da277be1902513049b45413a: | head -n1
    tree 04050d37b1676ba8da277be1902513049b45413a:
    $ git show 04050d37b1676ba8da277be1902513049b45413a | head -n1
    tree 04050d37b1676ba8da277be1902513049b45413a

which is expected.

It indeed becomes confusing when you give "<treeish>:" from the
command line, as it looks as if there is conceptually a list of tree
contents that is shown like so:

    tree tree1:
    contents of tree1

    tree tree2:
    contents of tree2
    ...

and we are showing only the first one.  If the original input were
given as "<treeish>^{tree}", there is no confusion.
