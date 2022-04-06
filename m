Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362B1C433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 13:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbiDFNt6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 09:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiDFNtv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 09:49:51 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124E54DF89E
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 04:18:45 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.251.39] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 236BIi7K025263
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Wed, 6 Apr 2022 07:18:44 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [BUG] git-2.36.0-rc0 - t6200 fails due to library/path issues
Date:   Wed, 6 Apr 2022 07:18:39 -0400
Organization: Nexbridge Inc.
Message-ID: <041601d849a8$1441ce60$3cc56b20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdhJp/cV6lTzxSAKQcCYJX3BNnD/0Q==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t6200 makes assumptions that ssh-keygen to be used is located in
/usr/local/bin. This causes problems when we have multiple OpenSSL
installations - which we do - 3 of them. Our environment supplies OpenSSL
1.1 in /usr/local-ssl1.1, with a corresponding version of ssh-agent in a
different directory. There needs to be a mechanism to override the
ssh-keygen so that tests will work in this situation.

*** RLD ERROR ***: Unresolved Text Symbol OPENSSL_add_all_algorithms_noconf
in file /usr/local/bin/ssh-keygen.

*** RLD ERROR ***: Unresolved Text Symbol EVP_MD_CTX_cleanup in file
/usr/local/bin/ssh-keygen.

*** RLD ERROR ***: Unresolved Text Symbol SSLeay in file
/usr/local/bin/ssh-keygen.

*** RLD ERROR ***: Unresolved Text Symbol EVP_MD_block_size in file
/usr/local/bin/ssh-keygen.

*** RLD ERROR ***: Unresolved Text Symbol EVP_MD_CTX_init in file
/usr/local/bin/ssh-keygen.

I do not know why the test is forcing SSH in /usr/local/bin - it is not
something coming from our environment, which has PATH set correctly.

Thanks,
Randall

