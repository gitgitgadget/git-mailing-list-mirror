From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: mac test failure -- test 3301
Date: Mon, 10 Nov 2014 20:19:29 -0500
Message-ID: <CAPig+cRxCj82F5aak0Y+Ce_SvUETtQ5dwM1RtzjUUvwtJ=WPYw@mail.gmail.com>
References: <CAO2U3QhiWVvVKivBhE5R2xhjf8SPPtg6VSaQMxw7vbm_454jBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Johan Herland <johan@herland.net>
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 02:19:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xo07N-0001SR-Pf
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 02:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbaKKBTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 20:19:30 -0500
Received: from mail-yk0-f179.google.com ([209.85.160.179]:44276 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaKKBTa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 20:19:30 -0500
Received: by mail-yk0-f179.google.com with SMTP id 131so4835106ykp.38
        for <git@vger.kernel.org>; Mon, 10 Nov 2014 17:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=53elGrk/95X4OO2qPlGmq/qkRQqXvBhIJMdKOoEg8BQ=;
        b=Or4M1Q/+h2kZ8By5QvQWbdICt7hTigG4hIgxNqp5YWcIcl9aHB8tN6oZxTQ1f7gdoR
         ifuH3hiU6y1X9SrZnrdnA/no37/21G+KsXx2yziA+cAS+Y0qVQ55ENVUNw3wJQgDcmr4
         7S8MP5gwDeeIW/rnYnsR3fVCNphN/Wkmb4h4BmBh9uz1qKaVvLrWFvJYDcZGhtatSqpV
         Oejwy4qYiBk/8s4exg+B/4pPgT4x75eVj5xiWEVT7w4pck3Z2SoY46D1rJbHs+uj9zt2
         u6D3PMBEYwD9P/dY3uxnSGel1/ev8AiSDc9eVBir+v3FKF2eZDdJBgS6b3Hp4GuTwa55
         8CmQ==
X-Received: by 10.170.115.132 with SMTP id h126mr15479483ykb.2.1415668769268;
 Mon, 10 Nov 2014 17:19:29 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Mon, 10 Nov 2014 17:19:29 -0800 (PST)
In-Reply-To: <CAO2U3QhiWVvVKivBhE5R2xhjf8SPPtg6VSaQMxw7vbm_454jBQ@mail.gmail.com>
X-Google-Sender-Auth: F83KujccBz75l7b3asUBXARSvME
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 10, 2014 at 7:17 PM, Michael Blume <blume.mike@gmail.com> wrote:
> the commit modernizing test 3301
> (https://github.com/git/git/commit/fbe4f74865acfd) appears to break it
> on my mac
>
> $ ./t3301-notes.sh -v
> expecting success:
> MSG=b4 git notes add &&
> test_path_is_missing .git/NOTES_EDITMSG &&
> test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
> test "b4" = "$(git notes show)" &&
> git show HEAD^ &&
> test_must_fail git notes show HEAD^
>
> b4
> not ok 8 - create notes

This and all other failures are due to the output of 'wc -l', which on
Mac is "{whitespace}1" rather than just "1" as it is on other
platforms. fbe4f748 added quotes around the $(... | wc -l) invocation
which caused the whitespace to be retained. A minimum fix would be to
drop the quotes surrounding $().
