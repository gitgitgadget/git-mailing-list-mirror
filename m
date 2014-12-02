From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/lib-gpg: adjust permissions for gnupg 2.1
Date: Tue, 02 Dec 2014 15:57:50 -0800
Message-ID: <xmqqiohtli4h.fsf@gitster.dls.corp.google.com>
References: <547DB6C3.5010704@drmicha.warpmail.net>
	<9c28f16c677bbc774e5b8dfc79b6ffe2c55d1720.1417527514.git.git@drmicha.warpmail.net>
	<20141202210753.GD23461@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 00:58:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvxKS-00016I-MI
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 00:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933562AbaLBX54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 18:57:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63041 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933319AbaLBX5y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 18:57:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 943ED23CCE;
	Tue,  2 Dec 2014 18:57:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OxTdOt1umw0KF6gWf1jwSF9t9uA=; b=P5SZY+
	IHsOiGq+qDU8huVhcsUoXbh129V6+ieesBBXn59bUU6U+6ukywk7T9DmawvhEEyI
	7vRIHCwpOrtjx8FZZB+5AdNFpL7fKASdaXN7DZdR0eiWUL/z6WD8IsvN0pFyWsna
	IONLU7o4dJMycoO1clm6U2DpdQXXSjkDlpJHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hWFgYlvcoF8wlR6IOLpfQjLytHsgtYdG
	w4jILhhGuqFtPs+WUwGkZskewThCMkHSo2YonwaM+LXsQvhDEN+0tbkF2fJffQ0W
	i2Y3FxqWQyJ5JP4o1IPzqq996M+6vYnVsrv2gZm1wv/nhmqzc5H4QYOr/FtK9A8/
	OY928yoLSQs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AB2B23CCD;
	Tue,  2 Dec 2014 18:57:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B41E23CCC;
	Tue,  2 Dec 2014 18:57:51 -0500 (EST)
In-Reply-To: <20141202210753.GD23461@peff.net> (Jeff King's message of "Tue, 2
	Dec 2014 16:07:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 06BF1A4A-7A7F-11E4-980E-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260602>

Jeff King <peff@peff.net> writes:

> Taking a step back, though, I am not sure I understand the reasoning
> behind the original e7f224f. The rationale in the commit message is that
> we want to make sure that the files are writable. But why would they not
> be? They are created by "cp -R",...

Wait.  After doing this,

    $ mkdir -p src/a && >src/b 2>src/a/c && chmod a-w src/b src/a/c
    $ cp -R src dst
    $ ls -lR dst

dst/b and dst/a/c are 0440 (with umask 0027, which makes src/b and
src/a/c also 0440, which is copied with "cp -R").

I was primarily worried about t/lib-gpg/* being read-only from a
src-tarball extract when we had a discussion that led to e7f224f7
(t/lib-gpg: make gpghome files writable, 2014-10-24).
