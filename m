From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] revisions passed to cherry-pick should be in
 "default" order
Date: Wed, 15 Aug 2012 11:39:05 -0700
Message-ID: <7vr4r857au.fsf@alter.siamese.dyndns.org>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
 <50289e50.a19f320a.5d99.3fdfSMTPIN_ADDED@gmr-mx.google.com>
 <7vtxw6d0ct.fsf@alter.siamese.dyndns.org>
 <CAOeW2eEbe9_m_QSbsJUbWPhf6G17X3vqbh__TCefrB0G2VKXdw@mail.gmail.com>
 <7vehnacxkf.fsf@alter.siamese.dyndns.org>
 <CAOeW2eH--Y_gq4jBBhd5EQRw+uuaNWrMT-Sua7CeJO-N9KHCLg@mail.gmail.com>
 <7vk3x06ppi.fsf@alter.siamese.dyndns.org>
 <CAOeW2eFK+cKt9Tnh5oe74dU+f8rOOTaWk3KvE2rtUpgcOeDD7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 20:39:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1iUu-0007ED-4n
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 20:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163Ab2HOSjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 14:39:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44633 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026Ab2HOSjI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 14:39:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 380319A3F;
	Wed, 15 Aug 2012 14:39:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tuPuw647IDYAcTP18bO5YtOfRvw=; b=NSRNIL
	BDOtBvXsh4kIGNBI6YMhBK3V68wjtVsiUXTM9eR/H3eoNAiHfdcrMbSaSx5D+k8+
	wlf9qGvOm8eilAIryfXfQvWyCJtHvO/U+NELIGXYggGoQ1MGlnFyOpRf6Y/uS62p
	CSEyDb67OyD9028DiQCYlrioei+taf5D8f54s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hZJ6V9ptEpixjCV4pBQaUhkxXMLSxaKT
	HG7SbgWY7qo+/EVqlZu4fsOjfnf7uh5iNZQcB1cLCA8eZ7Goz5WPn7BvOunlGrgj
	G+ui8WBdkzOGg4PBOcHfImpVI6Vr2fOLaanWDpFJSQQC5fLNc3BpNcGUG7piLY3q
	SSTizrhcR7E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2400A9A3E;
	Wed, 15 Aug 2012 14:39:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B8049A3D; Wed, 15 Aug 2012
 14:39:06 -0400 (EDT)
In-Reply-To: <CAOeW2eFK+cKt9Tnh5oe74dU+f8rOOTaWk3KvE2rtUpgcOeDD7g@mail.gmail.com> (Martin
 von Zweigbergk's message of "Wed, 15 Aug 2012 11:22:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E7458AA-E708-11E1-8256-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203483>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> Makes sense, I'll try to implement it that way. I was afraid that
> we would need to call prepare_revision_walk() once first and then
> if we afterwards find out that we should not walk, we would need
> to call it again without the reverse option.

> But after looking at
> how rev_info.reverse is used, it seem like it's only used in
> get_revision(), so we can leave it either on or off during the
> prepare_revision_walk() and the and set appropriately before
> calling get_revision(), like so:
>
>   init_revisions(&revs);
>   revs.no_walk = REVISION_WALK_NO_WALK_UNSORTED;
>   setup_revisions(...);
>   prepare_revision_walk(&revs);
>   revs.reverse = !revs.no_walk;

Sorry, but I do not understand why you frutz with "reverse" after
prepare, and not before.

I think you can just set no_walk and let setup_revisions() turn it
off upon seeing a range (this happens in add_pending_object()).
After setup_revisions() returns, if no_walk is still set, you only
got individual refs without ranges, so no reversing required.

You also need to be careful about "revert" that shares the code;
when reverting range A..C in your example, you want to undo C and
then B, and you do not want to reverse them.
