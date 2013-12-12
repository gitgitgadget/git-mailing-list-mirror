From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: I have end-of-lifed cvsps
Date: Thu, 12 Dec 2013 08:42:25 -0500
Message-ID: <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com> <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Thu Dec 12 14:42:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vr6XV-00078J-Hd
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 14:42:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929Ab3LLNmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 08:42:49 -0500
Received: from mail-ve0-f169.google.com ([209.85.128.169]:64158 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623Ab3LLNms (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 08:42:48 -0500
Received: by mail-ve0-f169.google.com with SMTP id c14so309241vea.28
        for <git@vger.kernel.org>; Thu, 12 Dec 2013 05:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ia6tgGyQbRvioYZqyybB0Pe9somRMwKlkcOcU7pez68=;
        b=DT0UGWstHnnSApdGQZ4EFvvsDXT4rLI7cdxvsADcgAjKC8fn9VgYZ0qXhCbUlxAwah
         ynSAsVPdcIRMe3EGKZqqA9V2iiwRRXkA21AxT99cI6et+h2dupgdwa5NJ41LHlxWmBGZ
         H2Ynbxqswlo1Ft3ZHcr700Z+4NoYCFFtNSL/zMTg1qTon/aLGRVa7PL78UCGh87nOXqC
         d9IlDwQXCWb/+Fli93ZoCRrjZfVOwoF2gUubjNtn7WVr+BadZKn+m2kvZMolBJNiQDLP
         YhR3hQh1oMygGtM1dfc456Msb4CE17/nBIqj63YVKzoneRqDh+tGcxnqY+D4c2QGARZh
         8brw==
X-Received: by 10.58.187.81 with SMTP id fq17mr2870961vec.14.1386855767658;
 Thu, 12 Dec 2013 05:42:47 -0800 (PST)
Received: by 10.220.74.133 with HTTP; Thu, 12 Dec 2013 05:42:25 -0800 (PST)
In-Reply-To: <20131212042624.GB8909@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239228>

On Wed, Dec 11, 2013 at 11:26 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> You'll have to remind me what you mean by "incremental" here. Possibly
> it's something cvs-fast-export could support.

User can

 - run a cvs to git import at time T, resulting in repo G
 - make commits to cvs repo
 - run cvs to git import at time T1, pointed to G, and the import tool
will only add the new commits found in cvs between T and T1.

> But what I'm trying to tell you is that, even after I've done a dozen
> releases and fixed the worst problems I could find, cvsps is far too
> likely to mangle anything that passes through it.  The idea that you
> are preserving *anything* valuable by sticking with it is a mirage.

The bugs that lead to a mangled history are real. I acknowledge and
respect that.

However, with those limitations, the incremental feature has value in
many scenarios.

The two main ones are as follows:

 - A developer is tracking his/her own patches on top of a CVS-based
project with git. This is often done with git-svn for example. If
old/convoluted branches in the far past are mangled, this user won't
care; as long as HEAD->master and/or the current/recent branch are
consistent with reality, the tool fits a need.

 - A project plans to transition to git gradually. Experienced
developers who'd normally work on CVS HEAD start working on git (and
landing their work on CVS afterwards). Old/mangled branches and tags
are of little interest, the big value is CVS HEAD (which is linear)
and possibly recent release/stable branches. The history captured is
good enough for git blame/log/pickaxe along the "master" line. At
transition time the original CVS repo can be kept around in readonly
mode, so people can still checkout the exact contents of an old branch
or tag for example (assuming no destructive "surgery" was done in the
CVS repo).

The above examples assume that the CVS repos have used "flying fish"
approach in the "interesting" (i.e.: recent) parts of their history.

[ Simplifying a bit for non-CVS-geeks -- flying fish is using CVS HEAD
for your development, plus 'feature branches' that get landed, plus
long-lived 'stable release' branches. Most CVS projects in modern
times use flying fish, which is a lot like what the git project uses
in its own repo, but tuned to CVS's strengths (interesting commits
linearized in CVS HEAD).

Other approaches ('dovetail') tend to end up with unworkable messes
given CVS's weaknesses. ]

The cvsimport+cvsps combo does a reasonable (though imperfect) job on
'flying fish' CVS histories _and that is what most projects evolved to
use_. If other cvs import tools can handle crazy histories, hats off
to them. But careful with knifing cvsps!

cheers,



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
