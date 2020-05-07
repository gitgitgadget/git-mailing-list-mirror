Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2183C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 12:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD1C52083B
	for <git@archiver.kernel.org>; Thu,  7 May 2020 12:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUHlZ8Bm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEGMQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 08:16:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20459 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725903AbgEGMQl (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 08:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588853800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L8/XzrbIchmqVzXlKCabpo9v/rGqePr9wsJB+jilPyc=;
        b=BUHlZ8BmyrsH6Us6G1X2jCRzZyCo49aTLigzDfQjMnE0Ty8gQBoihBgbbrrWzDocGBwSpg
        hRdO99rYJhfqdsj+uyXRyeF6ZskWJ86Se1LviueUztCeSUy73eA96zdtBkY7r/ccWsufcL
        vVxoP4cpxLpKfkNJbVBzC2IaoDvJT94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-PVRi6KotOpCFNgicrlffdg-1; Thu, 07 May 2020 08:16:38 -0400
X-MC-Unique: PVRi6KotOpCFNgicrlffdg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E805319200C0
        for <git@vger.kernel.org>; Thu,  7 May 2020 12:16:37 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-11.ams2.redhat.com [10.36.114.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C92C60CD1
        for <git@vger.kernel.org>; Thu,  7 May 2020 12:16:37 +0000 (UTC)
Subject: Re: "--quiet" for git-push does not suppress remote hook output
From:   Laszlo Ersek <lersek@redhat.com>
To:     public git mailing list <git@vger.kernel.org>
References: <ba70b25b-906c-0117-2594-c606595c6816@redhat.com>
Message-ID: <3cb011a9-ce3d-df38-01c6-062062f1c9c2@redhat.com>
Date:   Thu, 7 May 2020 14:16:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ba70b25b-906c-0117-2594-c606595c6816@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Sorry about the self-followup...)

On 05/07/20 14:05, Laszlo Ersek wrote:
> Hi,
> 
> being a total novice in git internals, it seems like
> "builtin/receive-pack.c" (on the server) forwards any receive hook
> output with copy_to_sideband() back to git-push (on the client), even if
> git-push was invoked with "--quiet".
> 
> And "case 2" in demultiplex_sideband() seems to print that "band" to
> stderr (on the client), despite "--quiet".
> 
> Is this intentional? I'd prefer "git push --quiet" to suppress remote
> hook output (unless the remote hook fails).

Or else:

would it be the job of the particular receive hooks to observe and obey
the "--quiet" option in the GIT_PUSH_OPTION_* environment variables?

Thanks!
Laszlo

