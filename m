From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: git to p4 conversion
Date: Fri, 4 Feb 2011 10:25:18 +0100
Message-ID: <AANLkTikfGapDfZtD9H10797Ted_Av78WD8M7XrACOCpW@mail.gmail.com>
References: <AANLkTi=0TSD6p7WtsVzx=pq8=GVu+jHUdxt1bnC++CT+@mail.gmail.com>
	<4D4AF29E.7070509@vmware.com>
	<AANLkTikW_sU8oCmU9wN5q1OPPJrQbS2YZAvS0C_nBQbD@mail.gmail.com>
	<loom.20110204T004658-497@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Endre Czirbesz <endre@czirbesz.hu>,
	Ian Wienand <ianw@vmware.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 04 10:25:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlHuw-0008Pc-Kh
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 10:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774Ab1BDJZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 04:25:21 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:36229 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547Ab1BDJZT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 04:25:19 -0500
Received: by yib18 with SMTP id 18so846873yib.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 01:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ff6OOXVYdd77j0SX5ZvJmsbkC7yFsSL3z6enosNlYtQ=;
        b=FJaeMpsxhXxVr8lRqbH82k5aTc/q6tSbncx76ELa/vfZsej1UTIPMWGArBoLM9AqF2
         GzAQYGt9Y/qJT/pMAYCpQs+ljAQ9FY+slMuqPhqQdvQgw3o576XWbJeYf4ogEu+frl/u
         I6bP6/rA4rhgAVu4l83zKAT4AWn5647miwi/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=trdWSVpjQ6Oy6UCL9ESPVRXGFQnNcr8zsQBQty2amrh/Lv9HtR1VhgBbRqp3S3U4DZ
         vyDlYKx/BSnDsVsBgJrKzbP+CvNDv8EdpcFP12Df7DuTtOwph/UH4wGJWAbxnPZKYUFh
         2/S9bMo8bu4bzF7GCqa9gU7QTsL/DfnPHeysU=
Received: by 10.100.165.20 with SMTP id n20mr7317304ane.114.1296811518207;
 Fri, 04 Feb 2011 01:25:18 -0800 (PST)
Received: by 10.101.1.19 with HTTP; Fri, 4 Feb 2011 01:25:18 -0800 (PST)
In-Reply-To: <loom.20110204T004658-497@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166029>

[on this mailing list, please don't cull the CC list]

On Fri, Feb 4, 2011 at 1:03 AM, Vitor Antunes <vitor.hda@gmail.com> wrote:
> Hi Endre,
>
<snip>
> I think what you should do is add the git repository as a remote with something
> like:
>
> git remote add remotename myprojectrepo
> git pull remotename master
> git p4 submit

That's not what I would do... When I try this, the 'git pull ...'
creates a merge, which I don't want to do when using git-p4.

But I think we're close to something that would work ok:

Endre, you should start like you already have; by git-p4 cloning your
project from perforce. (You maybe want to have a dummy file checked in
to your <projectdir> in perforce, so that the 'git-p4 clone' command
produces at least one commit in your git repo)...

Then, do 'git remote add tempremote <path-to-your-existing-git-repo>'
like Vitor suggests.

At this point I would do:

$ git checkout -b tempbranch tempremote/master
$ git rebase master
$ git-p4 submit

So, the 'git rebase master' should be like applying each of your
existing git commits *on-top-of* the git-p4 branch that you already
have. And that is the key to git-p4 knowing what to push to the
perforce server.

Thus, if I wanted to get all my existing git history into perforce,
this is how I would do it.

    -- Tor Arvid
