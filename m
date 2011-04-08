From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] --dirstat: Document shortcomings compared to --stat
 or regular diff
Date: Fri, 08 Apr 2011 12:50:32 -0700
Message-ID: <7v1v1c4j5j.fsf@alter.siamese.dyndns.org>
References: <201104071549.37187.johan@herland.net>
 <BANLkTinEipewx2+Cx7Us0BSoSbjjU9uE6A@mail.gmail.com>
 <201104081646.35750.johan@herland.net> <201104081648.11842.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Apr 08 21:50:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8Hhh-0004Cx-AR
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 21:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757868Ab1DHTuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 15:50:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60201 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757802Ab1DHTun (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 15:50:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C84EB4D46;
	Fri,  8 Apr 2011 15:52:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=da45cE6IfERY19VDEIBIV/yVn1A=; b=KQz5Be
	qJfFRD0wT3EPZI7tLUlMGwzjyVE284OF1t+XBkErBXxxC7yJ3EjjmtL5K/lEzA9C
	Battd0l3Vd5pA/aRSyS8/kWRuX6Zwc2VrjaITNGtahoqvkehilq8RbsuclKkybSu
	B6IeoLacDX6l8kwVq3dtU6xWua+IGZF547UO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RzOvEv5BxQJ/zaUGBHwg2ydRMMPyOHoT
	/+LCOWteeQGv9LPT21J28dn3CrVlF5p5Rb/Ch40ac6EdgKHCyvUeJ6fkYNjMZyat
	4LyouWxu1NAtkuPcbf3g/3xSZejWyTPOl8zZN8Z2F3bYSpbBIS1EPIMw0boO9V5s
	ObwRuscZWpU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 90A484D45;
	Fri,  8 Apr 2011 15:52:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3B6764D44; Fri,  8 Apr 2011
 15:52:29 -0400 (EDT)
In-Reply-To: <201104081648.11842.johan@herland.net> (Johan Herland's message
 of "Fri, 8 Apr 2011 16:48:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF4E2DA8-6219-11E0-8A85-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171152>

Johan Herland <johan@herland.net> writes:

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index c93124b..25e48c4 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -72,6 +72,11 @@ endif::git-format-patch[]
>  	a cut-off percent (3% by default) are not shown. The cut-off percent
>  	can be set with `--dirstat=<limit>`. Changes in a child directory are not
>  	counted for the parent directory, unless `--cumulative` is used.
> ++
> +Note that `--dirstat` does not use the regular diff machinery to calculate
> +the changes (rather it is based on the rename detection machinery). Therefore,
> +`--dirstat` may skip some changes that `--stat` does not skip. For example,
> +rearranging the lines in a file will not be detected by `--dirstat`.

Be positive: s/will not be detected/is not considered to be a change/,
perhaps.  Also "it is based on the rename detection machinery" is
describing an implementation detail without helping the end users.

Try to rephrase what Linus explained when he said "it is very much on
purpose".  Perhaps like this?

    Note that the `--dirstat` option computes the changes while ignoring
    pure code movements within a file.  In other words, rearranging lines
    in a file is not counted as a change.
