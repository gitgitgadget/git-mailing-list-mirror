Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E4AC433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 10:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJGKKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 06:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiJGKKT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 06:10:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823E853D28
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 03:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665137411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Kj81UUwEDZA2AlI4nKhR90ttDWwoB6evqGZlBwFh31o=;
        b=Rx9yWSHY8ZvcviGB0G1FdPlVKLtN9ple2zWCdXfvhBRqSyR+2mqmIH+IAIIxwtLjASroAF
        sPP5eJwiTalhqTwartyCUCqQ51UavwquC+sEj1uciI1WH+9JKmDepH1o6ZhDZieQNaLKAE
        SNB++W4cFbe+GN+7VEL8prs6M3lVqK8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-669--bEwJwdhPYidT3G7mbUGHA-1; Fri, 07 Oct 2022 06:10:10 -0400
X-MC-Unique: -bEwJwdhPYidT3G7mbUGHA-1
Received: by mail-wr1-f71.google.com with SMTP id l6-20020adfa386000000b0022e6b57045bso1270107wrb.20
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 03:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kj81UUwEDZA2AlI4nKhR90ttDWwoB6evqGZlBwFh31o=;
        b=pD+ppIxwZw6tGTFmdxcgfZj812ZRI1sw9Yq0kXBTrhRX1zx9GYAhRMGBges42nehON
         d4IOqWSRpc8D/e1qpMRsFMskg7XXwMFsJE1wZlLI4ABXegYajYU9VKLqIb0zu+1ifEXE
         XAZvCdfhjjKw63vgaaEhSIyZlRC8DZZ84FfPQR8l/iZh/N7WOyIVHuZ5Ke7uZkjdnzh9
         YXo1nW/00VZD2mgbyvenj2aaLhdQIoUAGHT4FGSOBbiuA4iK6htNff+l/C/dGgvp8F3t
         QayUVxbo5g1m3ffmhgZokSvLO5gawx4SlHc2YPYQIXEkq5xUTj4Q0PtOIy4absn7h/U/
         SiEg==
X-Gm-Message-State: ACrzQf2aVbqTUrfwy6Dxoxr4iEW9rz+3pqtIljtMOMhcrNR2cM6h32wK
        rqocazqVF4N6v8lL45akZRaVvM3T6N3TTfGeXsLTmMF17TqkbfRQTAwjdjekqfRLT5sihiZw2I5
        kPMjkHJmSQ05xLgW7nsDKM92XWqcB/g6e69Fbqi3RPHz+IkHD7vVRdmYTrA==
X-Received: by 2002:a5d:5909:0:b0:22e:57b2:260b with SMTP id v9-20020a5d5909000000b0022e57b2260bmr2806751wrd.597.1665137409416;
        Fri, 07 Oct 2022 03:10:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6LSAqMysCqA0p03lMdXFAe1IWmma3w1/b2fMC8SySuMKdZPicGsi4ww2F+nzfFGt8TZeMwIA==
X-Received: by 2002:a5d:5909:0:b0:22e:57b2:260b with SMTP id v9-20020a5d5909000000b0022e57b2260bmr2806726wrd.597.1665137409076;
        Fri, 07 Oct 2022 03:10:09 -0700 (PDT)
Received: from redhat.com ([2.55.183.131])
        by smtp.gmail.com with ESMTPSA id y8-20020a5d6208000000b0022c96d3b6f2sm2131786wru.54.2022.10.07.03.10.07
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 03:10:08 -0700 (PDT)
Date:   Fri, 7 Oct 2022 06:10:05 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     git@vger.kernel.org
Subject: sudmodule.<name>.recurse ignored
Message-ID: <20221007060713-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


THE CONFIGURATION OF SUBMODULES
       Submodule operations can be configured using the following mechanisms (from highest to lowest precedence):

       •   The command line for those commands that support taking submodules as part of their pathspecs. Most commands have a boolean
           flag --recurse-submodules which specify whether to recurse into submodules. Examples are grep and checkout. Some commands
           take enums, such as fetch and push, where you can specify how submodules are affected.

       •   The configuration inside the submodule. This includes $GIT_DIR/config in the submodule, but also settings in the tree such
           as a .gitattributes or .gitignore files that specify behavior of commands inside the submodule.

           For example an effect from the submodule’s .gitignore file would be observed when you run git status
           --ignore-submodules=none in the superproject. This collects information from the submodule’s working directory by running
           status in the submodule while paying attention to the .gitignore file of the submodule.

           The submodule’s $GIT_DIR/config file would come into play when running git push --recurse-submodules=check in the
           superproject, as this would check if the submodule has any changes not published to any remote. The remotes are configured
           in the submodule as usual in the $GIT_DIR/config file.

       •   The configuration file $GIT_DIR/config in the superproject. Git only recurses into active submodules (see "ACTIVE
           SUBMODULES" section below).

           If the submodule is not yet initialized, then the configuration inside the submodule does not exist yet, so where to obtain
           the submodule from is configured here for example.

       •   The .gitmodules file inside the superproject. A project usually uses this file to suggest defaults for the upstream
           collection of repositories for the mapping that is required between a submodule’s name and its path.

           This file mainly serves as the mapping between the name and path of submodules in the superproject, such that the
           submodule’s Git directory can be located.

           If the submodule has never been initialized, this is the only place where submodule configuration is found. It serves as
           the last fallback to specify where to obtain the submodule from.


However, when we are talking about the recurse attribute, it is
not taken from .gitmodules - only command line and .git/config seem
to be consulted.
Is this a bug or a feature?


Thanks!

-- 
MST

