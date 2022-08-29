Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B422ECAAD4
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 10:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiH2KxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 06:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiH2KxB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 06:53:01 -0400
Received: from mx2.freebsd.org (mx2.freebsd.org [IPv6:2610:1c1:1:606c::19:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E50F61B33
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 03:52:57 -0700 (PDT)
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 4MGS2V2JPPz429Z;
        Mon, 29 Aug 2022 10:52:50 +0000 (UTC)
        (envelope-from garga@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 4MGS2V1PvNz3x6r;
        Mon, 29 Aug 2022 10:52:50 +0000 (UTC)
        (envelope-from garga@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
        t=1661770370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W7uo/jBQ0cMzjwnJhLfONGAKuVWL1ue8fNKy+AKsR10=;
        b=suwDgqHQPGcZr01MBjkte02g8fq7kvLzVOnyyVEeKOf1gEW+obt6WX3EJOmGlkws2dnz+I
        /35WQd1LFwb49VqW+BhA7gLHTcs4shKltWPxcvJrGuHahu938ScS+0LTZ2V6LsbW2xn5/R
        8pMinMfmwsQZSITsY8YLol8cQ1u+s6qt0YWaQVVvVByL+nrHw7R61Svz8xF/vOhzso26Zu
        1DLkxeEJhU8zYbvoQJXxq3INSPDnme7ctw5XX/oj7lzxDgBhlay5L7t0i4VGGCfF9IG4Bp
        MEDKnbArOE+HL0UoI6j/PK8E4Qpv3et5krpaA0siJIC9p4QrIc1AcA5DJCwSRQ==
Received: from [172.21.4.170] (dynamic-177-53-82-16.telecominternet.net.br [177.53.82.16])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: garga)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 4MGS2T2457z1HLS;
        Mon, 29 Aug 2022 10:52:49 +0000 (UTC)
        (envelope-from garga@FreeBSD.org)
Message-ID: <d2b63f68-4463-63cd-065f-0902fc8be4e3@FreeBSD.org>
Date:   Mon, 29 Aug 2022 07:52:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.0
Subject: Re: [PATCH v2] gc: use temporary file for editing crontab
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>
References: <20220823010120.25388-1-sandals@crustytoothpaste.net>
 <20220828214143.754759-1-sandals@crustytoothpaste.net>
Content-Language: en-US
From:   Renato Botelho <garga@FreeBSD.org>
In-Reply-To: <20220828214143.754759-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
        s=dkim; t=1661770370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W7uo/jBQ0cMzjwnJhLfONGAKuVWL1ue8fNKy+AKsR10=;
        b=Oa0f0LxvthJnPzXmrf7R2yFHfs1j2uy6Qxs5BM/TX2SnqK/PqxNBkhwqiRRiDiNWAMMuTG
        aXfxvZReHu81wvm3Q35XOfB6OEfm7IWC1yfYuM0mfFEnkTv+qV3AaHhe7+TYHc+z0qgd5J
        zRbkSSYSSK9sX+fcihyZVgmffmLqebEcAPPhhdSk+IJ8fQa03y76AhaMeSMpcaltQh6kBS
        R9iw+Mxbzrk5jF1Et+3PEsAv/lj5+qvp6nq8cVT9fIn53UAHGUb7sboLKeceAYpeJIPWxX
        U1UYir2COQb+cCHTbqtdLlw073p4lo0KTAoqlJGw2GJ9jyDCpqBSbwz/IyP1WQ==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1661770370; a=rsa-sha256; cv=none;
        b=ueYjU4at6Kw9mrE8KYujXKYuSd1YCZ0bz6LhqbPLLwwuNiVBFOA3U2mw0BYqwXAjwyaQ+q
        5plPKJKZmgRuDu1bAclFlkiMlxjUz1OJUJvnU+27S+5hfvF8S690EG3x9pNjx2suGmu87k
        Sd1W1Obn8TlEw93K42AWYOMAwIpTePUJpoiIKKUn+ptD5wEmWnX8TWoAdK5shFr87bIM+G
        zMbwVTs2Wc/j/R8NwJkmmhSs07wIaohb61fW1tJWWN4FYgAbVlA/g5SZZBjZ0SbBAqF4VX
        aB5H9QtE52mlgZtk7T7RQ2a+ypmPuMlDkdhJW4WvNjFFDsWrGaMeHRh9B9+ATg==
ARC-Authentication-Results: i=1;
        mx1.freebsd.org;
        none
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/08/22 18:41, brian m. carlson wrote:
> While cron is specified by POSIX, there are a wide variety of
> implementations in use.  On FreeBSD, the cron implementation requires a
> file name argument: if the user wants to edit standard input, they must
> specify "-".  However, this notation is not specified by POSIX, allowing
> the possibility that making such a change may break other, less common
> implementations.
> 
> Since POSIX tells us that cron must accept a file name argument, let's
> solve this problem by specifying a temporary file instead.  This will
> ensure that we work with the vast majority of implementations.
> 
> Note that because delete_tempfile closes the file for us, we should not
> call fclose here on the handle, since doing so will introduce a double
> free.
> 
> Reported-by: Renato Botelho <garga@FreeBSD.org>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

brian,

I've tested and confirmed this fix works as expected.  This patch is now 
applied on FreeBSD ports tree.

Thanks!
-- 
Renato Botelho

