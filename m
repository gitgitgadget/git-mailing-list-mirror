From: Richard Weinberger <richard@nod.at>
Subject: Re: git ate my home directory :-(
Date: Tue, 26 Mar 2013 18:06:17 +0100
Message-ID: <5151D589.2000002@nod.at>
References: <5150C3EC.6010608@nod.at> <20130325214343.GF1414@google.com> <7vboa7w2vm.fsf@alter.siamese.dyndns.org> <384BCFE976364F1EA6E56306566D003A@PhilipOakley> <51519DA0.4090201@nod.at> <20130326145637.GA3822@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 26 18:07:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKXKt-0003K5-Ul
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 18:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529Ab3CZRGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 13:06:31 -0400
Received: from a.ns.miles-group.at ([95.130.255.143]:47834 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752268Ab3CZRGa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 13:06:30 -0400
Received: (qmail 12197 invoked by uid 89); 26 Mar 2013 17:06:29 -0000
Received: by simscan 1.3.1 ppid: 12188, pid: 12193, t: 0.0742s
         scanners: attach: 1.3.1 clamav: 0.96.5/m:
Received: from unknown (HELO ?192.168.0.19?) (richard@nod.at@212.186.22.124)
  by radon.swed.at with ESMTPA; 26 Mar 2013 17:06:29 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <20130326145637.GA3822@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219171>

Am 26.03.2013 15:56, schrieb Jeff King:
> On Tue, Mar 26, 2013 at 02:07:44PM +0100, Richard Weinberger wrote:
>
>>> Should this important warning be part of the git(1) documentation on
>>> the environment variables (and possibly other places) given the
>>> consequences of this case? It wasn't something
>>> I'd appreciated from a simple reading.
>>
>> BTW: Can't we change git-clean such that it will not delete any files
>> if GIT_DIR is set and GIT_WORK_TREE is "."?s
>
> We could, but that would break the existing behavior for other people
> (and I assume you mean "when GIT_WORK_TREE is not set at all", as I
> would think GIT_WORK_TREE=. is explicit enough).

Is there a valid use case to call git-clean with GIT_DIR set but GIT_WORK_TREE
not (or to ."")?
It will delete "." ;)

> I am sympathetic to your data loss, but I wonder how common a problem it
> is in practice. Git-clean already does a dry-run by default; you have to
> give it `-f`. This is the first such report we've had. This seems more
> akin to "oops, I accidentally ran `rm -rf` in the wrong directory". Yes,
> it's catastrophic, but at some point you have to accept that deleting
> files is what rm (and git-clean) does; you can only put so many safety
> hoops in place.

The data loss was not too bad. I was able to restore anything within 2 hours.
But was kinda shocked that git-clean deletes files outside my git tree.
I'm aware of -d. But in my case it happened within a fully automated script.
I simply thought GIT_DIR=.. git-clean -f -d does the right thing...

> I don't know. It's an uncommon enough case that we could deprecate
> "GIT_WORK_TREE is implicitly `.`" entirely, but I think it would need a
> deprecation period, and a way to get the same behavior (e.g., allowing
> "GIT_WORK_TREE=.").

Yeah, this sounds sane.

Thanks,
//richard

P.s: I've told this story to some friends and co-workers which use git like me very day.
All of them were shocked about the behavior of git-clean and GIT_DIR.
