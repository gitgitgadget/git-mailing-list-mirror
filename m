From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add option -b/--branch to clone for select a new HEAD
Date: Tue, 25 Aug 2009 15:42:36 -0700
Message-ID: <7vvdkbms6b.fsf@alter.siamese.dyndns.org>
References: <1251228341-29434-1-git-send-email-catap@catap.ru>
 <1251228467-29638-1-git-send-email-catap@catap.ru>
 <20090825215726.GA30981@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kirill A. Korinskiy" <catap@catap.ru>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 26 00:43:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg4jG-0001kG-8W
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 00:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756271AbZHYWmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 18:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756266AbZHYWmp
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 18:42:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44565 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756248AbZHYWmo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 18:42:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 23F46378C6;
	Tue, 25 Aug 2009 18:42:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bQ8zKcLnIeun2xfo5AUBRCJPVz8=; b=mRygPA
	RQAQLEL6ltRKHNCF4ixflbK1j/MhCBH0LmCq7Z2jKEmkSUrNQ/mQTg/JXyGMtW2f
	j3JyuM6MbUWGqIq6wWyDMQZPjFBvnrntVV/Bd4ekQNlUC8JNdwbVt3JfEuKrotgI
	hieWqHtKSVYQlgumgPsxFRO1e2ARC5hqM4s94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pLdXwBEdDTrIA//jW/ce1dMzbjlX/6Gr
	94udsHp3t/An1ooHSbnFeDultPB2DgweY+NGSaLVJLCN7rEIW9PNCwgkiGF+pKhl
	xVvr+veqRcY6PY0tKohzpib5KVLdbt9deJ+AD8H134If10UZr1mCfEmZAmdHCabK
	La26qjMTmJU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ED078378C2;
	Tue, 25 Aug 2009 18:42:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E8CA6378C1; Tue, 25 Aug 2009
 18:42:37 -0400 (EDT)
In-Reply-To: <20090825215726.GA30981@coredump.intra.peff.net> (Jeff King's
 message of "Tue\, 25 Aug 2009 17\:57\:26 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 99E711EC-91C8-11DE-A691-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127054>

Jeff King <peff@peff.net> writes:

> On Tue, Aug 25, 2009 at 11:27:47PM +0400, Kirill A. Korinskiy wrote:
>
>> +test_expect_success 'clone' '
>> +
>> +	git clone parent clone &&
>> +	(cd clone && git rev-parse --verify refs/remotes/origin/master)
>> +
>> +'
>> +
>> +test_expect_success 'clone -b' '
>> +
>> +	git clone -b two parent clone-b &&
>> +	(cd clone-b && test $(git rev-parse --verify HEAD) = $(git rev-parse --verify refs/remotes/origin/two))
>> +
>> +'
>
> OK, I think that second test makes sense (though please wrap the very
> long line), but now what is the first one doing? Shouldn't it be:
>
>   (cd clone &&
>    test $(git rev-parse --verify HEAD) = \
>         $(git rev-parse --verify refs/remotes/origin/master)
>   )
>
> also?

Are you checking that the HEAD (whichever branch it points at) points at
the same commit, or are you also interested in the _current branch_ to be
a particular name as well?  The suggested check only compares commits and
HEAD can be pointing at a local branch whose name is xyzzy.

What is the semantics of this new -b option?  When the remote repository
has 'next' as its default branch (i.e. HEAD points at it), and if you run
clone with "-b maint" against it, I expect that the checked out commit
will be the 'maint' of remote repository, but what is the name of the
current branch in the resulting clone on our end?

 - Would we use 'master' as the name of our current branch, because that
   is the default?

 - Would we use 'next' as the name of our current branch, because that is
   what the remote side uses?

 - Would we use 'maint', because that is what -b gave us?

I am _hoping_ it is the last one, as otherwise you would also need to make
sure that the branch that is different from 'maint' we set as the current
branch must track 'maint' from the remote.

Oh, with -b, would we set up our 'maint' to track their 'maint'?  Is it
something you may want to verify as well?
