From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/19] completion: use bash builtins to search for
 repository
Date: Wed, 09 May 2012 15:59:30 -0700
Message-ID: <7vsjf9ot9p.fsf@alter.siamese.dyndns.org>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
 <1336524290-30023-11-git-send-email-szeder@ira.uka.de>
 <7v62c5rv1q.fsf@alter.siamese.dyndns.org> <20120509223444.GH6958@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu May 10 00:59:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSFr8-000244-2q
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 00:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759046Ab2EIW7d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 18:59:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47527 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756901Ab2EIW7c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 18:59:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 144588555;
	Wed,  9 May 2012 18:59:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OvwXU4JQ1BsG
	75Zh1iAeWX99xKE=; b=cUIF6NyGxLTLLDjvHkLL8xmy35RihjQ/qq4kVSS/7Nfq
	OBq8gMs05uQBdYriiiClSGEhCe7kKNKGMrI0eF3YwIivNtXrHFad5iGOl5eQ6eT6
	P22rbbVeZ8LRaqzL6+4kYAEnWk+RE3MgX4wFTowzGv6l/iuoWb27XpZzZ3U+CPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sV/p2X
	hdOJhhjBhQvYhJjuvnBLEbI8aaH3c2LldxImpPhjhu5VsDennnvL8fURr68RaFpx
	dFSuyTWd8OWYHKNd38rjRGnkpHk3ONjwxylqpI/YXeeGV2EQorwvcE71eVpzdiI+
	M5QVybzoJVo4j7KhoBSd0JkHvIo1mo3YOySks=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 090C18554;
	Wed,  9 May 2012 18:59:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 927FF8553; Wed,  9 May 2012
 18:59:31 -0400 (EDT)
In-Reply-To: <20120509223444.GH6958@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of "Thu, 10 May 2012 00:34:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A341906A-9A2A-11E1-A08C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197528>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> I'm not sure what you mean by opt-in.  It's already opt-in in the
> sense that users have to set $GIT_DISCOVERY_ACROSS_FILESYSTEM to
> enable this logic.  Or do you mean that
> $GIT_DISCOVERY_ACROSS_FILESYSTEM should not implicitly enable this
> logic, but it should be controlled by a new dedicated variable?

Exactly.  In the three words in DISCOVERY_ACROSS_FILESYSTEM, I do not s=
ee
anything that indicates that the user wishes to use a "may be faster in
some situations but may be less correct" behaviour for one thing.  Also=
,
some day you or somebody else may find out how to take advantage of the
new code in this patch series and still stop at the filesystem boundary
and at that point, people may want to still forbid git to go up across
filesystem boundary and want to use the new prompt code.  Tying these t=
wo
independent concepts (i.e. "do I want to use the new experimental promp=
t
code?" and "do I want git to stop going up across fs boundaries?")
together only because the initial implementation happens to rely on it =
is
not such a good idea.
