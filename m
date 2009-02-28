From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Changing the defaults for send-email / suppress-cc ?
Date: Sat, 28 Feb 2009 14:29:39 -0500
Message-ID: <7d1d9c250902281129t1ea0d9d0k796d97bdd0af046d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 20:31:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdUty-00020w-5l
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 20:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbZB1T3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 14:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752574AbZB1T3m
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 14:29:42 -0500
Received: from wf-out-1314.google.com ([209.85.200.172]:22288 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbZB1T3l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 14:29:41 -0500
Received: by wf-out-1314.google.com with SMTP id 28so1966207wfa.4
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 11:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=8QxkRFeAjgI6kjL+FOgy8dYvsTIP5C5r4qJAyOgJz8w=;
        b=I+1Yr0IAEHSLAI6bP+VhbCvaTd9IAdXrA0GsaN3OxgHO+nbOFPBKRM91HDPLkavrcj
         6ltkrFNKBkGxYyp/JsCN8J/B71V3cwbr4We76ANfJ3GPlqoDyyrKjfFOYag9O1lKmbvj
         1obrgU0mXrVC3hdIWUfu/jNbm0/wjKGpe1yLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=Slb7zalf5gk91i56ZUXdX6ot4daFez76Xo1O0l3xo8lx9k5NuHbnytLghop3BuFOa3
         utCGZH4oWJuodHAfg7DGq5H2A3UxhdUur/i6ntUfZ6mTvnxLcCh8B4/CfyXnlWGJsc6B
         mzNvuyy0ffo8AXydNlEDOoQOM1Z88ZTdVG5YM=
Received: by 10.143.163.12 with SMTP id q12mr2004777wfo.224.1235849379874; 
	Sat, 28 Feb 2009 11:29:39 -0800 (PST)
X-Google-Sender-Auth: 632222b005ac006e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111787>

I've been involved in helping people who are new git users, and the
one thing that seems to violate the principle of least surprise for
them is the default setting for the sendemail.suppresscc -- in that
the new users don't expect the additional CC lines to be automatically
added based on what is present in the content of the mbox
(format-patch output).

The messages from send-email that indicate it is going to add CC lines
based on SOB etc. come *after* the last input from the user, and so
they don't have an opportunity to jump in and prevent the extra
e-mails from going out to whoever happens to be listed in the patch.
(Lets assume for the moment, that they didn't see "--dry-run", or
simply figured the process looked fairly straightforward, and didn't
see the need for it.)

Here is the use case which I suspect is fairly pervasive, and that
I've already seen several times:

1) User is working on something involving kernel version X, which is
some amount behind the current mainstream HEAD.  (Okay, doesn't have
to be kernel, could even be git itself.)

2) They've created a branch off of X and they've added their own
commits, and also cherry picked relevant commits from upstream that
happened between X and HEAD into their branch.   One of the features
they've cherry picked onto their branch is a 25 patch series that has
"Signed-off-by: miserable@bofh.com" in it, a miserable person who
hates extra-emails.

3) They run "git format-patch -n --thread -o foo X..mybranch"

4) They run "git send-email --to coworker@mycompany.com foo"  so their
buddy within the company can have an mbox patchset.

5) They recoil in horror while smashing ^C as they try to stop
send-email from spamming miserable@bofh.com with 25 of his own
patches.

In light of this, I've simply advised new users to run something like:

git config --global sendemail.suppresscc all

...just so that they won't accidentally do what I've described in the above.

Apologies if this has been discussed before; I took a quick scan of my
archive and didn't see any discussions on it.  With the recent thread
about warning people of non-back compatible changes that will appear
post 1.6.2 -- I thought perhaps this was a good time to
mention/consider it.

I'm not sure what the right thing to do here is -- I suspect if you
made suppress-cc=all the default, then there would be more experienced
users that would complain about having to explicitly add a
suppress-cc=self to get the old behaviour?  Would that be acceptable?
I don't know...

Thanks,
Paul.
