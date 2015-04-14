From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/7] path.c: implement xdg_config_home()
Date: Mon, 13 Apr 2015 17:18:13 -0700
Message-ID: <CAGZ79kYnmYu54XbEOtP8n_sgvLs4Zx=Z4Cr_U=qOrTmZCEFr=g@mail.gmail.com>
References: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
	<vpqwq1fn1pf.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Tan <pyokagan@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 14 02:18:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhoYW-00044G-Qa
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 02:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbbDNASQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 20:18:16 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:36131 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbbDNASO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 20:18:14 -0400
Received: by lagv1 with SMTP id v1so70137304lag.3
        for <git@vger.kernel.org>; Mon, 13 Apr 2015 17:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vCPZFKfspJ2IqEMg7YggNHH32E5OvREVcTULY2Farl0=;
        b=U9OwXJysd/tBCbZLfzZERhB9sN2Nz3dooXfYU4yJ+crCVT1SjzFZFcNY2W/edfbQ3S
         lZc4YTDkskGDq2s8Hgv4Ezim7xnCnSj3kYtQNuF/ShSDB3X3dcTvjfZOh51WVhu1URP5
         dR9cXrScKqEWhryLeeunC2jOtORR+ESIsga89TMpc+aoG22/r2p+eMS0CXRx0fne2Rlm
         v0hMOhE7oOL+02L6VH3Iy/itJoTnOM09jNpEvPSGx0WIZe/oJSy0c56K8YNpt4dCdhdt
         afPrQVzC1vpAuO7X/pfHA6NrNwjQbhEe1UltE/m3t3YTwnmU26FALJAh2AzM6FXqoYhu
         PadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vCPZFKfspJ2IqEMg7YggNHH32E5OvREVcTULY2Farl0=;
        b=SfJuLzxJcRc4VJhm5ONrmxK9oFs2uEil9JxkpKl1aDqo1Rai7w/tgUrxGNp5FdkM2x
         u4oEZD4AGfsWW9+E5Ps5MizVOMGBdCHfi8hRDtaoICJlBvaVo7E7MeyxroHQxsvkWF16
         TZq/II9vyim0gfn7YhdTsE54iZc6BCX6iNreGmBVjsUVpS5Az3FOgbacxPEZrkMEA8FL
         TTQxyl9F5I/tQ9YYqGVnhZ+w4ZWnY67VkI+Ci+GXDfph5CPwOR9xtDwgwyaLImEGWYfd
         vGEsE1eOjMp2lTMrSISa93d9FlMzvI2vHrJZpuoOtMYzMQWUVCqCQP6ShUqX0Iy30wYm
         oi+g==
X-Gm-Message-State: ALoCoQnoF44duw97sjq7Iiw3SezdyBHbKhS741n4kiuS86NsIEU0rMGaLo+F+NjXsj4s8lfRbshG
X-Received: by 10.112.157.100 with SMTP id wl4mr15684633lbb.108.1428970693090;
 Mon, 13 Apr 2015 17:18:13 -0700 (PDT)
Received: by 10.25.43.210 with HTTP; Mon, 13 Apr 2015 17:18:13 -0700 (PDT)
In-Reply-To: <vpqwq1fn1pf.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267104>

On Mon, Apr 13, 2015 at 2:43 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> As such, implement a simpler function xdg_config_home() for constructing
>> the XDG base dir spec configuration file path. This function, together
>> with expand_user_path(), can replace all uses of home_config_paths().
>
> Indeed. The code looks much better after your patch series than before.
>
> I agree with Dscho's remark that "fn" sounds like "function" more than
> "filename". Perhaps just "name" would be better.

I'd go with fname but that's just bikeshedding now.

>
> Anyway, the series is
>
> Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

and
Reviewed-by: Stefan Beller <sbeller@google.com>

>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
