Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3688E6D1AC
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 23:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708212672; cv=none; b=ZjdC/q5mSgQf88aAszpABwshi0g5FyeBcKWDzUu6OuHHpa7Z9jZIXqljPSBHOdfFjE4PlP2Z+xm90HMqZl4EnfRMcYDyKsVetYRTXjQlunN0c1mPqEgnAg0FLNnzkuGTZZdcbq+jpG6KmQerKe9BeNFoLzpRbVEQC7ivKco1VKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708212672; c=relaxed/simple;
	bh=L+nYPuMdM7/tWgBl1mVgEzoMVHuKYiEebMSzefVc6Z0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GNeipf/WqTM4cqBO5bXNEvta3cz26x9Qx9xVCzcP7bXx899ULHS8a0fG3yLZYOdtw7xBQK7sG4n9A5ZVjKc7SrzEijeX8fWIPmodDyvRHzOX1SP8GC8L0vA2mz8yLbrbg6XM4KY4OtgdegUc9yHnsC1rBbYPcOpIWAfq6DYCDYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XjuvrIJz; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XjuvrIJz"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E0C51C07CE;
	Sat, 17 Feb 2024 18:31:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=L+nYPuMdM7/tWgBl1mVgEzoMVHuKYiEebMSzef
	Vc6Z0=; b=XjuvrIJzEMcI3DQ+8VfaX+GxlVNCM2ANXbyVO0FAEjkmcv8BhujBvL
	AP4JLjd2OujzyHZ1r5mbaAhBnJgIwL8DSuoUL/x1IYU62jX7Ts4GyukmKe6byU2l
	kjEB0x7gUx9uz0Cc+yx4u2ZZl5vcEz9MvpK8PTfa+jvf4kUkwtsZw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 461391C07CD;
	Sat, 17 Feb 2024 18:31:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 833E21C07CB;
	Sat, 17 Feb 2024 18:31:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jens Schmidt <farblos@vodafonemail.de>
Cc: git@vger.kernel.org
Subject: Re: Calling "gpg --sign" with loopback pinentry in some scenarios,
 but not always
In-Reply-To: <de38341b-f69f-4d3b-a4c2-4443e1ec1f6f@vodafonemail.de> (Jens
	Schmidt's message of "Sat, 17 Feb 2024 23:51:43 +0100")
References: <de38341b-f69f-4d3b-a4c2-4443e1ec1f6f@vodafonemail.de>
Date: Sat, 17 Feb 2024 15:31:01 -0800
Message-ID: <xmqqle7ifz2i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9D07533A-CDEC-11EE-B629-25B3960A682E-77302942!pb-smtp2.pobox.com

Jens Schmidt <farblos@vodafonemail.de> writes:

> It seems that "git" does not have any hooks to pass arbitrary
> additional parameters to "gpg", right?  So my only reasonable
> option would be a Emacs/Magit-specific "gpg"-wrapper that adds
> command line parameter "--pinentry-mode loopback" to the wrapped
> "gpg" executable.

Correct.  You can point your gpg.program configuration variable at
your wrapper, perhaps

    $ cat >"$HOME/bin/mygpg-with-pinentry" <<\EOF
    #!/bin/sh
    exec gpg --pinentry-mode loopback "$@"
    EOF
    $ chmod +x "$HOME/bin/mygpg-with-pinentry"
    $ git config gpg.openpgp.program "$HOME/bin/mygpg-with-pinentry"

or something like that.  It is unfortunate that

    $ git config gpg.openpgp.program "gpg --pinentry-mode loopback"

does not work.
