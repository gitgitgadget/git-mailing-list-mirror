From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] introduce "format" date-mode
Date: Tue, 30 Jun 2015 14:13:53 -0400
Message-ID: <CAPig+cSJXZjrZ=OcV+C6bkCEHQFrw35-cjQ3At_Qo5KrpYxaQA@mail.gmail.com>
References: <20150625165341.GA21949@peff.net>
	<20150625165545.GC23503@peff.net>
	<20150629222247.GA31607@flurp.local>
	<20150630102055.GA11928@peff.net>
	<CAPig+cTXc_RXbOAOaF2MFjrg+DSet=g0XQMZY0ErMYAmNVSV+g@mail.gmail.com>
	<20150630175852.GB5349@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 30 20:14:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZA02h-0008TK-Vq
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 20:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbbF3SNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 14:13:55 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:34680 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbbF3SNy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 14:13:54 -0400
Received: by ykfy125 with SMTP id y125so16660773ykf.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 11:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=H29D1iCxGbAX//ktqKRQ+M63U202vz41JQThOnpPor4=;
        b=0r1L1MSP+L3fMWjBZTAY21vKxbY1EQRRoXQULYmbXyYkb2T5PDaPIqa5UUoTs54ADd
         sLxruMaB0eTmK3M27axemu0ZMtmeI8nDDopSUSOVcKOmWhqowmXra+1Hklz8DRbsLJ/P
         x5KboObPSZ4rfUEA/EJOjzqqJXWuNSaC+WOmTEJ67JmLfULB+3m0nv9Z9Gz2VdvdxmIQ
         DaU57qEKBVdUCM8pzNPd5nbcaaYdD0J8B0i+nzH2F/c8uwU0/dG0Z/lIMP4tMla++iJH
         uM53CzrVoQUcQrciTZYsS3mQ71ucypG1sOyAZdoZVMF0s8MQ0TRNnr/V20HEmzOW/uJv
         4Saw==
X-Received: by 10.129.70.69 with SMTP id t66mr13226475ywa.4.1435688033407;
 Tue, 30 Jun 2015 11:13:53 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 30 Jun 2015 11:13:53 -0700 (PDT)
In-Reply-To: <20150630175852.GB5349@peff.net>
X-Google-Sender-Auth: 0ayhVqYDIsZJ-T1xUSp2qTUyGZc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273093>

On Tue, Jun 30, 2015 at 1:58 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 30, 2015 at 12:58:33PM -0400, Eric Sunshine wrote:
>> Beyond the extra allocation, I was also concerned about the
>> sledgehammer approach of "%s " to append a single character when there
>> are much less expensive ways to do so.
>
> I don't think there's any other way. We have to feed a contiguous buffer
> to strftime, and we don't own the buffer, so we have to make a new copy.

Sorry, I meant that the interpolation expense of "%s ". A cheaper (but
more verbose) alternative might be:

    size_t n = strlen(fmt);
    const char *f = xmalloc(n + 2);
    strcpy(f, fmt);
    f[n] = ' ';
    f[n + 1] = '\0';
    ...
    free(f);

or something similar.
