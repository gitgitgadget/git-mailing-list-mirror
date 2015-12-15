From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/10] dir: do not use untracked cache ident anymore
Date: Tue, 15 Dec 2015 11:49:36 -0800
Message-ID: <xmqqd1u7fq5r.fsf@gitster.mtv.corp.google.com>
References: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
	<1450196907-17805-11-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gersh?= =?utf-8?Q?ausen?= 
	<tboegi@web.de>, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 20:49:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8vbU-0003Tb-S3
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 20:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbbLOTtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 14:49:40 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754215AbbLOTtj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 14:49:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A406232095;
	Tue, 15 Dec 2015 14:49:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=husnvcQ3uUnrzr1nRexyUoaqG+c=; b=GrnkEa
	uf9+t15trUJhEZxGVOu3zN2KjMCDkJ0aSdVeqvCRMQaqLRahaQGKDobHP8SknioM
	/8xe8Aqa+AZXp5lBoXZhRW9GjDFEv/NBmz1CSbC1rvHowF3etb1vba+aCptm09qu
	Yti2rMkOk8J7SJNFxfAlJXNnXHODhFuWn5VdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DertxN4FhHdGnv8rWy+b99RQ0HJbRB23
	uP8zn2s318mfw0iPvqGYdmGjL7k0cvuVInevDxPDNkJ6cLbPGMfitxcxbcY6edMk
	kP2Gawnk+qNf9uQmMSj1dMDRJB98Sdsep77cgsh/8SnMxx+q1L3TuoOFwmchnQjq
	+Iz8mzVR35Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9B65A32094;
	Tue, 15 Dec 2015 14:49:38 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0B8C532092;
	Tue, 15 Dec 2015 14:49:38 -0500 (EST)
In-Reply-To: <1450196907-17805-11-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Tue, 15 Dec 2015 17:28:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F96BC2CA-A364-11E5-8DDD-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282496>

Christian Couder <christian.couder@gmail.com> writes:

> +/*
> + * We used to save the location of the work tree and the kernel version,
> + * but it was not a good idea, so we now just save an empty string.
> + */

I do agree that storing the kernel version (or hostname or whatever
specific to the machine) was not a good idea.  I however suspect
that you must save and check the location of the working tree,
though, for correctness.  If you use one GIT_DIR and GIT_WORK_TREE
to do "git add" or whatever, and then use the same GIT_DIR but a
different GIT_WORK_TREE, you should be able to notice that a
directory D in the old GIT_WORK_TREE whose modification time you
recorded is different from the directory D with the same name but in
the new GIT_WORK_TREE, no?
