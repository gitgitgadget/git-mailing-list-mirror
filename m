From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] clone --dissociate: avoid locking pack files
Date: Mon, 05 Oct 2015 14:00:03 -0700
Message-ID: <xmqqbncdxc8c.fsf@gitster.mtv.corp.google.com>
References: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
	<cover.1444076827.git.johannes.schindelin@gmx.de>
	<73315ceddd3ee6aa7d1c2f01bd1b64441b42ad22.1444076827.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 05 23:00:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjCrl-0007xp-RJ
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 23:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbbJEVAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 17:00:06 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35363 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970AbbJEVAF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 17:00:05 -0400
Received: by pacfv12 with SMTP id fv12so190742662pac.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 14:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=f/gMPnO7FSRhb2H+u/LkFKRFcCYthTzNjfozNYENzsk=;
        b=lDEilwA3MNivufBNNxU0Q72X8hR0NN+24+8fjhAjjrKhVLs8l24mPt0P47/Vw2LGx8
         CpXD/oSEj7SC8wrKSukOvPp2qycxeKNRGoAF8qIvo3tx14cmP5HYXivJeTiiFdVb1VHz
         cD9jqVETDKt3sGnkNMWyFFnXL7YI/9pRDIu45dCEPcR+1TAazXhkaxYbcP1Br+FeEArk
         a+cUlCoGWZcmmLBmN+skvWHOSLrDqAFatE8DxEO4nQGCj8EMXu5g+B2SOZpY1U9WDC/X
         Wvkij4LR9F+Uqs0WS6OGuNvix3LuWit/BkvHUceH/lDcmhtxlzMz5WQE1E7P3l+lxFFf
         aGLg==
X-Received: by 10.66.240.37 with SMTP id vx5mr42105455pac.76.1444078804939;
        Mon, 05 Oct 2015 14:00:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:60e8:cc09:ddf4:4eed])
        by smtp.gmail.com with ESMTPSA id k10sm29275219pbq.78.2015.10.05.14.00.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Oct 2015 14:00:04 -0700 (PDT)
In-Reply-To: <73315ceddd3ee6aa7d1c2f01bd1b64441b42ad22.1444076827.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 05 Oct 2015 22:33:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279094>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 578da85..cc896e2 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1064,8 +1064,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	transport_unlock_pack(transport);
>  	transport_disconnect(transport);
>  
> -	if (option_dissociate)
> +	if (option_dissociate) {
> +		close_all_packs();
>  		dissociate_from_references();
> +	}

Much simpler and looks very good.
