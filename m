Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A18C54EBE
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 13:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241763AbjAMNiQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 08:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241230AbjAMNiG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 08:38:06 -0500
Received: from fallback16.mail.ru (fallback16.mail.ru [94.100.177.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334C31A81C
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 05:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=jKwNxPwikDA+gTtprGlUT8D84yXKYI6JcdJb8rGHVd8=;
        t=1673616671;x=1673706671; 
        b=P1BC4vhHYghC7xTtF4X3y4BpMO5t3zQMTNasE+xIRD72QvPOZjnj/9wqFPRgcslOq99V1BHBLLZomLrKXlGG8DLKgyLCttUT+ztyz9nY/l6fYpzrFQYAX0zsQ2ifAAZ29NbDYIPNFYwTXBjAzS8BUpmKhtWjo/EMELxCSDZEfr8=;
Received: from [10.12.4.9] (port=56062 helo=smtp30.i.mail.ru)
        by fallback16.i with esmtp (envelope-from <kostix@bswap.ru>)
        id 1pGK9D-0001kE-7q
        for git@vger.kernel.org; Fri, 13 Jan 2023 16:31:07 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=jKwNxPwikDA+gTtprGlUT8D84yXKYI6JcdJb8rGHVd8=;
        t=1673616667;x=1673706667; 
        b=Pc5zVxr3hJL+sgamQV70a3HFzrABivNuDHe+ULbrlDR9WlescQhYaAK0WB3YqulnI6i3NHXCRios07GkzPLDxxHTxXALNWWJav9Jreb/QaQN9Cb6lsCsuVe9b5//ki2y9bzqCKmTMScKVgu694PHsWlnT8qgJDzE9mQIiHY4QiQ=;
Received: by smtp30.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1pGK99-0029Jv-Oz; Fri, 13 Jan 2023 16:31:04 +0300
Date:   Fri, 13 Jan 2023 17:30:59 +0400
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     git@vger.kernel.org
Cc:     Hans Petter Selasky <hps@selasky.org>
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Message-ID: <20230113133059.snyjblh3sz2wzcnd@carbon>
Mail-Followup-To: git@vger.kernel.org,
        Hans Petter Selasky <hps@selasky.org>
References: <39dd1a00-786b-acf5-8a40-2425f7dab6cc@selasky.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39dd1a00-786b-acf5-8a40-2425f7dab6cc@selasky.org>
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD90D1502B3BE350FE460E08CDB322628C398144F1A0CCA906500894C459B0CD1B9419E1F3263FBF88E6D78A1BE3AAEB538997376E34FDEA5B94044E5D25B716109
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7548C33FFD72831AFEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637E16D8B060A9A23898638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D87EB6763C3B02EB188A89423AAE3966AB117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCAA867293B0326636D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B3D2201D7125A9A9FA471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FCC72290D3461944403AA81AA40904B5D9CF19DD082D7633A078D18283394535A93AA81AA40904B5D98AA50765F7900637D5025E0C20F902FDD81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F83C798A30B85E16B57739F23D657EF2BB5C8C57E37DE458BEDA766A37F9254B7
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34BDCC71B3781C9C95809CD50B3417A23A4A1B1527A23E0F4AD123AB03D8C7741C92575B0DDA02D6D01D7E09C32AA3244CE2C0C29D6709A1F0B605FD66D589CA018580396430872480729B2BEF169E0186
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj4ZlsFbC/htXtVJU5NkYfDg==
X-Mailru-Sender: 53225E476262CDFB75EED519089A6785C28D7D2FC1ADBA1595C32978263C9180EC285D5E42C12BCD13BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B41CF11DA7185A12D6F59AFDE8C3CC415EED2CE16157C1158268F3CF0E9FE49B69EE846DB3FDC391BCFE0159EEFEAA2B329BCEB26A502E68BDC63BFC2A479AC9C1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFd420tiPzan94DC+beQ1g+yQ==
X-Mailru-MI: 800
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2023 at 01:59:44PM +0100, Hans Petter Selasky wrote:

> Currently GIT only supports cryptographic hashes for its commit tags.
[...]

https://github.com/git/git/blob/9bf691b78cf906751e65d65ba0c6ffdcd9a5a12c/Documentation/technical/hash-function-transition.txt

It's not clear why are you referring to Gitorious in your mail's subject and
then talk about Git.

