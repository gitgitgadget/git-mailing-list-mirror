Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E56C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 21:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6F820772
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 21:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjYlwBna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbgDAVv0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:51:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41521 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732357AbgDAVv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 17:51:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9so1858354wrc.8
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 14:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VBQf1RbVgvOcDqejCO6zK6bWn1OW57yIIAUf8TbPXQE=;
        b=qjYlwBnatxTl7zuGapzA+PXKt/CNbZ0MigcEePARnS4iXzI4P2kc9F//NTjky0rqKs
         zAxmItof8IA8P7FVdo8/tR//5IsmpWMDU/fMuSvvB1WjEGUzvrtnntRFo4QF+pc38WRD
         37WtnXxL9hlPNH+M2AVZAFfRhojUlN4TaPHiQl8T4OF8ZeBV8lU9v0hWWqT2gfr2pXax
         lOtUoROao2i3kgTUCFcN+cZgai/7/hzwh21zAaEiBzbKU1ENBx7n52DMznIKaA+RvXIH
         UX0cfNvFx4Qu7uBBBUbVomvmQDQfL9TdgoLKW8PI6SRDZ0jaX1v1BgieCyyNF1kyY8Bz
         SAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VBQf1RbVgvOcDqejCO6zK6bWn1OW57yIIAUf8TbPXQE=;
        b=N+gIYbLDzS9ftI+MyUlttXUeTFvRUL6t8tOAF1BZg5Bi+JBZuUX4AE1YkfqT78iGHw
         wiEL3Y/Rc4CQib7Sp/odUG03aTRKYwFcvjv+jyFMXazJ7475+j5QRe6u3OuZVECnE5C+
         XfS+/Q9H3wzaaRsdryW8sKZ2yTZgcF8Wjrtl6mRQReJhWJkbZcvag5TLl8cogdkWYlR1
         ARjKkLLd7KL0828pDdeSKnXZ5+IFOctltb6CPsCMIEfLbMVqIYx6CY98+QCGVn+UQtSj
         X2WT+4w+kzjFxU+Ma3btHhCevd/3/cFCkeAkvgi8AX5Oyt8fEbojT++lf+XcdINgUfPn
         wJRg==
X-Gm-Message-State: AGi0PuadI5b9Ra6Xd14npa7i2L2hdhyogRkL7O8so5Ts/MkAPGPYvTlA
        Q7Pvh+/Ek9KVENXPW9e7rhk=
X-Google-Smtp-Source: APiQypLO7kbfWAQfVd0BU9DKyYRb2EhDPHoxizEtQ5ZZdP4JXGo0e+yE/IFdBt55oeadvRN4aX+u9Q==
X-Received: by 2002:adf:a18c:: with SMTP id u12mr19011wru.325.1585777884204;
        Wed, 01 Apr 2020 14:51:24 -0700 (PDT)
Received: from szeder.dev (78-131-17-192.pool.digikabel.hu. [78.131.17.192])
        by smtp.gmail.com with ESMTPSA id u17sm4975393wra.63.2020.04.01.14.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 14:51:23 -0700 (PDT)
Date:   Wed, 1 Apr 2020 23:51:21 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ci: refactor docker runner script
Message-ID: <20200401215121.GG2224@szeder.dev>
References: <cover.1585203294.git.congdanhqx@gmail.com>
 <cover.1585474409.git.congdanhqx@gmail.com>
 <140e0ef39064d0194e05cad6d9f48e8e5b03aacc.1585474409.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <140e0ef39064d0194e05cad6d9f48e8e5b03aacc.1585474409.git.congdanhqx@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 29, 2020 at 05:12:30PM +0700, Đoàn Trần Công Danh wrote:
> We will support alpine check in docker later in this series.
> 
> While we're at it, tell people to run as root in podman.

Ok, I'll try to be more specific :)

Please clarify *in the commit message* why we should tell this to
people, i.e. what podman is and why should we care.

