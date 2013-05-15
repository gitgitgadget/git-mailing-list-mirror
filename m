From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 0/2] refactor relative_path in path.c
Date: Wed, 15 May 2013 11:24:15 -0700
Message-ID: <7vli7gaypc.fsf@alter.siamese.dyndns.org>
References: <7vvc6ldtx7.fsf@alter.siamese.dyndns.org>
	<cover.1368630636.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 15 20:24:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcgND-0000OJ-IN
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 20:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933039Ab3EOSYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 14:24:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34811 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932980Ab3EOSYS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 14:24:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 131181F79A;
	Wed, 15 May 2013 18:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wGg7CwK0A1oAEgJOO9J6g98RFME=; b=NCtVbm
	7o0Qn0pJT1YMMfn4fBpv4OVo9iOH47BpKo6/CQLkwUuPqaTtX4dI/GHEYDiEk5yW
	vwd48U4nwbMyLcejk5rroTECUFTpy6eyqrIqRVnXAkkjvoJi1HK7573ALhawXF1K
	/40SxJWlbnWKz2Z/7RUNMaNqlkLpJfwl6co7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vodrA6GOzFS/0IOl9T3S2Xcl4y7w2ETb
	qobYoCHcRPidBgUUYutAtWS4ToZav4ZUfcbxT4l4mmthhcVTOyOhqpwMsUpt8IAL
	KqPyCguByC+Nu1KMK1uiN/59j2NEBvhLSssMNELBES0sAhMQZjTOpfSytIAZY+vw
	/RlaFYPwB6g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08D3C1F799;
	Wed, 15 May 2013 18:24:18 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62D071F798;
	Wed, 15 May 2013 18:24:17 +0000 (UTC)
In-Reply-To: <cover.1368630636.git.worldhello.net@gmail.com> (Jiang Xin's
	message of "Wed, 15 May 2013 23:18:37 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7483D18-BD8C-11E2-827A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224439>

Jiang Xin <worldhello.net@gmail.com> writes:

> These two patches enhance relative_path() in path.c, so that function
> relative_path() will return real relative path, not a path strip off
> the prefix.
>
> The 2nd patch is a bit aggressive, it refactor all related functions,
> remove unnecessary arguments: len and/or prefix_len.

I did not particularly find the second one "aggressive"; it would
have been much more pleasant to review if the "drop unused 'len'"
part were made into a separate patch [3/2] as a follow-up, though.

It is a bit sad that relative_path() in [1/2] uses a single static
and fixed sized buffer.  How is the new implementation making sure
the expanded result does not overflow the buf[]?
