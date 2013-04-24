From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 7/7] git grep: honor textconv by default
Date: Wed, 24 Apr 2013 10:35:38 -0700
Message-ID: <7vehdzesr9.fsf@alter.siamese.dyndns.org>
References: <517298D4.3030802@drmicha.warpmail.net>
	<043047afd2915dd8f3a68cf164dc516d4c0bb5c2.1366718624.git.git@drmicha.warpmail.net>
	<7vwqrtjmtx.fsf@alter.siamese.dyndns.org>
	<5177AE7F.1040400@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	jeremy.rosen@openwide.fr, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 24 19:35:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV3be-0001HI-7i
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 19:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159Ab3DXRfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 13:35:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47245 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756116Ab3DXRfl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 13:35:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11C2F196E6;
	Wed, 24 Apr 2013 17:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pwosUS1+G12lwepxS0WkzNe24Vo=; b=LGQ8oj
	PeFtiXPy8OS/Sqzv2nJ1BARk2tbQIAczQ4QpOaXsUDLkaxVIKJ+BFvnUwoRlwCBG
	/uE7M6WWdEUHX62nyo69r2RMkooOW9fo9qudq+2PLrCD6F8cF0sMW5+klCp09ANf
	9anflDewrM9u59kewb/+7NFtpeg5Utt/qqBG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gpnX7Pi/cKw7jfTKy3cKOXB7Si3SW4U7
	qNJUKNbpiYcUSkOv0Hn2svXijootae62miihqXnX4VFqRZ7Inzi3tLfwqihYBSY2
	z9OJaONPk37k+pa34R0NGDgkk2sQ4MfR9aKA6Js1TKCXORHMkpicAr4YysGCEN+9
	+qrLpkYarjw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 083C1196E5;
	Wed, 24 Apr 2013 17:35:40 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7EE26196E4;
	Wed, 24 Apr 2013 17:35:39 +0000 (UTC)
In-Reply-To: <5177AE7F.1040400@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Wed, 24 Apr 2013 12:05:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6175C9F0-AD05-11E2-8CE6-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222277>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> My point is that we apply textconv on "log diff greps" already, so why
> should't we on content greps?

I think you are going in circles.  If you start from "textconv is
about mangling blob contents", then it would look natural to you
that "show <blob>", "diff A B", and "grep <pattern> <blob>" would
all first mangle the blob contents using textconv and then work on
them.

But diff.<driver>.textconv is to mangle blob contents in preparation
for comparing with another.

That is why you explicitly ask "cat-file --textconv" to use the same
mangling even when you are not comparing it with anything else.
