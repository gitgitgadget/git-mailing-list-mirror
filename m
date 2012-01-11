From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] commit: allow to commit even if there are
 intent-to-add entries
Date: Wed, 11 Jan 2012 13:08:52 -0800
Message-ID: <7vr4z654m3.fsf@alter.siamese.dyndns.org>
References: <1326261707-11484-1-git-send-email-pclouds@gmail.com>
 <7vr4z67jbb.fsf@alter.siamese.dyndns.org> <20120111110222.GA32173@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Will Palmer <wmpalmer@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 22:09:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl5Pp-0002D2-AM
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 22:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758075Ab2AKVI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 16:08:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33745 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753064Ab2AKVIz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 16:08:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A51E96411;
	Wed, 11 Jan 2012 16:08:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hYk/2d6vFs0bSax+Bo0lg1MbIj8=; b=B+wJwy
	RxA3od/sDaQK0A78LGDVO7NQiEcgAqUdZp8ri4PZmmPSX8/TCuu2viJtIco9rb7U
	5hCubg3Dv7LW3BJPPl4mkOLEyLMy7LMbhTBwHzob4cGpwXRER2YuOeR6UY6i+fIx
	TXFfx2PnWiEyOpnGM04p7NdgLnpY1bMb5qCyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pTxsABI8TYDLuhmXdrYjn3AZpvoSbvZj
	Iv2MKbHyuFnCNdArHnlbjkQilWCTOgurC99527pomYuz+62DuoZJZIIqK2IEnt2k
	DSQyMq6cjXFfgXIx5LNbis3vZ1cmbD9a0PNG5lhyYe2kCnioiWkrGRASrSHQ5y3j
	MhTBMXCZ9dk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B7276410;
	Wed, 11 Jan 2012 16:08:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1ABEE640F; Wed, 11 Jan 2012
 16:08:54 -0500 (EST)
In-Reply-To: <20120111110222.GA32173@burratino> (Jonathan Nieder's message of
 "Wed, 11 Jan 2012 05:02:22 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 77D8B9DE-3C98-11E1-BBFD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188395>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> When running "commit" and "status" with files marked with "intent to add",
>> I think there are three possible interpretations of what the user
>> wants to do.
> [ (1) thanks for stopping me, I had forgotten about that file;
>   (2) I changed my mind, please leave that file out; or (3) please
>   dwim and add the file ]
>
> I think (3) was a trick --- no one that does not use the "-a" option
> would want that. :)

I really wish it were the case, but I doubt it.

People from other VCS background seem to still think that "commit" without
paths should commit everything; after getting told that "what you add to
the index is what you will commit", I can easily see this commint: but but
but I told Git that I _want_ to add with -N! Why aren't you committing it?

> At the time, I did not understand what (2) meant.  Now I see why ---
> in interpretation (2), the user did not change her mind at all.

You are correct. "I still cannot make up my mind" is what is happening in
that situation.

The user explicitly said "I cannot decide about this path right now" when
she said "add -N". And we haven't heard from the user what should happen
to the path. Now we have to make a commit so somebody needs to decide.

> She
> said "I will be adding this file at some point, so please keep track
> of it along with the others for the sake of commands like 'git diff'
> and 'git add -u', but that does not mean "I will be adding this file
> at some point _before the next commit_".

Correct. She only said "I cannot decide right now" when she said "add -N"
and hasn't gave us any more hint as to what should happen now we have to
make a commit.

It is _wrong_ for us to unilaterally decide for the user that she does not
want the path in the commit. The last we heard from her was that she does
not know what should happen to the path.

> (2) makes intent-to-add entries just like any other tracked index
> entry with some un-added content.

You are comparing files edited in the working tree without the user
telling anything about them to Git (both tracked and untracked) and files
the user explicitly told Git that the user hasn't made up her mind
about. Why is it a good thing to make the latter behave "just like any
other"?
