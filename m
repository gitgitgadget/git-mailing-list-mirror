From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Pull is Evil (was: Re: A failing attempt to use Git in a centralized
 environment)
Date: Wed, 30 Apr 2014 10:21:30 -0400
Message-ID: <536106EA.5090204@xiplink.com>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com> <xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 16:26:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfVTB-0006lC-H7
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 16:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759087AbaD3O0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 10:26:41 -0400
Received: from smtp146.ord.emailsrvr.com ([173.203.6.146]:52450 "EHLO
	smtp146.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759070AbaD3O0l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 10:26:41 -0400
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Apr 2014 10:26:40 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp11.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id EC77AF06E8;
	Wed, 30 Apr 2014 10:21:04 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp11.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id A12B4F0119;
	Wed, 30 Apr 2014 10:21:04 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247716>

On 14-04-28 02:41 PM, Junio C Hamano wrote:
> Marat Radchenko <marat@slonopotamus.org> writes:
> 
>> Problem #1: TortoiseGit GUI windows for common tasks have a heck
>> lots of controls that a common Git user will never need.
> 
> Do people around TortoiseGit lurk on this list?  Otherwise this may
> not be something we can help you with here.
> 
>> Problem #2 occured the first day we started using Git on real
>> project. It is explained in detail in older post to Git ML [3]. I
>> call it "swapped/reverse merge problem".
>>
>> In short:
>> 1. Hack, hack, hack
>> 2. Commit
>> 3. Push, woops, reject (non-ff)
>> 4. Pull
>> 5. Push
>>
>> The root of evil is step #4 that creates a merge commit with
>> "swapped" parents.
> 
> Yes, this is a real issue, and I do not mind seeing a patch to
> improve the situation (there may be different approaches, and one
> random approach somebody takes may not necessarily be a good way to
> improve the situation though).
> 
>  - Perhaps by allowing an option to tell the "pull" at the fourth
>    step to record swapped parents in the merge?
> 
>  - Perhaps in step #3, stop suggesting to "pull first" and instead
>    tell them to "fetch upstream, rebase your work on it and then
>    push"?

This approach would be my preference.

But I'm definitely biased because I think pull is pretty much broken:

* New users are encouraged to use pull, but all too often the default
fetch-then-merge behaviour doesn't match their expectations and they end up
starting threads like this one on the mailing list.

* If we change pull's default behaviour, we'll just be shifting the
mismatched expectations onto the other half of the new users who would be
happy with fetch-then-merge.

* I'm not sure why new users are taught to use pull.  I suspect it's because
it tries to hide the idea of local-vs-remote branches, and people writing git
tutorials don't want to overwhelm new users with what seems to be an internal
detail.  But these notions are really fundamental to using git effectively,
and I think pull does everyone a disservice by trying to gloss them over.

Anyway, rather than ranting on I'll just suggest that there's not enough
commonality between the ways people use git to make it worthwhile trying to
teach pull how to deal with a significant number of them.  I think the pull
command should be deprecated and quietly retired as a failed experiment.

		M.
