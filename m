From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix wrong failures in config test
Date: Mon, 10 Jan 2011 13:30:12 -0800
Message-ID: <7v62tw5twb.fsf@alter.siamese.dyndns.org>
References: <7vhbdg6286.fsf@alter.siamese.dyndns.org>
 <4d2b5c52.68e3cdc2.bm000@wupperonline.de> <20110110194242.GA11801@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 10 22:30:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcPJv-0001e7-Gx
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 22:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754873Ab1AJVaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 16:30:25 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55050 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710Ab1AJVaY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 16:30:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DF38F3C96;
	Mon, 10 Jan 2011 16:31:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5Y8Xy3WE/EwYDBwdcQNrCVk8PXs=; b=TFHLcY
	wuc6OX8QJzznRSI1F1MKHpvystKyH8/Vw9jHWWOnYnwRKBxVlLe5+6deBQxUeRkU
	tT7XqkkM74Zz0CtDsDzCL9wl88SngIj4YrJ4a86kEH36Ylkqe5ijhNsdbvNruHW7
	RIaC0Y68nDOjcR2G1L9QbR/zzNDzfvalrJUfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N9k3QFVeAjDeoRN/EYkIVWfCDRS6hN5R
	Vvd48KrqTC7HMGrPxXrLJnXCaPPN4L/y5CkmYlUYclhkhvCu046Q9Vs072ghXP4E
	91baIGarp5cGwkGHj3o0thNudkd31oZihG81gIIGzG8BF581liQKX+5hVZ4aRyXc
	ayzt3mts4Po=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A8FDC3C90;
	Mon, 10 Jan 2011 16:30:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8D4043C8F; Mon, 10 Jan 2011
 16:30:55 -0500 (EST)
In-Reply-To: <20110110194242.GA11801@burratino> (Jonathan Nieder's message of
 "Mon\, 10 Jan 2011 13\:42\:42 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EABC3C9A-1D00-11E0-B15A-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164895>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> Unfortunately, I had a shell alias function named git that interfered. In
>> fact it passes to the git program (command git "$@") but sadly does not know
>> about the newly set PATH and (still inexplicably to me) makes the variable
>> set.

Yuck.  I really do not want to do something like this X-<.

 t/test-lib.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index cb1ca97..df1b4f2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -77,10 +77,10 @@ export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR
 
 # Protect ourselves from common misconfiguration to export
-# CDPATH into the environment
+# CDPATH into the environment and such
 unset CDPATH
-
 unset GREP_OPTIONS
+unalias git >/dev/null 2>&1 || :
 
 case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
 	1|2|true)
