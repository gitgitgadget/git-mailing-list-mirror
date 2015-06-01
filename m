From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: dereference tags with --ignore-if-in-upstream
Date: Mon, 01 Jun 2015 07:56:28 -0700
Message-ID: <xmqqr3pv8okj.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD1phg8E0JCgkz88CMUo9H-W=s5JDuKeCMOkf1=UYBJt+g@mail.gmail.com>
	<1433120593-186980-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Bruce Korb <bruce.korb@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Jun 01 16:56:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzR8l-00056V-Ag
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 16:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbbFAO4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 10:56:31 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37026 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbbFAO4a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 10:56:30 -0400
Received: by igbsb11 with SMTP id sb11so63631722igb.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 07:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=yDXZppm+yMe/GnQdslYlexbF24WK4aoPrSD5U4J6OMM=;
        b=d5oR6j86tE9UDC9L0JGKAPpsM1b20wfy7Cs5rbBJjYJqA0JtGW8MswpO1+BStek4dg
         5/b4GX9eTe3tpKP2z/GnLyL57JOlYq9JVzSDHnENE7gqPFv4/pXxUIMUlgfyCHuRGj6D
         FRJOagrdAxnSo8mC5NVuNOSuyGTX9dxpxGho0GZ/GXExlp64P9CFeHUalBRSBu1lu9HG
         bN7H8kEl0cHMoRJ9nwHxqaHE8+1IMlR8wqQX1VwasiVGNu/yF24OSvbpTPLsF3U91xeC
         M0lDe/R8MnemxUf7U4n1H6LoD50EghvaJY/wyJiSClPAvhMdbjuCvPSm7iPgl6JLCNc0
         8hDw==
X-Received: by 10.43.141.196 with SMTP id jf4mr11505479icc.80.1433170589628;
        Mon, 01 Jun 2015 07:56:29 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0e6:ec48:f0c0:da4d])
        by mx.google.com with ESMTPSA id cy11sm7959663igc.14.2015.06.01.07.56.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 07:56:28 -0700 (PDT)
In-Reply-To: <1433120593-186980-1-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Mon, 1 Jun 2015 01:03:13 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270420>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/builtin/log.c b/builtin/log.c
> index dd8f3fc..e0465ba 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -807,6 +807,12 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
>  	o2 = rev->pending.objects[1].item;
>  	flags2 = o2->flags;
>  
> +	o1 = deref_tag(o1, NULL, 0);
> +	o2 = deref_tag(o2, NULL, 0);
> +
> +	if (!o1 || !o2)
> +		die(_("Invalid tag."));

Shouldn't you ensure o1 and o2 are commits here?
