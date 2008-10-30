From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: Using the --track option when creating a branch
Date: Thu, 30 Oct 2008 13:41:26 +0100
Message-ID: <adf1fd3d0810300541l7fb8b64nf9587fec4e481c58@mail.gmail.com>
References: <18696.32778.842933.486171@lisa.zopyra.com>
	 <1225343538.10803.9.camel@maia.lan>
	 <18697.41702.241183.408377@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Sam Vilain" <sam@vilain.net>, git@vger.kernel.org
To: "Bill Lear" <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 13:43:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvWrL-0003aS-7U
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 13:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbYJ3Ml3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 08:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753024AbYJ3Ml3
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 08:41:29 -0400
Received: from ik-out-1112.google.com ([66.249.90.178]:38700 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbYJ3Ml2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 08:41:28 -0400
Received: by ik-out-1112.google.com with SMTP id c29so430598ika.5
        for <git@vger.kernel.org>; Thu, 30 Oct 2008 05:41:26 -0700 (PDT)
Received: by 10.103.121.19 with SMTP id y19mr4849767mum.30.1225370486086;
        Thu, 30 Oct 2008 05:41:26 -0700 (PDT)
Received: by 10.103.131.8 with HTTP; Thu, 30 Oct 2008 05:41:26 -0700 (PDT)
In-Reply-To: <18697.41702.241183.408377@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99465>

On Thu, Oct 30, 2008 at 1:04 PM, Bill Lear <rael@zopyra.com> wrote:
> On Wednesday, October 29, 2008 at 22:12:18 (-0700) Sam Vilain writes:
>>On Wed, 2008-10-29 at 09:23 -0600, Bill Lear wrote:
>>> We use git in a way that makes it desirable for us to only push/pull
>>> to the same remote branch.  So, if I'm in branch X, I want 'git push'
>>> to push to origin/X, and 'git pull' to fetch into origin/X and then
>>> merge into X from origin/X.
>>>
>>> In other words, we want git push/pull to behave in branches other than
>>> master the same way it does when in master.
>>>
>>> I have discovered the '--track' option when creating a local branch,
>>> and this appears to me to be the thing that gives us the desired
>>> behavior.
>>
>>As things currently stand this is not achievable behaviour.  The
>>behaviour of 'git push' is to push all matching refs.  If you are lucky
>>this is what you intended, but it also pushes any changes to *other*
>>branches that you have made.
>>
>>I have tabled a change proposal to make it work as you suggest in a
>>separate thread.
>
> Ok, now I'm confused.  The ONLY thing I want to prevent is the
> "crossing of streams" issue.  If I am on branch X and issue 'git
> push', I want X, and ONLY X, to be pushed to the remote repository's X
> branch --- I don't care if other branches are pushed to their
> respective remote branches, as long as they don't get merged to X.

No branches will get merged in a push.

>
> So, are you saying that Santi was incorrect, and that in fact
> the push will result in a merge of the branches?

Sorry, I was (partly) incorrect because I was only talking about pull.
For push you can add a "push = HEAD" config to the remote and then the
"git push" will only push the current branch (with the corresponding
matching remote branch).

$ git config remote.origin.push HEAD

Strictly speaking when you push (with the default config or with the
above trick) you push matching branches (it doesn't matter what is the
branch.<remote>.merge). Currently there is no way to say "push to the
corresponding tracking branch"

Still I think this will work as you want (as long as your local and
remote branch have the same name):

$ git clone $url
$ cd path
$ git config remote.origin.push HEAD
$ git checkout -b branch origin/branch
$ work, commit,...
$ git push

HTH,
Santi
