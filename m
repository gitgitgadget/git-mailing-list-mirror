From: David Aguilar <davvid@gmail.com>
Subject: Re: Splitting a commit with rebase -i and keeping a commit message
Date: Tue, 16 Apr 2013 19:29:47 -0700
Message-ID: <CAJDDKr64KpF-DP5Axj+vhxRQ1rrig=pm25T3Angp8GaKK_CHMA@mail.gmail.com>
References: <20130416203825.3701d98b@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 04:30:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USI8V-0004f0-Nj
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 04:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936293Ab3DQC34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 22:29:56 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:63079 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936290Ab3DQC3s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 22:29:48 -0400
Received: by mail-we0-f174.google.com with SMTP id u12so847455wey.33
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 19:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=tlsRFeoVeFpE2mRLQXtK0kOS4YzNztuoCo5P4sk7Ffs=;
        b=FQ2uP+TJdpg6CHgza8fZB7xMjbkwhVg9hJwuTfdD+Xae/UXFx6DEAWXMOu2nWGYmE1
         WB3cWUgZOEgX5NhPtXUiFmecloVg9vbebkNELc/utWVgC0Z23f6hWF7kChv/UU0XiFf6
         zmHKq1GbEkR2yDxSTM4lwqxaLkvOOdFYyTGjT0G3XMD7FVqz+vtHN3ctkbusJvjzvRE4
         tAqVZsbZ01qLlLYCVbHI8o/qV55KjIe09gqsI+ua+cjVJxJhTedIFakowJ3l9oVbHQmF
         tuy2zg0659ncsOnUSO+gAYAgxZnj9Ee5tK0UaheWNJcGQCDduB1Cf+AjdK2WYFH3ZTTQ
         DA1g==
X-Received: by 10.194.10.129 with SMTP id i1mr7946231wjb.21.1366165787080;
 Tue, 16 Apr 2013 19:29:47 -0700 (PDT)
Received: by 10.194.240.195 with HTTP; Tue, 16 Apr 2013 19:29:47 -0700 (PDT)
In-Reply-To: <20130416203825.3701d98b@bigbox.christie.dr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221497>

Taking a wild guess here...

On Tue, Apr 16, 2013 at 6:38 PM, Tim Chase <git@tim.thechases.com> wrote:
> I asked this on IRC and played with some of their ideas, but struck
> out with anything satisfying.  I walked through [1] with the
> following setup:
>
>   git init foo
>   cd foo
>   touch a.txt b.txt
>   git add a.txt b.txt
>   git commit -m "Initial checkin"
>   echo "Modify A" >> a.txt
>   git commit -am "Modified A"
>   echo "Modify B" >> b.txt
>   git commit -am "Modified B"
>   echo "Modify A2" >> a.txt
>   echo "Modify B2" >> b.txt
>   git commit -am "Modified B"
>   git commit -am "Long-bodied commit comment about b.txt changes"
>   # whoops, just wanted B

Save the commit's ID here so that we can reuse its message later:

    orig_commit=$(git rev-parse HEAD)

>   git rebase -i HEAD^^
>   # change the "Added b.txt..." commit to "edit"
>   git reset HEAD^  # pull the changes out of the pending commit
>   git add a.txt
>   git commit -m "Tweaked a.txt"
>   git add b.txt
>   git commit ${MAGIC_HERE}

...reuse the commit message by passing the "-c" option to "git commit":

    git commit --reset-author -c $orig_commit

This will give you a chance to further edit the message in your editor.

>   git rebase --continue
>
> I haven't been able to figure out a good way to keep the "long-bodied
> commit comment" for the final commit where the ${MAGIC_HERE} is.  Is
> there a right/easy way to go about pulling in the commit-message from
> the commit the rebase is transplanting?

This is pretty much what the commands above do.
They save the commit ID so that we can reuse the message later.

HTH,
--
David
