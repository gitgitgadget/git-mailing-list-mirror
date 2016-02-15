From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/4] remote: use remote_is_configured() for add and rename
Date: Mon, 15 Feb 2016 17:52:14 -0500
Message-ID: <CAPig+cTH+S67_T=O58E_x--ZhawQEZKjCmK8G+unzm_8f2w8eA@mail.gmail.com>
References: <1455575984-24348-1-git-send-email-t.gummerer@gmail.com>
	<1455575984-24348-5-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 23:52:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVS0B-00031K-Ew
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 23:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbcBOWwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 17:52:15 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35919 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbcBOWwO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 17:52:14 -0500
Received: by mail-vk0-f66.google.com with SMTP id k196so8764953vka.3
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 14:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=s5Tg9vTKVZoFFJGOzaTTBzc/m5le58/ul8QRltRhs9M=;
        b=JCi2cXegvU3Jc57cSOheQRJmE5aufNePskf8Fl0tpjLhvtcwzzOHfeB5T+FaO0zLyb
         qUpSmC1XMui5cg7YP3R/mQS/GuSl6MRTF0eNn7kwEu/qckaeABMuZ+An6QY+UduWXVyl
         mQlKVHmbs2TqVg3vZsbUzsXfZMaqSIUGmUARNtxYseWgRU7RdHd+KV3HB8kzuW0qmQPg
         eJD4Yp14lsvPVl44w81Mw3hRQLf5NxUhXYhZBKlbKOwaCK7214HTOcvrT129vIQQdhzQ
         8P1ZjWlCXNDmFRiV/r9cDn13+JiuVE5wYcWvdBRvsR6s1ueolghYReONPkeCKI5Wifsl
         tduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=s5Tg9vTKVZoFFJGOzaTTBzc/m5le58/ul8QRltRhs9M=;
        b=XYLaV+0+XXHrcv2VzZWGtI4ulr3KVrQDyTtzk6FyN/BThAOXJktmPFvokGFvTHaPvq
         cOVMbDHKxoZjBkVbgT6mWSDkiTeMu5+u7VmaIumnijjYoDKVtF4znuGxx8ySlsx+vXCv
         mpOVOMAog1w5eRJNuI+u/SlymDuAeKWbFI/O5CHKxg5KAt7v7P0vRlV+aIeitfyaP+CY
         t827/ewI9ImWw4qCKvdVc/ZtCTyeFsRil0KD1lLTuohScw3dhHj2QG79h2cXjjykwizo
         6vIKT5nsxZFl+oWlwRKhJpUu2qdn8kpPOphlI0vsgyM53cOjbvsclq2lipE0M/Cq3x8L
         m52w==
X-Gm-Message-State: AG10YOT9JAVMQwUcBOrK+JNeJI/YD4BxDa9SSiUYLMoww1q5wDmCacle3p8IXPC+K6vxflaPrmRNX75Dt2VWcA==
X-Received: by 10.31.41.14 with SMTP id p14mr15594781vkp.151.1455576734293;
 Mon, 15 Feb 2016 14:52:14 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 15 Feb 2016 14:52:14 -0800 (PST)
In-Reply-To: <1455575984-24348-5-git-send-email-t.gummerer@gmail.com>
X-Google-Sender-Auth: nbujjRAWdiH0ytApDfQlSo3FM58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286284>

On Mon, Feb 15, 2016 at 5:39 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Both remote add and remote rename use a slightly different hand-rolled
> check if the remote exits.  The hand-rolled check may have some subtle
> cases in which it might fail to detect when a remote already exists.
> One such case was fixed in fb86e32 ("git remote: allow adding remotes
> agreeing with url.<...>.insteadOf").  Another case is when a remote is
> configured as follows:
> [...]
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> @@ -157,6 +157,24 @@ test_expect_success 'rename errors out early when deleting non-existent branch'
> +test_expect_success 'add existing foreign_vcs remote' '
> +       git config --add remote.foo.vcs "bar" &&
> +       git config --add remote.bar.vcs "bar" &&
> +       test_when_finished git remote rm foo &&
> +       test_when_finished git remote rm bar &&

Nit: If the second git-config fails, then none of the cleanup will
happen. You'd either want to re-order them like this:

    git config --add remote.foo.vcs "bar" &&
    test_when_finished git remote rm foo &&
    git config --add remote.bar.vcs "bar" &&
    test_when_finished git remote rm bar &&

or this:

    test_when_finished git remote rm foo &&
    git config --add remote.foo.vcs "bar" &&
    test_when_finished git remote rm bar &&
    git config --add remote.bar.vcs "bar" &&

or this:

    test_when_finished git remote rm foo &&
    test_when_finished git remote rm bar &&
    git config --add remote.foo.vcs "bar" &&
    git config --add remote.bar.vcs "bar" &&

Probably not worth a re-roll, though.

> +       echo "fatal: remote bar already exists." >expect &&
> +       test_must_fail git remote rename foo bar 2>actual &&
> +       test_i18ncmp expect actual
> +'
