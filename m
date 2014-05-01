From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Pull is Evil
Date: Thu, 01 May 2014 11:20:44 -0400
Message-ID: <5362664C.8040907@xiplink.com>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com> <xmqqoazlqot4.fsf@gitster.dls.corp.google.com> <536106EA.5090204@xiplink.com> <xmqqppjyhnom.fsf@gitster.dls.corp.google.com> <536152D3.5050107@xiplink.com> <5361598f8eaf7_4781124b2f02b@nysa.notmuch> <536173F5.7010905@xiplink.com> <53617877b41a9_41a872f308ef@nysa.notmuch> <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 17:20:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfsmd-0002o7-D5
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 17:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848AbaEAPUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 11:20:18 -0400
Received: from smtp130.ord.emailsrvr.com ([173.203.6.130]:42810 "EHLO
	smtp130.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbaEAPUR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 11:20:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp29.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 73A9D10830B;
	Thu,  1 May 2014 11:20:16 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp29.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 1E0221085FE;
	Thu,  1 May 2014 11:20:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247814>

On 14-05-01 05:46 AM, brian m. carlson wrote:
> On Wed, Apr 30, 2014 at 05:25:59PM -0500, Felipe Contreras wrote:
>> Marc Branchaud wrote:
>>> On 14-04-30 04:14 PM, Felipe Contreras wrote:
>>>> What is wrong when `git pull` merges a fast-forward?
>>>
>>> Nothing.  Everything.  It depends.
>>
>> It depends on what? I don't see how a fast-forward `git pull` could
>> possibly have any trouble.
>>
>>>> The problems with `git pull` come when you can't do a fast-forward merge, right?
>>>
>>> Some of them, maybe most of them.
>>
>> Name one problem with a fast-forward merge.
> 
> At work, we have a workflow where we merge topic branches as
> non-fast-forward, so that we have a record of the history (including who
> reviewed the code), but when we want to just update our local branches,
> we always want fast-forward:
> 
>   git checkout maintenance-branch
>   # Update our maintenance branch to the latest from the main repo.
>   git pull --ff-only
>   git pull --no-ff developer-remote topic-branch
>   git push main-repo HEAD

Thanks for the nice example.

To me this looks like an advanced use of "git pull".  A new user could be
taught to work like this, but I don't think a new user would come up with it
on their own (until they became an experienced user).

What's more, it seems to me that the only real advantage "git pull" provides
here is a less typing compared to the non-pull equivalent:

  git fetch main-repo
  git checkout main-repo/maintenance-branch
  git fetch developer-remote
  git merge --no-ff developer-remote/topic-branch
  git push main-repo HEAD

I suggest that this approach is superior for new users (despite the increased
risk of finger cramps), because if main-repo's maintenance-branch is updated
in the interim and the push fails, the user can use the exact same commands
to resolve the situation.

Sure, the non-pull approach makes use of Scary Branch Stuff (remotes and
namespaces and detached HEADs -- oh my!).  But trying to avoid that stuff is
precisely the slippery slope that led to pull's misguided gymnastics.  We've
gone down that slope, slipped and fallen over, and now we're wallowing in the
muck.

		M.
