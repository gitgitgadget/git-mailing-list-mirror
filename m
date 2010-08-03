From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: support -X to pass through strategy options
Date: Tue, 03 Aug 2010 16:07:43 -0700
Message-ID: <7vaap3i9c0.fsf@alter.siamese.dyndns.org>
References: <80763c667fa4685d2b6451838c0f1809e86fe07e.1280354419.git.trast@student.ethz.ch> <7vd3u6uv41.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>,
	Mike Lundy <mike@fluffypenguin.org>
X-From: git-owner@vger.kernel.org Wed Aug 04 01:08:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgQaW-0004MP-HW
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 01:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757919Ab0HCXHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 19:07:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756225Ab0HCXHy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 19:07:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 23655CA72F;
	Tue,  3 Aug 2010 19:07:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=/yHuEZzkNNNtTpp36pWpKfajOPo=; b=g9u2lPf4COkuAGZIUhm49PR
	uRdr3B6jNidkQSJudpb3caw0nPZvQ96yAVHrg+AnKnBrshG4IkN4KZYzxtcCfU9d
	Ocm//zbW4F5yt7mz5pYWazv5mLV8Efg/u5h1clyeB3IYlNeDV1c7ygkBSh3n+Wx9
	cN+dbBLTAA/2FsL3GW3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=wErTmEKEXK/OyzvaPUyJwl5kYnvAwDKuZWy5d5rKoz5LcSTGa
	AF3t6j2LWEQUTbB8dBzBM+sgO8axzGLfQY9qqI0Wg1kJJfP0uq+laKHAqNS7/CZa
	XwtN/lauYp/T6VFesMy/ClPwEoukEXQ9r96OffKtXXcnP/w+eX/dTjsWE0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D3EA2CA72E;
	Tue,  3 Aug 2010 19:07:48 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2173BCA724; Tue,  3 Aug
 2010 19:07:44 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EF2F4D9C-9F53-11DF-8572-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152547>

Junio C Hamano <gitster@pobox.com> writes:

> Looks good; thanks both.

I spoke too fast.  You would need something like this on top to avoid
confusing certain implementations of "expr" (e.g. FreeBSD 8.0).

 git-rebase.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index b1743ea..7d1c5c3 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -302,9 +302,9 @@ do
 			newopt="$2"
 			shift ;;
 		*,--strategy-option=*)
-			newopt="$(expr "$1" : '--strategy-option=\(.*\)')" ;;
+			newopt="$(expr " $1" : ' --strategy-option=\(.*\)')" ;;
 		*,-X*)
-			newopt="$(expr "$1" : '-X\(.*\)')" ;;
+			newopt="$(expr " $1" : ' -X\(.*\)')" ;;
 		1,*)
 			usage ;;
 		esac
