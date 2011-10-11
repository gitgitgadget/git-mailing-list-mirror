From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] commit: teach --gpg-sign option
Date: Tue, 11 Oct 2011 08:39:48 +0200
Message-ID: <4E93E4B4.9070901@drmicha.warpmail.net>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org> <4E91FD57.7050808@drmicha.warpmail.net> <7v4nzhrebp.fsf@alter.siamese.dyndns.org> <4E92919F.2030007@drmicha.warpmail.net> <7vaa98okwl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 08:40:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDW0K-0005Jn-ND
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 08:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794Ab1JKGjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 02:39:51 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:51277 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750712Ab1JKGjv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2011 02:39:51 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5CEBE20BA6;
	Tue, 11 Oct 2011 02:39:50 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 11 Oct 2011 02:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=hJkd9k07JEkYffc7lJ2VXK
	+pjlo=; b=O3z3HmyDc8PAzQ1aecOx0ai0n92hUXFsavDsITb6URzlPmBFDEHaDO
	pQYDf9I6X7/Z9oE58mHIAaCwWQTGJAijxapAlTz/8bAn7hLHTQb/Y6EYDOplosr1
	xuTbd2IoXQJJPn+U7bme0uH01waJhmtaZnQ/xMrfvHYv9qzo5r/Gs=
X-Sasl-enc: h3dNPILR3sfEAAg9d1HB2PdYj4/xB5RxoHDiVGDL0NMp 1318315190
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D1F964833D9;
	Tue, 11 Oct 2011 02:39:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <7vaa98okwl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183284>

Junio C Hamano venit, vidit, dixit 10.10.2011 18:45:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> What norm? --amend keeps some header fields and discards others. In
>> fact, signing a commit "without changing it" (i.e. keeping tree, parents
>> etc., alias "--amend -C HEAD") should be the normal use case for signing
>> the tip of an existing branch. I mean, I have no problems adding to this:
>>
>> git help fixup
>> `git fixup' is aliased to `commit --amend -C HEAD'
> 
> You are *additionally* saying "-C HEAD" in an non-standard alias. Isn't
> that enough indication that a vanila "--amend" is intended to record the
> commit based on the updated context in which the new commit is made?
> E.g. the authorship of the patch is still the same but committer
> information is updated.

I was more referring to leaving "parent" and "tree" headers in place,
which is a bit of a screwed comparison (because it relies on an
unchanged index).

>> But what is the best default for the workflows that we encourage (commit
>> early, ...)? You answer a pull-request which happens to be a
>> fast-forward, sign the tip and suddenly you've taken over ownership (and
>> changed dates)??? Signing a commit should not do this.
> 
> I personally think a pull that is made in response to a pull-request,
> i.e. the upstream merging from lieutenant, especially when the
> authenticity of the puller matters, is perfectly fine with --no-ff.

Yeah, --no-ff would work. I guess we should find out what our "main
customers" need here, since our own patch-based workflow is irrelevant,
and either approach works with our "single push authority". Seems
--no-ff is an easy solution to multiple sigs.

> Unlike the sign-less "we together made these history and nobody really
> owns the result" (aka "Linus hates --no-ff merge because people do that to
> leave a mark by peeing in the snow, without adding anything of value in
> the history"), the whole purpose of signing a commit in the scenario you
> mentioned is for the puller to leave his mark in the history.

diff --git i/Documentation/merge-options.txt
w/Documentation/merge-options.txt
index b613d4e..74d6a05 100644
--- i/Documentation/merge-options.txt
+++ w/Documentation/merge-options.txt
@@ -7,6 +7,13 @@ With --no-commit perform the merge but pretend the merge
 failed and do not autocommit, to give the user a chance to
 inspect and further tweak the merge result before committing.

+--pee::
+--no-pee::
+       This activates `--commit` and `--no-ff` and passes
+       `--gpg-sign` to `commit`.
++
+Use `--no-pee` if you do not want or need to pee.
+
 --ff::
 --no-ff::
        Do not generate a merge commit if the merge resolved as

:)

Michael
