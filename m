From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] cat-file --batch-check performance improvements
Date: Fri, 12 Jul 2013 10:23:34 -0700
Message-ID: <7vy59blmjt.fsf@alter.siamese.dyndns.org>
References: <20130712061533.GA11297@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 12 19:23:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxh4I-0008JM-0x
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128Ab3GLRXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 13:23:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38264 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964903Ab3GLRXh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:23:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE2462F064;
	Fri, 12 Jul 2013 17:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P/4uukMR7fUZFOW2mcKxMba7BT8=; b=SWRdXy
	HBjy3V4KfZC0YrQDCqLbGAPvuQW3tyAEyY0qsV38jFK6KUUelc9ENTJYxHaoE3+n
	6Vxg2hYNqM1jsNQusBm2Hp5sD8dtL0xtRYwKShc4hMvdIMaqSBweNc0hWDKmsHuN
	faDCHpUpDfF1WgzUkqVaCTM1R7IuhNYidmYDM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QMxlti8mmtclYO5E55n74rWbGwx/OshF
	zfukOhnvPI+TdaffM3m15j7s84NrPxezDDy/TifyDhATeorlDUW+axo2ZYeppRAc
	oeY6zIKJ0zm3v6ZJyx2yUVHTWIiB+CnJVuHT2AHN7QGiiY0LND2T4veTKO8J8KFP
	6X07sRGaqoo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2A792F063;
	Fri, 12 Jul 2013 17:23:36 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 213762F061;
	Fri, 12 Jul 2013 17:23:36 +0000 (UTC)
In-Reply-To: <20130712061533.GA11297@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 12 Jul 2013 02:15:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C8E0563C-EB17-11E2-8E35-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230209>

Jeff King <peff@peff.net> writes:

> The results for running (in linux.git):
>
>   $ git rev-list --objects --all >objects
>   $ git cat-file --batch-check='%(objectsize:disk)' <objects >/dev/null

I can see how these patches are very logical avenue to grab only
on-disk footprint for large number of objects, but among the type,
payload size and on-disk footprint, I find it highly narrow niche
that a real user or script is interested _only_ in on-disk footprint
without even worrying about the type of object.

> ... (though I think the result actually cleans up the
> sha1_object_info_extended interface a bit, and is worth it).

I tend to agree, especially eyeballing the result of 7/7.

Thanks.
