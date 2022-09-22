Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B29AECAAD8
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 18:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiIVSst (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 14:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiIVSsm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 14:48:42 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DB9E6A30
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 11:48:39 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 930F31BB6C6;
        Thu, 22 Sep 2022 14:48:38 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=3RBdvc4U391ksb9h6WAxd9lp9tSqPDs1P31O514
        KbFk=; b=hFx7HP4Zw8iGi3yMxkhYbXhU0e7e3Ax9yDaP6ZO7Cf2lvo6oSis80oR
        89B2Eb1o9k4FnD+p80BWj85PNwmo5kmiW1OK1PHLkAUFGVUwFCASwmYEi6Z2FoYC
        2gu/fREjczrPEDlu+nXRKE5Ck9Jt1vcHVBUtKIYkO0A78MKvWuOQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8BEE61BB6C5;
        Thu, 22 Sep 2022 14:48:38 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.192.78])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 030A41BB6C4;
        Thu, 22 Sep 2022 14:48:33 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Thu, 22 Sep 2022 14:48:30 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Lana Deere <lana.deere@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: 2.38.0 rc1 and explicit openssl version
Message-ID: <Yyyt/reX3mcYK+1Q@pobox.com>
References: <CA+4x=b-myNFKfN1n1jrU+wMYfXbA7VrnrKVi7vj9LU4E9wb_rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+4x=b-myNFKfN1n1jrU+wMYfXbA7VrnrKVi7vj9LU4E9wb_rw@mail.gmail.com>
X-Pobox-Relay-ID: 2918F1BA-3AA7-11ED-A201-B31D44D1D7AA-09356542!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lana Deere wrote:
> I built 2.38.0 rc1 from the tar file today.  One of the configure
> options I used was "--with-openssl=<path>/openssl/3.0.5".  As
> expected, configure reported
>     configure: Setting OPENSSLDIR to<path>/openssl/3.0.5
> 
> When it got as far as linking git-imap-send, the link command pointed
> at the subdirectory "lib" within the openssl/3.0.5 installation.
>     gcc ... -o git-imap-send ...  -L<path>/openssl/3.0.5/lib ...
> 
> However, this version of openssl put the libraries into a "lib64"
> subdirerctory rather than into a "lib" subdirectory so the link
> failed.  An easy workaround is to put a symlink from lib64 to lib
> inside the openssl directory.  It would be nice, though, if the
> configure command could figure this out automatically.

I don't use the configure script, but I think you can
specify the lib dir via --with-lib=lib64.  (The same can be
done using config.mak or passing parameters directly to
make with the lib argument, e.g. make lib=lib64 ...)

If I'm reading correctly, that would apply to all packages
which were configured via one of the --with-$package=$path
options.

-- 
Todd
