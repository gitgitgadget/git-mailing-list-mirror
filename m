From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse_object: try internal cache before reading object
 db
Date: Thu, 05 Jan 2012 13:55:22 -0800
Message-ID: <7vehvdn7at.fsf@alter.siamese.dyndns.org>
References: <20120105210001.GA30549@sigill.intra.peff.net>
 <7vipkpn87d.fsf@alter.siamese.dyndns.org>
 <20120105214941.GA31836@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 05 22:55:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RivHX-0005Ok-54
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 22:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450Ab2AEVzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jan 2012 16:55:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47694 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932299Ab2AEVzY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 16:55:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3563A6CF7;
	Thu,  5 Jan 2012 16:55:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pwguPrr7D+0ufE2HIvo8E5qB0oo=; b=ds1ptJ
	n3G87tCtRFj9+llsQYK0Wviq3jfvGBfzmbvFUzVrNfzx0NprMAy4++zKgafau5X6
	kvP0pfsV4aZeW4HxdUpG2Ueq+vOZZqbyZBn+4uLjev2gwc3z2S2wO1xwsL5T2gxa
	fTOQwBxDQO1UB49H8ph1zK0npUIx5XBC3yOl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rJZA6OhRts/YxcXIt/Lk70olWWn3Okmr
	mIiXlBeZbP/0WDGbP1jBImofYbXrhLrrrK8KV78gBskTu/MsgEdPW7Xjb6s/aMXo
	dMBygWkYWHH6G8fEVjSKgViGIETCOvEI0QItdSDqZLvAYje1DKdeh5Jkc08mDkVJ
	3QaFd9l7RuY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C3F66CF6;
	Thu,  5 Jan 2012 16:55:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 985476CF5; Thu,  5 Jan 2012
 16:55:23 -0500 (EST)
In-Reply-To: <20120105214941.GA31836@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 5 Jan 2012 16:49:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F80C4F2C-37E7-11E1-83A5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187998>

Jeff King <peff@peff.net> writes:

> The worst potential problem I could come up with is if you somehow had
> an object whose "parsed" flag was set, but somehow didn't have its other
> fields set (like type).
> ...
> So I think it is safe short of somebody doing some horrible manual
> munging of a "struct object".

Yeah, I was worried about codepaths like commit-pretty-printing might be
mucking with the contents of commit->buffer, perhaps reencoding the text
and then calling parse_object() to get the unmodified original back, or
something silly like that. But the lookup_object() call at the beginning
of the parse_object() already prevents us from doing such a thing, so we
should be OK, I would think.
