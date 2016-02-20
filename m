From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 12/27] refs: forbid cross-backend ref renames
Date: Sat, 20 Feb 2016 11:30:45 +0700
Message-ID: <CACsJy8B0Lt8Eq4GqSCKyA08g0Vvu-1B6dDjpkNmRre3M8DebDg@mail.gmail.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com> <1455772670-21142-13-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 05:32:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWzD6-0003N1-V9
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 05:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992730AbcBTEbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 23:31:17 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34738 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1948605AbcBTEbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 23:31:16 -0500
Received: by mail-lb0-f173.google.com with SMTP id of3so57410921lbc.1
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 20:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yriKNiy/rbxpqZ3lv2xkU0rfcYnrQ1bfSoptAhbpsZo=;
        b=vbJZS88HjeWgRKbPK5BFjJWgIX2bEpztAoNOfTJdsHUtPnyY9SryB3LyyFYmGQvmng
         FmVpPth0tdayCUd+1icFJ0U+W7/fKVsDV5pw6jMrDEdVaodj690/M/EpBeb5d5CTCOi9
         Cr5Vpor/Z03oQak3u+prB9mdXdttH7DyrfevlUDFmVb72cuyp2S79Fwmy52vFHaxlUh4
         sxYIrNwsZSSFSJU81mWr5V8y5CtkpktRakmYYO6uOat/cUpNW1iqDj1t0JLfTwC6wBn1
         eKv9bGzKfDA/Lb5ZKiL7J5B+WNY/rqn3lglAPL66IEbboBw9Y2fsnvtFRG1Xq3Jo6/xl
         nhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=yriKNiy/rbxpqZ3lv2xkU0rfcYnrQ1bfSoptAhbpsZo=;
        b=cC0aRdHwMAGN8bNipJcvNUNeTuX69/zhIcVwW8mS2AMN8AeoSnbo3IFOYhddGehDSN
         vqGqknayP7FND76tDTC1jt632AEPvV0P95hYaU0yX2+fu9IUuUcLCP05QWxBHKWIUp0b
         bNdvXAUBvg9DK2r2YofN6QfLW9T4nHYKNe5pxecoG/dBMFkXvM7vpPOQAuHYsIAf/0Qt
         EnUUAbZWRLQsim2HnUiQdVlEgMlXbFWDH6Ys95hLwBfCpHOI/IekZKRGaVtpDC3x/oYV
         +xD1Ye8+SdXPex88bARS0+Gx4dAVaPd2OWvTjT5/DLJ7pI/gu+DzyECKN3E0vgUoCaQa
         TLQw==
X-Gm-Message-State: AG10YOTygUgF4m5DM+Sipm14PT7MpnB1ZOi1agNQ0eVCQaAolAPVTGoo96f2uH+nB3ejOeCrNtExqiDx5dIujQ==
X-Received: by 10.112.130.41 with SMTP id ob9mr6451181lbb.81.1455942674798;
 Fri, 19 Feb 2016 20:31:14 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Fri, 19 Feb 2016 20:30:45 -0800 (PST)
In-Reply-To: <1455772670-21142-13-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286765>

On Thu, Feb 18, 2016 at 12:17 PM, David Turner <dturner@twopensource.com> wrote:
> This would be pretty weird, but since it will break, we should prevent
> it.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/refs.c b/refs.c
> index f5754f2..8eb04da 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1306,5 +1306,11 @@ int delete_refs(struct string_list *refnames)
>
>  int rename_ref(const char *oldref, const char *newref, const char *logmsg)
>  {
> +       if ((ref_type(oldref) == REF_TYPE_NORMAL) !=
> +           (ref_type(newref) == REF_TYPE_NORMAL)) {
> +               error(_("Both ref arguments to rename_ref must be normal "
> +                       "(or both must be per-worktree/pseudorefs)"));
> +               return -1;

You can do return error(...);

> +       }
>         return the_refs_backend->rename_ref(oldref, newref, logmsg);

LMDB backend can't deal with per-worktree rename. So either forbid
per-worktree rename here too, or fall back to files backend.
-- 
Duy
