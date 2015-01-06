From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] update-server-info: create info/* with mode 0666
Date: Tue, 06 Jan 2015 10:47:01 -0800
Message-ID: <xmqqh9w3px0a.fsf@gitster.dls.corp.google.com>
References: <20150106034702.GA11503@peff.net>
	<20150106035048.GB20087@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Sokolovsky <paul.sokolovsky@linaro.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 06 19:48:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8Z9q-0003V8-MP
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 19:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbbAFSrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 13:47:06 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932342AbbAFSrE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 13:47:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BAD42C7A4;
	Tue,  6 Jan 2015 13:47:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pjJJmCLOiKp1doCQYmuXmA3IzHM=; b=hLW5ZL
	crTqOSU1ifJlhQBYLvkgubOKkrtg6dgJPDtxuk3hxKWogk3/Unth4WoPQBt5QQmK
	vZT4Ju3s+vqHJ1zJPjsiWo92ynkLle/4fuOLGLEkQfc9athzW6a/dOVoRMkE6Z+g
	GDM8eQ6Aa2MI/W+x50nTpfIJHz/s+aYXbHTCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C+xDHo3mG1o8bhMGFWNv2HHYtTbmjqlk
	UIkCEW7gSh0TOWKckSDrxpVY6yUpDY1xeBYxtPW6BgIiWG8U1MJXJGPxwxcwsv2e
	7W3gV4zHYqy5UIQtFIiZ8tliISRlvb2JLictyzRylD52OJpiNn/RscSzzp4ljiNg
	euYGScvvyU8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 51CD32C7A3;
	Tue,  6 Jan 2015 13:47:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C90BB2C7A1;
	Tue,  6 Jan 2015 13:47:02 -0500 (EST)
In-Reply-To: <20150106035048.GB20087@peff.net> (Jeff King's message of "Mon, 5
	Jan 2015 22:50:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 67664E48-95D4-11E4-ADA5-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262086>

Jeff King <peff@peff.net> writes:

> +test_expect_success POSIXPERM 'info/refs is readable in unshared repo' '
> +	rm -f .git/info/refs &&
> +	test_unconfig core.sharedrepository &&
> +	umask 002 &&
> +	git update-server-info &&
> +	echo "-rw-rw-r--" >expect &&
> +	modebits .git/info/refs >actual &&
> +	test_cmp expect actual
> +'

Hmm, the label and the test look somewhat out-of-sync.  "readable as
long as umask allows it" would be more in line with what the fix is
about (i.e. I would expect a test with that title to pass even if I
changed 'umask 002' to 'umask 007', but that is not what we want in
this series).



>  test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
>  	umask 077 &&
>  	git config core.sharedRepository group &&
