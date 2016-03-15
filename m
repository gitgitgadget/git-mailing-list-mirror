From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 1/3] submodule: add test to demonstrate that shallow
 recursive clones fail
Date: Tue, 15 Mar 2016 12:50:35 -0700
Message-ID: <CAGZ79kYzbmzK1UwvWheugkqG0FwhpGMU0_K_jyCKOnoKb5oTxQ@mail.gmail.com>
References: <1450653595-22676-1-git-send-email-larsxschneider@gmail.com>
	<1450653595-22676-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 20:50:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afuzJ-0004PS-4K
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 20:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965800AbcCOTui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 15:50:38 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36121 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965194AbcCOTug (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 15:50:36 -0400
Received: by mail-ig0-f176.google.com with SMTP id nk17so74994952igb.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 12:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=iR5O8TyT7l2Sn8HTtrKvELqGqUHFUA4ifGZZateqHOg=;
        b=GAmlc8dcJwWDnbeBX6mQt5B+KDY585U02IJVXVcXO57jW/giAbKMXoJTo/LuSMUMLs
         hS12DX4tpc3lril8da9auBcOEtdnbsiPmZ3KIy1b5zLBwNdodwZoQN2t0B1AePBcqaJj
         syazlkMYHzoEJxfDXGxFf3mS/DJp5GGIrXaE4tpxA11X/lOsWZv13nDibZpkmvMDi92Q
         TGedCgT5pspFTWOS9Tgub71esgkMlN2lvE0ilpUE1xfpQ70sSw6SjbkFNQ1xkqXbyBt/
         K3A59mbd2/KSeIWjidAqNsS9QQcZg3MK/vwZNLe0bNWXF98seh4RxgF05f4ZvPKwEvyQ
         c5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=iR5O8TyT7l2Sn8HTtrKvELqGqUHFUA4ifGZZateqHOg=;
        b=mCgEX8ivSBz3HXxoLqqp0Y1vnoWMAa7DzF8fsKAUmdnDTfrv9ArjXXwsMsOV7yB7Mw
         ZKoZlXoAeqEh9l+jByt99tBaKAiB0QQ25Ij2UntwUx7WuMr9ujLcxhenrzhWOLgRtyPc
         FeVXSPRsvgd7P1+oCkhPzML/vUMuA9EpXmAs3y2tRN92/qg1tW7iYIJckMpjA3Yt20gs
         lLInuZXHN5NGc3wp8S1uFSosS5miOvLi5fYGv6lQkC7O+tCrMYdPgiuneMfFuqWVQh3M
         wp1eO8GytlNwzVFQ7oLOWmKCu0jsjqkVf3W7yHW7wBtCL7kSqZl2fSN+53upC286epoW
         NzbA==
X-Gm-Message-State: AD7BkJKGdYu2gmIM406nMjbO6G34Sw6c4YI2hYRgAQTYd39Srlgf3UhnBa12yEPvkSHZvruj1XmqLo4cTi1UiU/w
X-Received: by 10.50.132.42 with SMTP id or10mr459969igb.85.1458071435622;
 Tue, 15 Mar 2016 12:50:35 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Tue, 15 Mar 2016 12:50:35 -0700 (PDT)
In-Reply-To: <1450653595-22676-2-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288903>

On Sun, Dec 20, 2015 at 3:19 PM,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> "git clone --recursive --depth 1 --single-branch <url>" clones the
> submodules successfully. However, it does not obey "--depth 1" for
> submodule cloning.

I am about to resend "[RFC/PATCH] clone: add `--shallow-submodules` flag"
which would need tests and I thought about this series as tests.

I assume patch 2 (fixing a broken && chain in tests) made it through,
but patch 1 and 3 did not? I may pick up ideas from here as it will be
slightly different tests I'd guess.


> +test_expect_failure shallow-clone-recursive '
> +       URL="file://$(pwd | sed "s/[[:space:]]/%20/g")/repo" &&

This would break if the test suite is in a path containing any other white space
than U+0020 such as a tab? (Not that I am encouraging using such paths...)

Thanks,
Stefan


> +       echo $URL &&
> +       git clone --recursive --depth 1 --single-branch $URL clone-recursive &&
> +       (
> +               cd "clone-recursive" &&
> +               git log --oneline >lines &&
> +               test_line_count = 1 lines
> +       ) &&
> +       (
> +               cd "clone-recursive/submodule" &&
> +               git log --oneline >lines &&
> +               test_line_count = 1 lines
> +       )
> +'
> +
> +test_done
> --
> 2.5.1
>
