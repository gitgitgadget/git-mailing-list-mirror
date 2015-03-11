From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit --amend safety check?
Date: Wed, 11 Mar 2015 10:56:20 -0700
Message-ID: <xmqq1tkv770b.fsf@gitster.dls.corp.google.com>
References: <CAJo=hJuwdOzNZSVBRAPDz97Gdoi6JWvYxE0ufY+Hd9K8jjCqfA@mail.gmail.com>
	<xmqq8uf46ru8.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.2.00.1503110931100.26355@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Mar 11 18:56:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVks4-00033B-Bt
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 18:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbbCKR4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 13:56:35 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56335 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751052AbbCKR4e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 13:56:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E84DB3DA25;
	Wed, 11 Mar 2015 13:56:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V4PmJXAnh4krtxjjQL92/MkM6xU=; b=QfUwMY
	M4Xzchotgivrsr4z/PY5qQENPtmVxO/H8S8cVF+i6+mKSnVaSl6/uZdwvqQ6LFZ6
	UVMCDTx6FipAb3tKVuTzjgRn8QPOnULBL+WF9n//+Fi45TOQBFEsqToy+CSKaR/1
	n3yc97vaCwF0hGeHy/eGDPWJGRAW5Tbh8sxJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S2qku9HCDV4lWAiJYI2LLhvDOYeCHgOi
	0PVvpq658pf7oJI+M8J6Ycl3loyjEESORntjz/CE8Tl6PZdehNDBATduuKya3Hqh
	Q9EzuuPtkeYYbMzU9ex/10ZtXUSKwPciZFHXgfy3vQiAGDj5z66MZeIsBRcbLWG8
	hElI4zZwvks=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DFC503DA24;
	Wed, 11 Mar 2015 13:56:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 173903DA12;
	Wed, 11 Mar 2015 13:56:22 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.1503110931100.26355@ds9.cixit.se> (Peter
	Krefting's message of "Wed, 11 Mar 2015 09:37:09 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ED6C8B72-C817-11E4-B8AE-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265329>

Peter Krefting <peter@softwolves.pp.se> writes:

> For commit --amend, I would say it would refuse to amend if the commit
> you are trying to amend
>
>  1. was not authored by yourself (and --reset-author was not given), or
>  2. is reachable (or is the tip?) from an upstream branch.

I agree that 2. is a safe check without too much risk to trigger a
false positive (and the tip of origin/master is reachable from
origin/master, so we do not have to single out "is the tip").

On the other hand, 1. may be good in training wheel mode, but once
you start allowing amends and rebases, I do not see why it should be
considered possibly bad as long as check 2. says it is OK to rewrite.

> At least (1) would have saved myself from mistakes that take time and
> effort to clean up (I have used Git for eight years or so already, and
> I *still* do that kind of mistake every now and then).

Isn't your friend reflog helping you to clean things up?  The
difference between the state before you started amending and the
current state is what you did since then, so...?
