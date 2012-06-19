From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] Try harder to find a remote when on a detached HEAD or
 non-tracking branch.
Date: Tue, 19 Jun 2012 10:07:19 -0400
Message-ID: <4FE08797.50509@xiplink.com>
References: <1340038866-24552-1-git-send-email-marcnarc@xiplink.com> <7vaa004j9f.fsf@alter.siamese.dyndns.org> <4FDFA030.7080408@xiplink.com> <7vmx402rru.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 16:07:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgz5Y-0006xC-3C
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 16:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681Ab2FSOHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 10:07:19 -0400
Received: from smtp138.ord.emailsrvr.com ([173.203.6.138]:34099 "EHLO
	smtp138.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060Ab2FSOHS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 10:07:18 -0400
X-Greylist: delayed 59237 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2012 10:07:18 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp22.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id A0A212000B5;
	Tue, 19 Jun 2012 10:07:17 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp22.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 5A83F2000E0;
	Tue, 19 Jun 2012 10:07:17 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <7vmx402rru.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200201>

On 12-06-18 06:12 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> On 12-06-18 01:33 PM, Junio C Hamano wrote:
>>> marcnarc@xiplink.com writes:
>>>
>>>> From: Marc Branchaud <marcnarc@xiplink.com>
>>>>
>>>> get_default_remote() tries to use the checked-out branch's 'remote' config
>>>> value to figure out the remote's name.  This fails if there is no currently
>>>> checked-out branch (i.e. HEAD is detached) or if the checked-out branch
>>>> doesn't track a remote.  In these cases and the function would just fall
>>>> back to "origin".
>>>>
>>>> Instead, let's use the first remote listed in the configuration, and fall
>>>> back to "origin" only if we don't find any configured remotes.
>>>
>>> I admit that I wouldn't do anything that relies on any remote to be
>>> used while on detached head myself, so in that sense I am a biased
>>> audience, but guessing (or not guessing and blindly assuming
>>> 'origin') feels wrong, and trying even harder to come up with an
>>> even wilder guess feels even more wrong.
>>
>> OK, but what would be right?  AFAIK git doesn't have any real way of
>> designating an official default remote.
> 
> Correct, and that is why I tend to think "right" is to error out.

Erroring out seems like a step backwards to me.  Things already work just
fine when the remote the user wants is called "origin".

I suppose you could say that I'm arguing for a better default remote than
"origin".

>> That would be bad for our situation.  As I said, our automated build system
>> uses detached HEADs a lot.  Erroring-out in this case would break us.  It's
>> really only the near-ubiquity of the name "origin" that has kept things
>> working so far.
> 
> That reliance of "origin" is what made me think that "not guessing
> and blindly assuming" a wrong thing to do.

I think git can do better than erroring out, though.

> It is OK that your build usesdetached HEAD, but if that is the case
> shoudln't it be the one deciding which specific remote it wants to
> take the updated sources from, and telling Git to do so?

Sure, but I feel it did that already when it cloned.  It seems reasonable for
the submodules to default to using the remote specified when the super-repo
was cloned.

		M.
