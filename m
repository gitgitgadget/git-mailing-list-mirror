From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-status segmentation fault in master / OS X
Date: Tue, 19 Jan 2010 16:56:18 -0800
Message-ID: <7vd4157fwt.fsf@alter.siamese.dyndns.org>
References: <57518fd11001190959n355a0f22p7caa7251b705efaf@mail.gmail.com>
 <20100120004146.GB16824@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan del Strother <maillist@steelskies.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 01:56:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXOs5-0003Wy-8p
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 01:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232Ab0ATA42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 19:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754196Ab0ATA42
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 19:56:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33348 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144Ab0ATA41 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 19:56:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E8E892499;
	Tue, 19 Jan 2010 19:56:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jmGk8tqtr0X8Kywso15Q5Nw5i9I=; b=b+zofd
	BPTvfbHnR0/+vYdmcpU3U/0CIhh6pYvMUvK2zC1tvNAaV8BDYJZaprttPF4LFPxB
	tyNO1VG81M6zY1SPtYcNEqtAuksfhylgZ85jDDVXEgd4ubbhiRBq1yUJLKFJGCdT
	eqLli+dhOLFEyh2jqYaO3kkGJOJt9AhsemUmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NzSLGSyNdyb+tZj6Cnmv21MWYMhj+MJH
	nhh+E9L8oimbVgFSWnJEid1md63uFCMfQ1c9Q2dR46k056GlQK9xJyJEMYxRDpG2
	Os2P7EUXeFKI7uEARow+KXY6tsQZoRqc69hLk1BV6lZaoEDPQ0NTSFn/Qovrj7QZ
	Bi3JNe/VEMw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CBE9B92494;
	Tue, 19 Jan 2010 19:56:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F228892493; Tue, 19 Jan
 2010 19:56:19 -0500 (EST)
In-Reply-To: <20100120004146.GB16824@coredump.intra.peff.net> (Jeff King's
 message of "Tue\, 19 Jan 2010 19\:41\:46 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A171BFCA-055E-11DF-ADAF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137510>

Jeff King <peff@peff.net> writes:

> Could be a bad interaction between commits on nd/sparse and whatever was
> done since it had branched. You can try rebasing nd/sparse and bisecting
> a linearised version, like this:
>
>   bad_merge=73d66323
>   # pretend we are on nd/sparse
>   git checkout -b test $bad_merge^2
>   # rebase onto what we merged onto
>   git rebase $bad_merge^1

That is a very good suggestion.

You will get hit by a few conflicts during the rebase, but I managed to
arrive at the same tree as $bad_merge after running the rebase procedure
above.  Just for Jonathan's convenience, the result is at:

  git://repo.or.cz/alt-git.git junk-linearized-nd-sparse-for-bisection

I'll remove this after a few days.

>   # now bisect. what we have now is presumably
>   # bad (though you should probably double check)
>   # and from the previous bisect we know that
>   # everything pre-merge is good
>   git bisect start
>   git bisect good $bad_merge^1
>   git bisect bad

It would be interesting to hear the result of the test in the particular
repository Jonathan is seeing the problem with.  The issue didn't
reproduce for me, either but I only tried "having a staged change" case
without any more detailed set-up.
