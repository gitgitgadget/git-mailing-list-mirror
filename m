From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [RFC/PATCH 0/3] teach --histogram to diff
Date: Thu, 14 Jul 2011 00:34:14 +0800
Message-ID: <CALUzUxqS8y4HH44t2CuSvfQiLP-Y7hFtbi5x2rtAwPBKSJ+3Bw@mail.gmail.com>
References: <1310451027-15148-1-git-send-email-rctay89@gmail.com>
	<CAJo=hJu5ubkzUyyPM0nqP+J9CU3hBtAHfuzaLSuN214Hux4qTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 13 18:34:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh2OC-00046s-Qq
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 18:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756247Ab1GMQeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 12:34:16 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35417 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755811Ab1GMQeP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 12:34:15 -0400
Received: by eyx24 with SMTP id 24so2155495eyx.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 09:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Jw4Kc9IDp6uXTeogaVgHigC+ngUWVY+Ac2SMeTQ8nGQ=;
        b=YkAQbtROzdErytrtrE7X3T9eA5cB2OIWeMK7OZgzl26oTRXraQdGdhULqB9gf4C78O
         D3TKRLOpUwo9WdJ1oe/blKvEQyuFFDMq6xFKC+FR5Uv6Sphbry4kMYnysXp6NUtedMJU
         MPtWHVssmgFJDzHeH2b1sa1qxXQxHW2C3p44s=
Received: by 10.14.20.17 with SMTP id o17mr400445eeo.109.1310574854247; Wed,
 13 Jul 2011 09:34:14 -0700 (PDT)
Received: by 10.14.29.14 with HTTP; Wed, 13 Jul 2011 09:34:14 -0700 (PDT)
In-Reply-To: <CAJo=hJu5ubkzUyyPM0nqP+J9CU3hBtAHfuzaLSuN214Hux4qTA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177056>

On Tue, Jul 12, 2011 at 10:19 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Mon, Jul 11, 2011 at 23:10, Tay Ray Chuan <rctay89@gmail.com> wrote:
>> [RFC/PATCH 3/3] xdiff/xprepare: use a smaller sample size for histogram
>
> Do we need sampling at all for histogram? Can you skip it?

Sampling is done to get a guess of lines in the file. This guess is
then used to preallocated memory for the list of records. (This is
just a guess; if we find more records we allocate more memory.) By
doing this preallocation, we can save on malloc()'s, giving a
performance boost.

But then sampling has its costs - previously, we ran up to 256
memchr('\n')s within a mmfile "block". For histogram diff, we cut the
cap down to 20. (But not for the other diff algorithms - see the
relevant patch text for more.) I think this gives us a good balance -
time spent in guessing lines, and time gained from preallocating
memory.

-- 
Cheers,
Ray Chuan
