From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2012, #08; Mon, 31)
Date: Tue, 1 Jan 2013 16:29:37 +0100
Message-ID: <CALWbr2y6M7fZgQb2dizgcBZHTL=TudSc6c-DUOicKHvwahtm9g@mail.gmail.com>
References: <7vk3rxd9yo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 16:30:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq3mw-0006kC-HD
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 16:29:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334Ab3AAP3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 10:29:40 -0500
Received: from mail-ee0-f52.google.com ([74.125.83.52]:48225 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304Ab3AAP3j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 10:29:39 -0500
Received: by mail-ee0-f52.google.com with SMTP id d17so6420976eek.11
        for <git@vger.kernel.org>; Tue, 01 Jan 2013 07:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HyY2j6eN+OTs7m6xjvJglb+KQpveDxKTeMEqpryOnA4=;
        b=KGCcAUZXxqm42u3jcec5DtTJ79nJNCZqjuKWXqEL/HqUT5Y2L57cjwIhDjb+0pdPh3
         5G48+Sie6FSmxMnZk0Q45QclJ5G7jiaHAMSnxvuDdEvLlvXuDgo+1tFk3TBL5SwYbKIM
         wHWF4VKP6hc79zdfd0h4Uy4y5r7YKNnJYyHCaW+F8BwmY7rLrCMwY8Z2WKy52BR6NFhg
         J6YajhGi8jqRWHDOQldjsZfRtviL9j+YVv335/5m4A16QVEiJ3CK8nB+RoIX6cDDomn4
         HbkOSkSrNwW98tAb8F8W/A1YSDVSHusBbX4lttaS7jklLj2vL7E7gkd5c5TcnM6TSy1O
         u1Iw==
Received: by 10.14.194.4 with SMTP id l4mr118404777een.42.1357054177790; Tue,
 01 Jan 2013 07:29:37 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Tue, 1 Jan 2013 07:29:37 -0800 (PST)
In-Reply-To: <7vk3rxd9yo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212426>

> * ap/status-ignored-in-ignored-directory (2012-12-26) 1 commit
>  - wt-status: Show ignored files in untracked dirs
>
>  A topic still in flux; will be redone.

I've already redone this part sending two patches (one with the fix,
and one with some tests for each individual use-case) that you
probably missed. Here are the message ids:
 - <1356878341-12942-1-git-send-email-apelisse@gmail.com>
 - <1356878341-12942-2-git-send-email-apelisse@gmail.com>

> * ap/log-mailmap (2012-12-27) 10 commits
>  - log --use-mailmap: optimize for cases without --author/--committer search
>  - log: add log.mailmap configuration option
>  - log: grep author/committer using mailmap
>  - test: Add test for --use-mailmap option
>  - log: Add --use-mailmap option
>  - pretty: Use mailmap to display username and email
>  - mailmap: Add mailmap structure to rev_info and pp
>  - mailmap: Simplify map_user() interface
>  - mailmap: Remove buffer length limit in map_user
>  - Use split_ident_line to parse author and committer
>  (this branch is used by jc/mailmap.)
>
>  Clean up various codepaths around mailmap and teach the "log"
>  machinery to use it.
>
>  Will merge to 'next'.

I'm not sure that should be merged to next yet. I've thought of
another optimization that will require another preparatory step. Here
is the idea:

 - Create some string_list_lookup_extended with a n parameter (size of
the string to match) and a case parameter (to allow strncasecmp() the
strings).
 - Re-re-factor map_user() to take/return pointers instead of strbufs
to avoid a bunch of copies. (that is pointless without the former
point).

The whole idea would be to avoid a bunch of copies: one for lowering
the email, the other for adding '\0' at the end of name before running
string_list_lookup().

Cheers,
