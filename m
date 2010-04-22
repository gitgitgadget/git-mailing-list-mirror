From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Thu, 22 Apr 2010 14:28:23 -0700
Message-ID: <7vsk6n2n48.fsf@alter.siamese.dyndns.org>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
 <20100422155806.GC4801@progeny.tock> <87wrvzs590.fsf@frosties.localdomain>
 <alpine.LFD.2.00.1004221445310.7232@xanadu.home>
 <87sk6n4426.fsf@frosties.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Goswin von Brederlow <goswin-v-b@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 22 23:28:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O53x0-0003fr-3r
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 23:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756898Ab0DVV2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 17:28:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755754Ab0DVV2i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 17:28:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 92466AC9C0;
	Thu, 22 Apr 2010 17:28:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OlX3XzNQ6V0UIg2WHUM5pUnPj34=; b=vK+Dqe
	5Tx7xS8nfK3cdL+S6xDziSQ0UmgZ0B+AZ2La2KFifOyBLJ9ItisuE6d0VEtVFvyq
	bbZc5KTb64iqiJtr3WLL4TLSN2Lhp2ycgik3hz39/Kp0NryN18nh5NyOu7Ww2U1c
	wKpC4crk/tugzmkKAdxWJth8RjDmwbCRicmUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XjjLnuv052F0hXHLbtv11NPECLXj8xLl
	6Yw5gWzzGYycTafjqsUV+5o+AmrGpF2vzXpobIG73dWNGdgCDf+IbW73TYWieou+
	TzTGDeN4oLZstqGADQYqhrefCa1kh/wRg2cIS7uMzjZaz1eSyLHMejbuEA9QfNdR
	r156zowArzY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F32AAC9B9;
	Thu, 22 Apr 2010 17:28:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1CC01AC9B8; Thu, 22 Apr
 2010 17:28:24 -0400 (EDT)
In-Reply-To: <87sk6n4426.fsf@frosties.localdomain> (Goswin von Brederlow's
 message of "Thu\, 22 Apr 2010 22\:37\:05 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FF967E52-4E55-11DF-97DF-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145566>

Goswin von Brederlow <goswin-v-b@web.de> writes:

>> Exact.  It is therefore not progress to impose some inconvenience to one 
>> work flow in order to make another one easier.  And in this case we're 
>> talking about the difference between having to type an additional -a vs 
>> the risk of creating a commit with unexpected content.
>
> Is there a risk?

Absolutely.

Think of this sequence:

    ... edit edit edit to enhance the program a lot
    ... oops, noticed that there is a small typo in hello.c
    ... fix and do "git add hello.c" (at least I thought I did)
    ... edit edit edit to enhance the program a lot more.
    ... it is a good time to get rid of the trivial fix first.
    $ git commit -m 'hello.c: typofix the message'
    ... oops, I mistyped the earlier one as "git ad hello.c" and
    ... didn't notice it.

which is just an example.

And the problem is a lot bigger at the _conceptual_ level.

We promise to the user that "git commit" without paths (nor -a which is
merely a short hand to specify all the paths that have changed) to commit
only what has been added to the index.  If you earlier did "git add foo"
and "git add bar", changes made to these two files are the only changes
that are committed.  If you did only "git add foo", then changes made to
this one file are the only changes that are committed.  If you haven't
added anything yet, there is no change to be committed.

Special casing the last case (and only the last case) breaks consistency a
big way.  It is one more pitfall that users need to worry about.
