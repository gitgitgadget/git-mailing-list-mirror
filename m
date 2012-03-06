From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] perf: compare diff algorithms
Date: Tue, 06 Mar 2012 13:18:58 -0800
Message-ID: <7vr4x5qvgd.fsf@alter.siamese.dyndns.org>
References: <87pqcp6fyh.fsf@thomas.inf.ethz.ch>
 <f113867bcf2fec3210cd1a997e1398903b3bdd76.1331039505.git.trast@student.ethz.ch> <7vhay1se0g.fsf@alter.siamese.dyndns.org> <87y5rdzbpb.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	Michal Privoznik <mprivozn@redhat.com>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 06 22:19:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S51mm-0002Wf-AG
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 22:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920Ab2CFVTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 16:19:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61345 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604Ab2CFVTB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 16:19:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 670197B3E;
	Tue,  6 Mar 2012 16:19:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rX7jqXX3lrvtSKYga1W/6ymLGng=; b=e840QF
	BKobAA9j2ouE5NzWag7mQUCTd+ZQtoena2hkqtXFL0pTFUpF9Mk1XZEKV6GH66u+
	oVPppx72/9H9xgSoS5H7LAgWGaYRmsQnJtsd3eqAoLGiiRCtLwFNinrSxXjsDBJ0
	qbacTCs3r0fWg++quwtS175XUeceNDWI99GrM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BTtwsrlmgacuKhYXq+31FwbiNumdkND0
	5+8X/qQ72TRQ3D/fUHQFDzOv9WcrW4Tjh7hZr/HbezB3o54VD5Z0EOKH5aeAO3t5
	Ne7pjDELThv/ixAb4CeEo3Bm2eSpeEssMBOfKH3aEEnNDQUZJO8BTi7T3l9K7Ooc
	B7NPR2gAQTU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E1FB7B3D;
	Tue,  6 Mar 2012 16:19:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DAE017B3C; Tue,  6 Mar 2012
 16:18:59 -0500 (EST)
In-Reply-To: <87y5rdzbpb.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 6 Mar 2012 22:00:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FDA4AEC4-67D1-11E1-8197-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192396>

Thomas Rast <trast@inf.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>
>> I am getting this (probably unrelated to this patch), by the way:
>>
>> $ make perf
>> make -C t/perf/ all
>> make[1]: Entering directory `/srv/project/git/git.git/t/perf'
>> rm -rf test-results
>> ./run
>> ...
>> perf 4 - grep --cached, expensive regex: 1 2 3 ok
>> # passed all 4 test(s)
>> 1..4
>> Can't locate Git.pm in @INC (@INC contains: /etc/perl ...) at ./aggregate.perl line 5.
>> BEGIN failed--compilation aborted at ./aggregate.perl line 5.
>
> It would seem that you are not installing Git.pm as part of your normal
> installation?

I actually am installing it in a quite vanilla way.

I think our installation procedure places Git.pm in git specific
perl library path where a simple invocation of "perl" that is
git-unaware will not look into, and we make sure that our scripts
still find the matching version of Git.pm by having "use lib" at the
beginning that points at the right directory.

But of course, this from a command line would not work:

	$ perl -MGit

I do not expect it to, and for the ease of testing new versions, I
prefer it not to work.

In any case, you should be able to do anything under t/ _before_
installing, so relying on having Git.pm in normal @INC is a double
no-no.
