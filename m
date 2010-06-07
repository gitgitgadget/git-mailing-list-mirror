From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/4] diff/xdiff: refactor EOF-EOL detection
Date: Mon, 07 Jun 2010 10:10:40 +0200
Message-ID: <4C0CA980.6090706@drmicha.warpmail.net>
References: <cover.1275575236.git.git@drmicha.warpmail.net> <4C08AD75.6040307@drmicha.warpmail.net> <7vfx10yfmn.fsf@alter.siamese.dyndns.org> <201006061101.02156.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 07 10:11:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLXQP-00043s-Hr
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 10:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756427Ab0FGILG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 04:11:06 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:33513 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755444Ab0FGILE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jun 2010 04:11:04 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 280A0F84D1;
	Mon,  7 Jun 2010 04:11:04 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 07 Jun 2010 04:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=gjXos3zVio03t85dIi9TFEac3Yk=; b=oSirHL2xDPS93ZVClgAs2vNNPpsukIPVy8FjNr/Fxxs260iXXzcV4QAgpgE1YA5WZ48gXAWuqHKtJB4PbA0AAMGdROMvKunGAcDYaPkSVJ6s7DCH/EE9+0qNou8p/LwYGuLokprkI6e7+ipCijiCi4MvUp96hsf3JiXcsgBapb8=
X-Sasl-enc: Uf/JFWa0kZ1qnnZ/7rF8NWMbhzrGq/YjiyZdeSciShKa 1275898263
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 317F65EE54;
	Mon,  7 Jun 2010 04:11:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100604 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <201006061101.02156.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148584>

Johannes Sixt venit, vidit, dixit 06.06.2010 11:01:
[This is more of a response to all of you, not only J6t.]
[Scroll down to CONCLUSION if you're not interested in specific
technical repsonses.]
> On Sonntag, 6. Juni 2010, Junio C Hamano wrote:
>> Symlinks are minority among the tracked contents (e.g. in git.git there is
>> only one), and they are almost always a single incomplete line.  When they
>> change, you do want to notice, and I happen to find it a good visual aid
>> to have these incomplete line indicators, in addition to the unusual
>> 120000 mode on the index line.
> 
> You make whole lot of assumptions, don't you?
> 
> A repository cannot have many tracked symlinks? They change infrequently? 
> Additional clues are needed to notice that they change?
> 
>> Peff uses --textconv to show changes to the exif information on his photo
>> collections.  If he has any symlinks, and if he finds that removal of "\No
>> newline" is a regression and not an improvement, what recourse does your
>> patch give him?  Saying --no-textconv to work around that regression is
>> not a solution, isn't it?
> 
> Oh, I'm pretty sure that Peff wouldn't use --textconv on his repository if he 
> cared that diffs contained complete reproducible information.
> 
>> If you start from a false premise that "\No newline" was an unnecessary
>> warning,
> 
> That's a strawman. Michael never meant it that way although he said it 
> (unfortunately).

I'm not sure where I said that. I called that line a "warning", which
was unfortunate, because it is part of the diff spec. (Full disclosure:
I wasn't aware of that in the earlier stage of that series' development
either. Had I only known what alarm bells that term "warning" would ring...)

You're right about what I meant: Make the diff output (i.e. log, show
etc.) which is meant to be human consumable more human consumable.

> For me, the 120000 mode is visual clue enough (and a very strong visual 
> trigger, BTW) when I browse through a diff. It's appropriate that "\No 
> newline" is suppressed for symbolic links so that it does not distract from 
> the mode line, because "\No newline" is a much strong trigger (that makes 
> alarm bells ring).

Well, it seems that Junio takes that no-eol-eof-line actually as a
visually stronger indication of "symlink", which I find strange, but
that is a matter of taste.

When I say "human consumable" above I define "human" as "Git user with
average knowledge or better". And I would think that a large fraction of
those don't know how Git represents symlinks internally, and they
*should not need to know*. They also should not need to know the diff
spec for files with no-eol-at-eof, unless they use them.

And, there's no way denying: "Now newline at end of file" does look like
a warning, like something is wrong about a file. So, it is confusing
on two counts: "wrong" and "file".

I would also think that symlinks are much more common than proper files
with no-eol-at-eof, so it's very likely people know about and use
symlinks but not the rest. But, of course, that's just my assumptions.

I thought (before) about plugging into the textconv mechanism proper and
appending a \n before feeding the diff machinery but didn't want to dupe
strbufs in there, thinking one might use this (per explicit request) for
larger blobs also, not just symlinks. But maybe that concern was
unnecessary. I'm not sure though whether the eol should platform
dependent here, or dependent on core.eol, or... Suppressing the
warning^W diff line seems easier.

I haven't looked into the matter of "attributes per file type". I agree
with Jeff that it would be conceptually nice but can't judge the degree
of overboardness, so to speak.

I've learned not to be confused by those not-warnings any more, so I
don't care personally.

CONCLUSION

In conclusion, I think this shows (again) that we have a fragile
distinction between porcelain and plumbing. A porcelain command should
not have raised all these concerns. I should be allowed to claim "This
is porcelain so any scripting reasoning (diff|apply) is invalid by
definition" but didn't even consider it. I'm not that legalistic ;)

We need a proper strategy for having a consistent "used-as-plumbing"
mode, activated not only on request by "--porcelain". I would think that
activating that mode based on istty and, maybe, also by
GIT_PLUMBING_MODE set by a caller (or git --porcellain command) would
prove beneficial on more occasions then just this one (textconv...).

Michael
