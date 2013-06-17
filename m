From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] GIT-VERSION-GEN: support non-standard $GIT_DIR path
Date: Mon, 17 Jun 2013 13:09:03 -0700
Message-ID: <7vy5a8biu8.fsf@alter.siamese.dyndns.org>
References: <20130615230108.GA21005@kaarsemaker.net>
	<7v38sgcxjp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Jun 17 22:09:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uofjk-0006bL-DK
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 22:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042Ab3FQUJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 16:09:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56255 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929Ab3FQUJG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 16:09:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCEBA28E75;
	Mon, 17 Jun 2013 20:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fF/gEQrXTaVWjb8rEYBgYKhtf0o=; b=vxdLRq
	KQpDVO4+YtZ3BpO9gbY2+8kJfdMjBO4boPdprrEw8H+3judj8+HOPoWwGN/aXqmd
	fyuZn9drugbhaL7ubrx5VAQZYs8jLC+yjwdyl+R0yVVzyuZ2iLSjVVn8aIjZZw6X
	b+ox/8raXY244G3i5Ut1/P1q/lLiCJgd6+aT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wBRqAxHXLcJ1FDodLH5vypi30lMBTn7e
	YZ3Ke0eo3TwaLLNJMJ8ZEPbFzVKzKs1ewEm52DzfH0z5U+xfrDvfQonTGQPPKAdy
	sYXU28hFPzwkfT4LG+j2kwAoekOYEPEoZz8NLYUAHTetm+1V9IOKYcgkXCMnYx1m
	PbGomhZfH4s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1ADC28E73;
	Mon, 17 Jun 2013 20:09:05 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F01B28E71;
	Mon, 17 Jun 2013 20:09:05 +0000 (UTC)
In-Reply-To: <7v38sgcxjp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 17 Jun 2013 13:06:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2B06D70-D789-11E2-B76B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228108>

Junio C Hamano <gitster@pobox.com> writes:

> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>
>>  I'm doing daily builds of git, using many workers and a shared git.git,
>>  with per-worker checkouts
>
> OK, so GIT_DIR is explicitly specified in these "workers".
>
> Makes sense.

Actually it does not.  What if GIT_DIR is an empty string or not set
at all?  The patch breaks the build for everybody else, doesn't it?

Perhaps like this instead?

 GIT-VERSION-GEN | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 2908204..91ec831 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -11,7 +11,7 @@ LF='
 if test -f version
 then
 	VN=$(cat version) || VN="$DEF_VER"
-elif test -d .git -o -f .git &&
+elif test -d ${GIT_DIR:-.git} -o -f .git &&
 	VN=$(git describe --match "v[0-9]*" --abbrev=7 HEAD 2>/dev/null) &&
 	case "$VN" in
 	*$LF*) (exit 1) ;;
