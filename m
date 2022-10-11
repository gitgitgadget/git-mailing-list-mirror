Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65925C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiJKAeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJKAeC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:34:02 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14ED34726
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:34:01 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 187so9684237iov.10
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YpJocr0bl5VXIQ5DVB5Y0siQiDxpV6fI08gdsPHhwx8=;
        b=p4SN3sgFyjBX5yOUsYp/KcmZcAjQuNk2/nRz/8ajENPpcXn1vWrw/FXgzoHH6nkY8w
         RlAanz9LxEIxUqorJaKGkQKY2BiSknVBsR6VLmOEf1Qk+5nynzLKG7uh+bW+UEHsLjWx
         uCjshLclI1HQFNy000V5SsLhRjpdbrarNaWTn09U33QjNkqc280c0tIbCBTOMqwV6b8P
         oOGTsVRP31zBBzDaXKvB5hIDTAtA8z5PKBxzWk3S4E9bH1cSag4Ymv5XAyd4O8pbsnMf
         NndHGNwv8vPcjQdFuu65+hjLzZDNHJj0XtCkAHece9nfaEm7/l0YnL0PlDkgmoBZR8Z+
         7MtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpJocr0bl5VXIQ5DVB5Y0siQiDxpV6fI08gdsPHhwx8=;
        b=Q9QdM8hCyQrxNPg9ZWJnCpfDJ2RV5SQu+qj8GuVFNhEFTKg8oD+fPs0C0XnxsYP+Po
         O4gbT4RHECkAHqpwQVKbRC+Dlz+kRvsmHXxOV3vGnfM6sXg/Wgb4zg1iB17v5Pp2/UXH
         eEcGx9r/jJ532RJhD5drp3V6DB8kK4SL92eetK9euT7Nryn4OeeN8QEZv0CRJ7fpFvSj
         zQBrF2+jGB5UujSBpwor1AjmwJSbuKnY2+v8D6s8j/2cYVAPHJMo++VkpPGd+/bY/b0e
         2jsnfLsFKZ/HvVkKfBL2mV6cfDSocZ7Ek5fnKGzP0VIBVtMIPa17LajO1bCKfJyudoOk
         02zA==
X-Gm-Message-State: ACrzQf36tqDYTeRqrXDpf5zXnJ+zjaNQCVaRRwSDC2slm1BeqVTL0ib8
        FJNqAUJUP7+6r9Ot/OF3DxJL0BO2deNB4/ZW
X-Google-Smtp-Source: AMsMyM7k9Qs9TccNkWC9sn10lOQ0ZcIbR6QExmyWgHZI9dSKS4vHbDHlZ0eAhXxrTYF54Qd+aBErpg==
X-Received: by 2002:a05:6638:25d3:b0:35a:41e1:bb6a with SMTP id u19-20020a05663825d300b0035a41e1bb6amr11517386jat.36.1665448440839;
        Mon, 10 Oct 2022 17:34:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s2-20020a025102000000b0035ad8fd5ce9sm4585614jaa.147.2022.10.10.17.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 17:34:00 -0700 (PDT)
Date:   Mon, 10 Oct 2022 20:33:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com
Subject: [PATCH 0/7] shortlog: introduce `--group=<format>`
Message-ID: <cover.1665448437.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on a suggestion[1] from Junio in response to
Jacob Stopak's series to add committer month/year options as shortlog
groups.

This series pursues a more flexible approach, where arbitrary pretty
formats can be used to generate group names in shortlog. For example, to
group by committer month/year, you can do the following:

    $ git.compile shortlog -s --group='%cd' --date='format:%Y-%m' v2.37.0..
       117  2022-06
       274  2022-07
       325  2022-08
       271  2022-09
        17  2022-10

, which is cute. It can also be used to reimplement existing
functionality in shortlog, which is what the final three patches in this
series do. Author and committer options are implemented under the hood
as if they were shorthands for `--group='%aN <%aE>'` (or `--group='%cN
<%cE>'`, respectively).

The `--group=trailer:<key>` option is also reimplemented, but it is
slightly trickier than the rest. See the final patch for more details
there.

Thanks in advance for your review.

[1]: https://lore.kernel.org/git/xmqqillevzeh.fsf@gitster.g/

Jeff King (1):
  shortlog: accept `--date`-related options

Taylor Blau (6):
  Documentation: extract date-options.txt
  shortlog: extract `--group` fragment for translation
  shortlog: support arbitrary commit format `--group`s
  shortlog: implement `--group=author` in terms of `--group=<format>`
  shortlog: implement `--group=committer` in terms of `--group=<format>`
  shortlog: implement `--group=trailer` in terms of `--group=<format>`

 Documentation/date-options.txt     |  66 +++++++++++++
 Documentation/git-shortlog.txt     |   4 +
 Documentation/rev-list-options.txt |  67 +------------
 builtin/log.c                      |   1 +
 builtin/shortlog.c                 | 145 +++++++++++++++--------------
 shortlog.h                         |   6 +-
 t/t4201-shortlog.sh                |   9 ++
 7 files changed, 163 insertions(+), 135 deletions(-)
 create mode 100644 Documentation/date-options.txt

-- 
2.37.0.1.g1379af2e9d
