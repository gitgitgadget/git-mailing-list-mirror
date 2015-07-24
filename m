From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can we get a git clone flag to override the "required empty directory" behaviour?
Date: Fri, 24 Jul 2015 14:41:28 -0700
Message-ID: <xmqq6159kzcn.fsf@gitster.dls.corp.google.com>
References: <CACjsLYAPqCujmR0wQM-CD=qrPJz1zrC11Pe=C07DUBdEsG2r7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Kasprzak <mike@sykhronics.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 23:41:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIkil-0007e5-FV
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 23:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764AbbGXVlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 17:41:31 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34310 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507AbbGXVla (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 17:41:30 -0400
Received: by pdbbh15 with SMTP id bh15so19132891pdb.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 14:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RdzazwmW9hxohLcnVs1zwITnVzgV2SvrVcNiiZW3gcM=;
        b=Pfd2DDMHuaxqAVe766/olwbLX2oh2Jb8xfgJpCxetRRQkeUWo22eH1KMIsZZkylimh
         aH+yG09Hpujdcn9Gn4YrOL5dEOa8tHAKyz5mU2jH9qzowtGa7Ymgti2S+KLr4piWBouh
         T45VZlW2I2EIfgp02ld5YOuoSjhsOfTsZ++jZVt3in/8V9xafIUMg8ybdjkUBTz2c2vh
         Q9Gra4Q0yMB4qNzX/uqnTUPF/4KRpzEyBHCv51CyLGaDFLJZEmUDFlh189Yt4cgFuETN
         uVaohHSHpHCOzmW3bex0WA8lIiUvsrToUcgn6lcXvVWaYafeN/3K/2GSGss8KFPIVf/Q
         Aapw==
X-Received: by 10.70.124.134 with SMTP id mi6mr35599124pdb.104.1437774089914;
        Fri, 24 Jul 2015 14:41:29 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:bdad:9e5d:aa9:33a9])
        by smtp.gmail.com with ESMTPSA id ns14sm16278530pdb.17.2015.07.24.14.41.28
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 24 Jul 2015 14:41:29 -0700 (PDT)
In-Reply-To: <CACjsLYAPqCujmR0wQM-CD=qrPJz1zrC11Pe=C07DUBdEsG2r7A@mail.gmail.com>
	(Mike Kasprzak's message of "Fri, 24 Jul 2015 14:04:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274603>

Mike Kasprzak <mike@sykhronics.com> writes:

> What I would like to do is git clone inside that directory. Alas, git
> will not let you clone in any directory containing a file.

In the ideal world, I think both of these two commands:

    $ git clone $URL somewhere
    $ cd somewhere && git clone $URL .

should behave just like:

    - if somewhere/.git exists, barf and fail
    - otherwise, do the "git init && git add remote && git fetch"
      followed by "git checkout" dance.

without any additional option.  The final "checkout" step should
fail if the "untracked files" you have in the existing directory
interfere with it.

It used to be that you always had to create a "new" directory, not
even an empty directory was allowed.  Recently we took a small step
in that direction.

That hasn't happened, and will not happen unless somebody works on
it.  The thing is that it would not just be the matter of adding a
command line flag.  There are tons of things "git clone" can do
differently from "git fetch" and using much simpler and performant
logic because it assumes that the directory it is cloning into is an
empty one.
