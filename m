From: Junio C Hamano <gitster@pobox.com>
Subject: Re: MERGE_RR droppings
Date: Mon, 25 Jun 2012 12:04:47 -0700
Message-ID: <7vwr2vfc1c.fsf@alter.siamese.dyndns.org>
References: <CABURp0omkVoLrz29GeOjjoZOpN238Rm6Nu5aOKQyVxFVnPihsw@mail.gmail.com>
 <CABURp0os2no40BW0P-biG_fXyi7MHRcLLYWmCbLTdBv1o1OXcg@mail.gmail.com>
 <7v8vfk2pby.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 21:04:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjEak-0008DN-Iv
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 21:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002Ab2FYTEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 15:04:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37775 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088Ab2FYTEt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 15:04:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DDC68169;
	Mon, 25 Jun 2012 15:04:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ktd/zW5BrPWfxfubJJVZ6S5tLWY=; b=QiVGxd
	LdqMAr0XxCPhJa7CyS2/OUbSR+IKk12dTz1WDmdgeedWR+r9O2estA2LpFyp87KI
	Ct5KlMgSlOlI3NhP9hixSPaT7LWFg6F+mxloQMflt1+xmNHu+J4EAoIb1IS2INzY
	CZPlFGIoNnACaN7fmVporRLSsL5wi7fa/vuEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bBePcJTU59ZZzHJeD88OtouJpJZDha9S
	IfPK0LtClyC+DugAFojyD+svVH9tjBH16I7nJR30933hmVRJ3v5wOG85qmqF1NnU
	Q0wLscldX4lzTPxLYsYronN2kvcrn3/MM7aGIJqSt8nm+zrzt0BwfZjvXxchQXZi
	ms7jdKryhcE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 030D78167;
	Mon, 25 Jun 2012 15:04:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BA748164; Mon, 25 Jun 2012
 15:04:48 -0400 (EDT)
In-Reply-To: <7v8vfk2pby.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 18 Jun 2012 16:05:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A288310E-BEF8-11E1-B581-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200591>

Junio C Hamano <gitster@pobox.com> writes:

> Phil Hord <phil.hord@gmail.com> writes:
>
>> git mergetool decides to use rerere-remaining based on the existence
>> of the .git/MERGE_RR file:
>>
>>     if test -e "$GIT_DIR/MERGE_RR"
>
> This is correct, I would probably write it with "test -f" if I were
> writing this line today, though.  After you commit to conclude the
> merge, the MERGE_RR marker should disappear.  Isn't it happening for
> you?

Oops.  It actually does not happen for _me_. An empty MERGE_RR is
left in the working tree after rerere has dealt with the conflicts.
There seems to be only three codepaths that explicitly remove
MERGE_RR that is stale:

 - (obviously) "rerere clear"
 - "git reset"
 - "git checkout otherbranch"

Perhaps mergetool should consider a missing MERGE_RR and an empty
one the same way?
