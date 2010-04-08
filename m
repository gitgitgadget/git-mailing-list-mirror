From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull with "no common commits" : danger?
Date: Wed, 07 Apr 2010 23:20:40 -0700
Message-ID: <7v1veq8nyf.fsf@alter.siamese.dyndns.org>
References: <v2t3abd05a91004071856s5811e086q17241996a359e172@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 08:21:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzl78-0005EG-2X
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 08:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758203Ab0DHGUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 02:20:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758026Ab0DHGUt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 02:20:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 62171A9A05;
	Thu,  8 Apr 2010 02:20:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=71GQeSQAuonVCI8/4JPk8inr/VI=; b=M27iQ2
	Vr5h3oXIqYmMt484A5sV5DSHJYlFox12AldV4bPyUArvE+3NptA9JpuNZlErKb+v
	SPX8OpYn043kiL4wkwr5/6GwM2bePUSRrVGHm/HYgfmMS7u5d1XE0vN0drHVuIvB
	+G9m5gGqpGOs1v6Lwk5Z0QK6uvSa5jxZYXnTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gg0GbEGP/oqsE9EZkV5upfQ4JnPBG/f5
	1ufsPHBFrJs8ti/+eiOIuMsiHFQaI2lWUnDminTCx8DdKWtP2scOL1r+YWyx8kch
	ZFvY8NzQzFFNvok7TAtC0i3g+kzN6yiGQJY42/UzUMgotqguSE1hItDEpybK6qQt
	OtoasRCVBWA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4006DA9A04;
	Thu,  8 Apr 2010 02:20:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B316A9A02; Thu,  8 Apr
 2010 02:20:41 -0400 (EDT)
In-Reply-To: <v2t3abd05a91004071856s5811e086q17241996a359e172@mail.gmail.com>
 (Aghiles's message of "Wed\, 7 Apr 2010 21\:56\:56 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE2CFF50-42D6-11DF-B3C7-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144323>

Aghiles <aghilesk@gmail.com> writes:

> I mistakenly pulled a project into another project. I had the
> "warning: no common commits" but the pull did proceed.
> I am wondering if, from a usability point of view, it would be
> best to avoid doing so by default.

Refusing this without an escape hatch would regress two minor but valid
workflows.

 1. "a cross-project merge" like 5569bf9 (Do a cross-project merge of Paul
    Mackerras' gitk visualizer, 2005-06-22) aka "The coolest merge ever".
    Being able to do this kind of merge after the fact is the whole point
    of allowing merges between two histories with no common commits.

 2. A not so uncommon newbie mistake sequence:

    $ git init
    $ git pull $there

    instead of the usual

    $ git clone $there
    
    which was an actual complaint that led to the "merge into emptiness"
    behaviour of "git pull" in such a case added as a new feature.

If we were to forbid a "nothing in common" merge by default and add an
option to explicitly allow it on demand, I would not be worried too much
about the first use case.  Anybody who runs a cross-project merge has
already learned git well enough that having to add an extra option is not
a problem.

But I would be unhappy if I have to be the one to hear complaints from
newbies who are now forced to add an obscure option to his "git pull" in
the second case.

So this is not so cut-and-dried from the usability point of view as you
seem to think.
