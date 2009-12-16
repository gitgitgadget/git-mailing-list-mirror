From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Giving command line parameter to textconv command?
Date: Tue, 15 Dec 2009 17:05:52 -0800
Message-ID: <7vljh3wwwf.fsf@alter.siamese.dyndns.org>
References: <20091215071735.6117@nanako3.lavabit.com>
 <7vvdg9ceud.fsf@alter.siamese.dyndns.org>
 <20091215121110.6117@nanako3.lavabit.com>
 <7vfx7c3hmb.fsf@alter.siamese.dyndns.org>
 <20091215164959.GA21322@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 16 02:06:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKiLO-00077T-Fp
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 02:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934359AbZLPBGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 20:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756092AbZLPBGM
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 20:06:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38992 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832AbZLPBGG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 20:06:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0CDE0A7A75;
	Tue, 15 Dec 2009 20:06:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=VHMAko09Qcvy3IjSlQyHLxYv8jA=; b=eox720tpCUN0Hc/RRI+mXJx
	AFUtXTDWL+bwKPa8FxIYkhZ0MRTcG4cZCjObK5PShbKMrfunyj3z8z23nSApRNgy
	jcTAgfuVurOGzZKB3Bwe27fU/R96tgZu9K86q5b46gmSkGDgdlEndyzxkzhdFVxi
	EOrR+47EPqvjOfw5FUD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=j4OOd83/6sUK8oOf0RagwkO9n9wnDOyrz/GE2fZsvxffgKEDx
	1nsxVDLfIcPfILpNlLMPAobF5bbHSItBI5D2YHqg/DDYRi4vm1ueRaKNBd0clUaZ
	K5pztfEMNnN+XnY8qubK6/J0AwodeYNhEENRukbABrDw7SmA2p5SGJwCJg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CBE1BA7A74;
	Tue, 15 Dec 2009 20:05:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6C051A7A73; Tue, 15 Dec 2009
 20:05:54 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2BB4108E-E9DF-11DE-8E8E-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135311>

Jeff King <peff@peff.net> writes:

>>  - diff.c::run_external_diff() that runs GIT_EXTERNAL_DIFF defines that
>>    the command has to take 7 parameters in a fixed order, and is not
>>    designed to permute its arguments like ll_ext_merge() does, but these
>>    days people don't use it directly (they use it indirectly via
>>    "difftool" wrapper), so it probably is not an issue.
>
> There is also diff.*.command, which I think people _do_ set manually (I
> used to, until I wrote textconv. :) ).

I had to spend fair amount of time to find where "diff.*.command" is
described.  We may want to update the documentation.

> .... I agree that people almost certainly have to write a shell-script
> wrapper anyway. But I wonder if we should pass it through the shell,
> just for the sake of consistency with the other variables (in
> particular, if textconv changes,

This covers GIT_EXTERNAL_DIFF, diff.external, and diff.<driver>.command
trio, if I am not mistaken.

If we changed run_external_diff(), in practice nobody would notice, except
for people who have installed the difftool helper in a directory with IFS
in the path.  That's one downside but I don't offhand see a use case where
the change would make somebody vastly happier.

But maybe people will find good uses and we'll never know until we try.
Care to roll a patch for that as well, to be queued for 1.7.0 (which will
be the one after 1.6.6)?
