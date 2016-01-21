From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Submodule Groups
Date: Thu, 21 Jan 2016 14:18:31 -0800
Message-ID: <xmqq37tqy3t4.fsf@gitster.mtv.corp.google.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
	<56A14AD4.6040608@gmail.com>
	<CAGZ79ka+LZHRjVB8bZ4u+-n-U06mUWsbx9nRVCvd4aPwrb7yHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 23:18:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMNYs-0005qt-II
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 23:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbcAUWSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 17:18:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64625 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750804AbcAUWSe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 17:18:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 610183D1ED;
	Thu, 21 Jan 2016 17:18:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ra9cfjSPiu5ahWJ8ox/CcCOHL3k=; b=rM5dy9
	44bxA7a4qe9GzcLMa28G/B5DmSPZ3RGn5quW4n3nvUKsCMhdVqjBM8vtQF5Bxty1
	9wvl825C6fvgPQDMjWx5sOLPThQTglZXqHUCfF9tq7WVwTgCp+HQytfobJ5HfIsu
	6S0EEGxSDvRwwW3W5aMHT9jBWVhcaJgCzof/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pyawQNx2nI0I1zNaMBtVMpVhyEa/q+5r
	igmd9m88kP3kLkI7wAFa9salnmDyJpIQ0Agc7ogymAN+WsjBpO43byOP890P4NxF
	RJWIDToSJyJ+NkGNvOm+4ri8i82K0modpgXsOURzYgUgb8eTEbzBMFy+djg+mlSO
	D0p1XeO/3jc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5626B3D1EB;
	Thu, 21 Jan 2016 17:18:33 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B40403D1EA;
	Thu, 21 Jan 2016 17:18:32 -0500 (EST)
In-Reply-To: <CAGZ79ka+LZHRjVB8bZ4u+-n-U06mUWsbx9nRVCvd4aPwrb7yHQ@mail.gmail.com>
	(Stefan Beller's message of "Thu, 21 Jan 2016 13:56:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E8318AB8-C08C-11E5-AD7B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284535>

Stefan Beller <sbeller@google.com> writes:

> Instead of having a submodule -> set assignment, we could do it the
> other way round:
>
>      [submodule "gcc"]
>          ...
>
>      [submodule-set "default"]
>         submodule = gcc
>         submodule = foo
>         submodule = by/path/*
>
> This may be more handy from our perspective (while designing it and
> writing the code),
> but I'd assume this is less useful for the user. How often does a user ask:
> "How many/Which submodules are in $GROUP" as opposed to "What about
> submodule foo,
> is that part of group $GROUP?"

I suspect that we will end up needing to support both styles.  The
latter style is easier when you want to express a larger set as a
collection of groups, e.g.

    [submodule "gcc"]
    	group = development-tools

    [submodule "emacs"]
    	group = editors

    [submodule "frotz"]
        group = games

    [submoduleGroup "default"]
        member = *development-tools
        member = *editors
        member = :frotz
	member = !*xyzzy

might be a way to say "the default group includes everything in the
'development-tools' or 'editors' group, plus 'frotz' module, but do
not include modules in the xyzzy group" or something like that.
