From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce the GIT_CONFIG_EXTRA environment variable
Date: Fri, 18 Dec 2009 19:24:02 -0800
Message-ID: <7vhbrnodd9.fsf@alter.siamese.dyndns.org>
References: <4B2C0828.4010505@signalbeam.net>
 <20091219013246.GD25474@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Moe <moe@signalbeam.net>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Dec 19 04:24:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLpvY-0002n3-Rk
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 04:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbZLSDYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 22:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751966AbZLSDYP
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 22:24:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41247 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbZLSDYO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 22:24:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A89A8A832C;
	Fri, 18 Dec 2009 22:24:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iQJT84dFCyJcEWb/vq1FfsSg1ww=; b=d6ZooW
	o8puMH5d4CYlA/Rh5Sib7pN0F5KvWgyiEJNmMiS8NHsrG3cWBE42annyDfeL6Gh8
	6/KPkKF002C1ihsg8HUf6Ggq0Cr1MT5F/82IiErRPto2EE0FpCZbnl5aW/pu4rv4
	qB/s/woGPbEJg2Rwtd05OMI/sSFKNT1J0xhRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kQrp1XGmzPHsHEK5nT0llAKMkpRw3/Qq
	7fkqL9FTTJX8/0onDQJAi0zHhq5U8ipmX8kfbEgCtSSgZ0c04lsAWdl/7l8oExTP
	D9EozzB7a+y/OfGlccqoiugAmrYE+GqQHp62/vhgZeKoCR8owFIqYvOaKUrDBF5v
	ebT0wBMSpws=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 78EC2A8329;
	Fri, 18 Dec 2009 22:24:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5ABFAA8328; Fri, 18 Dec 2009
 22:24:04 -0500 (EST)
In-Reply-To: <20091219013246.GD25474@genesis.frugalware.org> (Miklos Vajna's
 message of "Sat\, 19 Dec 2009 02\:32\:46 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F7F7F424-EC4D-11DE-90CC-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135458>

Miklos Vajna <vmiklos@frugalware.org> writes:

> This is like GIT_CONFIG but it is not read instead of .git/config, but
> in addtition to it.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> On Fri, Dec 18, 2009 at 11:54:32PM +0100, Moe <moe@signalbeam.net> wrote:
>> $GIT_CONFIG doesn't work for this purpose because when set
>> git will *only* read the referenced file and ignore the
>> repository settings.
>
> What about this?


The patch text itself may be fine, in the sense that it makes "we read
from three" to "we now read from four", but I am not impressed.

I find the original use case highly moronic.

For people to be sharing an account, hence $HOME, there must be a reason.
They want to (rather, the administrator wants them to) use a common shared
set of settings, so $HOME/.gitconfig should be shared among them, just
like $HOME/.emacs and $HOME/.login are, unless there is some strong reason
to treat .gitconfig any differently from all the other $HOME/.whatever
files.  But I don't think there wasn't any argument to defend that.

That makes the patch doubly suspect and throws it into "because we can",
not "because we should".

Wouldn't it be just a matter of giving different HOME after they log-in?

After all, Moe will be giving _some_ way to his users set different value
to GIT_CONFIG_EXTRA depending on who they really are, and that same
mechanism should be usable to set different HOME to them, no?

As $HOME/.gitconfig is relative to the value of that environment variable,
I don't see a reason for us to fall into this "three is not enough, but
when we add another, we are fine" attitude, which makes me suspect that
there is something fundamentally wrong there.
