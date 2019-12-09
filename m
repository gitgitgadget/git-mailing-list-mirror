Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F35CC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CA22077B
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmRAFg54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLITdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:33:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33741 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfLITdX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 14:33:23 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so7617721pgk.0
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 11:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QmG1H6uV8y0QGEmnO7X2Kz7JrbLx8aKriHl5b6xDX7w=;
        b=dmRAFg54h3Z1FkCOi3kzS7OFDYvRMws6kwFvDugfIo8aNHxWm5QFEnYUlgGgtSccXd
         QvLzbo6P40ERspcxQOrpRYjqrTjuYOxHenRye8g1eWMEtYPhns/CJV+URgkPauFjhHa8
         KFt/sFWqWIfhUpJ0EcRrKn1Md8h3I62FiIf8xiSZE82j6oMJaqAOQURDvgsF2IYwty9L
         HySVtnsHoqb3yoc+yKWX5wXXJCaNK5ZWXRHReGEot8c0cJXOfLP1eVy7+vV92aNP/HTr
         S2VFFUwzUpyvnn0VpJj407zgaeke+xIbmmYXj7nrrdaVcs3yRek3wdf6xpS0abvNtb/+
         VNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QmG1H6uV8y0QGEmnO7X2Kz7JrbLx8aKriHl5b6xDX7w=;
        b=ofNce20cw9gfd+6PsYYHm3bSGd4le9XH0CaY1Cy8mifYx2uZ8GLXKlxtpwGRFzGx4w
         L/XupHZcykXns3XxVZ4zUuUfhekmIw6uT0vIjIEnbm+pPLsUQj6IJbyL+YKGj2gRr7Sj
         5ATzho17m1gY2z40/vDdYeTOuHn8jXnh+gY0js0t06oIJJsFdqOT8sGp0XdupUmBF9dI
         SMxg2wGsDYx6ttw26M1mDh7FqsMMw7k/a3tVTloVv75wg8HnDSI3b25ydjK4Dpk3Ucw3
         UzcdaMX1wvJAxNNL9accEMJUofXpnOKXG137na8JgVL9FKzRy/29dwduWK+LShLmgovk
         4meQ==
X-Gm-Message-State: APjAAAWwlHKVcQdxuDTHd/1s04Wj1IoKlJEPsgm/hSff0iI12olSq7l1
        u1/ZR322CQCpT0elCkJVvr8=
X-Google-Smtp-Source: APXvYqzPWai/OqrTZ3HAg/OPULtN0qPbU6Imt8KImbVAahxuvyXeyxytmaRQ8ldLikl7BCT9IlJQlw==
X-Received: by 2002:a62:1447:: with SMTP id 68mr31359849pfu.53.1575920003011;
        Mon, 09 Dec 2019 11:33:23 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id x13sm248755pfc.171.2019.12.09.11.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 11:33:22 -0800 (PST)
Date:   Mon, 9 Dec 2019 11:33:48 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 1/2] gitk: use --pretty=reference to generate the commit
 summary
Message-ID: <20191209193348.GA29379@generichostname>
References: <20191209182534.309884-1-dev+git@drbeat.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209182534.309884-1-dev+git@drbeat.li>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Beat,

On Mon, Dec 09, 2019 at 07:25:33PM +0100, Beat Bolli wrote:
> Git learned the "reference" pretty format in 1f0fc1db85 (pretty:
> implement 'reference' format, 2019-11-19). Use it also in gitk instead
> of duplicating the format string. This way, gitk always follows the
> formatting convention defined by git.
> 
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>

Heh, I had the exact same patch queued up and ready to be sent[1].
However, I was waiting until the feature actually got merged into master
before pulling the trigger on sending it out because according to
howto/maintain-git.txt:

	* Being in the 'next' branch is not a guarantee for a topic to
	  be included in the next feature release.  Being in the
	  'master' branch typically is.

Feel free to steal parts (or all of) my commit message since I think it
goes into a bit more detail if you think it works better. Or if you
don't want to deal with the burden of fixing this patch, I'll send out
mine at a later time (whenever 'dl/pretty-reference' gets merged to
'master').

> ---
> Junio, this goes on top of dl/pretty-reference, currently in pu.

Since this is a patch for gitk, it should be sent to Paul Mackerras, who
is the maintanier of gitk.

> 
> Thanks!
> 
>  gitk-git/gitk | 3 +--

Also, It should be based on his subtree, i.e. the file change should say
gitk, not gitk-git/gitk. You can find the tip of his tree by fetching
git://ozlabs.org/~paulus/gitk.

Thanks,

Denton

[1]: https://github.com/Denton-L/git/commit/da9321b1bd56aafd16c8dcb99d5d628b79e2244e

>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index a14d7a16b2..cc89fb25d2 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -9392,8 +9392,7 @@ proc mktaggo {} {
>  proc copysummary {} {
>      global rowmenuid autosellen
>  
> -    set format "%h (\"%s\", %ad)"
> -    set cmd [list git show -s --pretty=format:$format --date=short]
> +    set cmd [list git show -s --pretty=reference]
>      if {$autosellen < 40} {
>          lappend cmd --abbrev=$autosellen
>      }
> -- 
> 2.23.0.13.gecf2037ff6
> 
