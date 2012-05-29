From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How does Git's maintenance policy handle topics that don't start
 from "master?"
Date: Tue, 29 May 2012 16:06:56 -0700
Message-ID: <7vzk8q1t9r.fsf@alter.siamese.dyndns.org>
References: <m21um2682e.fsf@Spindle.sehlabs.com>
 <7vbol63ccs.fsf@alter.siamese.dyndns.org>
 <m2sjei4pvq.fsf@Spindle.sehlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Steven E. Harris" <seh@panix.com>
X-From: git-owner@vger.kernel.org Wed May 30 01:07:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZVVJ-00056w-P1
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 01:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567Ab2E2XHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 19:07:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59101 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753253Ab2E2XG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 19:06:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 663ED8EF7;
	Tue, 29 May 2012 19:06:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P72xpoVBWLbQ4dBBiHwW2yg/zzo=; b=xTwiB7
	ZGQHjS0A6CTvQAO+P4cPX1tkudB7LBZ0ihyJKmICWVWAlGY+4JSW/eTqN/qGnqQq
	jrY7zGdrobCghAX1WRwzZvOsOt6SEm3T9Fdxf7z5qqOwKiu1CtU/Kuqy/UT3jSjo
	GtCdtRw044/7ynQQCqZjYN/YmYO27Znly3g1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PuiV3zdG4HMS4r4duKbI2CeP7CDaRo+D
	kL9JFxH1nwH352+/Wv5KOpj69+y5VvhVcOJ/5GTkjmpurYacrvHTPFZssOlifng7
	ljd/RESVv4hyxW+4s7HjfbZaCx35n5yzkjmcb1bHi//RrdzWIXyBSrnJdOlqA9fa
	woSrUP9WrsQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E1BD8EF6;
	Tue, 29 May 2012 19:06:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D47928EF4; Tue, 29 May 2012
 19:06:57 -0400 (EDT)
In-Reply-To: <m2sjei4pvq.fsf@Spindle.sehlabs.com> (Steven E. Harris's message
 of "Tue, 29 May 2012 17:51:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD83F51E-A9E2-11E1-BEA5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198773>

"Steven E. Harris" <seh@panix.com> writes:

> What isn't so clear to me, though, is /why/ this don't-merge-from-"next"
> rule is so important. Say that we had one topic "t1" depart from "next,"
> and then another topic "t2" depart from "t1," and both have been cooking
> in "next," with good results.
>
>   ---o---o---o---o  master
>                   \
>                    o---o---o---o---o---M---o---o next
>                         \     /       /
>                          o---o t1    /
>                               \     /
>                                o---o t2
>
> If we wanted to graduate these two topics to "master," we /could/ merge
> from commit M back to "master," though here I deliberately included the
> nefarious commit X, which shows other interleaved contributions along
> "next" that are also part of the M commit.

I do not see any X above, but I think you meant the commits in
master..M that are not reachable from either t1 and t2.

And I think you answered your own question.  These "master..M ^t1
^t2" commits are topics that are *not* part of t1 nor t2.  If you
deem all of them are good enough for your master, it is perfectly
fine to merge M to master.  In reality, it is more cumbersome to
think about what is and what is not yet in M and decide if the set
of changes that happen to be in M match exactly what you want to
merge, than knowing that you exactly want to have t1 and t2 and
nothing else in your master during this integration run and merge
only these two topics.

The same answer to the other picture.  If you can figure out an
appropriate commit M that has what you want, go right ahead and
merge that to 'master'; I do not see any harm there.  I personally
do not think it is worth the effort to figure out which commit
between master..next that M is, and verify master..M contains
everything you want and nothing you don't.  Merging t1 and t2
explicitly, when you know they are the only thing you want to merge,
is much simpler and less error prone.

> What about this case, where topics "t1" and "t2" did depart from
> "master," and are doing well along "next" together as of commit M.
>
>   ---o---o---o---o  master
>       \   \       \
>        \   o---o---o---M---o---o next
>         \     /       /
>          o---o t1    /
>           \         /
>            o---o---o t2
>
> The Git policy as I understand it prescribes that we merge from the tips
> of "t1" and "t2" back to master, not from a commit like M. What harm
> would come from merging from M in this case? Future archaeology of topic
> provenance?
