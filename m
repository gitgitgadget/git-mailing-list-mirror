From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] submodule add: improve message when resolving a relative
 url fails
Date: Fri, 29 Jul 2011 16:10:04 -0400
Message-ID: <4E33139C.5000209@xiplink.com>
References: <1306792280-12768-1-git-send-email-marcnarc@xiplink.com> <4DE541EC.7010202@web.de> <4DE548C4.2010600@web.de> <4DE5561C.3010200@xiplink.com> <4DE565DF.7050207@cisco.com> <4DE660E2.9080500@xiplink.com> <4E306065.2010002@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Fri Jul 29 22:10:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmtO4-0001jG-Ns
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 22:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791Ab1G2UKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 16:10:08 -0400
Received: from smtp202.iad.emailsrvr.com ([207.97.245.202]:58061 "EHLO
	smtp202.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763Ab1G2UKH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 16:10:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp50.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 2ACE5370A11;
	Fri, 29 Jul 2011 16:10:05 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp50.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id CE7123708F3;
	Fri, 29 Jul 2011 16:10:04 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
In-Reply-To: <4E306065.2010002@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178164>

On 11-07-27 03:00 PM, Phil Hord wrote:
> On 06/01/2011 11:55 AM, Marc Branchaud wrote:
>> On 11-05-31 06:04 PM, Phil Hord wrote:
>>> On 05/31/2011 04:57 PM, Marc Branchaud wrote:
>>>>  - The current code rewrites the URL so that any relative path is either
>>>>    rejected or munged into an absolute remote URL.
>>> I don't see the URL getting munged away from being relative.  Can you
>>> point to an example?
>> I reached this conclusion because if I go into my clone of git.git and do
>>
>> 	git submodule add ../MyThing
>>
>> where ../MyThing is a regular git repo, I get
>>
>> Cloning into MyThing...
>> fatal: The remote end hung up unexpectedly
>> Clone of 'git://git.kernel.org/pub/scm/git/MyThing' into submodule path
>> 'MyThing' failed
>>
>> So it seemed the relative URL became an absolute URL.
>>
>> Looking more closely at a working example, I can see that (as you show below)
>> the URL in the super-repo's .gitmodules file retains the relative path, but
>> the submodule's remote.origin.url is an absolute path.
>>
>> In any case, "submodule add" isn't doing what I expected: make my local
>> MyThing repo a submodule of my git.git clone.
> 
> I thought I understood this workflow better than I actually did.  I
> think I understand more now, and I'm somewhat disappointed.  But I also
> failed to pick up the ball on this old discussion.
> 
> If you do this, I think it will work like you were hoping:
> 
>     :: ( mkdir MyThing && cd MyThing && git init )
>     Initialized empty Git repository in /opc/git/MyThing/.git/
>     :: git submodule add ../MyThing
>     Adding existing repo at 'MyThing' to the index

I see how that works, but I don't find that intuitive at all.  For one,
../MyThing doesn't even exist, neither locally or on the origin repo.  It's
really ./MyThing (with one dot).  The last idea that I'd come up with for
adding ./MyThing as a submodule would be to use ../MyThing.

What git does in this case actually looks like a bug to me.  I'd expect "git
submodule add ../MyThing" to fail if there's no local ../MyThing and no
remote ../MyThing.

> Furthermore, the relative path only works for URLs.  It does not work
> for local filesystems.

Well, sort of.  From the current man page: "If the superproject doesn't have
an origin configured the superproject is its own authoritative upstream and
the current working directory is used instead."

I submitted two patches to clarify the documentation on that point:

	http://article.gmane.org/gmane.comp.version-control.git/175163
	http://article.gmane.org/gmane.comp.version-control.git/175162

They seemed to have been lost in the shuffle, though.

		M.
