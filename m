From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/6] dir.c::match_pathname(): pay attention to the length
 of string parameters
Date: Fri, 29 Mar 2013 17:03:34 +0700
Message-ID: <CACsJy8CT8DQEEJVMwonW05bFZNb7HjQWBdEjy3tv332xabJ=Bw@mail.gmail.com>
References: <20130328214358.GA10685@sigill.intra.peff.net> <20130328214821.GD10936@sigill.intra.peff.net>
 <CACsJy8DisE8UNZzqmOFxPqw=bmFiHgE5-ao83ciGNUV9Sc9-gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	avila.jn@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 29 11:04:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULWAl-0005rF-LK
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 11:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744Ab3C2KEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 06:04:06 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:37494 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab3C2KEF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 06:04:05 -0400
Received: by mail-ob0-f175.google.com with SMTP id va7so286384obc.20
        for <git@vger.kernel.org>; Fri, 29 Mar 2013 03:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=1dd2vlFoutT/l0NhzSrFeUjnZhCiwaMiDeDXZBas8x4=;
        b=NG+08GT01rKpwOlX833vO8YPhHy7j4xuGSTZ0tFNv+1IkQWd0zsrXxySiEwXTfTtDg
         WN8C1Eu7586wsvhDQpiLLgnxlCD0RYg0hyRg6qzb6IfY1V3eupOezfSJaMIZQTSrhnkd
         BNnsBSytPEO17yZZWAatJwu5j11Q83a2ZTRdA5Xj6Zlvaute0VjVlM09EKhLHbkGnAhe
         icLyM6qR3sL5AxlgMDuUo5/IEQ6xE0iATUVPA1ZUa2Zzo7j6li01Lvb/9tu67bcS+wfl
         aFp90iWJK5wFaJmCtbPss/mlE+VBgTlzEOmjTfu1BlTj9uLp5pu3hqU3qWRzpkl/Oruz
         wpEw==
X-Received: by 10.60.11.8 with SMTP id m8mr714413oeb.22.1364551444425; Fri, 29
 Mar 2013 03:04:04 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Fri, 29 Mar 2013 03:03:34 -0700 (PDT)
In-Reply-To: <CACsJy8DisE8UNZzqmOFxPqw=bmFiHgE5-ao83ciGNUV9Sc9-gA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219487>

On Fri, Mar 29, 2013 at 3:45 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Mar 29, 2013 at 4:48 AM, Jeff King <peff@peff.net> wrote:
>> -       return fnmatch_icase(pattern, name, FNM_PATHNAME) == 0;
>> +       return fnmatch_icase_mem(pattern, patternlen,
>> +                                name, namelen,
>> +                                FNM_PATHNAME) == 0;
>>  }
>
> I think you (or Junio) should rebase this on maint. Since c41244e
> (included in maint), this call is turned to wildmatch(WM_PATHNAME) and
> WM_PATHNAME is _not_ the same as FNM_PATHNAME for patterns like
> "foo/**/bar". A diff between next and pu shows me that WM_PATHNAME is
> incorrectly converted to FNM_PATHNAME. I hope that is the cause of all
> breakages Junio found out on pu.

Just tested. t0003 and t3001 on 'pu' work for me because I have
USE_WILDMATCH on (which turns FNM_PATHNAME to WM_PATHNAME). Both break
without USE_WILDMATCH.
-- 
Duy
