From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/4] builtin/verify-tag: move verification code to tag.c
Date: Sun, 3 Apr 2016 04:19:26 -0400
Message-ID: <CAPig+cS47LSmwtLWPJZG8eFByEJ+t_hegM93nqsfTZEoH-+f4Q@mail.gmail.com>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
	<1459638975-17705-4-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Sun Apr 03 10:19:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amdFx-0006B0-AI
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 10:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbcDCIT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 04:19:29 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:34918 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbcDCIT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 04:19:27 -0400
Received: by mail-ig0-f196.google.com with SMTP id ya17so8119406igc.2
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 01:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=rXfZuMGWFAzx/BMFJntn1Xizkuel14Jh1ZxICskgSmc=;
        b=AZkpXMKVkBcZ1DltLhSTGdbpCbf+0WZJ+6alBJ9T3KhcQ33SHT/EbhMEwsI1IHj1Wa
         722zUk7QTYec94yadoTCRWU/X+DcG273dYvuZ/peHBKdbYb2Vg0L/rvOaNTH/nF1qrrH
         CN+1V33Ymvti4M1yPw1PFE2cOzpOF67mHc8+g7SYkeRp3U1uz+r4WrxVpn8DY6BBOM4V
         iQ/yObppJRnzy/F/KWoEC2exJcnaq+Wr3u80wMwzXQNP6CUvblEyTkAii8sK7xddceXd
         K/vTM/qDpG65pn7HxxDCvpe975GVNnSrg8Qepai3qI+MuWttZpVtnjs7npLWtRkl0TP2
         235w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=rXfZuMGWFAzx/BMFJntn1Xizkuel14Jh1ZxICskgSmc=;
        b=nNUOBYa7i9VHPFK467QkQ0b/VXu+Lv6XCMU17Bm8g1EHMZsO8G/37Ps9dKcgpynEUw
         FhmuEwHWCrP6duIPZTkp3BKgaHnAH7LHsrDR31W8RQhOZm5nKzayl99KHGfjq8/vKGe/
         BtNw3oMWMKHU8P70FIXabOvfENja2+w7OzQi63x70wYbo1wzehiSxP2DcxIL2E0Jepq6
         R9w8HDZqJDxtzvbiEeW1kynF0KriSghnjdDmOf0XbU8694HUDP1Ue0zJBIdij8juqyUJ
         pWZYhTkLu7mP4iDkiAA2hGTqaAh3nHM7L5oQMaKII+pZPUCP4Q5KBybsDKjbCDmrNknZ
         hjpg==
X-Gm-Message-State: AD7BkJLBaOj+aE+LjUP/dQzImkZ1pA1djKng+DNDLRP4GxTVP9dlbea36qhylqUsAMBh3jIzLjBg+hv58sZ24g==
X-Received: by 10.107.47.41 with SMTP id j41mr11098775ioo.168.1459671566462;
 Sun, 03 Apr 2016 01:19:26 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Sun, 3 Apr 2016 01:19:26 -0700 (PDT)
In-Reply-To: <1459638975-17705-4-git-send-email-santiago@nyu.edu>
X-Google-Sender-Auth: 4YqqZ6CAsWZJnzByTbiWjXg-GPA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290635>

On Sat, Apr 2, 2016 at 7:16 PM,  <santiago@nyu.edu> wrote:
> The PGP verification routine for tags could be accessed by other
> commands that require it. We do this by moving it to the common tag.c
> code. We rename the verify_tag() function to pgp_verify_tag() to avoid
> conflicts with the mktag.c function.
>
> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
> -       len = parse_signature(buf, size);
> -
> -       if (size == len) {
> -               if (flags & GPG_VERIFY_VERBOSE)
> -                       write_in_full(1, buf, len);
> -               return error("no signature found");
> -       }
> [...]
> +       payload_size = parse_signature(buf, size);
> +
> +       if (size == payload_size) {
> +               write_in_full(1, buf, payload_size);
> +               return error("No PGP signature found in this tag!");
> +       }

Also, [1] asked why the moved code no longer respects
GPG_VERIFY_VERBOSE, and that question doesn't seem to be answered
either in the previous review thread or by this patch's commit
message. It's not clear at a casual glance why this change is
desirable.

[1]: http://article.gmane.org/gmane.comp.version-control.git/289977
