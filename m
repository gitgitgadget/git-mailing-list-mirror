Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 385DA20288
	for <e@80x24.org>; Fri, 21 Jul 2017 17:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753905AbdGURkR (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 13:40:17 -0400
Received: from fallback10.m.smailru.net ([94.100.178.50]:38021 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752811AbdGURkR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 13:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=list.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Subject:From:To; bh=LyeurTJiqRg2NC7dlBAKIVc2xOQn9U1MVyCNHZQnats=;
        b=ehl1xr8XY5mAfokNwQPo8eXDcc5pRKROm9mmAGh3YkcT3NlKypYX8bOcKIxaoRWawrP6UgT+t4S7I/RS4mguTc6LwVBeflRChiP3wVzO9+B22M6GrbsFdtu+8jsvuYfS7Ec9izNDxavO+7vBqEB6w7HSY6FdGxSXxRI7tlogXc8=;
Received: from [10.161.64.56] (port=44014 helo=smtp48.i.mail.ru)
        by fallback10.m.smailru.net with esmtp (envelope-from <stsp@list.ru>)
        id 1dYbuQ-00069p-U3
        for git@vger.kernel.org; Fri, 21 Jul 2017 20:40:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=list.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Subject:From:To; bh=LyeurTJiqRg2NC7dlBAKIVc2xOQn9U1MVyCNHZQnats=;
        b=ehl1xr8XY5mAfokNwQPo8eXDcc5pRKROm9mmAGh3YkcT3NlKypYX8bOcKIxaoRWawrP6UgT+t4S7I/RS4mguTc6LwVBeflRChiP3wVzO9+B22M6GrbsFdtu+8jsvuYfS7Ec9izNDxavO+7vBqEB6w7HSY6FdGxSXxRI7tlogXc8=;
Received: by smtp48.i.mail.ru with esmtpa (envelope-from <stsp@list.ru>)
        id 1dYbuO-0004Qx-Pt
        for git@vger.kernel.org; Fri, 21 Jul 2017 20:40:13 +0300
To:     git@vger.kernel.org
From:   Stas Sergeev <stsp@list.ru>
Subject: git gc seems to break --symbolic-full-name
Message-ID: <234492d7-7fd6-f847-8b85-010732ff43b6@list.ru>
Date:   Fri, 21 Jul 2017 20:40:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-MW
X-7FA49CB5: 0D63561A33F958A5B8D8BF4A16333B278B0360E796F1BE645233254D21D32F46725E5C173C3A84C3335407143AA9223659E4CCE48244E7E7F3CCD8A865B74A75C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0FD319CD858665117E2623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: F1845AB6CCC9920DF7838D61D4D05C4223771C2B40362BDD75063EC0363C53349E6DB4201E91F1B01653177920737CA72999BEE114A20FF4278B2D54D4112F244F0A872F021F905956A8FB0C6EBA5FCCEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: OK
X-7FA49CB5: 0D63561A33F958A566A3DC47E0910AF6FE87098F8269346EE02F2E05526AA167462275124DF8B9C9DCB0CBAFC6C9F534574AF45C6390F7469DAA53EE0834AAEE
X-Mailru-Sender: A5480F10D64C90057D89EA641BAE1DDBF461ECC25EEC684492909D54B97D45ADBDD32C808CC9DE03BD9A213A94BF4775DDBB79867CC2C1EC5DD9ADBE8243F6ED0252A3EF2865ED2F733E9BFD465368085FEEDEB644C299C0ED14614B50AE0675
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello.

I do the following:

$ git rev-parse --symbolic-full-name devel
refs/heads/devel
$ ls -l .git/`git rev-parse --symbolic-full-name devel`
-rw-rw-r-- 1 stas stas 41 июл 21 15:05 .git/refs/heads/devel

This is fine. But after git gc:

$ git rev-parse --symbolic-full-name devel
refs/heads/devel
$ LC_ALL=C ls -l .git/`git rev-parse --symbolic-full-name devel`
ls: cannot access '.git/refs/heads/devel': No such file or directory

This is because after git gc there is nothing in .git/refs/heads:

$ LC_ALL=C ls -l .git/refs/heads/
total 8
drwxrwxr-x 2 stas stas 4096 Jul 31  2013 feature
drwxrwxr-x 2 stas stas 4096 Dec 23  2016 pr

I prepend the path with .git above just as an
example: the same happens with rev-parse --git-path.

So I wonder if it is an expected behaviour for
--symbolic-full-name to return the invalid pathes?
If so, how can I get the path to the needed head file?
I use that for dependency tracking.
