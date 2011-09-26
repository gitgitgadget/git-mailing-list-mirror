From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Thoughts on gitk's memory footprint over linux-2.6.git
Date: Mon, 26 Sep 2011 15:38:35 -0400
Message-ID: <CACPiFC+T1EZ1CSakQxsYZhsnHc-ZsN1-=tpoi-NaQSdpU5Yxkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 21:39:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8H13-0007Uf-O3
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 21:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007Ab1IZTi4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 15:38:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43083 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949Ab1IZTiz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 15:38:55 -0400
Received: by gyg10 with SMTP id 10so4447587gyg.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 12:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=q1Ci45TOPRae8eMoP3tE7USy6ss5+7mwd1e74vj5a10=;
        b=SzO3N8n3MBZDBggpy5e7QwFYFE2E4bJqXUHAfhW/MELvpx6a3Apkxb/rGYt4vMbKmD
         LwSABXT64/BdMyLE4fVXyu5VCWek2FYGu32JFyZnibg0HHR5jB4ni1rbh+20qamcjJs0
         t9qLLE0jYm+UNeR3QefyfyVqeLJmmhiGzk5Iw=
Received: by 10.42.133.3 with SMTP id f3mr466564ict.114.1317065935231; Mon, 26
 Sep 2011 12:38:55 -0700 (PDT)
Received: by 10.42.172.130 with HTTP; Mon, 26 Sep 2011 12:38:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182155>

In an odd turn of affairs, I am managing a bit of kernel development,
and even writing the odd patch myself. As usual, gitk is excellent to
visualize what's new in the tree when developers in the team commit
and push new stuff.

However, I find it extremely annoying over the kernel tree, due to its
memory footprint. It is not the only thing I am running, (Chrome
Browser, Gnome3, Firefox, many gnome Terminal windows, emacs), and
given that I am looking at "just a couple of commits" I don't feel
opening a few gitk instances should be problematic... except that it
is.

Each gitk instance wants to gobble up >1GB of memory! It really wants
to show me the "Linux-2.6.12-rc2(...)Initial git repository build."
commit.

Aren't kernel hackers hurting with this? This box blazes through a
kernel compile, but only has 2GB RAM. Regardless of amount of RAM,
firing up gitk gobbles up >1G and untold CPU cycles.

My tk isn't really up to par, but... here's a stupid idea.

 - In start_rev_list, run git log into a tempfile, and concurrently
open the same file for reading, as fd

 - Read in a bound number of commits, say 10000 ("just" 200MB)

 - If we haven't made it to the end of the file, remember the offset
and keep reading the file, counting matches of /^commit/ to get a
commit count and size the scroll back

 - re-activate the reading as required...

There are of course tricky aspects of concurrent programming at hand.
I am not sure what concurrency model gitk has now, but it does a great
job of not blocking and not getting confused.

Tricky Tk programming, or go buy some RAM? Yeah, I know.

Now why didn't I pack that Tk book when I moved here?




m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
