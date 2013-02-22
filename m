From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] add: allow users to silence Git 2.0 warnings about "add -u"
Date: Thu, 21 Feb 2013 23:12:42 -0800
Message-ID: <CAJDDKr4dCJ3p9QBGr09kW4_0BsVJcpE7s83=eNxKE15pMznWCw@mail.gmail.com>
References: <1361513224-34550-1-git-send-email-davvid@gmail.com>
	<7vtxp4sw8e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 08:13:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8moj-0004pu-7E
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 08:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882Ab3BVHMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 02:12:47 -0500
Received: from mail-wg0-f43.google.com ([74.125.82.43]:65324 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282Ab3BVHMn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 02:12:43 -0500
Received: by mail-wg0-f43.google.com with SMTP id e12so253066wge.34
        for <git@vger.kernel.org>; Thu, 21 Feb 2013 23:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=8LrqVyh3ZpTXLXPaAGzb+8jKw4N/wUqKw5Y4vnVbP38=;
        b=HRH7OA0hebjRl1wTLEXK+z0iS/PtsBdsLvxXa+GaJjzivjkkoSj/nx1YYzs9HeORUp
         1xiQ7yQDBq2+Qnh/XhjrdPZuAbkEcAXJB6JpuQS9qhEFSov7V2tDRiRtJTbGBxEYO80P
         HFdh8G/qVmN85a7040O0I0r+B4lquWYW1cNswBn151D+8Ggju7gJf9WB/ZmECvFmuBAU
         zZmXHQ39jkmjtlM3kPpk5zsXaUOnXYgsciJbuOVHmlm7QWc+/XujoUSULbzYAMYVI3C7
         l6a9MpQlOiC+8pBsi23+aO1txHaIP5liLwTYfZF5Gg8kBRFvApFcOC+9Fz0x+3KlzZR+
         jxwA==
X-Received: by 10.194.122.131 with SMTP id ls3mr1217149wjb.55.1361517162326;
 Thu, 21 Feb 2013 23:12:42 -0800 (PST)
Received: by 10.194.13.129 with HTTP; Thu, 21 Feb 2013 23:12:42 -0800 (PST)
In-Reply-To: <7vtxp4sw8e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216820>

On Thu, Feb 21, 2013 at 10:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> When "git add -u" is invoked from a subdirectory it prints a
>> loud warning message about an upcoming Git 2.0 behavior change.
>> Some users do not care to be warned.  Accomodate them.
>
> I do not think this is what we discussed to do.
>
> It was very much deliberate to make the way to "squelch the warning"
> not a "set once and *forget*", aka configuration variable, but a
> simple-to-type extra command line argument i.e. "git add -u .", that
> you will *always* type to train your fingers to explicitly say what
> you mean, so that the default switch will not matter to existing
> users.

In my use case:

- The user is always in a subdir; the behavior change
is immaterial to them.

- The user does not care about these details,
and is not harmed by using the short and sweet command.

Please enlighten me.
Are we really getting rid of it and replacing it with ":/"?
That syntax looks like a meh face.. just sayin'

I was actually surprised when "add -u" didn't do the whole tree
and am happy that 2.0 will make it do the right thing...

(and perhaps I am deluded, and am not aware of what 2.0 will
do when not given pathspecs.. is it really going to die()?
that's so mean! ;)

Sorry if I am missing most of the context.
I was reading this in builtin/add.c:

	/*
	 * To be consistent with "git add -p" and most Git
	 * commands, we should default to being tree-wide, but
	 * this is not the original behavior and can't be
	 * changed until users trained themselves not to type
	 * "git add -u" or "git add -A". For now, we warn and
	 * keep the old behavior. Later, this warning can be
	 * turned into a die(...), and eventually we may
	 * reallow the command with a new behavior.
	 */

...and I was being too optimistic about, "and eventually".

I misread that and thought it meant that (eventually) 2.0
would default to the full tree and fix the consistency.

I didn't think that meant 2.0 would die and "git add -u"
will not be a valid syntax anymore.

Why punish these users?  They are going to have :/ face.

Unlike push.default, whose warning can be silenced with configuration,
git 1.x does not have a way to silence this warning without retraining
existing users.

In other words I will have to answer an email about it one day, and I'm lazy ;-)


Another example...

$ git grep 'stuff' :/

would it be too much to teach it to do:

$ git grep -u 'stuff'

(some users are really simple...)

but in 2.0 that -u would be a no-op because "grep" will be full tree, no?

Would having that as an option and configuration be a way to allow 1.x
users to transition themselves to a 2.0 world?

I need to read the old discussions.
Can someone tell me the magic google search syntax they use to dig them up?


Would a better way be a method to make "git add -u" behave like 2.0 today?

I'm thinking of Python's "from __future__ import better_behavior" as a analog.

If full-tree is a better default then that should be the default.
Surely that's better than die(), no?

Apologies in advance as I have not read the discussions (yet).
-- 
David
