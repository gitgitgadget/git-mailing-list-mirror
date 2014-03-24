From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Git push race condition?
Date: Mon, 24 Mar 2014 22:16:52 +0100
Message-ID: <CACBZZX4ZEPA3sBp4-3QF6de0EWXzPkcOiqSxH3_CXV27Z=gxtw@mail.gmail.com>
References: <CAAyEjTN53+5B9Od9wW698wODNL3hR6Upot8-ZLwEksn3ir_zjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Scott Sandler <scott.m.sandler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:17:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSCFE-0002hr-JT
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 22:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbaCXVRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 17:17:14 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:56566 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbaCXVRN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 17:17:13 -0400
Received: by mail-oa0-f45.google.com with SMTP id eb12so6204765oac.4
        for <git@vger.kernel.org>; Mon, 24 Mar 2014 14:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YmmIfQTrz7NJudDcn6aeXio4svUGx2a6cQGY3JGUUXo=;
        b=d+C1j0krsqlABO0a6R1I4IM8Jsccmrz3xTwDNiMmtnI47Ho13QHAC+WFGcCufGNw+R
         EcXpo3vqJYFgGG2zOSykwqkAOAqQuinyRQfHAUIK+NB8gLC3+RFrtFNPbDDSVYnFGhQl
         +AkU79zv+lipF3b4qzztSLxq322PNmYg7sezKqqafbNFukeLmwdDPfncao7L1A7kCnMx
         WYIoaWMCDJMYlQdeAVbegMXBUME5R4rZVtOPn/UN3qzkpRvdz8qH5GI12qrCtUEJlsjk
         Kl5aaOyoGw17Ai4fDc349egLH+OCBfZfqBdCPtLjG3gKqnXcnVic+jeXs/dUjvA3ShaZ
         zitw==
X-Received: by 10.182.2.170 with SMTP id 10mr4161954obv.50.1395695832484; Mon,
 24 Mar 2014 14:17:12 -0700 (PDT)
Received: by 10.76.33.161 with HTTP; Mon, 24 Mar 2014 14:16:52 -0700 (PDT)
In-Reply-To: <CAAyEjTN53+5B9Od9wW698wODNL3hR6Upot8-ZLwEksn3ir_zjA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244869>

On Mon, Mar 24, 2014 at 8:18 PM, Scott Sandler
<scott.m.sandler@gmail.com> wrote:
> I run a private Git repository (using Gitlab) with about 200 users
> doing about 100 pushes per day.

Ditto but about 2x those numbers.

> error: Ref refs/heads/master is at
> 4584c1f34e07cea2df6abc8e0d407fe016017130 but expected
> 61b79b6d35b066d054fb3deab550f1c51598cf5f
> remote: error: failed to lock refs/heads/master

I also see this error once in a while. I read the code a while back
and it's basically because there's two levels of locks that
receive-pack tries to get, and it's possible for two pushers to get
the first lock due to a race condition.

I've never seen data loss due to this though, because the inner lock is atomic.
