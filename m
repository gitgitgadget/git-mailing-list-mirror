From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Mon, 28 Feb 2011 08:31:55 +0100
Message-ID: <4D6B4F6B.1040209@drmicha.warpmail.net>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com> <7vk4gm7dz3.fsf@alter.siamese.dyndns.org> <4D6A6291.8050206@drmicha.warpmail.net> <7v7hclulz0.fsf@alter.siamese.dyndns.org> <7v39n9uldp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Mart_S=F5mermaa?= <mrts.pydev@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 08:35:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptxdd-0000Mc-AF
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 08:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671Ab1B1HfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 02:35:18 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41545 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752377Ab1B1HfR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 02:35:17 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5B8EA20897;
	Mon, 28 Feb 2011 02:35:16 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 28 Feb 2011 02:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=9S/YMe/fRNj62Jk9g1wASIPYW6A=; b=Y+kDoArE0VqBO8n60i17v/4qN86x7FGClQx/pWxdcJPtMS0pWs1rq8dteUuqPqBTQb8VjhxFuuPs0Na/3Sa3kKy3ld3muTh4n+LEJhGxkVqWTXRn26bs6mp/r/AoKkLCum0d3fOlsRCctL77e0toJf7vx76G+bwqFx7F2sKLe1E=
X-Sasl-enc: gB/S9REG7cDLEP3/CFCXEvhxe1MxC8wQf2BDiy29P6FZ 1298878516
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BA70040049A;
	Mon, 28 Feb 2011 02:35:15 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <7v39n9uldp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168074>

Junio C Hamano venit, vidit, dixit 28.02.2011 00:07:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>>> Wasn't the pager invented for sifting through output which has to be
>>> several pages, but not not for that which could be more concise? ;)
>>>
>>> In fact, -D would be quite analogous to -M and -C in that respect.
>>
>> There is a big difference: -M and -C lets your recipient reproduce the
>> state using the change you are trying to convey with the diff output in
>> either direction (iow, "apply -R" works), but your "-D" would not have
>> that property.
> 
> Having said that we have always valued "reversibility" and a casual -D is

I didn't know, but I guess I haven't come across those issues yet.

> not in line with that principle, I don't have a strong objection if the
> new mode of operation is marked clearly as "nonusable if you are trying to
> produce appliable diff (iow, don't send such a patch to mailing list--it
> is for viewing purposes only)", treating it just like the --color-words
> and the --stat options (there isn't even need to mark these as unusable
> for that purpose, as people with common sense would be able to guess).

Yes, it is purely intended as "for viewing by humans". Even in the
forward direction saying "delete that path" is different from saying
"delete that content from that path", i.e. "diff -D" output may apply
without conflicts in cases where "diff" output does not.

That aspect is similar to -M and -C, though - unless we check the sha1
of the blobs before applying the patch (which would be possible for -D
also) - do we?

> If we were to do this, it probably is a good idea to apply that for a
> typechange patch (the one that is produced when a symlink turns into a
> regular file and vice versa) as well.  It also might make sense to apply
> the similar principle to shorten the output with -B when a rewrite patch
> is expressed as a single hunk patch that removes everything old and then
> adds everthing new.

Reminds me of my failed attempt to make the diff output for symlinks
more human-friendly. The latter can be solved with textconv, though.

Michael
