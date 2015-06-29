From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 38/44] builtin-am: support and auto-detect StGit patches
Date: Mon, 29 Jun 2015 16:51:57 -0400
Message-ID: <CAPig+cRWno4RkemOFJj01rhx_0oFSJ-x2TMKTNxwhF1YSBxjzQ@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-39-git-send-email-pyokagan@gmail.com>
	<CAGZ79kbzb4E8D87nQi+dat6szOdnp56ta3bEwsUwieX=3SiJqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Tan <pyokagan@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 22:52:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9g27-0004Qc-S5
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 22:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290AbbF2Uv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 16:51:59 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:32973 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754307AbbF2Uv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 16:51:58 -0400
Received: by ykdt186 with SMTP id t186so126042325ykd.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 13:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pNoW1U5aV2Pe1ZvKKiwN5PBM/qzdT/IJuBPSywqlU80=;
        b=Ud2AbJCYCYIg0RlOrA7yRXBjBCksEV7VCJbk52jifWdTlhLleRcWKNWzQ2EP8FUkEF
         Gl1oO4r6cvOu9yP8iMN2rWcoLmrvcT6QQZi3+6XEh9ehayRVG1xGSCbxvInIvOcbpcGJ
         Fes6TCinbqpaay9ISNzjhuN/aT/exwkcNImfLn0qIez4xJIhQCDBEHsSAAPK+7y0ksBL
         YowtXDXdPLqL3toPa3n9SMgi+wIwX4XsCkWUy08PFgKqGCA9xhJKvSZJCS0BTpsZp5tJ
         eqfg5clg8W7PZDm212Dg5mjKQ5X6toRL/pmRbHwDtTGhGPSgoCFUudfNWII7cYIaJl+1
         PnAg==
X-Received: by 10.170.138.134 with SMTP id f128mr21161455ykc.90.1435611117769;
 Mon, 29 Jun 2015 13:51:57 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 29 Jun 2015 13:51:57 -0700 (PDT)
In-Reply-To: <CAGZ79kbzb4E8D87nQi+dat6szOdnp56ta3bEwsUwieX=3SiJqw@mail.gmail.com>
X-Google-Sender-Auth: SEeH3QK_jxsVe6cdGhAfSgDlT5E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273019>

On Mon, Jun 29, 2015 at 4:42 PM, Stefan Beller <sbeller@google.com> wrote:
> On Sun, Jun 28, 2015 at 7:06 AM, Paul Tan <pyokagan@gmail.com> wrote:
>> +/**
>> + * Returns true if `str` consists of only whitespace, false otherwise.
>> + */
>> +static int str_isspace(const char *str)
>> +{
>> +       while (*str)
>> +               if (!isspace(*(str)++))
>> +                       return 0;
>
> (nit:)
> This looks a bit weird when first reading it, maybe combine the 2 conditions?
>
>     while (*str && !isspace(*(str)++))
>         return 0;
>
> The isspace checks for both tabs and whitespaces IIRC, so SP TAB SP
> would be valid here
> (returning 1).

Ugh. Please don't break the logic with this strange and bogus transformation.

If you really want it to read more idiomatically, try:

    for (; *s; s++)
        if (!isspace(*s))
            return 0;
