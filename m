From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/19] mingw: avoid absolute path in t0008
Date: Mon, 25 Jan 2016 14:20:23 -0800
Message-ID: <xmqq1t95fgig.fsf@gitster.mtv.corp.google.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
	<7c35a7b9c65d9febb6af1b50907988974bca3fbd.1453650173.git.johannes.schindelin@gmx.de>
	<xmqq60yibe89.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601251747050.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 23:20:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNpUt-0002PN-VH
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 23:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbcAYWU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 17:20:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58896 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932084AbcAYWU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 17:20:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9CCE840FC7;
	Mon, 25 Jan 2016 17:20:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l6vD+llIZQpagvTay0ryiubHcgo=; b=Q8QFSQ
	FWUqukvxbeAQKAUQE+5VGgNuEdMM1RuVfbx5scH9CBUELzuWFk5Ttg8QpViQ9IEA
	dtGffWeN3KHfxDQxA6Y5twqQiqrH0+fOeGNaYyrGEcAbGJ0oqo3uD5jkJjVntyF4
	YsDACjz/X4Uzkgp9Nd0uP7GMlWM4WiR05isi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PKuhVpLhoJvp1I/ahilie+JmWjoIobVN
	I1gBav95Hqw2OwLQBXDHYf81EX8SVv7gMBHyvdF7PnXeJ3WISKkBL1w6Omlk3suh
	s2HTgdwEfwmOgeMs50jRa5UfB3ZJm/IHQ3vNP+d3r/OTbZY6nQUX5CR5DV3tfSue
	KDIJAhzXcsU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 898BE40FC6;
	Mon, 25 Jan 2016 17:20:25 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8256540FC1;
	Mon, 25 Jan 2016 17:20:24 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601251747050.2964@virtualbox> (Johannes
	Schindelin's message of "Mon, 25 Jan 2016 17:48:37 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D4711430-C3B1-11E5-AED0-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284763>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Is the fact that $global_excludes is specified using an absolute
>> path significant to the correctness of this test script?
>
> Apparently not. So I followed your suggestion and made this independent
> of the OS:
>
> 	https://github.com/dscho/git/commit/0b9eb308

I see many "cd" in the script, some of which come before the global
exclude file is enabled, but others ("--stdin from subdirectory",
for example) do run from a subdirectory.  It turns out that this
file is used as the value of core.excludesfile.  By the time that
file is read in setup_standard_excludes(), presumably we have
already done setup_git_directory() and moved back to the root of the
working tree, so I guess such a change would be harmless.

It somehow makes me feel dirty, though.  But that is not a specific
problem to mingw port.
