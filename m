From: "Lars Hjemli" <lh@elementstorage.no>
Subject: Re: Terminology question about remote branches.
Date: Sat, 4 Aug 2007 15:07:01 +0200
Message-ID: <8c5c35580708040607ya186edcg89fbc90587b64d68@mail.gmail.com>
References: <854pjfin68.fsf@lola.goethe.zz>
	 <20070804120243.GB9716@coredump.intra.peff.net>
	 <85tzrfh3yg.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 15:07:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHJLZ-0007gJ-0P
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 15:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756455AbXHDNHF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 09:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756725AbXHDNHF
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 09:07:05 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:42764 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756421AbXHDNHC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 09:07:02 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1162525wah
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 06:07:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=FUlEzmqCVdz2aNXU0+8+ax1DoFrdf5Yo11mCQkOmIHS/HMdATDfT7jeVUXjzVECwTnd+ygCmeYBZFHlMrxTL4pw7jEFPvcakdap/VmhJmh91hqh7EzDCEieBpcJJmvejDkO7He48id8RNYFXKUROkvgi8HFw3PGgxy7HL9Zv4ws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=tEH+SJJ7Gs3uWuY6hkJ91jISPsQcmC5KvefDxVmsVvLSADTIzADow97LOEbCRZEUHhTuFcj79BWQeES00QFyXQApWSNpCtYRHtJdOljfFeNBNZkaHaRELN6hullgX+mEJEp7BzgII3fCWk9UhMsmTUXi7rnAPfNHPUs0HRSfn2U=
Received: by 10.114.24.1 with SMTP id 1mr3913644wax.1186232821906;
        Sat, 04 Aug 2007 06:07:01 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sat, 4 Aug 2007 06:07:01 -0700 (PDT)
In-Reply-To: <85tzrfh3yg.fsf@lola.goethe.zz>
Content-Disposition: inline
X-Google-Sender-Auth: cb5dbfc2386ce154
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54842>

On 8/4/07, David Kastrup <dak@gnu.org> wrote:
> Now I think that I basically have no chance figuring this out on my
> own sufficiently well to be able to improve the documentation.

Remote-tracking branch:
  A local copy of a branch in another repository. This kind of branch
  cannot be updated by 'git-commit' but only by 'git-fetch' (hence
  indirectly by 'git-pull' and 'git-remote update'). If you try to
  'git-checkout' a remote-tracking branch, you will get a detached HEAD.

Local branch:
  A branch to which you may commit changes. Optionally, the branch can be
  configured to "follow" one of your remote-tracking branches. This means
  that a 'git-pull' without arguments (when your local branch is checked
  out), will automatically 'git-fetch' and then 'git-merge' the remote-
  tracking branch.

Example:

Your local branch 'master' is setup to "follow" 'refs/remotes/origin/master'.
So if you do this:

$ git checkout master
$ git pull

Then the 'git pull'-command will do this:

$ git fetch -f origin master:remotes/origin/master
$ git merge remotes/origin/master


The magic setup that makes this happen is the following lines in .git/config:

[remote "origin"]
        url = git://git.kernel.org/pub/scm/git/git.git
        fetch = +refs/heads/*:refs/remotes/origin/*

[branch "master"]
        remote = origin
        merge = refs/heads/master


Was this helpful?

-- 
larsh
