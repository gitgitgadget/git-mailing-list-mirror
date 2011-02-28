From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2011, #06; Sun, 27)
Date: Mon, 28 Feb 2011 08:52:08 -0800
Message-ID: <7v7hckje4n.fsf@alter.siamese.dyndns.org>
References: <7vy650k62n.fsf@alter.siamese.dyndns.org>
 <AANLkTikW1GVzFoq=zUxvi7MTcUYBLO6fbjJPVZziLUk8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 17:52:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu6Kk-0001WK-VU
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 17:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297Ab1B1QwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 11:52:22 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232Ab1B1QwT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 11:52:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A46754150;
	Mon, 28 Feb 2011 11:53:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TUdfPGOCl3PRe+zIox7kO3EHFss=; b=EJTrOK
	E603XKHTSL/cwTy079sBa9vxhPV4j2P7itY2d3dFukOpDSTQhWpKdYXQ19fIaUrA
	/vROganjrijngty3AXBO51Rkb0DRZKxGSt8Pl2pbHK1TEFd3SepeQPOHfHJWn1bs
	mTsUhnpfOweW4LGgWs2yCaryJUb4XSc0loJa8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ScaChR5GttfidxyOB0ykbjIDgr8aIl/E
	ph6G+sycOEkC3XbJGaiBpggbMu4LOody3uh9sCWnbYO/O+9YBapv4CuU0KSfWAT8
	K33dxl1OiDjFHKolcvy3LLrn2wD3RPfxoHZ48HTarNWk2vK4p4Jdyjlrd+UT1JVk
	RAMSFweWaa4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6DEAC414D;
	Mon, 28 Feb 2011 11:53:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4A7CB414C; Mon, 28 Feb 2011
 11:53:29 -0500 (EST)
In-Reply-To: <AANLkTikW1GVzFoq=zUxvi7MTcUYBLO6fbjJPVZziLUk8@mail.gmail.com>
 (Sverre Rabbelier's message of "Mon\, 28 Feb 2011 14\:22\:42 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 470AFD58-435B-11E0-B087-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168121>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Mon, Feb 28, 2011 at 07:48, Junio C Hamano <gitster@pobox.com> wrote:
>> * jc/checkout-orphan-warning (2011-02-18) 1 commit
>>  - commit: give final warning when reattaching HEAD to leave commits behind
>>
>> Likes, dislikes?
>
> I can't find a message containing this commit title, can you link to
> the relevant thread?

This is a re-roll of a fallout from this thread:

    http://thread.gmane.org/gmane.comp.version-control.git/166595/focus=167133

I do think the safety net for detached HEAD is a bit too flimsy, and that
is the motivation behind this.

As I don't think it is necessarily a good idea to attempt to make every
possible operation revertible (e.g., I do not think "oops, I did 'git add'
and I have only "git lost-and-found" to find the old index entry" is a
problem worth solving with extra complexity and storage cost), we should
strike a good balance by adding safety only at key places in reasonable
workflows (as opposed to every step to clutter the "undo log").

I am not convinced that this patch nailed that balance at exactly the
right place, even though I think we are getting closer than before.  In
this sequence:

    $ git checkout somewhere^0
    $ git commit
    $ git reset --hard somewhere_else
    $ git commit
    $ git checkout master

The second commit is protected with the patch, but not the first one,
which is still protected by the reflog on HEAD (i.e. "git log -g HEAD").
You have to know the reflog on HEAD if you _intend to_ work on detached
HEAD anyway, and you don't need this patch if you do---the second commit
can also be recovered from the reflog on HEAD.

So this patch is not about helping people who _chose to_ work on detached
HEAD; instead the patch in its current form is about helping sightseers
who has become _only_ a bit adventurous.  To help people who accidentally
started from a detached state (i.e. starting from sightseeing but then got
very adventurous, forgetting that they are not on any branch) and spent
significant amount of time committing and resetting, the advice message
should teach them to use "log -g HEAD" more explicitly, instead of giving
details of the last state (i.e. "you are leaving %n commits behind...").
