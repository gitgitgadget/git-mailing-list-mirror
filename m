From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help.c: Pull cmd_version out of this file.
Date: Wed, 01 Sep 2010 18:04:28 -0700
Message-ID: <7v39tt552b.fsf@alter.siamese.dyndns.org>
References: <2ae543604216146b742253584d8393c5e3179697.1283114573.git.tfransosi@gmail.com>
 <20100830023812.GA4010@burratino> <20100830024020.GB4010@burratino>
 <AANLkTimDjRz=JmiVn+ybQ5ewaj=7N5tp48fUArD5vG_H@mail.gmail.com>
 <7v1v9e803a.fsf@alter.siamese.dyndns.org>
 <AANLkTinHJHzcoFFjv-TaQ+DYVyqn46fqA802m8Lq5anp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 03:05:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqyEi-0002uk-Ie
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 03:05:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348Ab0IBBEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 21:04:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205Ab0IBBEj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 21:04:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 35BF4D2D1B;
	Wed,  1 Sep 2010 21:04:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=wnYdq8v3I9kqN6B0MDNsLPccMNk=; b=iw9b54Jf3fOQ+Lo8X3SND51
	TCyIqe1xkFiBkkCHAVAECjXXQMWaDoc+AVDrsHLQXAg8NLMTqgJsoUGjGXkeYG6c
	MW8K4zTK/x3+HTf7+5GnHgAG4rqHY8uTkRRo38v2PW5VIA3ouw9g1eODLEt7JXn4
	AegvI6BkpI0sErbqhLLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=iSRP5l24nVViUwr5gaD99aEssrei5JeQx2oqNtp7R8ggWY/Uf
	9ekn+zf5cxmfAYILEM/1p4lefmJjCfl4tHJ0/K3n01otqD9nQl//r9t2FbBnCBCF
	lpdAjTEZdTgIm6O2cH8om8dzzNGqSxKk/l4cjatUNutOHCYeliI4s5DSPM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 01D2CD2D15;
	Wed,  1 Sep 2010 21:04:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF288D2D0B; Wed,  1 Sep
 2010 21:04:30 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D26B484-B62E-11DF-A74C-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155099>

Thiago Farina <tfransosi@gmail.com> writes:

>>risk causing broken builds?
> Hum, how such trivial change can cause that?

Imagine if we had this in help.c:

        int cmd_version(int argc, const char **argv, const char *prefix)
        {
                printf("git version %s\n", GIT_VERSION);
                return 0;
        }

which were compiled with this rule in Makefile:

	help.o: help.c GIT-VERSION-FILE

and then you moved the function to a new file without touching the
dependency.  Especially because the change is trivial (just moving a
function from here to there), you don't immediately notice the broken
dependency.

I just spent 15+ minutes explaining this to you (and another 10+ minutes
checking that the above is _not_ the actual case before giving the same
explanation to you last night).  Now is this still a trivial change that
costs nothing?

>>What did we gain through this exercise?  Did we fix any real problem?
> All patches should just fix real problems?

There is a "cost vs benefit" ratio you need to consider.
