From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] fetch: document that pruning happens before fetching
Date: Tue, 14 Jun 2016 16:36:59 +0700
Message-ID: <CACsJy8Ds_DnBLJ0jx7Pp9EH1coG-xAtri4w4hh__=nigCmBbdA@mail.gmail.com>
References: <20160613235850.GA8009@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Tom Miller <jackerran@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 11:37:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCkmt-0000y6-Rm
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 11:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbcFNJhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 05:37:31 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36437 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbcFNJha (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 05:37:30 -0400
Received: by mail-io0-f196.google.com with SMTP id o127so17187654iod.3
        for <git@vger.kernel.org>; Tue, 14 Jun 2016 02:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hxVIAu2L+cCz49su/v2p9SES8AAVn1OO7tJL5Kkw4MU=;
        b=MkNM3VFR4aWnSn4+KzPcjSH61aD7NnNOO0uUkYvTJ1h/s4pcFXMx18KiIDVcTun2mP
         aXbm0WDplcm9SXRqkmNC0iuTHqdgk8t/Icyjsis+JEefBzIMTRSwusUK23Qi8WbtoaeH
         1/Zyuk/HvYW6I5858aS4G4FooSH59Cc5OzQBnR89yeYvxh2y6X2azCLAxWuAAFpbjRaj
         itcFqLC1Hxpx0+bSYa63E0nA3gHnPyTUTAGmqr4eneQ1xw58WYp73A35dAyb0Mj58jmL
         IAWMEO9Pi/4EtkcI8w6N4J6ei/yDItZMOfi7KVY0ie0EsAmr6IVAwemPhR4zgdHTBIPe
         d4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hxVIAu2L+cCz49su/v2p9SES8AAVn1OO7tJL5Kkw4MU=;
        b=Hps+5oqGsTIchlXQX0kRtBsSlBwTfK6h7tMWlchYcjdqoYNiHUD5XodzKqxlRUWoMj
         VOqfdcNrdXX/EFDmVTDRDfSTzu4o960LAegFti+RrU29QeZSkQ4x4opAxpxcx2oBmfWP
         oGqW33V0yCbyqymmRziakullFhcP33jYL/plK9Ko75n2nhhRwngfUP+fgV6ylDx1NXNE
         bCJaG/wQE5JPLM1MdA1SpeE9R2G8RFTay8JB1G+E4qEphR2abrB2YZx1fplcCYV6fx5x
         A2puOX2Kh1HmWR7eE7lRq3S6qNO4/8Sk0hzlr7DfRupBBHreMyyQuTs3MIu8elptERG0
         gF/A==
X-Gm-Message-State: ALyK8tKwjKcz5nmqhXeO4LvQ5I7zdRc6BTuC9GRSgExVIyRiVH7Hw9a2kWLFLhxlwbldxwDCPhlQ2SXZCHUIpg==
X-Received: by 10.107.8.220 with SMTP id h89mr30303380ioi.95.1465897049089;
 Tue, 14 Jun 2016 02:37:29 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Tue, 14 Jun 2016 02:36:59 -0700 (PDT)
In-Reply-To: <20160613235850.GA8009@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297277>

On Tue, Jun 14, 2016 at 6:58 AM, Jeff King <peff@peff.net> wrote:
> This was changed in 10a6cc8 (fetch --prune: Run prune before
> fetching, 2014-01-02), but it seems that nobody in that
> discussion realized we were advertising the "after"
> explicitly.

Ah... ok. Good to know it's moved up top on purpose because I almost
tried to move it down :) It's irritating that current output looks
like this

<delete ref>
<delete ref>
<delete ref>
remote: <random progress lines>
<update ref>
<update ref>
<update ref>

It probably looks better if we can move the <delete ref> part after
"remote: ..." lines (iow still _after_ fetch, but _before_ ref
updates), e.g.

remote: <random progress lines>
<delete ref>
<delete ref>
<delete ref>
<update ref>
<update ref>
<update ref>

If we do so, there's no need to update document. But I don't know,
maybe it's not worth doing.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I include myself in that "nobody" of course. :)
>
>  Documentation/fetch-options.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index 036edfb..b05a834 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -52,7 +52,7 @@ ifndef::git-pull[]
>
>  -p::
>  --prune::
> -       After fetching, remove any remote-tracking references that no
> +       Before fetching, remove any remote-tracking references that no
>         longer exist on the remote.  Tags are not subject to pruning
>         if they are fetched only because of the default tag
>         auto-following or due to a --tags option.  However, if tags
> --
> 2.9.0.150.g8bd4cf6
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Duy
