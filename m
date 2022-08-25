Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46A2C3F6B0
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 08:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiHYIwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 04:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiHYIwa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 04:52:30 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7468DA831A
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 01:52:29 -0700 (PDT)
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CBC0B3F11D
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 08:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1661417547;
        bh=N1v/eO6wQhuZ5QIP06H6BLuQ1TiALqvgtWzskcUXyjM=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
        b=fL8pZE3sSqVLLe9ov5qS8U5DnmYlEmA5qt70274DfrSoWew2B4cXuiPOQ/YXkpwrL
         Rme+lvWuJ3MPS6BxsNFek5Q6UPu2pS711LhnOuznOyqL4G/8kkwDUGi01Xh807Ot5Y
         z9YGRaytQO7S1mgl0RfYOGLGDS0rejZV+oZzKbp+EH9tw2GcKA7LWk9C78PM9L9/EX
         iIheuuaWL3n8AQMgApi4iGckUgdJZYkTAPW7B6WvlIn/ax/lXp0lWHlgduDAHp7Z0W
         IjBjTdc/TovaRIHedzxZZp8TOXjrYD47VojuSRl8OQZH1PGdcM/tnnta/8mFTva/Sp
         MPWTMxBn1HdQw==
Received: by mail-ua1-f69.google.com with SMTP id p4-20020a9f2b04000000b0039f2ed5774aso2177576uaj.10
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 01:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=N1v/eO6wQhuZ5QIP06H6BLuQ1TiALqvgtWzskcUXyjM=;
        b=VgzOpNCNzom+JrOIVfa0qk8X0gRQeGKM5h69FnF0nhP+HIyUfz4IKUxpWh7svMcog7
         F9cuonL0VORfhhUWYCLbHvmpbYh2u2Q4vvSUL7TYxPqzCu4/xIfb8Qxk81yKzJjcvZhO
         IbN0RI3OcVPuTqEURQArO88PrFYpHwUA4ooki33gQRCXA57XEkAmxkhQxhEvvWVhV1jC
         BQ9VEMwOzeKC9K+Ahe/j57VKafnzLfx5SW1xQan73GWLduulMFvu8qLBnd6uuVc6EqoH
         ZPTrZpdKVIMvzI8q4bY3zeHqp7Lpe53M+fY7+3xoPJ75J0x/vtpJExV4QMvUx+4Y+Lrx
         UT/Q==
X-Gm-Message-State: ACgBeo2QIAGHzEtoiXpuBLwBT+kvcELns5VLtJen+SHv5FLkQTTmJfsr
        kf2FezVehqgZEb84swz3rbsERoaJieabemHZu4GFcU21YlsI1d1w9P/DgLIpJJtOBVGPohd9Ipw
        ez4b8CuzBma+2GFWLziAtdGY/5bA6+jVWM+0RgV5Jt219+Q==
X-Received: by 2002:ab0:6853:0:b0:39f:e54:90e9 with SMTP id a19-20020ab06853000000b0039f0e5490e9mr992973uas.34.1661417546730;
        Thu, 25 Aug 2022 01:52:26 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6TlRPT5jhyaKc/BNxDAQ+uFgbShUp4owmWp6keyfJ1ZNEPYuXvsQwB2OxawQzXN+Z9L8QjOqKGKUGeTotQ/iI=
X-Received: by 2002:ab0:6853:0:b0:39f:e54:90e9 with SMTP id
 a19-20020ab06853000000b0039f0e5490e9mr992970uas.34.1661417546567; Thu, 25 Aug
 2022 01:52:26 -0700 (PDT)
MIME-Version: 1.0
From:   Arturo Seijas Fernandez <arturo.seijas@canonical.com>
Date:   Thu, 25 Aug 2022 10:52:16 +0200
Message-ID: <CAHckPJS6ibtxbU+VKwDaU6pFMtJ5SMcWnBi6D2pY+ekqpWsqXg@mail.gmail.com>
Subject: [BUG] git config --unset is not idempotent
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The command "git config --unset [option]" is not idempotent. It is
currently returning a success  code when the property had already been
set and a 5 error code otherwise.

I would expect the error code to be set according to the current state
when compared to the target state, regardless of the previous state of
the option.

Thank you,

Arturo Seijas
