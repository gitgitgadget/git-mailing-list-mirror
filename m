From: Troy Telford <ttelford.groups@gmail.com>
Subject: Branch Names and tracking branches
Date: Wed, 26 May 2010 14:39:17 -0600
Message-ID: <201005261439.17442.ttelford.groups@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 22:39:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHNO4-0001m2-8W
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 22:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289Ab0EZUja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 16:39:30 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:49645 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab0EZUja (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 16:39:30 -0400
Received: by ewy8 with SMTP id 8so252191ewy.28
        for <git@vger.kernel.org>; Wed, 26 May 2010 13:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=c6fpJ/Oa8a1H+s754W86rfLcgb2n0fhwGUkOVBazBB8=;
        b=kmC6MiaKfN29NPYOyiiT9JHlxgdPzB18yuiu1Vu84rd+zvXSk5o1x7BOxIRxawza7i
         LmvtTxPhuHH+efHxiJRa3teyRfB5ad1g3Y4DmFBq7k9ZiQC/vR0C9Toer/yyT2dm9/Kn
         wi/tAeVYZUXMPV9UEn1MgJIJGyVBwj1ejiIjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id;
        b=swcik62kBTI1kBGHL3pZEU6tlPqzXDGVgRFTxaV5hvqLNI7ArIPY+RfMd3BRpT6JbX
         eORSBrFY1abBSKUBpGLswFuBNVkdi+QDolub152GH9NWe75bZzymCw416/i6MXJqjzCE
         YrMFbYgwKfRDXbuSEaMnZtdSxvXxWepvfIxk8=
Received: by 10.213.29.200 with SMTP id r8mr1496867ebc.83.1274906368438;
        Wed, 26 May 2010 13:39:28 -0700 (PDT)
Received: from rigel.localnet (cfcafwp.sgi.com [192.48.179.6])
        by mx.google.com with ESMTPS id 13sm242768ewy.9.2010.05.26.13.39.26
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 26 May 2010 13:39:27 -0700 (PDT)
User-Agent: KMail/1.13.3 (Linux/2.6.32-22-generic; KDE/4.4.3; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147822>

I've got a situation where I'm trying to integrate git into another tool, so 
that when you make a commit into a git branch, a post-receive hook will then 
push the code changes into the other tool when the user pushes their changes 
into the repository.

The problem:  The other tool uses colons in the name.  So, I looked at 'man 
git-check-ref-format', and found that the colon can't be used.

So, I looked for a substitute character that isn't likely to be used anyway -- 
semicolon seemed to be a good choice.

As I decided to use a semicolon, a conversion as needed in the post hook.  It 
works fine with the git branch names along the lines of sna;foo;bar.

But using a branch name of "sna;foo;bar" is not entirely great, as the 
semicolon has to be escaped on the command line when referencing the branch 
name.

So, I decided to use a tracking branch:
 git branch --track branch "refs/origin/sna;foo;bar"

Again, it checks out okay, and it is able to pull in changes fine.  However, 
changes can't be pushed into the remote repository at all; 'git push' simply 
returns "Everything up-to-date," even when changes are made.

This differs from the behavior I've seen in the past for tracking branches - 
I'm used to (and was expecting) the git push to push the changes into the 
remote's "refs/heads/sna;foo;bar" branch.

Using another character is, of course, an option; but the semicolon isn't 
explicitly forbidden and it works for everything I've used but 'git push'.

So am I just doing something wrong, or have I found a bug or documentation 
issue?
