From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] git-config: git-config --list fixed when GIT_CONFIG value starts with ~/
Date: Fri, 14 Nov 2014 12:10:16 -0800
Message-ID: <xmqqk32x35nb.fsf@gitster.dls.corp.google.com>
References: <1415989760-20259-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Alex Kuleshov <kuleshovmail@gmial.com>
To: 0xAX <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 21:10:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpNCK-0006GW-AJ
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 21:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754313AbaKNUKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 15:10:20 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53082 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751625AbaKNUKT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 15:10:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C8F6A1E0F2;
	Fri, 14 Nov 2014 15:10:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nmJSE4E2FHkSJCT/3aVbX5lko8Q=; b=otFmXH
	iBLPN2IAhJl65lw++n8Jgqs0gr4K5j8Hid7X5t3IaeWJkZo+GT+AZyB4T55GkJ4o
	gnk86BF8QPLfFilrbcNHJfMDpJvW0K1Ur1Lp0yK3SpaRlpGjk7Sovqdv4lJBwGbI
	t+lGjsTeto+aG57G5y4Nw+d8h24RzECYaPYTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GcSGGFlCD51a6r8ht4qDOvEiRP1D4pM5
	qoE6YeV1loulK16tT6GfazBei7xDDa5ZLcXhpIdAmX6Kr/uz2b3WTW5Wu2sgU5rr
	Oq9zrlC3JjPKH7FsuB0wCm2VMGZdkq3z8TwYojuhOfJnG/XNfblZlDt/CfjjnsFw
	KtZWDuXKjbE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF1391E0F1;
	Fri, 14 Nov 2014 15:10:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 509571E0F0;
	Fri, 14 Nov 2014 15:10:18 -0500 (EST)
In-Reply-To: <1415989760-20259-1-git-send-email-kuleshovmail@gmail.com>
	(kuleshovmail@gmail.com's message of "Sat, 15 Nov 2014 00:29:20
	+0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 410F5136-6C3A-11E4-B06E-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

0xAX <kuleshovmail@gmail.com> writes:

> When we execute git config --list and $GIT_CONFIG value starts with home
> prefix - ~/ it produces folowing error - fatal: unable to read config
> file '~/.gitconfig': No such file or directory. This patch fixed it with
> expand_user_path for configuration file path before git-config --list
> call.

Expanding tilde ~ in environment variables is what you let your
shell do when you assign it.   This is not limited to Git:

    $ FOO=~/.bashrc
    $ BAR='~/.bashrc'
    $ head -n 1 "$FOO"
    # Bourne Again SHell init file.
    $ head -n 1 "$BAR"
    head: cannot open ‘~/.bashrc’ for reading: No such file rdirectory

    $ echo "FOO=$FOO" "BAR=$BAR"
    FOO=/home/gitster/.bashrc BAR=~/.bashrc

The patch does not fix anything and not necessary.
