From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv3 3/7] show: honor --textconv for blobs
Date: Mon, 13 May 2013 16:57:55 +0200
Message-ID: <5190FF73.1080606@drmicha.warpmail.net>
References: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org> <c4ed1e0b67877e6453b8c269290e09e1672ce37d.1368197380.git.git@drmicha.warpmail.net> <7vy5bm22f8.fsf@alter.siamese.dyndns.org> <518E0741.1060008@drmicha.warpmail.net> <518E16B1.7000505@drmicha.warpmail.net> <7vtxm7qxql.fsf@alter.siamese.dyndns.org> <20130513115451.GA3903@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 13 16:57:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbuCF-0002fw-F9
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 16:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930Ab3EMO5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 10:57:47 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46648 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752118Ab3EMO5q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 May 2013 10:57:46 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0EAEB20C07;
	Mon, 13 May 2013 10:57:46 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Mon, 13 May 2013 10:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=DT4IevBIrvdj/ccRyc+k5s
	yU87o=; b=UjaT6xKh41NzJb+wdv/WSBa0YJzmpoLXLm+45t/ojHMt/5bvb52HLj
	MDLikBd4A2V4noalGjgZeBTTaey1fqGGzOgZYg6MBu4v7wlCsLzc1MQ1Ne5ZcC3m
	c5L/x6C7dKKgkf8V1whQLX7q4SMrPYYv8O97PBFifoRKOo4gzvx84=
X-Sasl-enc: MLXpBOZ1m4JJx+aywqbiRYj2hsQ71Y3c8rAtC16xAVws 1368457065
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 46E8AC8000A;
	Mon, 13 May 2013 10:57:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <20130513115451.GA3903@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224162>

Jeff King venit, vidit, dixit 13.05.2013 13:55:
> On Sun, May 12, 2013 at 10:01:38PM -0700, Junio C Hamano wrote:
> 
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>>> Adding to that:
>>>
>>> Somehow I still feel I should introduce a new attribute "show" (or a
>>> better name) similar to "diff" so that you can specifiy a diff driver to
>>> use for showing a blob (or grepping it), which may or may not be the
>>> same you use for "diff". This would be a much more fine-grained and
>>> systematic way of setting a default for "--textconv" for blobs.
>>>
>>> Of course, some driver attributes would just not matter for coverting
>>> blobs, but that doesn't hurt.
>>>
>>> I'm just wondering whether it's worth the effort and whether I should
>>> distinguish between "show" and grep".
>>
>> Haven't thought things through, but my gut feeling is that it is on
>> the other side of the line. We could of course add more features and
>> over-engineered mechanisms, and the implementation may end up to be
>> even modular and clean, but I cannot answer "Yes" with a confidence
>> to the question "Does such a fine grained control help the users?"
>> and cannot answer "If so in what way?" myself.
> 
> Yeah, I think the _most_ flexible thing is going to look something like:
> 
>   $ cat .gitattributes
>   *.pdf diff=pdf show=pdf
> 
>   $ cat ~/.gitconfig
>   [diff "pdf"]
>           textconv = ...
>   [show "pdf"]
>           textconv = ...
> 
> But that obviously sucks, because in the common case that you want to
> use the same command, you are repeating yourself in the config. You
> could assume that the "show" attribute points us at a "diff" block. And
> that makes sense for textconv, but what does it mean if you have
> "show=foo" and "diff.foo.command" set?

I don't propose "show drivers". In your example above, you would point
to the same diff driver.

If you use a diff driver just with the "show" attribute then only its
textconv config will be relevant.

But you do have the possibility to use different drivers for diff and
show. For example, for showing a file some sort of automatic pagination
or line numbering can be helpful whereas it would hurt the diff case.

> If the _only_ thing you would want to do with such a "show" mechanism is
> to display converted contents on show/grep, then we could lose the
> flexibility and say that "show" is a single-bit: do we respect diff
> textconv for show/grep in this case, or not? And that leaves only the
> question of where to put it: is it a gitattribute, or does it go in the
> config?
> 
> I don't think that it is a property of the file itself. That is, you do
> not say "foo files are inherently uninteresting to git-show, and
> therefore we always convert them, whereas bar files do not have that
> property'. You say "in my workflows, I expect to see converted results
> from grep/show". And the latter points to using config, like either
> "diff.*.showConverted" (to allow per-type setting), or even
> "grep.useTextconv" and "show.textConv" (to allow setting it per-user for
> all types).

I strongly disagree here. I have textconv filters for pdf, gpg, odf,
xls, doc, xoj... I know, ugly. At least some of them would benefit from
different filteres or different settings.

The way I propose it, a user would just have to add "show=foo" to the
"diff=foo" lines without having to ad an extra filter, but with the
flexibility to do so.

> And of course for any workflow-oriented config, you will sometimes want
> to override it for a particular operation. But that is why we have a
> command-line escape hatch, and that part is already implemented.

One may ask what a purely ui output oriented setting like "show" has to
do in .gitattributes, of course, but that applies to "diff" as well.
Separating the two (one in attributes, one in config) looks artificial
to me.

Michael
