From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] lockfile: improve error message when lockfile exists
Date: Mon, 29 Feb 2016 07:35:46 +0700
Message-ID: <CACsJy8BgqE2iZG6zhSoXsFXq+x9gMBJU8LB8PtJq519nePeVdw@mail.gmail.com>
References: <1456690276-13914-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Gregory.Mounie@grenoble-inp.fr
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Feb 29 01:36:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaBp1-0005FC-Js
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 01:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbcB2AgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 19:36:18 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34760 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbcB2AgR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 19:36:17 -0500
Received: by mail-lb0-f174.google.com with SMTP id of3so71355394lbc.1
        for <git@vger.kernel.org>; Sun, 28 Feb 2016 16:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LO+GRZBCcvYjIENwqjnHfNgIa4ySntBvScr3G8oReAU=;
        b=TLmJFyYRt7g+EuA1fefhBSjguBigiI0vhhTtxr2LAYimfVtHw47u2Yp7ZF1BdgAAkC
         TyTPcFOEIpruEAJmzQSNg9c6xxut3f0apQHq/zirM9f9LpwtUe3RqYwqfPbuQhfLBPI9
         IItO/8raLR/POdWQW887228NKwoqY+YdvwCzVm9ztG0m5JNn+alin7sJlHwFIpKN3ZZl
         Do2995VrDMSNrfOvmwQrBn508oGvr1TqzVmrxeCjF0D+vjeIFKLdTJvNS1gqPj/6/fK9
         ItPs+Qbj9oeH3wS4zrQ8DpNV12Spp5ifK6GAxoOybgqlc3zAvYQPPcfn9ftD0EYeJgks
         Mchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LO+GRZBCcvYjIENwqjnHfNgIa4ySntBvScr3G8oReAU=;
        b=LkE8//LXnpbIvrBAdufvqrHceFI3vMhAo4jkICr6OfRzOAoZQJA97BBgG74BEHBS2O
         RRnDotzY+k0ZFfcMCn37CiISCdv/8tWzbGMMcLS3T5uzHjzyS85c2g76spGyuh5xpAA3
         OnPsdE4YsfM//KHFYafEZlc+bnwohFkpcf4I+injdrk2GDp57hJVrfgq9KFX/GzZtsxq
         Z+ofQscnYCSnEtbJzDwu5IHnU5ibrWkGYCqXPMPXe5dmYvkPW12swoS02A/uuLq4D8vv
         w+iip2iwiU4LfPg9rjNjkcqGaeclA4xaa3KEYhylk2vRA/qt0g0hq++oW9vOvo9kcnwH
         IoJQ==
X-Gm-Message-State: AD7BkJIioOrjy9xzUXuyz4+4kG8419JNK6zkhLByUSbcJBQ/w+eYb0Et/4JZYviQU/u3Sqi0tWy0Vj4DAAqXdQ==
X-Received: by 10.112.130.41 with SMTP id ob9mr4428217lbb.81.1456706176175;
 Sun, 28 Feb 2016 16:36:16 -0800 (PST)
Received: by 10.112.51.99 with HTTP; Sun, 28 Feb 2016 16:35:46 -0800 (PST)
In-Reply-To: <1456690276-13914-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287795>

On Mon, Feb 29, 2016 at 3:11 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> diff --git a/lockfile.c b/lockfile.c
> index 80d056d..a7d6175 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -150,9 +150,11 @@ void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
>  {
>         if (err == EEXIST) {
>                 strbuf_addf(buf, "Unable to create '%s.lock': %s.\n\n"
> -                   "If no other git process is currently running, this probably means a\n"
> -                   "git process crashed in this repository earlier. Make sure no other git\n"
> -                   "process is running and remove the file manually to continue.",
> +                   "Another git process seems to be running in this repository.\n"
> +                   "Please terminate it (e.g. quit any text editor that git may be\n"
> +                   "waiting for) and try again. If no other git process is running,\n"
> +                   "then a process may have crashed in this repository earlier:\n"
> +                   "remove the file manually to continue.",
>                             absolute_path(path), strerror(err));

i18n police checking in :) This message looks very much translatable.
Could you check if that's true while you're touching this code, and if
so _() it?

>         } else
>                 strbuf_addf(buf, "Unable to create '%s.lock': %s",

also this one, I think.
--
Duy
