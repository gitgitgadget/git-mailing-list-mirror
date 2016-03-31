From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 2/4] submodule--helper clone: simplify path check
Date: Wed, 30 Mar 2016 17:32:16 -0700
Message-ID: <CA+P7+xq0w+dyhpT7VeURjj5wEa6++p_N2ASLYzjeQy+eOgLQLQ@mail.gmail.com>
References: <1459383457-6848-1-git-send-email-sbeller@google.com> <1459383457-6848-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	norio.nomura@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 02:32:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alQXR-0000uA-Hc
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 02:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbcCaAch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 20:32:37 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:33041 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbcCaAcg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 20:32:36 -0400
Received: by mail-io0-f176.google.com with SMTP id a129so88161058ioe.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 17:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XYxkJz3c+Cu5977+WCaqws3upsulcrPBdxJgg1KYX0A=;
        b=NAuXNmppvS0ZauJ4MYCWvyq9bm0fMjVQWXnozbNnEPOiFdF5xGmoI8lsHWb08cRrFL
         Gj1kR+zYxizZO7nxswsYaRc+Nf42dhIPVOMmlWYOZmR9FZo8DMMq7V3mIMtU9egcDqSN
         5XeEEzeFbwpJP/rRYKkhWgNoStsBvc4l2Ovbe5qkTsQNh3X+mjlVY+W5NgtfkNqqU4mI
         wIT0uG7L5dfjjtEg5nJS3lWF2F8S5/Gu7oIyM4mj8+3Ewub8RWrZoy7POH8KkM+MSiIy
         /LcFB4PNvxwWASJsT/0Sy3PdRMaDkLbN25DJIYI4e6hn6UIe4YgD2ItF+KNmqUqpl7fX
         iUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XYxkJz3c+Cu5977+WCaqws3upsulcrPBdxJgg1KYX0A=;
        b=QBiLgdit5WC9PtNX5Krm00cIUQgBf8T4lcx2H4F6ULIbxM5vmVoInyI16uCaG6Np3U
         VXjUisQYXHA41LuJJlQJpFradLzgU6O4NnNL3ATUzzxTQltoYop2pl6Z94mNV08D8jhF
         w0h1z1uRuYtAKf0KSVQ3BDdVmwAHAKpom8CBfbHQXlAVv2P/Mne8pS7x6mtHkVKf4owM
         ydpWc+wSYFH8gCI0Fkk84PtVNav7FDQdVW3y6Xty5aJABHUkxITm4A+kbb72kyYApHSV
         2vbfGgc3HXQnBcifalcaSiUK0ETp4jHeH/x3uUgDQFxfQgYQxfwukpCQ2zoZe/GFz0I+
         0fJQ==
X-Gm-Message-State: AD7BkJIV/h1EBS8hnALi+uEEd1nBw5Ya2c5kgc0WEDqKFy40Jgk+ckJ/DcFUtvArmPXyrCCHrX6JqK5GtMjgGQ==
X-Received: by 10.107.170.17 with SMTP id t17mr6143573ioe.71.1459384355968;
 Wed, 30 Mar 2016 17:32:35 -0700 (PDT)
Received: by 10.107.10.202 with HTTP; Wed, 30 Mar 2016 17:32:16 -0700 (PDT)
In-Reply-To: <1459383457-6848-3-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290363>

On Wed, Mar 30, 2016 at 5:17 PM, Stefan Beller <sbeller@google.com> wrote:
> The calling shell code makes sure that `path` is non null and non empty.
> (side note: it cannot be null as just three lines before it is passed
> to safe_create_leading_directories_const which would crash as you feed
> it null).
>

So we're going to assume that all callers of submodule--helper will
provide a non-null non-empty path? Hmm, since we expect only our shell
code to really do this... that's probably ok I think. I don't think it
can do any real harm should someone outside git call it with a bad
path.

Thanks,
Jake
