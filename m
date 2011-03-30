From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] Make "git notes add" more user-friendly when there
 are existing notes
Date: Wed, 30 Mar 2011 08:54:17 +0200
Message-ID: <4D92D399.4090404@drmicha.warpmail.net>
References: <09668994f10284cfa5243789a627dce8c2325bc6.1301388217.git.git@drmicha.warpmail.net> <4D9226B4.20806@warpmail.net> <7vd3l9rbnq.fsf@alter.siamese.dyndns.org> <201103300202.55973.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 08:58:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4pLr-0000Cz-Oz
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 08:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958Ab1C3G5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 02:57:54 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:57653 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751638Ab1C3G5x (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2011 02:57:53 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5206B20611;
	Wed, 30 Mar 2011 02:57:53 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 30 Mar 2011 02:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=XFtqrXjvfPA3a7efUw8lebFJEXI=; b=pUDz3EJUvDZ4IXxWiQRUFXeYTh1it0Bqp60N5H52sXqxEuYMMYcu1UgBNgscKcIaPRpfTKsN8TNbvOe+8iDBhG6qMXSnnTtc4NNmVdoZ+jE96rfD6HK/w1Q9IwENrUGfegWYrSOQ01miPB2ZaTwld6hfI7gAu+BAWPwGgDpvtgU=
X-Sasl-enc: TJeUZztcS+bpB+KQYeRje1cWTIbcLxZoPz8bFzBfycOm 1301468272
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9528E4428DF;
	Wed, 30 Mar 2011 02:57:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <201103300202.55973.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170360>

Johan Herland venit, vidit, dixit 30.03.2011 02:02:
> Currently, "notes add" (without -f/--force) will abort when the given object
> already has existing notes. This makes sense for the modes of "git notes add"
> that would necessarily overwrite the old message (when using the -m/-F/-C/-c
> options). However, when no options are given (meaning the notes are created
> from scratch in the editor) it is not very user-friendly to abort on existing
> notes, and forcing the user to run "git notes edit".
> 
> Instead, it is better to simply "redirect" to "git notes edit" automatically,
> i.e. open the existing notes in the editor and let the user edit them.
> This patch does just that.
> 
> This changes the behavior of "git notes add" without options when notes
> already exist for the given object, but I doubt that many users really depend
> on the previous failure from "git notes add" in this case.
> 
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
> 
> On Tuesday 29 March 2011, Junio C Hamano wrote:
>> Michael J Gruber <drmicha@warpmail.net> writes:
>>> and while at it rename "add" to "edit"
>> That one I think is older wart that may be harder to change.
> 
> Here's one attempt at giving Michael a nicer "git notes add" without
> breaking too many existing users. It's not very pretty, but I hope it
> gets the job done without inconveniencing current users too much.

That is certainly an improvement, though I'm still wondering how large a
change we're aiming at, given Junio's remarks. Things I would like to
throw in:

* options vs. arguments:

"tag", "branch" etc. use options for subcommands, e.g. "tag -d", "branch
-d" etc. "remote", "stash" use arguments, e.g. "remote add", "stash
list". I don't see us unifying that, but we should decide about a
direction to go for "new" commands and stick to that. I feel that
options are the way to go. What I really feel strongly about is that we
should decide once and then stick to that for future commands (and may
be gradually revamping).

* singular vs. plural:

All our porcelain commands are singular even when they deal with
multiple items (tag, branch, remote, submodule, ...). "notes" is the
only exception, why not have it be "note"? (That would also open up a
migration strategy, though the usual suspects may not even bother ;))

* "notes message":

The term seems to be used to distinguish between the content of a note
and the note object (blob content vs. blob object). A regular git user
may think it is the commit message in the notes log, i.e.:

git log $(git notes get-ref)

I'm wondering whether we should actually expose those note commit
messages. If notes are shared then editing a note may require an
explanation just like other commits do, especially when they get used
for other things than "notes" in the proper sense.

If we do that, then -m,-c,-C etc. would need to be analogous to "git
commit -m,-c,-C", i.e. about note commit messages, not about the actual
note. If we completely discard the possibility that users will look at
the notes log and write note commit messages, we can use the "regular
commit message <-> notes content" analogy for the options that we
partially have now (and adjust -c,-C).

Cheers,
Michael
