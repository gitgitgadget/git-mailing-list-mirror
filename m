From: Junio C Hamano <gitster@pobox.com>
Subject: Re: No fchmod() under msygit - Was: Re: [PATCH 00/14] Add submodule test harness
Date: Mon, 14 Jul 2014 14:18:03 -0700
Message-ID: <xmqqha2jy704.fsf@gitster.dls.corp.google.com>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de>
	<53B46425.3030000@web.de> <53B4F0AA.10809@web.de>
	<53B5C7AC.4040701@web.de>
	<xmqqsimddrq3.fsf@gitster.dls.corp.google.com>
	<53BAF7AF.4020901@web.de> <53BC47BD.1000705@web.de>
	<53BC53C3.1010304@ramsay1.demon.co.uk> <53BCE3A7.8070600@web.de>
	<20140709200046.GB17454@dcvr.yhbt.net> <53C42FE0.10904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Torsten =?utf-8?Q?B=C3=B6gershause?= =?utf-8?Q?n?= 
	<tboegi@web.de>, Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 23:18:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6ndX-00020H-Uf
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 23:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757241AbaGNVSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 17:18:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58032 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757226AbaGNVSL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 17:18:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F0DF62892A;
	Mon, 14 Jul 2014 17:17:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rww6Z4P71NHROEfNCDflSEBWcak=; b=Ubvh2g
	s5sT7IPUdAXQqTV3WILxjhHQu60krYzcf9JOehlE2eAwZ3vKW/BYQZ38DqMwmulZ
	ySUv7pvVnNfuEybVBWyXv+x9C9Jo9pOCkgjJyAgCEWrqw72wpIlbOvB9IY+6UM74
	gDDV11Tm2ecaHYIY903W/pSDFtNG3RbRZpoxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I/z9pgk7FQAMGEpjayHU85i8Z5vxehg1
	C/3rxGSxnVi8jfRQNQfmeRwGC4NQIqpw56i4KNXVZrcKvc6rLzRF1m5jNW+FlrEv
	oFIT2b5LNRF2fo4dWe0MsBqRISqB3iJwSbXxROMVhx/xUxC9KmyM0SkNA3dpBuB3
	FLh5J4o0qWM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E68CE28929;
	Mon, 14 Jul 2014 17:17:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5F40F28925;
	Mon, 14 Jul 2014 17:17:47 -0400 (EDT)
In-Reply-To: <53C42FE0.10904@gmail.com> (Karsten Blees's message of "Mon, 14
	Jul 2014 21:30:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4DB7FA90-0B9C-11E4-AA6C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253536>

Karsten Blees <karsten.blees@gmail.com> writes:

> 1.) Permissions of files in .git are controlled by the core.sharedRepository
> setting, and your patch seems to break that (i.e. if someone accidentally
> has made .git/config world readable, git-config no longer fixes that, even
> if core.sharedRepository=0600).

For any repository, when you further run "git config" to update it,
.git/config always exists with the permission bits initialized when
"git init" was run there.  And Eric's change is to propagate that
same bits to a new file, so there wouldn't be any difference, no?

And $HOME/.gitconfig should not be governed by "sharedRepository",
and that was the primary focus of Eric's change, I would think.
