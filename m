From: "Jacob Helwig" <jacob.helwig@gmail.com>
Subject: Re: How to clone git repository with git-svn meta-data included?
Date: Sun, 7 Dec 2008 00:43:32 -0800
Message-ID: <8c9a060812070043r472e10abu7a76152b5fe1314d@mail.gmail.com>
References: <493A6CEC.4060601@tuffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Grzegorz Kossakowski" <grek@tuffmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 07 09:45:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9FGr-0002CY-Qj
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 09:45:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbYLGInf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 03:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbYLGInf
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 03:43:35 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:10016 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbYLGIne (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 03:43:34 -0500
Received: by qw-out-2122.google.com with SMTP id 3so158155qwe.37
        for <git@vger.kernel.org>; Sun, 07 Dec 2008 00:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tXAsTC6yNfRVzBLsSoUDOkjxape+qsibGWGdJG+cgHg=;
        b=vInkGUyUXRVnEs0FU7YAnhdhA+TvWxoiEl9C0HtLg6lJOMZFlmxG21/QXPcp4CUm/k
         TnSfJ88QKVJtZ93pVAVHwT+w0jBVjm0Qk9+mK+HYg52syOUkpZeo2Wqv7xrY8f+DkMb4
         m8AYUU++4G/DSk0kWkAjDBn9Yb2hD5n+IFysM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=l2KvyWYIDoQSNtBS6zTvrJhH77b8Xce8qPM1y9azv3cp0S94fwkqS0iA3xtSkp0O44
         huPFBLgosgE4l/jsEGO6qNJvns9Awbt0961DJdBaUc+CCHE0DKZyDKOOCqTW9kDWg0Nf
         p3aAPZL7PzwYspVmrRKU47c7KRgXjI6kE8X9s=
Received: by 10.214.11.12 with SMTP id 12mr1403543qak.117.1228639412667;
        Sun, 07 Dec 2008 00:43:32 -0800 (PST)
Received: by 10.214.78.1 with HTTP; Sun, 7 Dec 2008 00:43:32 -0800 (PST)
In-Reply-To: <493A6CEC.4060601@tuffmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102491>

On Sat, Dec 6, 2008 at 04:15, Grzegorz Kossakowski <grek@tuffmail.com> wrote:
> Hello,
>
> Some folks at Apache are experimenting with Git and we are currently seeking for the git-svn
> integration that fits our needs and infrastructure.
>
> After some evaluation we decided that our setup could be described using following points:
>  a) our svn repository remains our main, official server where every committer is obligated to push
> their changes to at some time.
>  b) we set up clone of svn repository using git-svn. One of our members, Jukka Zitting, maintains
> such a service here[1]. Such repositories should be usable both for our committers (that have rights
> to push to svn) and our contributors that want to contribute random patches
>  c) we want carefully track who committed/contributed what
>
> Basically, a) implies b) and point b) looks little bit problematic right now.
> Jukka has set up his hosting using method described in his e-mail[2] which basically makes use of
> git svn. The major problem is that if one clones Jukka's repository then git svn information is not
> being cloned so committers have no means to push their changes to main, svn server.
>
> I've tried to play a little bit around with this issue and I tried to copy information from .git
> directory found on Jukka's server. This made me able to push my changes but git svn insisted on
> rebasing my repository using commits found in svn which is wrong. Basically we want such a setup
> that uses git repository (Jukka's clone) for pulling changes and local git svn for pushing changes.
> Git svn should never try to rebase local repository because this will lead to two different trees on
> two different machines so we won't be able to exchange and merge changesets.
>
> Is it possible with Git right now?
>
>
> Another point (c) which seems to be brought a couple of times but never a definitive answer has been
> given, AFAIK. Let's imagine we have committer C and two contributors A and B.
>
> A and B start to work on some feature and C agreed to help A and B and once their work is finished
> to merge their changes into his repository and eventually push them to main, svn repository. Now A
> and B work on implementation and from time to time their merge changes from each other. Once they
> are finished A asks C to merge their work into C's repository. Everything is fine provided we can
> trust both A and B.
>
> What if A was not fair and has rewritten a few commits coming from B so they contain malicious code?
> How we can detect something like that and how C be sure that what he merges is really work
> attributed by correct names?
>
> Thanks for your answers.
>
> [1] http://jukka.zitting.name/git/
> [2] http://markmail.org/message/fzzy7nepk7olx5fl
>
>
> --
> Best regards,
> Grzegorz Kossakowski
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Grzegorz,

I use git-svn quite a bit at $work, but I haven't seen a way to clone
a git repo, and have it Just Work(TM) with git-svn in the new clone,
unfortunately.

I have been able to use clone to significantly cut down on the setup
time for working with git-svn, however.  I was following the
directions at http://subtlegradient.com/articles/2008/04/22/cloning-a-git-svn-clone
 (Clone the git-svn clone, then re-do the git svn init, and fetch to
re-sync.)

Not sure how much this will actually help you with the first part of
your problem.

-Jacob
