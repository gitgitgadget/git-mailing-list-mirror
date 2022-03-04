Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400E5C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 20:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiCDUne (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 15:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiCDUnc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 15:43:32 -0500
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Mar 2022 12:42:43 PST
Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7959C224509
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 12:42:42 -0800 (PST)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id QEl6nYEhNN0saQEl7nn4wk; Fri, 04 Mar 2022 20:42:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1646426561; bh=l94t8VM7Vo++Ljh2ClYOhKlYWS4RmPP1Szb8QJ8AcYA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=OMoT6qOLUBl3+t5DepnNSYQQXy9/EUliSERmsiIA2hjWZxEGPV/0YQHSaBXKG5J4/
         +GOy5Lztaa9h3YxjCoHwdFRHJvEEArvn4K4lBQKEC4IY6O8mMHu+sRzotRQ0Q3ej18
         Lcg0G0fL+/U3btzgwqxxbFiRMOU8bWDWRCcYPMowLDMUtC5tyrjms1yKQYMYjeh+Xb
         DjmiWBj4wxJydjBcgefjyXqDlqcM6sZdmB8CKkH2eKMDyKfBM3fMp7WG3+0ahw4lDe
         TqkoFUQpAdHsEzrBJUI+OHqrE2iPhbOAa50j+KPpOV4ViiHDYFOs8nP98Ad2SS3LYZ
         92de1nxbZZ8jg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=Ecqr/NqC c=1 sm=1 tr=0 ts=622279c1
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8 a=FjKJCpkIEXy-edj1iUEA:9 a=QEXdDO2ut3YA:10
 a=RfR_gqz1fSpA9VikTjo0:22
X-AUTH: ramsayjones@:2500
Message-ID: <0a8b4a1d-f6e7-dc8f-3496-c2c96a25bcda@ramsayjones.plus.com>
Date:   Fri, 4 Mar 2022 20:42:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/4] terminal: don't assume stdin is /dev/tty
Content-Language: en-GB
To:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Cc:     carenas@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220304131126.8293-3-phillip.wood123@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20220304131126.8293-3-phillip.wood123@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHyuuXPGWcTz9DkGXYncEeCKK2I08QRCYcXjTEVgRVWPw+rLaHZdDksnYF73B9b0wjzB154qAuu5oc1gieBs915qEroXL7t9eaXe0q5lYtioDB7vcJl/
 uzNgQ8yriTCBx9gTR7rSs90L8HpaYs3D2r/TnhYqKZu43tBkC2VeOXf26eIFty4VzwLekDWyRhxiS19uzNxEiXdollOl/MBeJ94=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 04/03/2022 13:11, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
[snip]
> diff --git a/compat/terminal.h b/compat/terminal.h
> index f24b91390d..f5655d0d0b 100644
> --- a/compat/terminal.h
> +++ b/compat/terminal.h
> @@ -3,7 +3,8 @@
>  
>  /* Save input and output settings */
>  #define SAVE_TERM_DUPLEX (1u << 0)
> -
> +/* Save stdin rather than /dev/tty (fails is stdin is not a terminal) */

s/fails is/fails if/ ?

ATB,
Ramsay Jones

> +#define SAVE_TERM_STDIN  (1u << 1)
>  /*
>   * Save the terminal attributes so they can be restored later by a
>   * call to restore_term(). Note that every successful call to
