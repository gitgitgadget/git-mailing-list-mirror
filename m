From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 3/3] submodule: extend die message on failed checkout
 with depth argument
Date: Mon, 11 Jan 2016 08:26:18 -0800
Message-ID: <CAGZ79ka9+KxqbogbN1UnNxQ_G6U_incYKLiuadTroc90VmEWpA@mail.gmail.com>
References: <1450653595-22676-1-git-send-email-larsxschneider@gmail.com>
	<1450653595-22676-4-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 17:26:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIfIY-00055B-QJ
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 17:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933827AbcAKQ0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 11:26:21 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34008 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933793AbcAKQ0T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 11:26:19 -0500
Received: by mail-ig0-f172.google.com with SMTP id ik10so126072785igb.1
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 08:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/xABX84BLgxr5rTUwhiMMHelaTolvXhT7qDs0pk2+JI=;
        b=PFzgnAfSt9NjJqqWH007H4TC7kUCh5YIOTvXnWueRt2ojbjncFwC1aD7pwedZjo90/
         Kri2RB1aZtwty536QYaHrxlux1lDnvFVe/at3oKFvNgpJ/3lAb9ws76OLcbz21fBMrzG
         AjA8+NtdMmgX/ZKdB+oe0dtvsB+7IIuc7tZLPcUrMd1v5Uw46rg87mbsGhgHYRL6vpXZ
         lmxZl0VdcnocWl1f8NDqRiGZWKuqcc/vSr5d1xvJUZBi8Dy38iZVMwuHKouS2s1EJbTZ
         d3CqPfCgggJJSESUg39y1RIzTlkYk7qJeySdPTwNySEvKkSVGTjil1vDF6mLx045aNTZ
         fALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/xABX84BLgxr5rTUwhiMMHelaTolvXhT7qDs0pk2+JI=;
        b=Cfnima6SZlk5y9S9rhbVjJeH7EfRjnLuysJcv8wQ9wcBlz3mSw4GuSq+0CYXCjQ4Nd
         bmpdk0/HdxA179xbUdDgWTdLKWKijvufAa45udCdOXPny3xqCbB/WvXI8w5cwHBArhE8
         tWtMMGkPh2ar7mBXmun9LTjjdeSYMkAjENkhncChQ1ZhPNby8uvzVJyTppcSReZU7WPm
         zaF8/T1g/359hxTFtTPQuk7jaEWFsY4ZOXx0I4g/YZYHxcIlQuuJ+CUoiO9HftmjCbUI
         lmRjMfqQjXgq64ypIa4DG3IzIMw+0eqTNcmswQiwmwS3U8XGJat23ddwT397pTSnQPIl
         w5vQ==
X-Gm-Message-State: ALoCoQle1lJoQ3G2D0jSd+xVOZSSATLL/mJ+vlDju4JCO9EzpJ1pa7asQCkO1QtQTW1s8sxae0ouC/Ru9VhwnETzKlZqHXGvkj8zjYvr7CMAudB4407yN4E=
X-Received: by 10.50.138.76 with SMTP id qo12mr5907082igb.85.1452529578258;
 Mon, 11 Jan 2016 08:26:18 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Mon, 11 Jan 2016 08:26:18 -0800 (PST)
In-Reply-To: <1450653595-22676-4-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283665>

On Sun, Dec 20, 2015 at 3:19 PM,  <larsxschneider@gmail.com> wrote:

> +test_expect_success 'submodule update clone shallow submodule on non-default branch' '
> +       git clone cloned super4 &&
> +       pwd=$(pwd) &&
> +       (cd super4 &&
> +        sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
> +        mv -f .gitmodules.tmp .gitmodules &&
> +        test_must_fail git submodule update --init --depth=3 2>submodule.out &&

Why do we choose a depth of 3 here?

> +        test_i18ngrep --count "Commit is probably not on the default branch." submodule.out
> +    )
>  '
>
>  test_expect_success 'submodule update --recursive drops module name before recursing' '
> --
> 2.5.1
>
