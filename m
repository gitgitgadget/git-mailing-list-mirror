Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4991ECAAD8
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 21:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiIMV7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 17:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiIMV7N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 17:59:13 -0400
X-Greylist: delayed 363 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Sep 2022 14:59:10 PDT
Received: from outbound8.mail.transip.nl (outbound8.mail.transip.nl [IPv6:2a01:7c8:7c9:ca11:136:144:136:8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F69C72B65
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 14:59:10 -0700 (PDT)
Received: from submission12.mail.transip.nl (unknown [10.103.8.163])
        by outbound8.mail.transip.nl (Postfix) with ESMTP id 4MRxzP3tqWzY75qJ
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 23:53:05 +0200 (CEST)
Received: from [192.168.1.198] (5072ADBC.static.ziggozakelijk.nl [80.114.173.188])
        by submission12.mail.transip.nl (Postfix) with ESMTPA id 4MRxzN5TgGz1BFfj
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 23:53:04 +0200 (CEST)
Message-ID: <2e846a72-a4c6-2a5a-255a-15eee037f574@fwdekker.com>
Date:   Tue, 13 Sep 2022 23:53:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     git@vger.kernel.org
From:   "Florine W. Dekker" <florine@fwdekker.com>
Subject: Wildcards in mailmap to hide transgender people's deadnames
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: ClueGetter at submission12.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=fwdekker.com; t=1663105984; h=from:subject:to:date:
 mime-version:content-type;
 bh=aaESTikbGl1NbgOu9+exOdkdjfQHr6SOrAYzakLrDFg=;
 b=GOWX888LFdn/Vy0WQ59/GLgz+qdmqc2cSvAMwwNW1P/ZDIyjZOGFHne+iRu+5hau7NFzv0
 ml6hW3cClB7dFD+VTmjBs28nOre4QyzjRuV1dKO6JwuPxJPO8H5jEUv0kSmwgb0i2zbLm5
 xIu9uh0PUxhSu4JswMcJrGlIHrm7PZLs0h2LK8RUA+vIzil9rNlG9exHjhV80NnRS82ayD
 fdd0nXam6+ah5rVOkFDuBgUGaTKbityvKIp1P2iLC3PyNjWdzoP/fw936vBywcaoRbBrRH
 vFB4jvsUeeJ0MJfuwQMCzrZmCeQ0cfTZy1Nreu8cVXZseaXEwVlJ1ofySefM6w==
X-Report-Abuse-To: abuse@transip.nl
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi! I would like to suggest that the mailmap feature accepts (a limited 
form of) wildcards for matching email addresses, which helps transgender 
users configure the mailmap to map their old name ("deadname") and email 
to their new name and email without revealing the old info in the 
mailmap config itself.

For example, consider a user who changed their name from Jane Doe to 
John Doe, and their email from jane.doe@example.com to 
john.doe@example.com. John wants to prevent others from learning their 
old name, but sometimes it's not feasible to rewrite the entire history 
of the repository (e.g. because there are thousands of commits, or 
because this would mess up references between commits). In this case, 
mailmap seems like a good way to prevent people from finding out the old 
name by accident: Just add the line `John Doe <john.doe@example.com> 
<jane.doe@example.com>` to the mailmap config. However, this has the 
unfortunate effect that readers may now accidentally find John's old 
name if they look at the mailmap config.

I suggest that mailmap config files support wildcards in the email 
address. This helps people who have changed their name to specify a 
mapping without revealing their old name in the definition of this 
mapping. Because the * symbol is valid in an email address, I suggest 
the sequence \* to be the wildcard symbol, meaning "0 or more symbols". 
This cannot be misinterpreted in an RFC5322-valid email address, because 
this sequence is not legal in the domain part, is not legal in an 
unquoted local part, and is not legal in a quoted local part unless 
preceded by an unescaped backslash (that is, "jo\\*hn"@doe.com does not 
contain a wildcard). In short, if mailmap encounters the sequence \* in 
an email address, it should interpret the sequence as a wildcard if and 
only if it is not directly preceded by an odd number of backslashes 
regardless of whether the local part is quoted (so \* is a wildcard, \\* 
is not, \\\* is, \\\\* is not).

Now, John can now add the following line to their mailmap config: `John 
Doe <john.doe@example.com> <\*.doe@example.com>`, which does not reveal 
their old name. Someone could always spend more effort to uncover the 
name using more advanced tools, but the point of this feature is to 
prevent accidental discovery of the name in cases where completely 
hiding the name is not feasible.

If you have feedback or comments on this suggestion, please let me know.

- Florine


