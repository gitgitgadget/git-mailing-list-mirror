From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] wildmatch: properly fold case everywhere
Date: Thu, 30 May 2013 05:07:26 -0400
Message-ID: <CAPig+cTfaj3e_sRZhHLQUDWYinFVsNieFFA027zJSfdSty1x1g@mail.gmail.com>
References: <CACsJy8CuaowyZJGKh7X+43qRwYAdUCDbVo8P5CpEtukBzRiReg@mail.gmail.com>
	<1369903506-72731-1-git-send-email-n.oxyde@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Anthony Ramine <n.oxyde@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 11:07:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhypa-000189-KL
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 11:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967953Ab3E3JHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 05:07:31 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:62842 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030210Ab3E3JH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 05:07:29 -0400
Received: by mail-lb0-f182.google.com with SMTP id z5so283848lbh.41
        for <git@vger.kernel.org>; Thu, 30 May 2013 02:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=MLpGnyVQdXEjpIxTXIq0d21qavvBZNGxcEgjBz4yLAQ=;
        b=meb7HQSei83cbwLdtU2SM5s4MhkMuZqM7nmWsHc2lVq5cQf0avzJNln2uOKDuYZ9ZJ
         5fP8DF1FJFcCnFV2jgTC02XP7y4kR49zEOE1IV+EorI2gi2HQBSLy+EhXgNOw4ZMo5Ti
         U6+h4d1Mgo5CGjl06Usieg5EtJ4tiohHL28zkmtNh9dmBRcC/MPOxbTHH6W0rxojueS2
         oq57vObRs/MsirMM4JOYiMdhjwIihV0m3biizb8mV3JvfaoU3wm7g1JpjB8WTvNyG6BG
         Om2oPCiWi6mPw0Zj+87eCvh0aTBt/DfJTq9s6rPV3HTv+RzIJ3rtafPd79j73nibKeO4
         qSzA==
X-Received: by 10.112.164.105 with SMTP id yp9mr3226257lbb.103.1369904846660;
 Thu, 30 May 2013 02:07:26 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Thu, 30 May 2013 02:07:26 -0700 (PDT)
In-Reply-To: <1369903506-72731-1-git-send-email-n.oxyde@gmail.com>
X-Google-Sender-Auth: wvE7mwMOy8DivO6nHPa9WmbHZLY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225948>

On Thu, May 30, 2013 at 4:45 AM, Anthony Ramine <n.oxyde@gmail.com> wrote:
> Case folding is not done correctly when matching against the [:upper:]
> character class and uppercased character ranges (e.g. A-Z).
> Specifically, an uppercase letter fails to match against any of them
> when case folding is requested because plain characters in the pattern
> and the whole string and preemptively lowercased to handle the base case

Did you mean s/and preemptively/are preemptively/ ?

> fast.
>
> That optimization is kept and ISLOWER() is used in the [:upper:] case
> when case folding is requested, while matching against a character range
> is retried with toupper() if the character was lowercase, as the bounds
> of the range itself cannot be modified (in a case-insensitive context,
> [A-_] is not equivalent to [a-_]).
>
> Signed-off-by: Anthony Ramine <n.oxyde@gmail.com>
