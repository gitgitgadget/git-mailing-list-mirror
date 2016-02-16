From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 00/15] config: make git_config_set die on failure
Date: Tue, 16 Feb 2016 12:15:35 -0500
Message-ID: <CAPig+cQav4AS6-RwUKGA2fmWxRL-2e2o72oYkk83emqz3z6q3w@mail.gmail.com>
References: <1455627402-752-1-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Tue Feb 16 18:15:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVjDx-0005ML-8W
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 18:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290AbcBPRPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 12:15:37 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34382 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204AbcBPRPg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 12:15:36 -0500
Received: by mail-vk0-f45.google.com with SMTP id e185so139218869vkb.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 09:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=biK4lTwgRxqN4UDMS5ivjDMBQTPmvqBoMFQJvOcV4hY=;
        b=tVJa4aAjMlx+JBvNfGJzO8BC2oVM/ECuYnbRE80+NG+apUpk489VQClaGb4xeXTy8A
         5qjkqGVqMbJkzEgAHFrkJWNjUarrujG+dLlxiBHvTPOJhrDsUvKnm8mj55jaeYYAaRXa
         7bf5nzVyEnFHE7esdz9/8qFk+tRaPC6GdEXg8C7Q1fupdCeoX0NANbZsVu1eL+tXnx47
         9ZAxnz1phR9f5kvediJkVGx5UxLCSVqAoUzL+V8YJQBbfQ4DaLxhj8TGpb5I9AOYFh2g
         1xpefm/QmZUf+I1Ecm0Uj9yfIPMmyx90txM7VJRNYUMsLN9WxnlGuQ8cneA3gT7it/o4
         c4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=biK4lTwgRxqN4UDMS5ivjDMBQTPmvqBoMFQJvOcV4hY=;
        b=ZRx9SJSfUBLLxlaf7zVgwYDsmx8N0b4Zasqh2F2HZ89mbNVLwKa5wNY8HCXeo/OUih
         P0t0lKNxUPiM/gYzEROm+4KqIrYIzFPUutX9soZjhu824Rf1R9+mUMk8XbxopdDnFIB8
         pwuvQgXKfhWRzy8urYuismImMnUp2Ikl/w4iSPXFBLkmai7ayarByHrRN1PaxPwByPkt
         dj6peyfQHDvSMmOBy/mjh0pO8Z8bkrH7vdivf2nnWPwvHng+MTmAp5fzVUtsoCryDaDM
         G9p9vAx2cVG7RJkPYMhPqnWb39J3O+bNC+u2zK8Ln6SX6gDPLZL/DBd+1N2xo+nOYYAz
         DdWw==
X-Gm-Message-State: AG10YOT0kY+1P0FyxrJLNvuy7gFnQ//SAw71lf/po1X/SzGAmHZ8ELduUQ9lYOjSczcjIdLSJd3dSjlHRTrcwA==
X-Received: by 10.31.168.76 with SMTP id r73mr18822838vke.117.1455642935581;
 Tue, 16 Feb 2016 09:15:35 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 16 Feb 2016 09:15:35 -0800 (PST)
In-Reply-To: <1455627402-752-1-git-send-email-ps@pks.im>
X-Google-Sender-Auth: oT74BOq16RGgFebZZZTiOgZMTFs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286408>

On Tue, Feb 16, 2016 at 7:56 AM, Patrick Steinhardt <ps@pks.im> wrote:
> [...]
> Junio pointed out that it might not always be the most sensible
> thing to die when install_branch_config fails. After thinking
> about it I changed the behavior of the function to print an error
> and advise message and return an error code. The error code is
> then only used by the `git branch --set-upstream-to=` command to
> abort early, as its main intent will usually be to set the
> tracking information. The other callers (related to git-clone and
> git-push) simply ignore the returned value while the messages are
> still printed.
>
> I think it does make sense to not abort clones and pushes when
> the function fails. Setting the upstream information is only a
> small part of these commands and especially when cloning a large
> repository it is harmful to die as this would delete everything
> that has just been cloned. The user can still fix up the remote
> tracking branch afterwards.
>
> Interdiff between v4 and v5:
>
> diff --git a/branch.c b/branch.c
> @@ -49,7 +49,13 @@ static int should_setup_rebase(const char *origin)
> +static const char tracking_advice[] =
> +N_("\n"
> +"After fixing the error cause you may try to fix up\n"
> +"the remote tracking information by invoking\n"
> +"\"git branch --set-upstream-to=\".");

Do you have enough information at the point this message is emitted to
make it even more useful for the user by showing the actual argument
to --set-upstream-to= that the user would need to invoke once the
issue is resolved?
