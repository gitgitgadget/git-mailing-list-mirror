Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9ACC54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 18:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiIVSzw convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 22 Sep 2022 14:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiIVSzt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 14:55:49 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F619DFB9
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 11:55:47 -0700 (PDT)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 28MItk3E067039
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Sep 2022 14:55:46 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Lana Deere'" <lana.deere@gmail.com>, <git@vger.kernel.org>
References: <CA+4x=b-myNFKfN1n1jrU+wMYfXbA7VrnrKVi7vj9LU4E9wb_rw@mail.gmail.com>
In-Reply-To: <CA+4x=b-myNFKfN1n1jrU+wMYfXbA7VrnrKVi7vj9LU4E9wb_rw@mail.gmail.com>
Subject: RE: 2.38.0 rc1 and explicit openssl version
Date:   Thu, 22 Sep 2022 14:55:41 -0400
Organization: Nexbridge Inc.
Message-ID: <022d01d8ceb4$eccf3fb0$c66dbf10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFmWOWrQEfqmn9vGl1ETNbEXi/dRq7QtkVQ
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 22, 2022 2:36 PM, Lana Deere wrote:
>I built 2.38.0 rc1 from the tar file today.  One of the configure options I used was "-
>-with-openssl=<path>/openssl/3.0.5".  As expected, configure reported
>    configure: Setting OPENSSLDIR to<path>/openssl/3.0.5
>
>When it got as far as linking git-imap-send, the link command pointed at the
>subdirectory "lib" within the openssl/3.0.5 installation.
>    gcc ... -o git-imap-send ...  -L<path>/openssl/3.0.5/lib ...
>
>However, this version of openssl put the libraries into a "lib64"
>subdirerctory rather than into a "lib" subdirectory so the link failed.  An easy
>workaround is to put a symlink from lib64 to lib inside the openssl directory.  It
>would be nice, though, if the configure command could figure this out
>automatically.

The OpenSSL team moved the 64-bit builds to lib64 as of 3.0.x. This is very likely to be retained in 3.1.x. I am working on a change that moves the runnable parts of OpenSSL 64-bit to /bin64. The 32-bit builds are still in /lib and /bin. My team hit this issue when first trying to build git and curl with 3.0.1. We control where we pick up libraries on the make command line using the CFLAGS and LDFLAGS variables so the internal git makefile does not need to know where the libraries are. This also avoids needing symlinks that can cause DLL conflicts between 32 and 64 models.

Regards,
Randall

