From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] gc and impatience
Date: Fri, 2 Aug 2013 21:44:11 -0700
Message-ID: <CAPc5daXi_ZG6GcK6pWafffyOY4MEZHUMkZxTxiRiU4BaFybqqg@mail.gmail.com>
References: <CALkWK0k2B5OW9zMrw0jBDDWpufojYDJybXa7jCBdzftNUc7mxA@mail.gmail.com>
 <CACsJy8DRo9Akoydwn9-EPOSyJiPhqAf1=HncYjHvXZwS4S_d7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 06:44:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5Ti3-0002d7-U1
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 06:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916Ab3HCEod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 00:44:33 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:46804 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab3HCEod (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 00:44:33 -0400
Received: by mail-lb0-f177.google.com with SMTP id r11so923335lbv.22
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 21:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=GWLC7NW48FnyDzQ9XDNntJ+ej6vzP922RsV112zdbdY=;
        b=QbjjeBeQBqZyuo42tHKKX1soM8VL+ALGKMhjaC0RSMT7Xk+h+/ft8pQ5eSBHeQq6Rp
         w1xssmp4YRZKSTzrMa752ZaPu4QDJwNs2qASPYM4+mRMZ9YWGVV/cxI0/8vOXtnzjcdL
         WeBDoD3iglJiai82yWsmt/pEy2vKI78kMM+PLg682+1nQLSJGJgBoZHqEUWDLqA3DMKg
         8yh0VyqCOjrMcR9uXAN6N9u7a+b8PZVtb2z+D5ejJfOIGinLBBO8McT7brzDqgkFZsnW
         03KglCg9haYihwEbzoPboftJlR2SqWX991WHGEy9tYGrT2BSpLlP6ZBMZSn5Fa09V+bh
         m80A==
X-Received: by 10.152.170.162 with SMTP id an2mr4268969lac.3.1375505071341;
 Fri, 02 Aug 2013 21:44:31 -0700 (PDT)
Received: by 10.112.64.73 with HTTP; Fri, 2 Aug 2013 21:44:11 -0700 (PDT)
In-Reply-To: <CACsJy8DRo9Akoydwn9-EPOSyJiPhqAf1=HncYjHvXZwS4S_d7A@mail.gmail.com>
X-Google-Sender-Auth: 9aok_3gJaELzASa4Q3qkPboCGuE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231559>

On Fri, Aug 2, 2013 at 8:53 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> Good point. I think that is because gc does not check if gc is already
> running. Adding such a check should not be too hard. I think gc could
> save its pid in $GIT_DIR/auto-gc.pid. The next auto-gc checks this, if
> the pid is valid, skip auto-gc.

Defining "valid" is a tricky business, though, as pid can and will
wrap around, and the directory could be shared on multiple machines. A
pid written by a process on one machine has no relation to any pid on
another machine.
