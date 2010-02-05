From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rebase vs rebase -i
Date: Thu, 04 Feb 2010 17:18:19 -0800
Message-ID: <7vy6j8pjj8.fsf@alter.siamese.dyndns.org>
References: <76718491002032019i5f8ea947paa527988ddb7a378@mail.gmail.com>
 <alpine.DEB.1.00.1002041414530.4505@intel-tinevez-2-302>
 <76718491002040914t12956bb2gbe21ae89f31cbc7f@mail.gmail.com>
 <alpine.DEB.1.00.1002041859000.4505@intel-tinevez-2-302>
 <76718491002041010k84ad55ct5c3e80529e8f8428@mail.gmail.com>
 <alpine.DEB.1.00.1002041946170.4505@intel-tinevez-2-302>
 <76718491002041157o37de139brb7995076274375aa@mail.gmail.com>
 <7vmxzose72.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 02:18:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdCqE-0006CK-2B
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 02:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755616Ab0BEBSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 20:18:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53832 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754405Ab0BEBSa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 20:18:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AC2B96A31;
	Thu,  4 Feb 2010 20:18:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=HMN1atj3hqmionBFju6z4FXUb6g=; b=B6GXlE
	opelM2Qzx1ebnU/8ynteiKrms04TLhiMzK4QsQJ5pvN/ssp+w2hxcSra7tDNYXWs
	TOLImeUa6uYV9Bbhy6VZuwOGxb/mAlRJhZh+G1iGokkFJq/y7DygCKevmwthNPbU
	MEgCS6UTWGfAb7VErFcn2NuI924WPuUA/vmLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KFF71oZ6BeI4FZAftiObAe4QqmlH0WfJ
	E/Bn8/JnQwUjdSTwdqGs96BwWXDFfPoAuBk8gOB+ss/qv1uBWXe8yLnjrGJC6bNo
	uqiKNgB2vfsCAG6U7l9YFSqL9J9cv0ko1ZdO/SzYDJv38oKtVt2y+Tw8C9MLb9qO
	aIXQ8kKtiwY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B34596A30;
	Thu,  4 Feb 2010 20:18:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42F3D96A22; Thu,  4 Feb
 2010 20:18:21 -0500 (EST)
In-Reply-To: <7vmxzose72.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 04 Feb 2010 16\:45\:21 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5B989DC8-11F4-11DF-9240-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139018>

Junio C Hamano <gitster@pobox.com> writes:

> And no, "format-patch --stdout | am -3" pipe in the normal rebase codepath
> will stay unless you can produce a benchmark that says the performance of
> merge machinery is good enough these days.  Back when "rebase -m" was
> introduced, it wasn't.

Just for fun, I pulled from the kernel tree.  Its tip is at fc76be4 (Merge
master.kernel.org:/home/rmk/linux-2.6-arm, 2010-02-04), which is a merge
of a subsystem tree into the mainline.

I tried to rebase HEAD^2 (i.e. subsystem change) on top of HEAD^1 (the
state Linus merged that subsystem change into).  Either way, the
experiment is to linearlize a side branch that has 16 patches:

The experiment is to take a history of this shape:

  --A-...--N--O--P master^2 = test (subsystem tip)
                  \
             ---X--Y master
          master^1

and turn it into a history of this shape:


  --A-...--N--O--P master^2 = test (subsystem tip)
                  \
             ---X--Y master
                 \
                  A'-B'-...O'-P' (rebased tip)

The tree at rebased tip P' must match the merge Y, of course.

First, to prepare:

    $ git checkout -b test master^2 ;# at the tip of subsystem
    $ git checkout HEAD^0 ;# detach so that I can easily repeat

Best of 5 runs on my box are:

    $ git reset --hard test && time git rebase master^1
    real    0m3.060s
    user    0m1.976s
    sys     0m0.812s

vs

    $ git reset --hard test && time git -m rebase master^1
    real    0m19.060s
    user    0m15.025s
    sys     0m3.564s

The numbers are understandable; the series touches only 12 paths among
31.5k paths, so applying patches has to be faster.

I have a plan to make a merge go faster by using a yet another merge
strategy, but that has been backburnered for now.
