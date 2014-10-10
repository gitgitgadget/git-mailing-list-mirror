From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v2] mergetool: use more conservative temporary filenames
Date: Fri, 10 Oct 2014 13:19:40 +0200
Message-ID: <5437C0CC.7030102@gmail.com>
References: <1412929187-57936-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sergio Ferrero <sferrero@ensoftcorp.com>,
	Charles Bailey <charles@hashpling.org>
To: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 13:20:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcYFA-0006pG-Sz
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 13:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884AbaJJLUL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Oct 2014 07:20:11 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:64229 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286AbaJJLT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2014 07:19:59 -0400
Received: by mail-lb0-f171.google.com with SMTP id z12so2844781lbi.16
        for <git@vger.kernel.org>; Fri, 10 Oct 2014 04:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=DSmTW0xr71176NXY+VrvlY3b3qPxy7coUJ5HGOMjBLM=;
        b=ufbVioNL0uuWUmonlW0tS+HB1lYuDY+5Pi8QU65xlKTbGwhhaiEa9/A5BwBvLQICgx
         7QAknlGy1vDnTrhXQMKX6+n8YsgFkoWA8+yAokNZR2DlzTRHjYGJq0aoP5HayIawVGPM
         O9ZFqXpxhdn7w54d4OixOmgVjOU/BnyROFsX8tp1mLxkEFtr7H5mLHsLk0ufzp1IbCjr
         eUKa0L74Gk1QZ7a8mX6goegWJtw+LggXcIBDe9IwrHTeUdfTETLjBjGPRtdRKRF3DEC/
         JccbheMCp9/FO7E70GSOmdcFlsjR/EwZv6Hw9qKj+IWMhfkalTq+f6LHdGBz4o2NcZ62
         /mSg==
X-Received: by 10.112.204.197 with SMTP id la5mr4000241lbc.2.1412939997387;
        Fri, 10 Oct 2014 04:19:57 -0700 (PDT)
Received: from [192.168.130.235] ([158.75.2.130])
        by mx.google.com with ESMTPSA id lk5sm181568lac.45.2014.10.10.04.19.55
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 Oct 2014 04:19:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1412929187-57936-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar wrote:
> Avoid filenames with multiple dots so that overly-picky tools do
> not misinterpret their extension.
>
> Previously, foo/bar.ext in the worktree would result in e.g.
>
> 	./foo/bar.ext.BASE.1234.ext
>
> This can be improved by having only a single .ext and using
> underscore instead of dot so that the extension cannot be
> misinterpreted.  The resulting path becomes:
>
> 	./foo/bar_BASE_1234.ext
>
> Suggested-by: Sergio Ferrero <sferrero@ensoftcorp.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---

> +	if BASE=3D$(expr "$MERGED" : '\(.*\)\.[^/]*$')
> +	then
> +		ext=3D$(expr "$MERGED" : '.*\(\.[^/]*\)$')
> +	else
> +		BASE=3D$MERGED
> +		ext=3D
> +	fi

Why use expr and not POSIX shell parameter substitution?

BASE=3D${MERGED%.*}
ext=3D.${MERGED##*.}

Or something like that...

--=20
Jakub Nar=C4=99bski
