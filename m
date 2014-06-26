From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH (performance tracing)] test git-status performance
Date: Thu, 26 Jun 2014 19:30:55 +0700
Message-ID: <CACsJy8Bkfz6=WUy0RsXd0e9dXqocUFXhAaO0dpUg+AjZ5RNeNA@mail.gmail.com>
References: <53AA0129.1080109@gmail.com> <53AA0228.4080600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 14:31:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X08pu-0005QZ-U9
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 14:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617AbaFZMb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 08:31:26 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:50357 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122AbaFZMb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 08:31:26 -0400
Received: by mail-qg0-f48.google.com with SMTP id q108so2926242qgd.7
        for <git@vger.kernel.org>; Thu, 26 Jun 2014 05:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FvyFVvRhblYUjhvIXOfoyKchFuAI3PTp1TMDpqGp9Ms=;
        b=ojgVLiOndlvyugPReiPAVM7VyLAoUbqDsxg/LAYLIH0oiNtRE/UjOTe3W0J0neNwe1
         xvalEm4g1QM3AwoQxMgQitw8ywN3HK0jX+mLnJQB9frkUMhWSBCOsDfqwlyKNOD7ieLk
         mqg9gcv8ABB2aqruhCUqR99FjgLLzj4iZBpHBf87ByeAjvVsrDixxaq3TRrnaZJPiws3
         lCkfbqtn4sHYdaGOqXK1CBkae5LwovWMikzbEfnGq44QttvZkuiEB0Yl1qB+LTWUbhUn
         URQya9DaToQbsYEtnbpS0DZ1urgfq2WQOgqzlCVogwWIoHnEfJNQqJ0LqTwBFL+SFdEW
         1+nw==
X-Received: by 10.224.22.12 with SMTP id l12mr22134640qab.88.1403785885265;
 Thu, 26 Jun 2014 05:31:25 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Thu, 26 Jun 2014 05:30:55 -0700 (PDT)
In-Reply-To: <53AA0228.4080600@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252498>

On Wed, Jun 25, 2014 at 5:56 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
>  void wt_status_collect(struct wt_status *s)
>  {
> +       uint64_t start = getnanotime();
> +
>         wt_status_collect_changes_worktree(s);
>
> +       trace_performance_since(start, "wt_status_collect_changes_worktree");
> +       start = getnanotime();
> +
>         if (s->is_initial)
>                 wt_status_collect_changes_initial(s);
>         else
>                 wt_status_collect_changes_index(s);
> +
> +       trace_performance_since(start, "wt_status_collect_changes_index");
> +       start = getnanotime();
> +
>         wt_status_collect_untracked(s);
> +
> +       trace_performance_since(start, "wt_status_collect_untracked");
>  }

Now that we have good perf measuring support, perhaps the next step is
remove gettimeofday() in advice_status_u_option related code in
wt_status_collect_untracked().
-- 
Duy
