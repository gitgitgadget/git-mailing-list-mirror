Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635BDC74A5B
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 17:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjCURoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 13:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjCURov (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 13:44:51 -0400
Received: from smtp55.i.mail.ru (smtp55.i.mail.ru [95.163.41.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632C425E16
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 10:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=jsBA37xE+9BT6uXXjH7xXOy1p4zAS9ODdffeaY/rpDY=;
        t=1679420688;x=1679510688; 
        b=SOtz6D+JjOb4718QsuqMvmBLQ7IoMQqwXqdxWTvTBmHPw9CoM3ij2+T1QhzKNMkB3ni110vUd309AE8+qOpdtjX8JXZ1ef6uITuZjWA2SFYyZ1xwYWjPj7yBxuKgWDbV5Hpz1xTX5qCgxrOhgZZ+l80Tzyw1AtN/wEaB81ny5HY=;
Received: by smtp55.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1peg2P-001OlI-1N
        for git@vger.kernel.org; Tue, 21 Mar 2023 20:44:45 +0300
Date:   Tue, 21 Mar 2023 20:44:44 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     git@vger.kernel.org
Subject: Re: [PATCH v2] git-compat-util: use gettimeofday(2) for time(2)
Message-ID: <20230321174444.nuvym6ti3p3rd6hv@carbon>
Mail-Followup-To: git@vger.kernel.org
References: <20230319064353.686226-1-eggert@cs.ucla.edu>
 <20230320230507.3932018-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320230507.3932018-1-gitster@pobox.com>
Authentication-Results: smtp55.i.mail.ru; auth=pass smtp.auth=kostix@bswap.ru smtp.mailfrom=kostix@bswap.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD992B47CBA3690DD1ED999BEAD809499EA05A0C48DE60CF63D00894C459B0CD1B94880A9337FF7DD60CC13D69127995988512AB6F74B4D2A15F99B2959C0506FF8
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70CB15FA6C489297DEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F907CB39E8CA2E228638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D80D93F503992C3D59579FE40400D98BDC117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC55768045DF7AC1F5A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520FAD5A440E159F97DF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C5D2C5C0A547CD2CB302FCEF25BFAB3454AD6D5ED66289B52698AB9A7B718F8C46E0066C2D8992A16725E5C173C3A84C3E6DA32D78056113CBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE7A3CCBC2573AEBDE1C4224003CC83647689D4C264860C145E
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D340A4C04F5DECA7EE934EEDDA38707D2BA474A25F887DF14D5EE065FA1745BEE7181C125BA6436948F1D7E09C32AA3244CD278949F56AA9E86EA07B504EBC9775469B6CAE0477E908D3EB3F6AD6EA9203E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojTmvmcsmE6tgmt4V0WHLKtA==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD13846040B01B007EBC665DC3E941CD7A00957BF939C6BBDF48713BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2023 at 04:05:07PM -0700, Junio C Hamano wrote:

[...]
> higher-res methods like gettimeofday.  Although strictly
> speaking users should tolerate this behavuior because a

A small typo: it should probably read "behavior" or "behaviour".

[...]

