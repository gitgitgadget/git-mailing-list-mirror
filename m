From: Kyle Neath <kneath@gmail.com>
Subject: The imporantance of including http credential caching in 1.7.7
Date: Tue, 6 Sep 2011 22:33:35 -0700
Message-ID: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 07 07:34:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Alv-0006ub-Ku
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 07:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997Ab1IGFd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 01:33:58 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47844 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753874Ab1IGFd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 01:33:56 -0400
Received: by wwf5 with SMTP id 5so7071497wwf.1
        for <git@vger.kernel.org>; Tue, 06 Sep 2011 22:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=RCd1/Thz7FepaqrAbc+2porr7bzw+bfHaTmKUbav5eQ=;
        b=YN7w+PFt8DiYsxI7+Wc4AAdYNLbwHxv/FBpAKUZW67XS1ITegUFeUItE3fucVLfMis
         kTdYeoUoMa3Wf94z4zNv2ktcWegQrbqq+iA3Bu+du5Ddaxiw09HTa9ygUsuwzwgs9IQ5
         bDouUnLTHAX/BFPNSqqLANQJRGdx9EdekxSuk=
Received: by 10.227.8.214 with SMTP id i22mr5866262wbi.11.1315373635162; Tue,
 06 Sep 2011 22:33:55 -0700 (PDT)
Received: by 10.227.54.208 with HTTP; Tue, 6 Sep 2011 22:33:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180852>

Earlier today, Scott Chacon alerted me to this email thread:
http://www.spinics.net/lists/git/msg164192.html (many apologies to the list, I
am not sure how to properly reference this email or reply to it since I have
not been subscribed until today).

> * jk/http-auth-keyring (2011-08-03) 13 commits
>   (merged to 'next' on 2011-08-03 at b06e80e)
>  + credentials: add "getpass" helper
>  + credentials: add "store" helper
>  + credentials: add "cache" helper
>  + docs: end-user documentation for the credential subsystem
>  + http: use hostname in credential description
>  + allow the user to configure credential helpers
>  + look for credentials in config before prompting
>  + http: use credential API to get passwords
>  + introduce credentials API
>  + http: retry authentication failures for all http requests
>  + remote-curl: don't retry auth failures with dumb protocol
>  + improve httpd auth tests
>  + url: decode buffers that are not NUL-terminated
>
> Looked mostly reasonable except for the limitation that it is not clear
> how to deal with a site at which a user needs to use different passwords
> for different repositories. Will keep it in "next" at least for one cycle,
> until we start hearing real-world success reports on the list.
>
> Not urgent; will not be in 1.7.7.

This is very disheartening to hear. Of all the minor changes, bugs, and
potential features, I believe that http credential caching is the absolute
most important thing that git core can do to promote adoption. I've believed
this for more than a year now and I'm incredibly disappointed that it's being
shelved for yet another release.

Over the past two years as a designer for GitHub, I've answered ~thousands of
support requests and talked face to face with ~thousands of developers of
varying git skill levels. Once a month our company does online git training
for newbies - https://github.com/training/online and I've had many discussions
about newcomer's struggles with Matthew McCullough and Scott Chacon.
Previously, I worked at ENTP where I helped polish the very popular "Git for
Designers" guide http://hoth.entp.com/output/git_for_designers.html based on
feedback. I was also lead designer for GitHub for Mac - an OSX GUI aimed at
people less familiar with the command line.

I bring all of this up because I'd like to think I have a good handle on
common problems that git newcomers or people resisting git adoption run into.
I've been deeply involved in spreading git adoption full time for nearly 3
years - it's something that's incredibly important to me professionally and
personally. And the number one problem that *always* comes up is SSH key
complexity.

A lot of these problems surface themselves in people saying it's hard to setup
git on Windows. When I push these people to explain further, it turns out that
the problem is always setting up SSH key authentication on Windows, not
necessarily git.

It's incredibly frustrating that git's biggest roadblock has nothing to do
with version control at all, but rather network authentication. Just as I
believe only *you* can own your availability, I believe git should do it's
best to own authentication.

HTTP credential caching combined with Smart HTTP make git one hell of an
amazing tool for newcomers and experts alike. I like to envision a world in
which git with both these features shipped with the latest OSX install.
Developers, designers, or anyone with an inkling for code would have exactly
two steps to get started with any given git host:

  1. Set your git config email / username
  2. git clone https://example.com/repository

Contrast this to our current help page for OSX:
http://help.github.com/mac-set-up-git/ or worse yet, our Windows setup page
with all of it's yelling about what kind of SSH keys to setup:
http://help.github.com/win-set-up-git/

Please note that I am not arguing against the merits of SSH keys - for those
developers who understand them, they're fantastic. But the reality is the
great majority of people who interact with version control do not understand
them at all. This results in passwordless SSH keys, confusion, and
frustration.

If another git version comes and goes without http credential caching, I fear
we as a community have purposefully ignored the largest potential for git
adoption currently available. This is important enough for me that I believe
it would be in git's best interest to delay the release of 1.7.7 until this
feature has been patched to the core team's standards.

I'll summarize with a graph of my opinion of where git's potential for
adoption lies:

------------------------------------------------------------------------------
            OPPORTUNITY FOR GIT ADOPTION ACCORDING TO KYLE NEATH

                      Caching of http credentials
                                  |
[=====================================================================||=====]
                                                                          |
                                               Everything else in the universe

------------------------------------------------------------------------------

With hopes and butterflies,

Kyle Neath
Director of Design at GitHub
