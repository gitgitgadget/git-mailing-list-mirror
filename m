From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Workflow on git with 2 branch with specifc code
Date: Sat, 18 Jan 2014 14:30:50 +1100
Message-ID: <CAH3Anrq9XbkFj+K7FJ28XAwwYkc1UseDrCdjWCEJ+kJjFsKrUQ@mail.gmail.com>
References: <1389960868.21737.2.camel@pc14.intranet>
	<20140117230507.GD107228@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Gordon Freeman <freemanmtc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 18 04:31:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4MdR-0002IF-0z
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 04:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbaARDba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 22:31:30 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:44218 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592AbaARDax (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 22:30:53 -0500
Received: by mail-lb0-f173.google.com with SMTP id y6so3549364lbh.18
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 19:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=7RCOKkwevoXtuXW8SLkkOSGcJ81pBAMef56cd0VP4+8=;
        b=Ff+coaB7f18PPOgaMa+OqbGDyDBJfQOVEuV19lOEb7JikT47vs6dNzwOQELO22anbf
         RjhWxb2UC1PIBWnxwDMALOM3B6lSmafQjjaDKL2Kcn+U+HTp5iZAj6c5LcO3DzEDTQv0
         ygImtDgZY36KRuapUwuPOH6dFQRed53l0N0I9FRzRjUxfxqWXiAoJYAvPSNDgzmKXnch
         QeigtjT/CcEq2nBiNxT0XR6xzUv9429q1mvNP4VUbDMRpvuuvsbhOsi54LtlZkw7Q3Zj
         f1j0FTIaK454ToaEe1PGb1ptNPo4bJbpOYwa2a1Q7hgwUrqeAM+GBMMZqgJATD0cKydw
         ypHA==
X-Received: by 10.112.146.233 with SMTP id tf9mr2809550lbb.28.1390015850551;
 Fri, 17 Jan 2014 19:30:50 -0800 (PST)
Received: by 10.114.26.73 with HTTP; Fri, 17 Jan 2014 19:30:50 -0800 (PST)
In-Reply-To: <20140117230507.GD107228@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240643>

On Sat, Jan 18, 2014 at 10:05 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Fri, Jan 17, 2014 at 10:14:28AM -0200, Gordon Freeman wrote:
>> Hello guys, im Gordon.
>>
>> I have a question about workflow with git that i dont know if im doing
>> it right.
>> I have 1 repo with 2 branchs the first is the master of the project.
>> the second is a branch copy of the master but he need to have some
>> specifc code because is code for a client.
>> so, every time that i updade master i need to merge master with client
>> branch and it give me conflicts of course that will hapen.
>> Well if was just me who work on this 2 branchs it will be easy to fix
>> the conflicts and let all work and shine.
>> But whe have here, 10 people woking on master branch and some times code
>> are lost on merge and we need to look on commits to search whats goin
>> on.
>> What i just asking here is if its correct the workflow that i do. If for
>> some problem like this, the community have a standard resolution. Or if
>> what im doing here is all wrong.
>
> There are many correct workflows.  I personally use the workflow you've
> mentioned for the exact same reason (customizations for a client), but
> I'm the only developer on that repository.
>

I agree with Brian that there are many correct workflows and which one
you choose does depend on details of the branches you are trying to
manage.

Myself, I would tend to avoid a workflow in which you continually
merge from master into the client branch. The reason is that once you
have done this 20 times or so it will become quite difficult to
understand how and why the client branch diverged from the master
branch. Yes, it is in the history, but reasoning about diffs that
cross merge points is just hard.

Assuming that there is not much actual development on the client
branch, but rather a relatively small set of customizations to
configuration and things of that kind, then I would tend to maintain
the client changes as topic branch, then maintain a client integration
branch which represents the merge between master and the client topic
branch. Changes that represent divergence of the client from the
master branch would be committed to the client topic branch and then
merged into the client integration branch.  Refreshes from master
would be merged into the integration branch. Commits directly to the
integration branch would be avoided where possible.

Once master has diverged from client enough that there start to be
frequent conflicts when merging into the integration branch, then
consider rebasing the client topic branch onto the tip of master
branch and then repeat the cycle again. There is some risk of history
loss with this approach - a later release of the client branch may not
be a direct descendent of an earlier release of the client branch, but
even this problem can be solved with judicious use of merge -s ours
after you have successfully rebased the client topic branch. I can
expand on how you do this, if there is interest.

jon.
