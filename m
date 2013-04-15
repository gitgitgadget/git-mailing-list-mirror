From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 10:58:36 -0700
Message-ID: <7vr4ibu14j.fsf@alter.siamese.dyndns.org>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com>
 <vpq38us2oov.fsf@grenoble-inp.fr>
 <CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
 <vpqppxvoqsc.fsf@grenoble-inp.fr> <7vobdfztz9.fsf@alter.siamese.dyndns.org>
 <CALkWK0=cNEkE0bUoWJg119o+FaQywJhgkUxiFfLGPSsLrFVZ=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 19:58:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URnfw-0006za-Em
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 19:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920Ab3DOR6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 13:58:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56621 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752729Ab3DOR6j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 13:58:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6A1616655;
	Mon, 15 Apr 2013 17:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QUjYtlkyHDhljlV/ReozYI65jRo=; b=tYpDlb
	I9HkyfybJRewuC701KQPF8DT4obbmNx87VAQN8ZGAHwW3BlydFRHg+gbeHHQiqdh
	lGPtvKHonFRcyQGo6ZsD2zGHiiupjS8M93r9NYIgSvvIJih6XBugUNBpSCGAFndL
	1xlkayVVOdIrmIbg/k2SDiwcFC5ENSd1lWYGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Iugt2vYLKfjrNz+hjZgpzXEgqYXOFWyq
	z6yhEvOxgyiZ1pMK2uIN6RRef95JxQOMCjNbcRiebS4QBQLNYLCTNlbGycGMDjxH
	2wsYk3bviQ7ri7sWvvf3MwjKZPgZ7SIVEF8zTAAyv6nxDetwrPjtCVGoL5e2w4H5
	us+KG1cJSkw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A555A16654;
	Mon, 15 Apr 2013 17:58:38 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1358016653; Mon, 15 Apr
 2013 17:58:37 +0000 (UTC)
In-Reply-To: <CALkWK0=cNEkE0bUoWJg119o+FaQywJhgkUxiFfLGPSsLrFVZ=A@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Mon, 15 Apr 2013 22:08:34 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 196137F0-A5F6-11E2-A9CC-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221275>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>         git-rebase --autostash
>>
>>                 git commit --allow-empty -m 'index part'
>>                 git commit --allow-empty -a -m 'working tree part'
>>                 git rebase --onto $UPSTREAM
>>                 git reset HEAD^
>>                 git reset --soft HEAD^
>
> Why are you rolling your own stash?  What do you have against git stash?

Nothing.  It just felt that it does not _have to be_ implemented
with stash, and explaining things in terms of commit and reset would
be simpler.

If "rebase -m" were to be taught to do this, the natural way to do
so is to 

  (1) Prepare the todo the usual way
  (2) Do those two commits for index and working tree
  (3) Append two insns (exec reset HEAD^ and exec reset --soft
      HEAD^) at the end of the rebase todo file.

Then the usual "rebase --continue" would just work.  Instead you
could use "git stash" at step #2 and add "exec git stash pop" at
step #3.

"rebase--am" could also be told to generate (on the preparation
side) and notice (on the application side) a pair of patch files at
the end that represent the index state and the working tree state
and apply them without making the WIP part into a commit.
