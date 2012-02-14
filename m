From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff-highlight: Work for multiline changes too
Date: Mon, 13 Feb 2012 16:05:05 -0800
Message-ID: <7v8vk6b7pq.fsf@alter.siamese.dyndns.org>
References: <20120210213209.GA7582@sigill.intra.peff.net>
 <1328910433-2539-1-git-send-email-michal.kiedrowicz@gmail.com>
 <20120213222702.GA19393@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 14 01:05:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx5tY-0007Xs-9Y
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 01:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758489Ab2BNAFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 19:05:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39470 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755925Ab2BNAFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 19:05:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 114E56153;
	Mon, 13 Feb 2012 19:05:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BjGeFpDrltfxMOFF70WxoEJWUGU=; b=i0CCIC
	n5xPXw9sOoJNzEoWuFByvoL9pxojKijD4rebmm40eIKF7pQhIA+cyJRp3zeGFvjA
	xptOvshLPOESOfmWaehttqM7nvkjmjyg6erVoKglr5KBtRSdFt3oI2fz8TxaTj0N
	ml/6K5ejjiis5L5lERpXyeZWKYDkwGmtl9R1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TyACDO9wTOQuLCuCmWGPoSB5YrjSEB/P
	u75q8pbMQJTqGvf2/ddQPvm7ChPdyoe/NE/e8EpKKlyCa2jywLZopo63C79w9cWr
	CJ+2DskoagYygDqSday2OOTFZjNkbR97HOWviWLDJOGjD1mVkSvXuvxJzLt/9ehI
	jMpATGuf51U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 089586150;
	Mon, 13 Feb 2012 19:05:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87D53614F; Mon, 13 Feb 2012
 19:05:06 -0500 (EST)
In-Reply-To: <20120213222702.GA19393@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 13 Feb 2012 17:27:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D25B8CA-569F-11E1-835E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190691>

Jeff King <peff@peff.net> writes:

> I ended up pulling your changes out into a few distinct commits. That
> made it easier for me to review and understand what was going on (and
> hopefully ditto for other reviewers, or people who end up bisecting or
> reading the log later). I'll post that series in a moment.

This is all nice.  As I am lazy and this is a long neglected contrib/
material I didn't even know it existed ;-), I am tempted to apply them
directly on top of 'master'.

This shows the first hunk of your "diff-highlight: refactor to prepare for
multi-line hunks" like this to me, by the way.

@@ -23,7 +23,7 @@ while (<>) {
            $window[2] =~ /^$COLOR*\+/ &&
            $window[3] !~ /^$COLOR*\+/) {
                print shift @window;
{-               show_pair}(shift @window, shift @window);
+               show_{hunk}(shift @window, shift @window);
        }
        else {
                print shift @window;

Is this intended, or is setting "diff.color.old = red reverse" not
supported (without the custom configuration, the leading blank on the old
line is not highlighted)?
