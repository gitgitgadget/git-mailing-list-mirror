From: "Manuel Woelker" <manuel.woelker@gmail.com>
Subject: [JGIT] Blame functionality for jgit
Date: Sun, 11 Jan 2009 21:23:16 +0100
Message-ID: <3d045c7e0901111223j43a69402s28a59612212943f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org, "Robin Rosenberg" <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jan 11 21:24:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM6rb-0002zS-4g
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 21:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbZAKUXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 15:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbZAKUXU
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 15:23:20 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:2397 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbZAKUXS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 15:23:18 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3791715fgg.17
        for <git@vger.kernel.org>; Sun, 11 Jan 2009 12:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Q1oWfb3CbzGkU1aZ9uefnpJ72+ZVot6hjRenmxfRuSI=;
        b=aUoTs7KN1Ec04mXLHbXOSt9w/fQZyyC9+4RjoCQMVAJIKHDLEPr490aydrygYymmDA
         kXPN8RRFAZAZuGndiGfIvkiR0KF9FCcDr08hY1+TFm9O+MM8Jy4k/98/TESo60yzGj3S
         N219sr3qBZzAL3sdpS6sOPureuzd/f6Vw6DLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=RQAay3AK/M7HGmTd8Ii4Md7CVeqN0BUfOWtoUWWfP3q7+B6n7e0lwjwscd6pp2lExr
         /k6P/GdVS3Bf32ZQcfT65c+F4ypknnPSZs713QQWvjXVjEOYt/CWlWgJDqg4msgQR1K1
         ZwwQRjh1mw83jTWPyf4afAUG2efce3O6bO4ig=
Received: by 10.86.95.20 with SMTP id s20mr9677018fgb.39.1231705396305;
        Sun, 11 Jan 2009 12:23:16 -0800 (PST)
Received: by 10.86.89.3 with HTTP; Sun, 11 Jan 2009 12:23:16 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105219>

Hello there,

Over the weekend I have been hacking the jgit sources a little to see
if I can add blame/praise/annotate functionality to it. The results
can be found at http://github.com/manuel-woelker/egit/tree/blame . All
work is in the blame branch in org.spearce.jgit.blame package.

I largely ported the cgit blame algorithm described here
https://kerneltrap.org/mailarchive/git/2006/10/12/224187 , the
relevant file is builtin-blame.c cf.
http://repo.or.cz/w/git.git?a=blob;f=builtin-blame.c;hb=HEAD

The structure has been kept largely intact, but I have tried to
translate the concepts to idiomatic java, with the bulk of the logic
now in the Scoreboard class

The blame algorithm needs to use a diff algorithm to find common parts
in files. AFAICT there is no diff implementation in jgit at the
moment. I used the incava java-diff library, (see
http://www.incava.org/projects/java/java-diff ), but I introduced an
interface that should make it possible to swap implementations with a
minimum of effort. To compile I just create a new eclipse project with
the java-diff sources.

Currently renames, copies etc. are not supported, so only files with
the same name can receive the blame. Unmodified renames and copies
should be fairly simple to implement. Modified renames and copies
might prove to be a little bit harder, so that would have to wait
until jgit can follow history across renames/copies.

There are some simple unit tests to check the basic functionality. I
also "blamed" SUBMITTING_PATCHES in the egit repo, and got the same
results as cgit. I am certain that there a some bugs lurking in the
code, but overall it looks quite promising.

I would like to hear your thoughts on a couple of topics:
 - Merge/patch/diff/blame functionality needs a diff implementation,
what are our options within technical and license constraints?
 - What is the roadmap for these features?
 - Can you see this blame effort getting integrated upstream?

I would love to contribute more effort to egit and the blame
functionality in particular. To me, "blame" is one of the killer
features of modern SCMs.

Last no least, kudos to the git and egit teams for their hard work on
making git such a great piece of software.
 - Manuel Woelker
