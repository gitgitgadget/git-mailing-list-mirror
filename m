From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] send-email: auth plain/login fix
Date: Wed, 28 Sep 2011 15:00:40 -0700
Message-ID: <7v62kcz5rr.fsf@alter.siamese.dyndns.org>
References: <m3fwjjp69m.fsf@localhost.localdomain>
 <1317205600-7210-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: joe@perches.com, git@vger.kernel.org
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Sep 29 00:01:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R92Bs-0002Hr-PW
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 00:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349Ab1I1WAo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Sep 2011 18:00:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32876 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634Ab1I1WAn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2011 18:00:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D8D55BD1;
	Wed, 28 Sep 2011 18:00:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PLe1n34Uhzk9
	YphcUGSQ+TERNss=; b=Berp7shu0xUuJkGIcINDnd/XRCB66JCAGRCNU3PJq0jY
	5WrKOwVpnx5fqIbZ0HMnmbAX4294gAmqgWe2IBaHFbt4WxK+nMQ/f4O6+oixFCK7
	hS2x/KW3/4qYPPoynq/FvEye67eFoa2heq2aNHFnHVXyBVCS/1i5sJFDQtDp6XY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oG8U0i
	e3pBjfSGg1tfDiqscs/7+gdgfkraCIiweyfoeHEcFOF8XFwLvYb6OljD8mReabBK
	GCBiHs4CHMH4LzkjBSvhm3j2aFv3k9Rxz7hkzYGvKmDwc+wKtbLY2ziFqGIlJzmE
	FzW5ME6uxS0IGLn7JuctvEOU03XtWTCSM57PU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 842485BD0;
	Wed, 28 Sep 2011 18:00:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB7F15BCF; Wed, 28 Sep 2011
 18:00:41 -0400 (EDT)
In-Reply-To: <1317205600-7210-1-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Wed, 28 Sep 2011
 12:26:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4ED1F460-EA1D-11E0-ACD5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182366>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> This patch is tested by sending it :)

I am tempted to shorten the log message to cull the protocol trace.

    send-email: auth plain/login fix
   =20
    git send-email does not authenticate properly when communicating ov=
er TLS
    with a server supporting only AUTH PLAIN and AUTH LOGIN. This is e.=
g. the
    standard server setup under debian with exim4 and probably everywhe=
re
    where system accounts are used.
   =20
    The problem (only?) exists when libauthen-sasl-cyrus-perl (Authen::=
SASL::Cyrus)
    is installed. Importing Authen::SASL::Perl makes Authen::SASL use t=
he perl
    implementation, which works better.
   =20
    The solution is based on this forum thread:
   =20
        http://www.perlmonks.org/?node_id=3D904354
   =20
    This patch is tested by sending it. Without this fix, the interacti=
on with
    the server failed like this:
   =20
        ...
        Password:
        Net::SMTP::SSL=3DGLOB(0x238f668)>>> AUTH
        Net::SMTP::SSL=3DGLOB(0x238f668)<<< 501 5.5.2 AUTH mechanism mu=
st be specified
        5.5.2 AUTH mechanism must be specified
   =20
    Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Around the line "the server failed like this:", it would be helpful if =
we
can say how others can reproduce the protocol exchange log shown above.
That would help those who may (or may not) be seeing a similar issue to
diagnose if this commit may help them (or is the culprit of a breakage
they find in the future).

Thanks.
