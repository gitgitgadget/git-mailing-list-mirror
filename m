Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBB0C6379F
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 22:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjAMWTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 17:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjAMWTk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 17:19:40 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630B07466F
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 14:19:39 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id p24so24788529plw.11
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 14:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5q5zc0gPJMqT5gWOMM31eeAjqzpgDuitcdNs8C3xWbk=;
        b=XyJeguty4G4l2F0BWUmB4uCXl09HG/OlE9QqWHhLPjzLFoYSp37IRWtjMAselMtGVG
         4tNvYpYdHV88ZfcUYksQp9cvzxED34k9PcQfAvv6USarMmkzod2mzzOl5oFdKqb6Wrj1
         VErjFZO+An0XhBCzYjNaQdA9bHB8AQYvt4wC2cSwTVPxS39xhoAgyAA0+BqgbxsXTIm6
         o9U2+dx3zO1nbPtaXuQ8WXQZBrfFZvIiAhqv/QibpSQrEFUtFwZAFCBCqgctEqmCeMyb
         JZJ4m1tFkxuNoz1T8J2v+67BVSqOPl60m6CWL+K0uavB3GWKPd+gtcJ0p010u1Bo2Xqr
         LDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5q5zc0gPJMqT5gWOMM31eeAjqzpgDuitcdNs8C3xWbk=;
        b=KO/juKRAf3Dv0DJKwlG56tD+8Wzm38vt7HPg2TozjJSCiAhmYwlm/akZd0U+jAv3RB
         YA1FbaIMwbt+1ENThWWeNSRmExj8ieAmcZIk9DMSFB3WbBoysi3Pb+Xc5xGGq9PajQoG
         EJZYO6Yq7s7B8GlzYqSs0vtwWPWJZkVXdOWPOp9J1zQ6Lgt2hiF/1c7aoYTkDZX5Lg9H
         t0NBgtMgeLfMRMQmHjwGeTO/APtsDp5SGJYsgZJNjUMUhUIVcA7XeJ9mcJDRdsGmCYdf
         OL684HTyIzrqfB4McusxiEJk+mkUHa/JnXUv7hub/OZk56KcJwuiKXyNuIXJ3qrdgj/O
         yitQ==
X-Gm-Message-State: AFqh2kqrP1/UDdOUW84jEWKZc7vViqelwxHGdgp0OituX1tDUmWpx/nK
        IEQ34NLrkWWwtvdDUvU+NG9vovl21CI=
X-Google-Smtp-Source: AMrXdXsEGUGpbAhPZa3SIJqxXRqMs4HlgBQ8gA3fL/deu6wbC5rtbwIYpDS2O2+mNKBDJtJbkPX3/A==
X-Received: by 2002:a17:90a:b306:b0:218:d7ee:d4ba with SMTP id d6-20020a17090ab30600b00218d7eed4bamr86805378pjr.3.1673648378761;
        Fri, 13 Jan 2023 14:19:38 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00218abadb6a8sm13058631pjb.49.2023.01.13.14.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 14:19:38 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        sunshine@sunshineco.com, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v6 2/2] attr: add flag `--source` to work with tree-ish
References: <https://lore.kernel.org/git/cover.1671793109.git.karthik.188@gmail.com/>
        <cover.1673521102.git.karthik.188@gmail.com>
        <57f5957127ce3be2621445806f2f00857ac8b1aa.1673521102.git.karthik.188@gmail.com>
Date:   Fri, 13 Jan 2023 14:19:38 -0800
In-Reply-To: <57f5957127ce3be2621445806f2f00857ac8b1aa.1673521102.git.karthik.188@gmail.com>
        (Karthik Nayak's message of "Thu, 12 Jan 2023 12:00:31 +0100")
Message-ID: <xmqq4jsu13id.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> diff --git a/attr.h b/attr.h
> index 3fb40cced0..f4a2bedd68 100644
> --- a/attr.h
> +++ b/attr.h
> @@ -1,6 +1,8 @@
>  #ifndef ATTR_H
>  #define ATTR_H
>  
> +#include "hash.h"

You only want "struct object_id" declared.  Why include the whole
file?
