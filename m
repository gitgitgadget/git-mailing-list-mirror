From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: [PATCH] Fix file mark handling and sort side-effects in git.el
Date: Sun, 15 Feb 2009 16:04:09 -0800
Message-ID: <e38bce640902151604k6bc24ad1gd0986df9abf52f02@mail.gmail.com>
References: <18834.27724.991388.339214@hungover.brentg.com>
	 <87hc31kzrb.fsf@wine.dyndns.org>
	 <e38bce640902120738h7b9bb75o42e1524cbfd95169@mail.gmail.com>
	 <18836.22386.987021.484807@hungover.brentg.com>
	 <87ocx3hbkq.fsf@wine.dyndns.org>
	 <e38bce640902151035s18e374e6j25e3887728722700@mail.gmail.com>
	 <87k57rh5qe.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Mon Feb 16 01:13:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYr6r-0008Mm-IC
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 01:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643AbZBPALt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 19:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754548AbZBPALs
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 19:11:48 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:37388 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461AbZBPALr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 19:11:47 -0500
Received: by yx-out-2324.google.com with SMTP id 8so887964yxm.1
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 16:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GwjKWRxUMwSAqTJRy2fxf4orD+v0lHb7UIoWh7nDeek=;
        b=b0OlLKLg42q5V6NJsdmV3/r+/kKr4RVKFVtn34DJOmf621KPuAyEKH+tk0oMCJ3Hze
         4mkP3efJLMhgiieY7Ud/4JYXkDvnicwOjJH0gyRS3l0LJsb0KprYQJwer6pgDlQ6rM+d
         oyS0/gaaVBLecuDgsC6bCBx2ZUoxrhGDEcoNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IbeNPLg70m5eAPOlFc+Dh04xPcCFjI/uDF/vM6usA7bW9c7XJZoDmoA/Fckf1cMFPn
         T7o6wxuxmRXHy0TqcTbGjHQ5ZshVyPgUh1cLUOEwJpYlek2zU34OKwJuwGkvV+dTxT3G
         uWscBiIeCc13Z/tDC3TWIu2zAfQUZ/kw4Uyd4=
Received: by 10.90.68.20 with SMTP id q20mr2368859aga.74.1234742649950; Sun, 
	15 Feb 2009 16:04:09 -0800 (PST)
In-Reply-To: <87k57rh5qe.fsf@wine.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110099>

> There's no manual, and I'm not going to write one, I suck at writing
> documentation. If you would like to contribute one it would certainly be
> welcome.

It's apparent that you are quite articulate in your emails, so I don't
buy the argument that you suck at writing documentation. ;)

Actually, there isn't enough functionality in git.el to write up in a
manual yet. Once there is, then perhaps having a manual might make
sense.

Let's just leave it as adding additional commentary at the top of
git.el that warns future users of the intent behind the user interface
so that you don't have to keep answering this question later on.  To
that end, here is a patch of my attempt at adding an explanatory
comment at the top of git.el (in lieu of a full-blown manual):

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index fcbe2d9..b383f51 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -23,8 +23,33 @@

 ;; This file contains an interface for the git version control
 ;; system. It provides easy access to the most frequently used git
-;; commands. The user interface is as far as possible identical to
-;; that of the PCL-CVS mode.
+;; commands. The user interface intensionally hides some of the full
+;; interface provided by the git command. This was done in order to
+;; keep the user interface similar to other Emacs SCM interface
+;; modes, such as the PCL-CVS mode. For example, it is possible using
+;; git directly from the command-line to do partial checkins such as:
+;;
+;;  - Make a first edit to an git-controlled file
+;;
+;;  - Add the file to the git index with the "git add" command.
+;;
+;;  - Make a second edit to that same file
+;;
+;;  - Checkin the change using the "git commit" command, which
+;;    results in the first edit being committed, but not the second.
+;;
+;; The Emacs Git interface as provided by the git-status command
+;; herein simplifies the checkin sequence by hiding the git index
+;; from the user. Instead, the buffer git-status shows will only show
+;; that the file has been modified, even if some of the modifications
+;; are not yet added to the git index. Only files not yet known to
+;; git have to be added using the "a" keybinding one time (i.e., you
+;; don't have to remember to re-add the second change as required by
+;; git in the example above). To commit, you mark multiple files in
+;; the git-status buffer using the "m" keybinding, and then commit
+;; those files with the "c" binding. Then git-status will insure that
+;; all edits made to those marked files are silently added to the git index
+;; before git commit is executed.
 ;;
 ;; To install: put this file on the load-path and place the following
 ;; in your .emacs file:


>
>> However, the *git-status* buffer does properly reflect the two added
>> files by their state being changed to "Added". Since you may have a
>> ton of files that are being added, it probably doesn't make a whole
>> lot of sense to dump a long message into the minibuffer with all of
>> those names.  By the same token, it doesn't make sense to emit one
>> message per file either. Instead, would you be willing to change that
>> message to just state "Added n files" where "n" is the number of files
>> added?
>
> That's exactly what git-success-message already does. The only problem
> is that the list isn't always preserved properly (and that's only a
> cosmetic bug, the operations get carried out correctly).

Agreed.  Thanks for your help!

bg
