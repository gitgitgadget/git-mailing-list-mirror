From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git notes list/show <revision-range>
Date: Wed, 20 Apr 2011 09:16:55 +0200
Message-ID: <4DAE8867.8010704@drmicha.warpmail.net>
References: <4DAC80CF.8020704@lyx.org> <20110418182724.GB11250@sigill.intra.peff.net> <4DAD371F.9040003@drmicha.warpmail.net> <20110419203211.GA12071@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Vincent van Ravesteijn <vfr@lyx.org>,
	Git Mailing List <git@vger.kernel.org>, bebarino@gmail.com,
	johan@herland.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 09:17:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCRev-0003l5-4W
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 09:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869Ab1DTHRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 03:17:00 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:46290 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753850Ab1DTHQ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2011 03:16:58 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D53FB205AC;
	Wed, 20 Apr 2011 03:16:57 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 20 Apr 2011 03:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=pKvBtxPNUvnJwJ9N3kD+gPvm5kg=; b=KQSbxayCVbFTfRrOzTv66V0hlyeBqOBDChig5JmpjN3LuinBJ18QSjtOeKBbw/xtd0nxxVez4mYFUoiY3PkeBhscqjxwAf0A1dIh9KgLxU+WO9Sp4pvbC3qEujj06upfiHBI874zp0970t0M9fiP67QBSg3fhCp9vRw0DheJqoE=
X-Sasl-enc: HJ+VVZfW08fYsJSyo6tuet0awTu3xjCkov04gcQPa3Se 1303283817
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D000040ECAF;
	Wed, 20 Apr 2011 03:16:56 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110419203211.GA12071@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171845>

Jeff King venit, vidit, dixit 19.04.2011 22:32:
> On Tue, Apr 19, 2011 at 09:17:51AM +0200, Michael J Gruber wrote:
> 
>> But since the OP is volunteering to code for notes :-)
>> We could need a feature which allows to log the history of a note. The alias
>>
>> `git noteslog' is aliased to `!sh -c 'git log $(git notes get-ref) "$@"' -'
>>
>> gives you the history of the notes tree (try it with "-p"),
> 
> Hmm, I just use "git log notes/<whatever>", which works fine. It does
> help if you know that the default ref is "notes/commits", though.

Sure. That's what the alias does.

> It's not something I do often, though (most of my notes use has been
> things that automatically make notes, so the history tends to be
> uninteresting and useful only for debugging the note-making code).

In particular, the log messages "Notes added by..." are useless. I use
notes for patch boiler plates and branch annotations, and in these cases
history can be interesting (between versions of a patch, e.g.).

>> sometimes I would like the history of the notes to a specific commit, and in
>>
>> git noteslog -p -- $(commit)
>>
>> I would have to use for $(commit) all possible breakdowns of the sha1 of
>> the commit for all possible notes tree structures. It feels as of the
>> revision walker needs to learn another pathspec, say
>>
>> ":(note):<sha1>"
>>
>> in line with our magic pathspec discussion.
> 
> That's a clever solution. It is a little non-intuitive for a user to
> need to know about notes storage, though. Maybe you were already
> thinking this, but we could have something like:
> 
>   git notes log [revs] [--] [pathspec]
> 
> where "[revs]" are checked for in refs/notes/*, defaulting to
> "refs/notes/commits". And each element of the pathspec gets the
> ":(note):" magic automatically. I wonder if we could even resolve the

Here we are back at my alias is a first step in that direction... "git
notes log" should do all that, of course.

> pathspec bits as regular refs.
> 
> So you could write:
> 
>   # long form, just as you can do with "git log"
>   git notes log notes/commits -- ":(note):`git rev-parse HEAD`"

I don't think "notes log" should take a notes ref argument like that. It
already has "--ref" for that purpose, so I would suggest

git notes [--ref <notesref>] log [<rev>]

with <rev> being mapped to :(notes):<rev> automatically, <rev>
defaulting to HEAD. That is much more in line with the other notes
subcommands. (We may or may note check for ":(notes):" being there already.)

> 
>   # or with automagic ref lookup for pathspec
>   git notes log notes/commits -- HEAD
> 
>   # and automagic default ref
>   git notes log -- HEAD
> 
>   # and I think you should be able to write a disambiguator similar to
>   # what we use for the revs/paths distinction, but this time for
>   # notes-refs versus regular refs. And then drop the "--":
>   git notes log HEAD
> 
> I think it would need a little refactoring of setup_revisions() to be
> more flexible, but most of the hard work is already done by the usual
> revision traversal mechanism.

? I haven't checked in detail, but I think all we need is:

- Make "git notes --ref <notesref> log <rev>" call "git log
<resolvednotesref> -- :(notes):<rev>" (and pass on log options).

- Make the pathspec ":(notes):<rev>" resolve <rev> to <sha1> and match
with all possible breakdowns of <sha1> which we accept for a notes tree.

Michael
