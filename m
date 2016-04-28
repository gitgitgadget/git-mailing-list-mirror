From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 3/5] submodule: export sanitized GIT_CONFIG_PARAMETERS
Date: Thu, 28 Apr 2016 08:28:29 -0700
Message-ID: <CA+P7+xoJrU884n7xG_kof46TSg_4NwS=5+nZza8PM7D=YtsXng@mail.gmail.com>
References: <20160428133534.GA19056@sigill.intra.peff.net> <20160428133744.GC25319@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Users <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 17:28:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avns6-0006Dw-4l
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 17:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbcD1P2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 11:28:50 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35373 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714AbcD1P2t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 11:28:49 -0400
Received: by mail-oi0-f42.google.com with SMTP id x19so87321823oix.2
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 08:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w5J79Ez1PBz9EOB1dvXw8xQgb91G/wG9hGhN+ouXep0=;
        b=EOmwpaZMSIQ6bfrExp26dSAnoDmKLDW0fOF6E6wfi84j2yK8nR0DYCRvwGmcjHlopR
         R3d492sEOD5bUK5+WX2XBnXED5rsU8I47bHkj1vAioDcPZ4LVYHhwZINiHEApsTF11ua
         YzQ4yfi6ZYZN/WJmTtqFSXrZvftGOrHLLUQ+sDqUNWL9KemZyClyWji4aAOhCMh24SnQ
         KMIQ6uh0ZH0pHJyXotwi8wavRSSjNVmHSvqjr0Fmo9dtRRH5iv1IXweD/Y8A6zTVuik7
         y8CepqN0FLMCjyBhlygkf1pPYj6iL8v1qgP3i7MgtS2Ht8n0b4SmLHTq/pNlK6FM4T+1
         fK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w5J79Ez1PBz9EOB1dvXw8xQgb91G/wG9hGhN+ouXep0=;
        b=RUfxwFGf0NAoLlq35BvRT3WIMgyGbPm8utCwJ98AKKSodQZ/J6vFUQPIQAQnzorTJj
         i3j5DdDTuMeJIgQDi5sQ8SdKZ3XoippGDF3MtrtZrx2HikOFqBRwTuqkCsOe5GCNro7A
         g1bO9pomuD33OKnJvZ7xiWQ5otokRIb85zGTy1T2BDdzny44pu3975o4t7LDHRhG/mMm
         qUYcu9z8katQx/nm2VK+ui8cLR489U/gdZMN7ierTNyvZh1fFLQPaJMThqin89HKVIqb
         zAvLWPkBrk/WVRZysFwFlsbYb9yLaOIhNcPSK2gSDvpMNI8FCVhLWsCwiQbAbHTPZhbD
         lQ1g==
X-Gm-Message-State: AOPr4FXRnZPxdKDtv0N03V1YsQ4kQ6Tubds7IrybLjNz4EZSIO1F5NlY4HcfiC+5V5hkl+oWZyjkRzkFwNOK+w==
X-Received: by 10.157.49.1 with SMTP id e1mr7346937otc.148.1461857328951; Thu,
 28 Apr 2016 08:28:48 -0700 (PDT)
Received: by 10.182.117.132 with HTTP; Thu, 28 Apr 2016 08:28:29 -0700 (PDT)
In-Reply-To: <20160428133744.GC25319@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292902>

On Thu, Apr 28, 2016 at 6:37 AM, Jeff King <peff@peff.net> wrote:
> Commit 14111fc (git: submodule honor -c credential.* from
> command line, 2016-02-29) taught git-submodule.sh to save
> the sanitized value of $GIT_CONFIG_PARAMETERS when clearing
> the environment for a submodule. However, it failed to
> export the result, meaning that it had no effect for any
> sub-programs.
>
> We didn't catch this in our initial tests because we checked
> only the "clone" case, which does not go through the shell
> script at all. Provoking "git submodule update" to do a
> fetch demonstrates the bug.
>
> Noticed-by: Lars Schneider <larsxschneider@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  git-submodule.sh           |  1 +
>  t/t5550-http-fetch-dumb.sh | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2a84d7e..3a40d4b 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -200,6 +200,7 @@ sanitize_submodule_env()
>         sanitized_config=$(git submodule--helper sanitize-config)
>         clear_local_git_env
>         GIT_CONFIG_PARAMETERS=$sanitized_config
> +       export GIT_CONFIG_PARAMETERS

why not

export GIT_CONFIG_PARAMETERS=$santized_config

?

Thanks,
Jake
