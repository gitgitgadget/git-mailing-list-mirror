From: Tim Visher <tim.visher@gmail.com>
Subject: Git Submodule Usage Pattern
Date: Tue, 16 Feb 2010 09:39:19 -0500
Message-ID: <c115fd3c1002160639m113a3604wa6686bc613a7c202@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 16 15:39:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhOaj-0002Qh-F7
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 15:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774Ab0BPOjw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 09:39:52 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:43003 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055Ab0BPOju convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2010 09:39:50 -0500
Received: by ywh6 with SMTP id 6so4531762ywh.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 06:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=WWBgYbrf3BldmG+oqo9rkdX9EXMZ5fVAIg3kyuuWboo=;
        b=OAAPQGQN9p4BOPhOKvOW3zs5CM/h4JvXPyJLm6S10fFSHnQYSXCh3FEoKLaVNFK9EK
         vr4QV0jP7555Qgju4REWO9+sYjt59YzMYKuU3hcYAri5gVpGSpiCQhUY/r5DCkUcBKWV
         nfkcG/YNnPpedQwSLuPxwOQ2K6dcpQCRdClw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=aaRL+BNw6WLl6vIhI60o9EanAcE0CcbaS0/0MZ/thAIzirTGfbmPuO96giM4WLq2yJ
         xj/8QhRiFrRRpha5WO6oHbfH41BOzIySKvjdTxd365ScnRFKBjqV62frqFFbTF2BwOoW
         RL4K29qBZ2cn/KiLnxQb9IE/xXl+35YCakSwU=
Received: by 10.101.147.24 with SMTP id z24mr4394502ann.150.1266331179173; 
	Tue, 16 Feb 2010 06:39:39 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140102>

Hello Everyone,

I recently found a case where I thought submodules would be a perfect
fit.  I confess that I don't fully understand how submodules are
supposed to work.  The [section in the Pro Git
Book](http://progit.org/book/ch6-6.html) is fairly explanatory but
also seems to be very cautionary.  The man page also is a little
cryptic, sort of like submodules really aren't supposed to be used all
that often, which I think is indeed the community feeling.

That being said, I wanted to include the [zen-and-art color
theme](http://github.com/irfn/zen-and-art) in my .emacs file and since
it is already a git repo, I figured that it's the perfect case for a
submodule.  Now I ran into a problem.

I have the following configuration typically.  My main box at home
will point at GitHub if I have a public repo, as I do with my .emacs
file.  I then also sync with 2 other locations, a Backup directory for
safety's sake and a USB stick.  The stick repo is so that I have a
place to sync to if I have to work behind a firewall, as I do at work.
 I want to not have to remember to sync to 2 places from home so that
I can work at work and I don't feel like writing a script that would
allow me to not have to remember it (although that is, admittedly, one
solution to my problem).  The solution I came up with was to have my
work repo clone via `http://` from GitHub (that would be `origin`) to
get the latest changes I made at home, but then push to my Stick if I
needed to do any emergency work so that my home location could grab
those changes and then push them out to GitHub.  Obviously at home I
would just be pushing and pulling from GitHub.

So that's:

                     GitHub
                    /   ^ \
                   /   /   \
                  /   /     \
              --git://--     \
                /   /       http://
               /   /           \
              /   /      ---firewall---
             /   /               \
            v   /                 v
           Home Box              Work
         /       ^ \              /
   file system  file system      /
       /           \ \          /
      v             \ v        v
    Backup          ----Stick----

---aside---
=46or those of you reading mail in a sucky reader like GMail (as I am)
that ASCII art got pretty well screwed.

I posted a picture of it
[here](http://random.burningones.com/gitSubmodulesWorkflow.png).

Sorry=E2=80=A6
---aside--

This works great because remotes are configured on a per-repo basis.
My origin at work points where it needs to and my origin at home does
the same.  Now comes the confusion.

Apparently, submodules are not configured on a per-repo basis, unless
I'm totally misunderstanding something.  The .gitmodules file wants to
be checked in just like .gitignore, etc.  I don't know if submodules
will work correctly without syncing that between repos, either.  What
I need is to have the submodule at work point at a different repo than
the submodule at Home to avoid firewall issues.  Or for someone to
suggest a different work flow that would allow me to have my main home
repo point at GitHub using my private git:// address and the
zen-and-art repo using it's public git:// clone address and then have
my Work repo clone from GitHub around the firewall (or somewhere else,
GitHub's http cloning is still pretty Janky) but then push to the
Stick.

Thanks in advance for your thoughts.

--=20

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
