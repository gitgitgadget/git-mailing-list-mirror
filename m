From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/25] prune-safety
Date: Thu, 16 Oct 2014 14:10:56 -0700
Message-ID: <xmqqoatbsotb.fsf@gitster.dls.corp.google.com>
References: <20141015223244.GA25368@peff.net>
	<xmqqsiinsoyk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 23:11:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XesKA-0006Tq-Cl
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 23:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbaJPVK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 17:10:59 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61239 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751491AbaJPVK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 17:10:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 23AC0150BA;
	Thu, 16 Oct 2014 17:10:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R6g0WJ9WWsIO7AXxwaWfp0b5Y/c=; b=E9XjLW
	JnJwc/VfE9Fvrnvu8qU1wbeJFGiBjtxPoL3qwp91wyt7ADRdYGQTFYucywBDZ3ud
	zDNrdy6NHKG3qJaUjGCuxf4hyKs0wpVZA7JHJHczSc+fRHr0hnmGOpu4/q0/HxOH
	Hih+trK8iFEVHugAHfKIxjg+4gz7Pa8Bw0JBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=paFiP91pnSq/MYkA6VNqMK43mlaJoGlc
	7c0OmDf0QZc8J1rqzyfvZS59Cl/p3S7XcNXAplI8HpO4qpExM1EDaenxaQAvYVCi
	vIZZZSeyL0PtP2ziRbaLrOrytEhyx0abibULhIaYGhPkvbNfn/w4spJBhnqF2Wdz
	PDcysbkfevw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1912C150B9;
	Thu, 16 Oct 2014 17:10:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E95A150B8;
	Thu, 16 Oct 2014 17:10:57 -0400 (EDT)
In-Reply-To: <xmqqsiinsoyk.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 16 Oct 2014 14:07:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EC3EFE7C-5578-11E4-AEF5-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Somewhere in this series the object enumeration seems to get
> broken.  "git clone --no-local" of git.git repository died
> with
>
>     Cloning into 'victim-7'...
>     remote: Counting objects: 173727, done.
>     remote: Compressing objects: 100% (43697/43697), done.
>     remote: Total 173727 (delta 130908), reused 170009 (delta 128151)
>     Receiving objects: 100% (173727/173727), 33.45 MiB | 13.69 MiB/s,
>     done.
>     Resolving deltas: 100% (130908/130908), done.
>     fatal: did not receive expected object a74380c3117994efba501df1707418eb6feb9284
>     fatal: index-pack failed
>
> where a74380c... is such an object.

Ehh, "such" is a nonsense.  It is a blob that directly is pointed by
a tag that is in refs/tags/*.

> If you have a clone of https://github.com/git/git.git
>
> $ git rev-list --parents --objects --all | grep  a74380c3117994
>
> would be an easy way to reproduce.
