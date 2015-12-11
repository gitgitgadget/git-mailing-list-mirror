From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Case insensitive URL rewrite
Date: Fri, 11 Dec 2015 10:26:41 -0800
Message-ID: <xmqq7fkkg7tq.fsf@gitster.mtv.corp.google.com>
References: <B207EFC1-48DF-4B8F-8373-28A0CB5660B0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 19:26:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7SP4-0003nT-W4
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 19:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbbLKS0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 13:26:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52348 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750797AbbLKS0p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 13:26:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EB92331897;
	Fri, 11 Dec 2015 13:26:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f4KrdJTRx9W5sTSKHKJedUuRZ7E=; b=xxMgGD
	FxnSr2WbHn/Hgnf7Rh/rhXwnU/fuV1f4YHG0yEXl8hgWZ2sVhmxl1Uv31TA+i7NI
	0QqMFvFxUgm3wvEzLVqRErU2fhramfRUYonpS5serK8RR9m45bpqCMVko+cZdOcO
	2PqcLQoj7hC/FzG/UcBulsUmu4X06U0lbI0KA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gghBUTvwNsIfqXr1wdpHAd5pEah5CexC
	4Uv83+bbv2d+yLVmXkagJq0WvdKvSE39jpOdsyNGGBPl99jAfLWJcBG6wLavUvGv
	LKlzTyjvE6hqLskYgsqGHlArPEa6DmMzguKTmP4CZGkS5ljfGG3dk2ipoDwsP0Pm
	zk0i5afcokI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E453731896;
	Fri, 11 Dec 2015 13:26:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 69B8131893;
	Fri, 11 Dec 2015 13:26:44 -0500 (EST)
In-Reply-To: <B207EFC1-48DF-4B8F-8373-28A0CB5660B0@gmail.com> (Lars
	Schneider's message of "Fri, 11 Dec 2015 14:45:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BB388264-A034-11E5-A26C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282267>

Lars Schneider <larsxschneider@gmail.com> writes:

> What do you think about a flag that makes these rewrites case insensitive? E.g. with the following config flag:
>
> [url "<actual url base>"]
> 	insteadOf = <other url base>
> 	ignorecase = true

I am with Daniel on this.

It is perfectly fine to consider these two equivalent.

    git clone https://github.com/git/git (canonical one)
    git clone https://GitHub.com/git/git (host part in funny case)

In fact, I think we should do this without any additional
configuration variable.

On the other hand, these two MUST be treated as different by
default:

    git clone https://github.com/GIT/GIT (differences outside host part)
    git clone git@github.com:GIT/GIT     (differences outside host part)

Although I am OK if this is hidden behind a configuration variable,
I am not sure how much value you would be giving to the users.

In any case, I expect that additional change (on top of what is
required to make hostname part treated case insensitively) would not
be too bad, if we were going to fix the hostname part.
