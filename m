From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Multiple worktrees vs. submodules fixes
Date: Wed, 15 Oct 2014 10:09:59 -0700
Message-ID: <xmqq1tq9xnrs.fsf@gitster.dls.corp.google.com>
References: <1413090791-14428-1-git-send-email-max@max630.net>
	<CACsJy8BUtkWKE+P_sHgpAY6wJ9tpzxZRtZHULiLoO=dGnBjkHQ@mail.gmail.com>
	<543D58D9.5060606@web.de> <20141014203114.GB8157@wheezy.local>
	<CACsJy8AmBr2YTJkVw4BDD95RVE91EEBtEyakOpb77NDXaVBzJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Max Kirillov <max@max630.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 19:10:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeS5U-0007j5-Rt
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 19:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbaJORKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 13:10:07 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61354 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750880AbaJORKF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 13:10:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 60CF4145AD;
	Wed, 15 Oct 2014 13:10:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=js6/IIuCENJQMbWlqReCIzMLYSE=; b=jGnFI5
	T6Zyp7lLH86vmwEWQWnfgBNszit9rvaS0Q2ZTaGw2BZCzAyrLyql0t+V4VRu2gsi
	V9IujPp5V5n+c6bQbdEuX1vjum98SShb2ADK5FE2ahkj7f71gyqOr1PqaufscA0q
	v5LJzx6ngMzeaaNkREm3X1uG15d8aBFvCCTcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eEpeiZuFQCIprZmUG2PN12zFSRU35u/j
	O6M/uhbbFc70e7atD3S0TkrpOQmudBL5YOK2naWRP6BKTxi/lQ0d62kFlE+3rj7C
	AhjlpT7prxYql3Ho8zbMhVELgqfrWwviU1URhGa9cVQe3XN5RsAyJhUVU2AEzt5r
	hmxP+8RWP8E=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 546BE145AC;
	Wed, 15 Oct 2014 13:10:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E5E4145A8;
	Wed, 15 Oct 2014 13:10:01 -0400 (EDT)
In-Reply-To: <CACsJy8AmBr2YTJkVw4BDD95RVE91EEBtEyakOpb77NDXaVBzJA@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 15 Oct 2014 20:08:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1932E952-548E-11E4-B8DA-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Oct 15, 2014 at 3:31 AM, Max Kirillov <max@max630.net> wrote:
>> On Tue, Oct 14, 2014 at 07:09:45PM +0200, Jens Lehmann wrote:
>>> Until that problem is solved it looks wrong to pass
>>> GIT_COMMON_DIR into submodule recursion, I believe
>>> GIT_COMMON_DIR should be added to the local_repo_env array
>>> (and even if it is passed on later, we might have to
>>> append "/modules/<submodule_name>" to make it point to the
>>> correct location).
>>
>> Actually, why there should be an _environment_ variable
>> GIT_COMMON_DIR at all? I mean, gitdir is resolved to some
>> directory (through link or environment), and it contains the
>> shared data directly or referes to it with the commondir
>> link. In which case anyone would want to override that
>> location?
>
> It's how the implementation was built up. First I split the repo in
> two and I need something to point the new/shared part.
> $GIT_DIR/worktrees comes later to glue them up. Keeping it an
> environment variable gives us a possibility to glue things up in a
> different way than using $GIT_DIR/worktrees. Of course the odds of
> anybody doing that are probably small or even near zero.
>
> Still consuming the rest of this thread. Thanks all for working on the
> submodule support for this.

Hmph.  I was hoping that the multiple-work-trees topic was ready for
'next' by now, but we may want to wait to see how the interaction
with submodule plays out to have another chance of a clean reroll
before it happens.  This is a topic with large impact and is quite
intrusive code-wise, even though the intrusive parts are cleanly
done.  So we'd want to take more time to unleash it to the general
public than more usual small scale topics, anyway.

Thanks.
