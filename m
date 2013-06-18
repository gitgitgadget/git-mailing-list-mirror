From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http.c: don't rewrite the user:passwd string multiple times
Date: Tue, 18 Jun 2013 00:15:52 -0400
Message-ID: <CAPig+cTKBzfrB6QQ4qjHNknv1CKRro_t=f77OV+ZhabtMN6Uiw@mail.gmail.com>
References: <1371520840-24906-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 06:16:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UonKp-00082y-D1
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 06:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431Ab3FREPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 00:15:55 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:34489 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836Ab3FREPz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 00:15:55 -0400
Received: by mail-la0-f49.google.com with SMTP id ea20so3057912lab.8
        for <git@vger.kernel.org>; Mon, 17 Jun 2013 21:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=HlVNb7Mvnuh+1jUfWFIhCo3vRBtdSWzc2+O9l0yTF2s=;
        b=J2Vs2sIJX0g5F4TjE0ktgd3T7VnSml4XS8YGApxM2OBnVDJhohgu0Kd6IYkMaQsm5O
         g+DnYlXnorJvOX5+3Esz2UGad2HvmjJot6SMT9Qercp3oWSjiah44PJ0CdyV0A6UqAiY
         kV/Xmmdm9VCCLTGQLEOug1cULcuUX6eger7MImpSMZgIzZ4d8vHGO40PVyjZECdlIsvX
         lNmT8g3/TPEnkWhwa1U5QiiIFDQvc2kIQuBkZ4gV6GM6rXNqRbl8g36ShOyncGEWx6DP
         IYWAWqJFnnBHdBnmZId/+05v5nFXahQkxVfX7TRNKGqhS2mrABXb0ecFgU1J+6zk56fp
         3sag==
X-Received: by 10.152.5.227 with SMTP id v3mr4536759lav.31.1371528952420; Mon,
 17 Jun 2013 21:15:52 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Mon, 17 Jun 2013 21:15:52 -0700 (PDT)
In-Reply-To: <1371520840-24906-1-git-send-email-bcasey@nvidia.com>
X-Google-Sender-Auth: NobQBALbnHdQCWrCD--kF7QwR6I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228149>

On Mon, Jun 17, 2013 at 10:00 PM, Brandon Casey <bcasey@nvidia.com> wrote:
> From: Brandon Casey <drafnel@gmail.com>
>
> Curl requires that we manage any strings that we pass to it as pointers.
> So, we should not be overwriting this strbuf after we've passed it to
> curl.
>
> Additionally, it is unnecessary since we only prompt for the user name
> and password once, so we end up overwriting the strbuf with the same
> sequence of characters each time.  This is why in practice it has not
> caused any problems for git's use of curl; the internal strbuf char
> pointer does not change, and get's overwritten with the same string

s/get's/gets/

> each time.
>
> But it's unnecessary and potentially dangerous, so let's avoid it.
>
> Signed-off-by: Brandon Casey <drafnel@gmail.com>
