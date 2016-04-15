From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 11/16] ref-filter: introduce refname_atom_parser()
Date: Sat, 16 Apr 2016 00:32:01 +0530
Message-ID: <CAOLa=ZRhj=ckUX42iWw4S1aKLtKY5OAw1MWybbCOYzwoEC73ZQ@mail.gmail.com>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
 <1460227515-28437-12-git-send-email-Karthik.188@gmail.com> <20160414204304.GA20875@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 15 21:02:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar90m-000453-Rl
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 21:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbcDOTCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 15:02:33 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:35316 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbcDOTCc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 15:02:32 -0400
Received: by mail-qg0-f42.google.com with SMTP id f105so86611374qge.2
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 12:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QYV+UfUDfRk5+99rStkZsIppmIYUPSA7kDF9MDOuOCY=;
        b=p3GEQw3Ro+HZiWtZCyygr31KXgzNaGY8sRUAyDr9ljyTKBwhs6kPIXOopOMVyM0PYE
         HWo7feoZvTZBiPvorGuKX5R5+S3W8X9WEB4g942+L1pA5kohyogWMxW+III4qz0xgVjT
         0CRLuzotXUMaBe+9pgw5dY7xffsbeTKh/OQ3YqJIFJEtiChHFsqVnauGW6c8x/tj3Q8s
         6LS3YNXBRiJkfsHd2cFmk0CY9d0+VwUCuZuj8ZOavpbPyrIxM8wFInoL1GmfrpVLM4W0
         LTZlJcjUGyvHFk/Ahc5X+IBGGoPVW364oln7XcVO7l3tcRHkWOZ4MVCzO3n7ik4ZizNb
         jImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QYV+UfUDfRk5+99rStkZsIppmIYUPSA7kDF9MDOuOCY=;
        b=EL5r+7PvvrGoPqLPqtCac3YJeg0hU3eDG4t4xbeihc6f2+gooMS+Xl0N+p20OqxFm7
         ypANydY2g/NhyvYcgxFKfuRhheoph0jrmZG47Nqm0ZeTF8hL1VB/HqgbI6PVC5DWZY8B
         6t876dc+1zBnnyXCrpgellMe8hNp9g5mddXRV30lVjRcALjqBX4E1jsrwY1CNZeeLHKI
         af0Vhk0DjaNNNUTtYp6JPxfAO41XaFBiQ5VdvtGegCgQa+U5QvPBFqFymUau6aHN0wlk
         OcLV47RrEiYDJjgpnUcP7qEsuUDKXZDLlQgjoUw6zmtIOZ6mftXrGhNVoGMKhu2nswE8
         2ZVA==
X-Gm-Message-State: AOPr4FVY62vQMTXaCuHBpL3t3uFwyXKROnbFh9ATHpAl+SoitVRXeQ9T7mAPAvOrMJxJKiP2nQdMp/jjMu3w1w==
X-Received: by 10.140.86.101 with SMTP id o92mr27164646qgd.49.1460746951268;
 Fri, 15 Apr 2016 12:02:31 -0700 (PDT)
Received: by 10.140.92.238 with HTTP; Fri, 15 Apr 2016 12:02:01 -0700 (PDT)
In-Reply-To: <20160414204304.GA20875@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291633>

On Fri, Apr 15, 2016 at 2:13 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Apr 10, 2016 at 12:15:10AM +0530, Karthik Nayak wrote:
>
>> +static void refname_atom_parser(struct used_atom *atom, const char *arg)
>> +{
>> +     if (!arg)
>> +             atom->u.refname.option = R_NORMAL;
>> +     else if (!strcmp(arg, "short"))
>> +             atom->u.refname.option = R_SHORT;
>> +     else if (skip_prefix(arg, "strip=", &arg)) {
>> +             atom->u.contents.option = R_STRIP;
>> +             if (strtoul_ui(arg, 10, &atom->u.refname.strip) ||
>> +                     atom->u.refname.strip <= 0)
>> +                     die(_("positive value expected refname:strip=%s"), arg);
>
> That R_STRIP line should be setting atom->u.refname.option, right?
>
> The same mistake happens in a later patch, too, when parsing for R_BASE
> and R_DIR is added. And I think the same problem is also present in
> objectname_atom_parser.
>
> The compiler doesn't notice because, hey, it's C, and why bother
> complaining when somebody assigns the value from one enum to another?
> And the tests don't notice because the enum is at the front of each
> union member, so the compiler happens to put it in the same place (I
> think it _might_ even be guaranteed by the standard's type-punning
> rules, but that's really not something we should rely on).
>
> -Peff

True, I'm surprised that went unnoticed, will fix it, thanks :)

-- 
Regards,
Karthik Nayak
