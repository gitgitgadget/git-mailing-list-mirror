From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-new-workdir: support submodules
Date: Sun, 25 Jan 2015 20:05:10 -0800
Message-ID: <xmqqa916nq4p.fsf@gitster.dls.corp.google.com>
References: <CAGXKyzHoLLgkXk0X4UVtLBEryqsHriKmmO5+2iVWk3mR8y7=Hw@mail.gmail.com>
	<CAGXKyzEwAjCNTxRtjSuFh9b6BzzOYKOQryKtXBGY3_hkkFvyVw@mail.gmail.com>
	<xmqqegqlnelu.fsf@gitster.dls.corp.google.com>
	<CAGXKyzEPWrbRFOhvCBm=2Z50zso85G50z-nLd_wyzyeEADQSmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Craig Silverstein <csilvers@khanacademy.org>
X-From: git-owner@vger.kernel.org Mon Jan 26 05:05:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFavc-0003vk-Sd
	for gcvg-git-2@plane.gmane.org; Mon, 26 Jan 2015 05:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbbAZEFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2015 23:05:20 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53782 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751218AbbAZEFS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2015 23:05:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F66133858;
	Sun, 25 Jan 2015 23:05:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+l9xA8B+78w3C5yESdyHciwxJiY=; b=dTzmOw
	TaX/1SmVh07EmFxtpJGrqAA2MAUZH2cMh2ry9RPKU5x//5fH7WkAE5Gz2SwjNqxa
	6eZPc6ZV6RM4ioeC8Zb6Yodp305PPDDdp5fH4L3mPVVFBXCqFgC/qxjuzfBinR0/
	NUDKHLcl4PQfVxsWZ73EczUafAhx9eluddBak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H33mYqvyOoTdtUANqBdpIEOJD6HPZJFU
	9Afn9qrQB7jL6wpGLiNPjOUAoOsQykt8TjxuRpNadNcopT89FNVzuunME02SR4hn
	jN3UvLtxAt7qkkyL479PNHaK4gejU1LqMhYRLD6Zilr06Mm6PtBH9Al0wDzwEUsP
	yQVdbdix1BI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 184C733856;
	Sun, 25 Jan 2015 23:05:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9202633855;
	Sun, 25 Jan 2015 23:05:11 -0500 (EST)
In-Reply-To: <CAGXKyzEPWrbRFOhvCBm=2Z50zso85G50z-nLd_wyzyeEADQSmw@mail.gmail.com>
	(Craig Silverstein's message of "Sat, 24 Jan 2015 17:47:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 861EE160-A510-11E4-932F-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263023>

Craig Silverstein <csilvers@khanacademy.org> writes:

> } Or one new-workdir checkout's branch may check out a top-level
> } project from today while the other one may have a top-level project
> } from two years ago,
>
> This is also true, but just as much a problem with the 'git
> new-workdir' script as it existed before my change.  It already
> symlinks the top-level .git/config directory, which lists a remote,
> submodules, and many other things.  Does symlinking the config file
> for submodules add any new wrinkles, that symlinking the config file
> for the top-level repository does not?

The update under discussion is labeled as "support submodules";
presumably the only reason that such an update is good is because it
will fix existing problems that makes the use of the script break
when submodules are involved --- submodules are not supported with
the current code, and this patch fixes the code to support it.

But then, you are saying that the update does not fix these existing
issues around submodule support.  So...?
