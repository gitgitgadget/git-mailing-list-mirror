From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Mon, 30 Apr 2012 18:55:11 -0700
Message-ID: <4F9F427F.7000100@palm.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com> <7vr4v4d6um.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 03:55:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP2JF-00038n-7L
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 03:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466Ab2EABzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 21:55:15 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:6901 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234Ab2EABzN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 21:55:13 -0400
X-IronPort-AV: E=Sophos;i="4.75,508,1330934400"; 
   d="scan'208";a="13229885"
Received: from unknown (HELO ushqusdns4.palm.com) ([148.92.223.164])
  by smtp-relay2.palm.com with ESMTP; 30 Apr 2012 18:55:13 -0700
Received: from fuji.noir.com ([10.100.2.13])
	by ushqusdns4.palm.com (8.14.4/8.14.4) with ESMTP id q411tBuL018377;
	Mon, 30 Apr 2012 18:55:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <7vr4v4d6um.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196645>

On 4/30/12 18:32 , Junio C Hamano wrote:
> Rich Pixley<rich.pixley@palm.com>  writes:
>
>>> Git tracks your version of master separately from each other remote's
>>> master.  This is exactly dual/multiple heads.
>>
>> No, it isn't at all.
>>
>> Multiple heads are the idea that a single commit can "branch" in the
>> repository and that both commits can be HEADS of the same branch at
>> once in a single repository.  This allows a potential collision to
>> exist in the repository and to be pushed and pulled through multiple
>> repositories.
>
> I think your "not at all" thinking is a bit tainted by your knowing very
> well how Hg does things,

Actually, I came up with the same design back in the early 90's when I 
was working on CVS.  I think the hg way of doing things is pretty 
obvious once we think about it.  You can't expect users to do manual 
merges on a remote server.  So the only thing you can reasonably do is 
collect and propagate the collision with enough info that a human being 
can put it back together later.  Refusing the commit doesn't seem 
reasonable to me.

The old approach from clearcase multisite where every repository owns 
it's own unique branch, which shows up as a read-only branch in the 
other repositories, is a nuisance because you have to constantly keep 
merging or your geographic partitions drift.  It's difficult enough to 
keep disparate groups working in concert.  Forcing them to do big merges 
in batch frequently doesn't help.  That's essentially what we're reduced 
to with git.

The illusion that we're all working on the same branch, (mercurial, 
monotone, etc), defaults to more frequent merges, and a much smaller 
change tree when it comes to visualization.

> but I do not think there is much fundamental
> difference between what we do.  Git just tends to be a bit more explicit
> and encourages users to be also be more explicit.
>
> When you integrate from the other side (say, "origin") by pulling, instead
> of splitting the 'master' branch into two (i.e. ours and origin's), we
> store what came from the origin in remotes/origin/master and let the user
> merge it into his heads/master.  Essentially, the same name 'master' is
> split into two, between remotes/origin/ and heads/ namespace.  We are just
> more explicitly about the split.

I wouldn't call it explicit.  That level of detail provides no features. 
  It's tedious extra work that could have been tracked and managed 
automatically.  The fact that it isn't tracked and managed automatically 
prevents simple repository chaining of the sort I originally set out to 
accomplish.

> Similarly, when pushing, you could follow the same model by pushing your
> change into remotes/pixley/master, instead of pushing directly to the
> "master" branch, i.e. heads/master, and then merge the former to the
> latter after push succeeds.

That presupposes that I own both repositories rather than working in a 
cooperative environment.

> Needless to say, you do not have to limit the splitting just to two.
> Since everything is named, you can tell where each 'master' came from by
> looking at the namespace (obviously this requires people to establish and
> follow the naming convention).

Right.  This is the sort of thing people write source code control 
systems to manage.  :).

--rich
