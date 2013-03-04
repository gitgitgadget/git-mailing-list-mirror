From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git rebase" loses the additional changes in "evil" merges
Date: Mon, 04 Mar 2013 13:41:21 -0800
Message-ID: <7vppzex2pq.fsf@alter.siamese.dyndns.org>
References: <201303042058.r24KwwEx012408@freeze.ariadne.com>
 <7vtxoqx3s1.fsf@alter.siamese.dyndns.org>
 <87sj4aoo3s.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Dale R. Worley" <worley@alum.mit.edu>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 04 22:41:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCd8r-00033m-66
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 22:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648Ab3CDVlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 16:41:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34665 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932552Ab3CDVlY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 16:41:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6E7EB1E8;
	Mon,  4 Mar 2013 16:41:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bIeUTCsc2l2B0tgiucp8aPYCemg=; b=Eq68J1
	CdRTX3xzi2v0VSOR383NVp0Grvn0PEL5w70nx5r1nYFFjnn7ijxEpePsIZ21HasR
	QpCtoTM8ROmNZBYvMq0qjBWzqt6vC7l9t0MvFN03bOJoFBytqnHXC09RBJunUwuo
	l/WLd2lp3X70fHZ4CvHzpDn9G49c10KoxxA9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WVJaM5HTqbud3Qk4PGUaMtBdIEu0qlMD
	T3HxGjFEIR7lvyKuxUT1CYDl2s1MKD1L5PLrVAJOlN2yFbjykr6ZmPYFyrMDuLb/
	+rqDlVAeeq/a/OG9SJocj51GT1Nuy1NeQ1d8Tq98RZ4OhmxJPCAlZ4JjUX7u1lU9
	L/dPOjUx7Iw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB48AB1E0;
	Mon,  4 Mar 2013 16:41:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E794B1DD; Mon,  4 Mar 2013
 16:41:23 -0500 (EST)
In-Reply-To: <87sj4aoo3s.fsf@pctrast.inf.ethz.ch> (Thomas Rast's message of
 "Mon, 4 Mar 2013 22:24:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4255D9B6-8514-11E2-9BF6-2F862E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217413>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> worley@alum.mit.edu (Dale R. Worley) writes:
>>
>>> (git version 1.7.7.6)
>>>
>>> I've been learning how to use Git.  While exploring "git rebase", I've
>>> discovered that if the branch being rebased contains an "evil" merge,
>>> that is, a merge which contains changes that are in addition to the
>>> changes in any of the parent commits, the rebase operation will
>>> silenty lose those additional changes.
>>
>> I think this is to be expected for "git rebase", as it does not even
>> look at merges.  It is a way to find non-merge commits that haven't
>> been applied yet, and apply them to the upstream to create a new
>> linear history.
>
> I can see the problem with --preserve-merges though.  It will actually
> just *redo* the merge; the name is wrong in the sense that it undertakes
> nothing to preserve whatever evilness was in it.

With or without evil, preserve-merges have other issues to make me
not to trust it. Which side branches to take literally (i.e. just
merge again) vs which side branches to also rebase (i.e. rebuild the
history and then merge).

It was suggested to make it apply the first-parent diff and record
the result, I think.  If that were an acceptable approach (I didn't
think about it through myself, though), that would automatically
cover the evil-merge case as well.
