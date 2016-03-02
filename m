From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] builtin/receive-pack.c: use parse_options API
Date: Wed, 2 Mar 2016 16:53:54 +0700
Message-ID: <CACsJy8Dc38BrAHJ2t3HRdrk=A7VR7SFqc03wyajKrydsiCfoNw@mail.gmail.com>
References: <1456846560-9223-1-git-send-email-tigerkid001@gmail.com> <1456863661-22783-1-git-send-email-tigerkid001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Sidhant Sharma [:tk]" <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 10:54:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab3UO-0007KS-26
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 10:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754461AbcCBJy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 04:54:27 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:33327 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286AbcCBJyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 04:54:25 -0500
Received: by mail-lb0-f170.google.com with SMTP id k15so3994969lbg.0
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 01:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aoQQTrJrrDynm2g6715T24kyft0fcW51NHAULxeT+ro=;
        b=pZH+xjaA4Zgkq5d88Y5mGmDFzH8GXICZL6q+2iSXvhi5XJbmVbv6Tlk9yI/lGgIwcL
         weKkLczVvMyO7MOarjAv3cH2FUKRyenrKKZ8VRahYIX2iBZ/6x7c9P3ryF2+Q15WvWOw
         eftlbCXUHXargbwDEvOYLwixXDXOMtrf3gXBndLJ/AXDdzWvy1R3PR/wiW2v9sdE38Xz
         gcssyIaZKFlirI1szIvzYVy/oPsXnDvzgiqLJwaf2jxyway/FmqLDI/bNbjH4SuQFT7X
         H4J8F/KydLF4OAorXw6ts3rETxmfXgj9xqE8x6s8yQi2HmqzHdAVHOHMUnrCfFyZWrAM
         z1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aoQQTrJrrDynm2g6715T24kyft0fcW51NHAULxeT+ro=;
        b=TOWrPFj2IlTBL9MxJs8VsrNI6ttfgcWlwh1rGbpc9ivsflWtaldUK0/zBmbyPAITor
         QUA8yWmnkf/e31qD52HW4LXGCPb7jeNEXdJuigsBaPaag7dIcHh0Q3z8ORHLNsThKhOa
         MADdocWe+HuCBpb5L3LZftVdomnM4wCIwtsne8oStyiwJkhvoSRSiVkQGel1MalyqGty
         OAIssQparCLyzhfh8ahwWM4Go5mByAu3W8Ty/Oj2f/IPNEujuQpFHGs2unJIzILLk65E
         h9y1jd2Gh1fsLQFAAH4WVICKkUS569OUwBsuqUrhxBCLdMNtZzZIWAp6eTM+XuO77vsW
         LjIQ==
X-Gm-Message-State: AD7BkJLMsMUVnSeuRy9DcaLPUwAkAD22wajx2HRLPvc4ItTPpQ69S6QcKR64u2kJ7inO5F3uFr5p9vXHzn6E7A==
X-Received: by 10.112.140.129 with SMTP id rg1mr10235455lbb.80.1456912464312;
 Wed, 02 Mar 2016 01:54:24 -0800 (PST)
Received: by 10.112.51.99 with HTTP; Wed, 2 Mar 2016 01:53:54 -0800 (PST)
In-Reply-To: <1456863661-22783-1-git-send-email-tigerkid001@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288119>

On Wed, Mar 2, 2016 at 3:21 AM, Sidhant Sharma [:tk]
<tigerkid001@gmail.com> wrote:
> +       struct option options[] = {
> +               OPT__QUIET(&quiet, N_("quiet")),
> +               OPT_HIDDEN_BOOL(0, "stateless-rpc", &stateless_rpc, NULL),
> +               OPT_HIDDEN_BOOL(0, "advertise-refs", &advertise_refs, NULL),
> +               OPT_HIDDEN_BOOL(0, "reject-thin-pack-for-testing", &reject_thin, NULL),
> +               OPT_END()
> +       };

If the patch is already final, don't bother. If not, I think I prefer
to keep all these options visible (except the "...-for-testing"). This
command is never executed directly by mere mortals. The ones that run
it need to know all about these hidden tricks because they're
implementing new transports.

Another side note. I'm not so sure if we should N_() and _() strings
in this command (same reasoning, the command's user is very likely
developers, not true users). But it does not harm to i18n-ize the
command either. Slightly more work for translators, of course.
-- 
Duy
