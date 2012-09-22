From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Quickly searching for a note
Date: Sat, 22 Sep 2012 18:10:51 +0200
Message-ID: <505DE30B.2000805@drmicha.warpmail.net>
References: <505C7C80.3000700@workspacewhiz.com> <7vy5k370n7.fsf@alter.siamese.dyndns.org> <505CB21E.4040607@workspacewhiz.com> <7vtxur3zxi.fsf@alter.siamese.dyndns.org> <505CCD2A.8020003@workspacewhiz.com> <505CD2FA.80200@kdbg.org> <505CD7D0.2000505@workspacewhiz.com> <20120921233723.GA29433@sigill.intra.peff.net> <7v7grn3pfo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 18:11:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFSIL-0003z5-JB
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 18:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593Ab2IVQKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2012 12:10:55 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45659 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751664Ab2IVQKy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Sep 2012 12:10:54 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1A001205F2;
	Sat, 22 Sep 2012 12:10:54 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Sat, 22 Sep 2012 12:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=ULujN9EftfRnB4kWPv6zSO
	VNjCI=; b=WbItv5T+7hbzF2z4Je5e5BmES1YuIn+ZvYwPVODFL5jjGYYeEIWszK
	4WWpvzjLSlf/lxkc9lP3gt5VbIF3vIRXBR2wAhCGgpcWpkEO60M1WYxZSnH/GeQC
	HTkqy38i4y471Ixils6J3sWTuyo8SsuH24zV7u0bUAEU8hwmy/rpI=
X-Sasl-enc: x79OIkah5DurBYf4DyM6DUOr9MoYN1bmsA2AQ95zAZu1 1348330253
Received: from localhost.localdomain (unknown [88.70.159.46])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2B61B48278C;
	Sat, 22 Sep 2012 12:10:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7v7grn3pfo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206206>

Junio C Hamano venit, vidit, dixit 22.09.2012 01:51:
> Jeff King <peff@peff.net> writes:
> 
>> I think people have provided sane techniques for doing this with a
>> pipeline. But there is really no reason not to have --grep-notes, just
>> as we have --grep.  It's simply that nobody has implemented it yet (and
>> nobody is working on it as far as I know). It would actually be a fairly
>> simple feature to add if somebody wanted to get their feet wet with git.
> 
> I agree that the implementation will be simple once you figure out
> what the sensible semantics and external interfaces are. The latter
> is not that simple and certainly not something for newbies to solve
> on their own.  That is why I didn't mention it.
> 
> But now you brought it up, here are a few thinking-points as a
> starter:
> 
>  - Wouldn't it be more intuitive to just let the normal "--grep" to
>    also hit what "--show-notes" would add to the output?  Does it
>    really add value to the end user experience to add a separate
>    "--grep-notes=P4[0-9]*" option, even though it would give you
>    more flexibility?
> 
>    Not having thought things through thorouly, I still answer this
>    question both ways myself and what the right user experience
>    should look like.
> 
>  - Do we want to be limited to one notes tree?  Would it make sense
>    to show notes from the usual commit notes but use different notes
>    tree for the sole purpose of restricting visibility?  If we
>    wanted to allow that for people who want flexibility, but still
>    want to use only one and the same by default, what should the
>    command line options look like?
> 
>  - Would it be common to say "I want commits with _any_ notes from
>    this notes tree"?  Having to say "--grep-notes=." for such a
>    simple task, if it is common, feels a bit clunky.
> 

On my mental scratch pad (yeah, that's where the bald spots are) I have
the following more general idea to enhance the revision parser:

--limit-run=<script>::
--run=<script>:::
These options run the script `<script>` on each revision that is walked.
The script is run in an environment which has the variables
`GIT_<SPECIFIER>` exported, where `<SPECIFIER>` is any of the specifiers
for the `--format` option in the long format (the same as for 'git
for-each-ref').

In the case of `--limit-run`, the return code of `<script>` decides
whether the commit is processed further (i.e. shown using the format in
effect) or ignored.


So far the idea. We could also squash both the limitting and the
formatting option into one run option. Typical usecase could be

git log --limit-run='sh -c "test x$GIT_NOTE = xp@myid'

or the like. We could also feed <script> to a shell directly. We could
also make the limit option stop traversal (optionally). Just a scratch
pad, rwally ;)

Michael

P.S.: option name bike shedders: it's named after bisects's "run"; we
could name it after rebase-i's "exec" instead...
