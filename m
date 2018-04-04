Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D90EF1F404
	for <e@80x24.org>; Wed,  4 Apr 2018 16:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeDDQnR (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 12:43:17 -0400
Received: from forward2j.cmail.yandex.net ([5.255.227.20]:53080 "EHLO
        forward2j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751950AbeDDQnQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 4 Apr 2018 12:43:16 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Apr 2018 12:43:16 EDT
Received: from mxback20j.mail.yandex.net (mxback20j.mail.yandex.net [IPv6:2a02:6b8:0:1619::114])
        by forward2j.cmail.yandex.net (Yandex) with ESMTP id F067D20C5D;
        Wed,  4 Apr 2018 19:36:08 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback20j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id rXc3hnjrYK-a80aegJO;
        Wed, 04 Apr 2018 19:36:08 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1522859768;
        bh=uv4753VjFNQYbBizsV/ZrpYvh6DxGzs2CL0oYF1le9g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date;
        b=fh89vBF+7JM4iOBHFg5JiN3jL9cseEtMofx+LFFM4dzd8ta0LGILeYQX7cbd6C3Ne
         wD/CBPdIvaETeTnizBllYRa4Rv0J7HVB+NWhK5QzQ0KAfkblevXwkRX9mm1yu+4ubz
         nf9XEjZnRZRmzKFBaQ9RVhyuKAo/6Ggjx1Bc+kOo=
Authentication-Results: mxback20j.mail.yandex.net; dkim=pass header.i=@ya.ru
Received: by web13j.yandex.ru with HTTP;
        Wed, 04 Apr 2018 19:36:08 +0300
From:   Alex Ivanov <gnidorah@ya.ru>
Envelope-From: gnidorah@yandex.ru
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
In-Reply-To: <CA+P7+xoaOt4KwTOQSfwiyB1CQ317kbCZ2u26RoPA02Z4WYr9EA@mail.gmail.com>
References: <671541522781590@web3o.yandex.ru> <CA+P7+xoaOt4KwTOQSfwiyB1CQ317kbCZ2u26RoPA02Z4WYr9EA@mail.gmail.com>
Subject: Re: Socket activation for GitWeb FastCGI with systemd?
MIME-Version: 1.0
Message-Id: <2030761522859768@web13j.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 04 Apr 2018 19:36:08 +0300
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



03.04.2018, 23:04, "Jacob Keller" <jacob.keller@gmail.com>:
> On Tue, Apr 3, 2018 at 11:53 AM, Alex Ivanov <gnidorah@ya.ru> wrote:
>>  Hi.
>>  I want to use systemd as fastcgi spawner for gitweb + nginx.
>>  The traffic is low and number of users is limited + traversal bots. For that reason I've decided to use following mimimal services
>>
>>  gitweb.socket
>>  [Unit]
>>  Description=GitWeb Socket
>>
>>  [Socket]
>>  ListenStream=/run/gitweb.sock
>>  Accept=false
>>
>>  [Install]
>>  WantedBy=sockets.target
>>
>>  gitweb.service
>>  [Unit]
>>  Description=GitWeb Service
>>
>>  [Service]
>>  Type=simple
>>  ExecStart=/path/to/gitweb.cgi --fcgi
>>  StandardInput=socket
>>
>>  However this scheme is not resistant to simple DDOS.
>>  E.g. traversal bots often kill the service by opening non existing path (e.g http://host/?p=repo;a=blob;f=nonexisting/path;hb=HEAD showing in browser 404 - Cannot find file) many times consecutively, which leads to
>>  Apr 03 21:32:10 host systemd[1]: gitweb.service: Start request repeated too quickly.
>>  Apr 03 21:32:10 host systemd[1]: gitweb.service: Failed with result 'start-limit-hit'.
>>  Apr 03 21:32:10 host systemd[1]: Failed to start GitWeb service.
>>  and 502 Bad Gateway in browser. I believe the reason is that gitweb.service dies on failure and if it happens too often, systemd declines to restart the service due to start limit hit.
>>  So my question is how to correct systemd services for GitWeb to be resistant to such issue? I prefer to use single process to process all clients.
>>  Thanks.
>
> This sounds like a systemd specific question that might get a better
> answer from the systemd mailing list.

Thanks I will try that too.

>
> That being said, I believe if in this case gitweb is dying due to the
> path not existing? You might be able to configure systemd to
> understand that the particular exit code for when the path doesn't
> exist is a "valid" exit, and not a failure case..

I will try to do that, but I'm afraid that there may be other ways to remotely abuse the service.

>
> I'm not entirely understanding your goal.. you want each request to
> launch the gitweb process, and when it's done you want it to exit? But
> if there are multiple connections at once you want it to stay alive
> until it services them all? I think the best answer is configure
> systemd to understand that the exit code for when the path is invalid
> will be counted as a success.

I want a single process for all connections too keep RAM usage at minimal. I also though it fits my case since number of users is low.

>
> Thanks,
> Jake
