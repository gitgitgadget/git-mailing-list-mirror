From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: Re: [PATCH] Add the commit.gpgsign option to sign all commits
Date: Tue, 5 Nov 2013 12:28:40 +0100
Message-ID: <20131105112840.GZ4589@mars-attacks.org>
References: <1383606881-2979-1-git-send-email-boklm@mars-attacks.org>
 <xmqqppqfag2e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 05 12:28:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdeoS-0000BI-4h
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 12:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932Ab3KEL2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Nov 2013 06:28:44 -0500
Received: from mx0.mars-attacks.org ([92.243.25.60]:45964 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412Ab3KEL2n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Nov 2013 06:28:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id 2B69F4E73;
	Tue,  5 Nov 2013 12:28:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id mDeE6Z-aWyOS; Tue,  5 Nov 2013 12:28:57 +0100 (CET)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 8FBD54E5A;
	Tue,  5 Nov 2013 12:28:57 +0100 (CET)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id CB7CD43934; Tue,  5 Nov 2013 12:28:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqppqfag2e.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237328>

On Mon, 04 Nov 2013, Junio C Hamano wrote:

> Nicolas Vigier <boklm@mars-attacks.org> writes:
> 
> > If you want to GPG sign all your commits, you have to add the -S option
> > all the time. The commit.gpgsign config option allows to sign all
> > commits automatically.
> 
> I'm somewhat horrified to imagine the end-user experience this
> "feature" adds to the system; if one sets htis configuration and
> then runs "git rebase" or anything that internally creates or
> recreates commits, does one have to sign each and every commit, even
> if such a rebase was done merely as a trial run to see if a topic
> can be rebased to an older codebase, or something?

If the problem is users having to type their passphrase to sign each
commit, we can suggest using an agent in the option description :

  commit.gpgsign::
	A boolean to specify whether all commits should be GPG signed.
	Use of this option when doing operations such as rebase can
	result in a large number of commits being signed. It is therefore
	convenient to use an agent to avoid typing your gpg passphrase
	several times.


An example of why someone might want to use this option is :

You use git to store deployement scripts for some servers. Those
servers have a cron job that pull from the git repository and run the
scripts as root. Anyone with root access on the server hosting the git
repository can then gain root access to all your servers quite easily.
You want to avoid this, so you decide that all commits should be gpg
signed, and your servers will now do "git pull --verify-signatures".
People who work on this repository will want to set "commit.gpgsign"
so they don't have to add the -S option all the time.
