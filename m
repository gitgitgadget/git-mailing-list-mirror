From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gc --auto: warn garbage collection happens soon
Date: Wed, 28 Dec 2011 12:02:18 -0800
Message-ID: <7vfwg41n3p.fsf@alter.siamese.dyndns.org>
References: <1324993534-16307-1-git-send-email-pclouds@gmail.com>
 <7vpqf94r8c.fsf@alter.siamese.dyndns.org>
 <20111228184000.GA18780@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 28 21:02:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rfzhz-0001nn-Pp
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 21:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192Ab1L1UCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Dec 2011 15:02:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64819 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754165Ab1L1UCV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2011 15:02:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAB287810;
	Wed, 28 Dec 2011 15:02:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z3LbF616hI9BJnAEs3v+QfYo9To=; b=nbc4cV
	R6F2/ent9Rvfl9GivQ9S6lDDdly6YQoebvb4+oXf7W8xqhJncyNBYpRZTNRNFiHU
	YKCI+icu9GdHQCFR5mgd4BEzG7/bpQDziW8qUCtKy0bQ/PqG9Wy9m3WfUC78q87Q
	5KwQKfwCWWXbxNuWeiOL0nApa9nh6GzubWqT8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QEjht6JdYSp0lzLyn8usC3qGm2GatSG7
	g3p8FfFCrwOs3abTXTApr4ibQolq7TMBaG/M8pqwpFAi8b276NMs8HFsB5sQ/YEo
	FSkM+0miTVYmwGqUHyc1P2QpsOkogBWtXq03HoW+m0Md5UjTYZtHHUXDQA6XE6ho
	tTWMSBM5gxs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3672780F;
	Wed, 28 Dec 2011 15:02:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6752A780E; Wed, 28 Dec 2011
 15:02:20 -0500 (EST)
In-Reply-To: <20111228184000.GA18780@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 28 Dec 2011 13:40:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D9A3E3E2-318E-11E1-8E9A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187756>

Jeff King <peff@peff.net> writes:

> [1] Actually, it's not just having objects. You may have just exploded
>     unreachable objects from a pack, but they are still younger than the
>     2 week expiration period. Therefore trying to prune them is
>     pointless, because even if they are unreachable, you won't delete
>     them. So you really want to say "how many actual candidate objects
>     do we have for pruning?"

An obvious knee-jerk reaction is "Ugh, if we have very recently repacked,
don't we know what are reachable and what are not already, and use that
knowledge while pruning to avoid traversing everything again?"

My memory around repack, fsck and prune needs refreshing, though, to tell
if that suggestion is feasible.
