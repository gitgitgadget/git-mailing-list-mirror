From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [submodule] Add depth to submodule update
Date: Wed, 26 Jun 2013 09:16:32 -0700
Message-ID: <7vli5wyhi7.fsf@alter.siamese.dyndns.org>
References: <1371974698-28685-1-git-send-email-iveqy@iveqy.com>
	<20130624224925.GC32270@paksenarrion.iveqy.com>
	<20130625221132.GB4161@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Jun 26 18:16:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrsOf-00033K-8D
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 18:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586Ab3FZQQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 12:16:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36233 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383Ab3FZQQg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 12:16:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB1032A94F;
	Wed, 26 Jun 2013 16:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mK1y9hnZSz27AQd7rSSeVUOkpM4=; b=DrTiU+
	2qR5nhQenqGhtnyg2hORKUuoyu08fisY55iHuYt3bquYr0O5KIDPW3GedODiFaz9
	AWCSekFAhWIfR5/VYwmoAPl/VyMpVTDIo8ohYupbCfB7a2wM098/WufHoXKCBawv
	ELA3kE4C7HoAp30RyEE7aIcGktthDvMsCcFrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CosgwlTloJF2q5LLbNXeTMx+0vIKMLTf
	FA/LgZq6FNUJFbxP6Hpxo0cn/s6bDUQhvztDEJ3KstwfhspXIEVr+mdGN7t7350b
	YVR397b8UxlfAdURepbm4VntuSxiKmedKNatX2OO31XW/yJ8VAf4kfLzkM8IvJAF
	KGq9fSzrHJo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B8362A94D;
	Wed, 26 Jun 2013 16:16:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3ECE42A948;
	Wed, 26 Jun 2013 16:16:34 +0000 (UTC)
In-Reply-To: <20130625221132.GB4161@sandbox-ub> (Heiko Voigt's message of
	"Wed, 26 Jun 2013 00:11:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C51262AA-DE7B-11E2-A867-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229045>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Tue, Jun 25, 2013 at 12:49:25AM +0200, Fredrik Gustafsson wrote:
>> Used only when a clone is initialized. This is useful when the submodule(s)
>> are huge and you're not really interested in anything but the latest commit.
>> 
>> Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
>
> I this is a valid use case. But this option only makes sense when a
> submodule is newly cloned so I am not sure whether submodule update is
> the correct place. Let me think about this a little more. Since we do
> not have any extra command that initiates the clone this is probably the
> only place we can put this option. But at the moment it does not feel
> completely right.

I could imagine why people would not want to truncate the history
when they "submodule update" a submodule that has been already
initialized and cloned long time ago, but the new option is ignored
in the patch for an already cloned module, so that is not a problem.

The only possible confusion factor I can see is that the option is
ignored silently, but I do not think it is a grave enough offence to
error out when the user says "git submodule update --depth=N $path"
for a submodule at $path that has already been cloned.  It may not
even deserve a wraning, so in that sense the patch may be fine as-is.

> Apart from that the code looks good. If the user does a checkout of a
> revision that was not fetched submodule update will error out the same
> way as if someone forgot to push his submodule changes. So that should
> not be a problem.

True.

Thanks.
