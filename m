Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D4EC433FE
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 17:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJORfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 13:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJORfB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 13:35:01 -0400
Received: from mail.hostpark.net (mail.hostpark.net [212.243.197.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099632228C
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 10:34:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.hostpark.net (Postfix) with ESMTP id 86BF9163CB
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 19:34:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bernoul.li; h=
        content-type:content-type:mime-version:message-id:date:date
        :references:in-reply-to:subject:subject:from:from:received
        :received; s=sel2011a; t=1665855277; bh=dmrBt6qzpFAJXxy9aX5d6F7b
        QTFYlbsEjHgRuh9MDzs=; b=RPm+5vRQPmrReBc41wWVAq//LygMEltBoDsbd38E
        y5iCGAgfUf821LQ6VX+HRPKPwqQRW6yAmhVmVcT2bYnII0cu18IR/epRSPFCqMzc
        oik/UsNecC91g2ZU1/GAxIqUbAXxVYXGZ11G5Au58uUe10/jouoo37y2rRw7wAct
        lKM=
X-Virus-Scanned: by Hostpark/NetZone Mailprotection at hostpark.net
Received: from mail.hostpark.net ([127.0.0.1])
        by localhost (mail1.hostpark.net [127.0.0.1]) (amavisd-new, port 10224)
        with ESMTP id BMbzjhNTVn9I for <git@vger.kernel.org>;
        Sat, 15 Oct 2022 19:34:37 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.hostpark.net (Postfix) with ESMTPSA id 5C8E5162AB
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 19:34:37 +0200 (CEST)
From:   Jonas Bernoulli <jonas@bernoul.li>
To:     git@vger.kernel.org
Subject: Re: "submodule foreach" much slower than removed "submodule--helper
 --list"
In-Reply-To: <87czatrpyb.fsf@bernoul.li>
References: <87czatrpyb.fsf@bernoul.li>
Date:   Sat, 15 Oct 2022 19:34:36 +0200
Message-ID: <87a65xrnwz.fsf@bernoul.li>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just noticed that "submodule--helper name" was also removed, which I
also found useful in scripts.  Please tell me if I am missing something,
but it seems I now have to do something like this instead:

  git config -f .gitmodules --list |
      sed -n "s|^submodule.\([^.]*\).path=$path\$|\1|p"

The old way was nicer:

  git submodule--helper name $path

I realize submodule--helper is for internal use and using it anyway
comes with the risk of such removals and other changes, but again,
please consider restoring that or providing something similar in the
public interface.

     Cheers,
     Jonas
