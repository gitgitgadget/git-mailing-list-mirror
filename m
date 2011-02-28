From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 3/3] git-add: rename -u to -a
Date: Mon, 28 Feb 2011 09:30:01 +0100
Message-ID: <4D6B5D09.8010806@drmicha.warpmail.net>
References: <cover.1298821535.git.git@drmicha.warpmail.net> <4D68D630.9000608@drmicha.warpmail.net> <711e34a5f4761ccd1056a992df21e3389db7add7.1298821535.git.git@drmicha.warpmail.net> <AANLkTintuaM+p7XKmTy+hOa80nkbph7MP00cvEA+oHZJ@mail.gmail.com> <7v39n8ll0s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 09:33:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtyXp-00072w-SZ
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 09:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778Ab1B1IdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 03:33:24 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55366 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752268Ab1B1IdX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 03:33:23 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4B06520CF5;
	Mon, 28 Feb 2011 03:33:23 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 28 Feb 2011 03:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=57qJ/vRK/EbHr8NngpxjyF7ADTQ=; b=g6XswTUCCcwgXokKbR7+Hxp5bpytHq+HZBpVSRakiiJy8pUSLOmTo+jPtg2cAKIrzG/aEsrcovn2UD3SfR8uSOtKXp896P/WdYEe/JAwCj/cn8vV88GDYh7ce+ycQCOymnbVC4MQ19gOhIISXbLNxcz6nO0N5QVhs+CGbBGogcg=
X-Sasl-enc: FFM6FVVbUyvoAwdSiri8Skw5glOwWBtoN2XpB7n3KDwQ 1298882002
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7ADBB441C7D;
	Mon, 28 Feb 2011 03:33:22 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <7v39n8ll0s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168075>

Junio C Hamano venit, vidit, dixit 28.02.2011 07:40:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> 
>> Should -u now print warnings to help script writers migrate to -a? Or
>> do we plan to keep hidden -u forever?
> 
> I'd rather not to apply 2 and 3 from this series for now, until we have a
> more reasonable solution.  Yes, I said "add --add-tracked" _might_ be

"add --all-tracked", I think.

> worth considering, but that is in contrast to "add --tracked" which was
> out of the question.

Come to think of it: How about "-A,--everything" and "-a,--all" if
"-A,--All" is a no-no?

> Like it or not, "add -u" has already been quite established, and the 'u'
> stands for "update(d)" (i.e. "run update-index to the files updated in the
> work tree"), which I think makes perfect sense.

I think here and below you are reasoning from the perspective of a
well-trained user - which already must be quite an effort (trying to
think way below your level of experience), of course ;)

We know that add runs update-index, but we are irrelevant, so to say. If
"update" or "updated content" describes the option (!, not the command)
well for an ordinary user, differentiating it from other add options,
I'm all for it. My problem is that in

git add pathspec
git add -u pathspec

both commands update the index with the updated contents of pathspec if
pathspec is tracked already. They are only different when pathspec (or
some of the files under pathspec) is not tracked yet. So, really:

-u == --tracked-files-only

That is, without "-u" we add (potentially) more than we would with "-u".

It's just that the defaults without pathspec are very different: ""
resp. "."

But that default makes "-u" appear very all-ish.

> I would suggest just keeping "add -u" as is.  As I said in the review in
> the previous round, if Michael really wants to, it probably is Ok to give
> "commit -a" a synonym "commit --update".
> 
> I further find that the verb form "--update" doesn't rhyme well as the
> option name to select what classes of paths are operated on; it might make
> sense to change the fully spelled version of the option for both commands
> from "--update" to "--updated" while we are at it.  This would not bother
> end users at all, as parse-options will complete "--update" typed by the
> user or in scripts uniquely to "--updated" just fine.

In fact, I'd be much happier with "--updated" than with "--update" -
"updated" makes sense for tracked files only, so "updated" is really
another way of saying "tracked" in the context of the add option in
question!

> Michael seems to be resisting against introducing "commit --update", and I
> understand one reason is because "status -u" means something totally
> different from "updated paths"; I am somewhat sympathetic to that fear.
> 
> But we started making "status" independent from being "commit --dry-run"
> in 1.7.0 for a reason---it would be Ok if "status -u" means something
> completely different from "commit -u", _as long as_ existing "commit -u"
> does not make much sense.  I think that is the case here.

While technically possible, as you explained, having "-u" inconsistent
between "commit" and "status" is a bitter pill to swallow while I'm
driving for consistency between "add" and "commit". I could try to
convince me that "add -u" is quite a bit like "status -uno", though...

> I don't think the distinction between "commit -a" vs "commit -A" is all
> that bad.  When people talk about "all" files in the context of SCM, we
> almost always think about already tracked paths, and other files do not
> get into the picture unless you first "add" them (this is not limited to
> git; even "svn commit" or "cvs commit" wouldn't touch untracked paths).

That's exactly how I was reasoning that "commit -a" does The Right Thing :)

> For this reason, it is not unexpected that the normal version of "all"
> excludes untracked files, and you would need to ask for the unusual
> version of "all" to include them (i.e. "commit -A" or "add -A") when
> dealing with usual SCM commands.

Yes, I'd much rather have a better long name for "commit -A", such as
"commit --everything", even though there's no "A" in "everything". It is
"more than all", "all-and-more", and maybe that's good enough.

> The same argument however does _NOT_ hold for "add", as "add" (especially
> in other SCM's context) is about making paths that haven't been tracked so
> far into tracked ones; iow, it is natural to expect that "all" would mean
> more than normal "all" (i.e. "all what are tracked") in the context of the
> "add" command (and "add" command only).

Well, I thought we're trying to teach users that our "add" is primarily
about adding changes from updated files, and *also* about adding files
to the "list of tracked stuff".

Also, "all tracked" is not normal for "add", otherwise plain

git add

would have to default to "git add -u", wouldn't it?

> IOW, renaming "add -u" to "add -a" and having "add -a" vs "add -A" is more
> confusing than necessary, because of the nature of the word "add" that has
> a connotation of affecting paths that have been untracked so far, and
> keeping "add -u" and "add -A" distinct to avoid confusion is probably a
> reasonable solution to avoid "which variant of 'all' are we talking about"
> confusion.  This compromise unfortunately does not give us the uniformity
> between '-a' vs '-A' applied to 'add' vs 'commit'.  That is why I would
> suggest '-u' vs '-A' if we _really_ want to have such a uniformity between
> two commands, i.e. not adding "add -a" but adding "commit -u".

I think it all boils down to the fact that because "add" and "commit"
have different defaults (because we want useful defaults), the meaning
of the same long option "--all" could be different. I mean, "commit
--all[-tracked]" is pointless.

But just how useful is our default that "git add" is a no-op? I know I'm
getting a bit radical here, but the more I think about it, I feel that

- "add" should be about tracked paths by default (default pathspec "."),

- "commit -a,--add <addopts>" be "add <addopts> && commit", and

- "-A,--all pathspec" (default pathspec ".") be about tracked and
untracked paths (whether add or commit).

Yes, that makes our "add" even more different from "svn add", but our
"commit" is very different already. That would need a proper migration
plan etc., and some thinking about -i/-o. Just brain-storming.

Cheers,
Michael

P.S.: Maybe we could even use "git stage" as the construction site for
the "new git add", but that would loose the "-a,--add" niceness.
