From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 09/10] replace: check mergetags when using --graft
Date: Mon, 07 Jul 2014 15:28:13 -0700
Message-ID: <xmqqion8by82.fsf@gitster.dls.corp.google.com>
References: <20140707063342.3708.83493.chriscool@tuxfamily.org>
	<20140707063540.3708.29773.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jul 08 00:28:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4HOb-0002pS-4U
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 00:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbaGGW2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 18:28:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55738 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976AbaGGW2U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 18:28:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 25EF927285;
	Mon,  7 Jul 2014 18:28:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/xoRTernOS6Qj7qqdAx59an/Ong=; b=fCONGb
	4mkIhl4O+mpv5/ODFqvp+erPJVcu7+NNMRJfeT6giqJ5gvs0kT62GjQULT3nGMdL
	iLEftau66nCH/oXSMuNTNuoNSt4VLKWIbeV3Bjx241aTO5vjtH7R7hdPyoYbpafb
	3JZ9W9I2sqBfXECBIyU31v1BBLvVEbcZpDXJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ux3cCpuIIa/0bYgxQM7FF/1pviHYCwho
	dM/VfdatpDZHRzZKtxpULkK0xC/X3WiMUnW5MxWYKuCPIDBC/LrknDMFlX14ga/X
	cTbKEY/DXZObeXN6sliE2DJ1BvrwWFsHFl4ad1+ijyZKPfe6tQ/x21iN5+qEaFh4
	7/bx280Frlo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1CC5727284;
	Mon,  7 Jul 2014 18:28:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 06C432727E;
	Mon,  7 Jul 2014 18:28:02 -0400 (EDT)
In-Reply-To: <20140707063540.3708.29773.chriscool@tuxfamily.org> (Christian
	Couder's message of "Mon, 07 Jul 2014 08:35:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F4F28004-0625-11E4-B113-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252994>

Christian Couder <chriscool@tuxfamily.org> writes:

> When using --graft, with a mergetag in the original
> commit, we should check that the commit pointed to by
> the mergetag is still a parent of then new commit we
> create, otherwise the mergetag could be misleading.
>
> If the commit pointed to by the mergetag is no more
> a parent of the new commit, we could remove the
> mergetag, but in this case there is a good chance
> that the title or other elements of the commit might
> also be misleading. So let's just error out and
> suggest to use --edit instead on the commit.

I do not quite understand the reasoning.  If you have a merge you
earlier made with a signed tag, and then want to redo the merge with
an updated tip of that branch (perhaps the side branch was earlier
based on maint but now was rebased on master), it will perfectly be
normal to expect that the title or other elements of the resulting
merge to stay the same.  Why is it a good idea to error it out?

If the argument were '"replace --graft" that changes the parents is
likely to affect merge summary message, so error out and suggest to
use --edit instead', regardless of the 'mergetag', I'd understand
it, but that would essentially mean that 'replace --graft' should
never be used, so...
