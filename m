From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Another use of "@"?
Date: Sat, 4 May 2013 18:14:07 +0530
Message-ID: <CALkWK0=qdGcbQDz2VomhOcy7AybXj5jkxzS53jFGyjdZ9+6juQ@mail.gmail.com>
References: <CACsJy8AcWV8hmbhG27dw+GdnZf8NnQEctYmowqd3sSzOOHf+xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 04 14:45:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYbpo-0008LF-3w
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 14:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758683Ab3EDMos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 08:44:48 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:34939 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758248Ab3EDMor (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 08:44:47 -0400
Received: by mail-ie0-f182.google.com with SMTP id a14so2724562iee.41
        for <git@vger.kernel.org>; Sat, 04 May 2013 05:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/I0IWKwp2hOLzYNE/GEfzX6/UT86wcBXCW/7Pjak2qs=;
        b=Gd8vWqIJiRSrj9fymNAZfmyU6bA4nMjYvlqk4uDrUdWJgaKJ1Ti32143hz51Tf8PTd
         8Dj+6UywRJPSlrRi1UqMNYSrxEr/SoWB3A7uJ/9us+zU98CZHFcB1Hyxlehze2JBkLik
         I/RaS39PEgTrd9xDoB3+96xSVfCMlMydSwkCsRdYt0GobeJRi4BpEpQBVqpzOkrp+z87
         Uv6ItedeMSkRsE3BsYKqa1LHXxLKNtb2jr7fO22oPO98koY0YIf8K4pkpIAYv1tyJvFd
         wuCxJzOHC7wkTLMc5r7DA+a9rK+rgrG5u0PlepkWkzJLu4lamDiIrvHYeK47aV3zdDKk
         YYnw==
X-Received: by 10.50.57.200 with SMTP id k8mr615582igq.44.1367671487213; Sat,
 04 May 2013 05:44:47 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sat, 4 May 2013 05:44:07 -0700 (PDT)
In-Reply-To: <CACsJy8AcWV8hmbhG27dw+GdnZf8NnQEctYmowqd3sSzOOHf+xg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223366>

[joining the discussion late; was travelling]

Duy Nguyen wrote:
> git co long-branch-name
> git diff A/@
> git reset --hard A/@

In this form, this looks highly inconsistent.  You have to decide if
you want @ to resolve to the current branch name or HEAD.  Our current
@-proposal makes @@{1} display the reflog for HEAD for instance.  The
other problem is that we resolve things like @{-1} to full refs like
refs/heads/master.  Making a A/@{-1} work makes little or no sense,
because that refs/heads needs to be changed to refs/remotes in the
first place.  What about refs/decapitated/@{-1}?  Should we support
it?

I tend to agree with Junio here: @{u} is the way forward.  We need to
define useful reduced consistent semantics; while inventing a
mini-language to do all kinds of revision manipulations may be a fun
theoretical exercise, it's too much effort for too little gain.  We
have to learn to work within the limitations of what we've invented so
far.

On Matthieu's note, I have a comment: symbolic refs are an absolute
dead end.  We didn't think of it from the start, and it's too late
now.  Do NOT go there: from my investigation, I believe that hooking
up everything to the revision parser is the way forward.
