From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] install_branch_config: simplify verbose messages logic
Date: Thu, 13 Mar 2014 11:34:13 -0700
Message-ID: <xmqqr466hrru.fsf@gitster.dls.corp.google.com>
References: <1394584412-7735-1-git-send-email-pawlo@aleg.pl>
	<CAPig+cTmdF06PrWboJFNFEGKLCa=3rmGrcPusSsYZxdtfSEewA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Pawe=C5=82?= Wawruch <pawlo@aleg.pl>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 19:34:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOASZ-0002O8-UN
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 19:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754945AbaCMSeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 14:34:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44020 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754927AbaCMSeW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 14:34:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC7C8730BE;
	Thu, 13 Mar 2014 14:34:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R2UjpW8yaGGgkFIWRzUpKTXSIkc=; b=QmH8EG
	dD4ug0j5DkKG7Jd5vn875eOmFRKAn0RLJQp6SF4PalWAmjRvoFALPnjoIs4vh1Zw
	V5RVkmTEzwtjgHzlexi8SHJHbaP0uUiz0G6mciqXHzMmSqKmbcY69AvLVeKvisGV
	fQFpJOXGusMGz4eq5UMi4Mj8hJujycI8xJlc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KNaPoJQv6Cdtddbl2YF3IvGOwF+TZQ4Z
	V9VjEpiL7eASP3Nr7JHxX7eExgVtPSmuSNzElj8Y2LozXSqdcb70jLgx7hTEQsXm
	ju8mtk042hN20+E4yRdUBHoAqVYANf7H9xRQsfZNmdECCiXwWZGHx1Yf1rD8vcZr
	/iLzMikmVsU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AADD7730BD;
	Thu, 13 Mar 2014 14:34:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC46B730BB;
	Thu, 13 Mar 2014 14:34:15 -0400 (EDT)
In-Reply-To: <CAPig+cTmdF06PrWboJFNFEGKLCa=3rmGrcPusSsYZxdtfSEewA@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 12 Mar 2014 01:36:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 14CE255C-AADE-11E3-B24B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244043>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Shouldn't this logic [to decide what the printf arguments should
> be] also be encoded in the table?
> ...
> The same argument also applies to computation of the 'name' variable
> above. It too can be pushed into the the table.

Because the "printf argument" logic does not have to be in the
table, the same argument does not apply to the 'name' thing.

After looking at the v5 patch, I do not think an extra two-element
array to switch between remote vs shortname is making it any easier
to read.  I would have to say that personally I find that

	const char *name[] = {remote, shortname};
	... long swath of code ...
	printf_ln(... name[!remote_is_branch] ...);

is a lot harder to read than:

	printf_ln(... remote_is_branch ? shortname : branch ...);

HTH, and thanks.
