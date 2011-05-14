From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/2] receive-pack: Add receive.objectCountLimit to
 refuse push with too many objects
Date: Sat, 14 May 2011 10:50:18 -0700
Message-ID: <7voc355fz9.fsf@alter.siamese.dyndns.org>
References: <201105131854.31540.johan@herland.net>
 <7vpqnm7cim.fsf@alter.siamese.dyndns.org>
 <201105140343.48741.johan@herland.net> <201105140403.09981.johan@herland.net>
 <BANLkTik_taBK+=nh+0WEUjp3AV_fC7e_dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 14 19:50:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLIz3-00067i-Hz
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 19:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684Ab1ENRu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 13:50:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51497 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab1ENRu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 13:50:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DE28A585C;
	Sat, 14 May 2011 13:52:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d+GZqBheEDOPh0UtvG0NmRqBris=; b=oB8v6P
	sp0NE59lz8ifJfiqfQ8t/6pYKJerdaErEuPuRDQZW4yjl9La1lOM74awWtutxG/b
	MWtpaxy+0uaxnXIL9k1JrDO2zG4333uooiURpQzq3tPS5Oi+vqVVVfKIXkVShnQu
	2+pDDGVNBMgi/IiuCdp88faMqHuPyTHfcQ+08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ssAyA1bQXObq2oN7ReuFy+gCJBbBatMv
	SPJ5l5RsFRr9O7xK4e+MdhxyEHUPnkEGBRdMyJMNLgT5zoQzA0q33Ty+GHAfvxSf
	cjRmNBwmpOVZ9+/mkNXX0FTGY7ZBxH2xhnVWlPM9mbKb2pQYvFUcJo11zWHHCwPm
	pkExeqf/9+c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AD53B585B;
	Sat, 14 May 2011 13:52:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A3D4B585A; Sat, 14 May 2011
 13:52:26 -0400 (EDT)
In-Reply-To: <BANLkTik_taBK+=nh+0WEUjp3AV_fC7e_dg@mail.gmail.com> (Shawn
 Pearce's message of "Fri, 13 May 2011 19:30:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F05F2582-7E52-11E0-AEE7-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173598>

Shawn Pearce <spearce@spearce.org> writes:

> If we are going to put limits in, does it make sense to try and push
> these limits back to pack-objects in a more detailed way? You talked
> about depth of history, or size of pack. pack-objects could
> approximate both.

I think the receiving end switches between index-pack and unpack-objects
based on the object count, but if we can add a protocol extension to carry
these estimates from the sender, we would be much better off. A large push
with a small number of objects would want to keep everything in a pack,
for example, but currently there is no way to do so.
