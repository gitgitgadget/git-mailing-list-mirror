From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help: ensure that common-cmds.h is only included by help.c
Date: Sat, 13 Sep 2014 22:23:03 -0700
Message-ID: <CAPc5daXDCAi3eP3YmXfcO+9ncN8=b6tCGUFUxwKE=MuRBuXvEg@mail.gmail.com>
References: <1410657073-3089-1-git-send-email-davvid@gmail.com> <5414f6b2.XwoOyI03zlXiZ3ds%perryh@pluto.rain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Aguilar <davvid@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Perry Hutchison <perryh@pluto.rain.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 07:23:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XT2HZ-0007ai-Kv
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 07:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbaINFXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 01:23:25 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:62378 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbaINFXY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 01:23:24 -0400
Received: by mail-la0-f53.google.com with SMTP id ge10so2892403lab.26
        for <git@vger.kernel.org>; Sat, 13 Sep 2014 22:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=mZvjLENUIh7W7nLQJXl9sx5z3uF1dw9JF/IQRexzWZw=;
        b=d10+ojXffYeaCnUqrIjCjCizxQzXDJ1Q4JGzOUTUlRrPYZWUp6Q6DWiZCpcDp2Xnoh
         EiyEAEW9AMeczddABnh8AaJc3zjnJb7Qg+rFcXvTVFI6hfgY2l+QUSfax1RCAFeSPxFY
         AMc2I9miFQTK8vZ06c09yVU6ReNz7yEy1S69tIrn5cYS/4wznqHIfMu4IcOwgIpLXCRU
         JvgifHIqXkOJCM7ziqm8pmEjoCjky+phcXI8kSpIv50UpqWw5VevF8gg5UV47+Y7zxrd
         xys0jMSCYrnm1347A22QOZPTlGUybbJ2lr7YMP/fPgCiYNiAW3UrffV32IC7P71fp9kQ
         E4Yg==
X-Received: by 10.112.13.10 with SMTP id d10mr18840317lbc.10.1410672203142;
 Sat, 13 Sep 2014 22:23:23 -0700 (PDT)
Received: by 10.112.97.177 with HTTP; Sat, 13 Sep 2014 22:23:03 -0700 (PDT)
In-Reply-To: <5414f6b2.XwoOyI03zlXiZ3ds%perryh@pluto.rain.com>
X-Google-Sender-Auth: ujlaNcuiLaKmNaQfd9LL03hnLZM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256993>

On Sat, Sep 13, 2014 at 7:00 PM, Perry Hutchison <perryh@pluto.rain.com> wrote:
> David Aguilar <davvid@gmail.com> wrote:
>> Add a #ifndef guard to ensure that common-cmds.h can only
>> be included by help.c.
>
> This strikes me as a very peculiar, and sub-optimal, way of
> achieving the purpose.  If these definitions are intended to
> be private to help.c, why not put them there and eliminate
> common-cmds.h entirely?

Have you studied where common-cmds.h comes from?
After you have done so, would you make the same suggestion?

Having said that, I also do not think this is such a good idea.
Wouldn't the new "check" script added in this series a better
place? For example, it may want to make sure that git-compat-util.h
(or a couple of its equivalents) is the first file included in any mainline
C source file, and such an inclusion is done unconditionally.

Which would mean that the checker would scan *.c files with grep
or a Perl script. It would be trivial to enforce "nobody other than these
small selected C files is allowed to include common-cmds.h" rule.

Regarding the other patch that butchers many *.h files, I am not
still very enthused. Including cache.h at the beginning of branch.h,
for example, would mean git-compat-util.h ends up included at the
beginning of branch.h.
