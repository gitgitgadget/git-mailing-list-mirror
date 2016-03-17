From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Code reorgnization
Date: Thu, 17 Mar 2016 12:10:44 -0700
Message-ID: <xmqqy49gzzrf.fsf@gitster.mtv.corp.google.com>
References: <20160317111136.GA21745@lanh>
	<CAGZ79kbcwFcPSJ9xwE6xi4gQ871m3brtfAut2TChGNzL-foxdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 20:10:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agdJs-00074D-9N
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 20:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031207AbcCQTKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 15:10:49 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64198 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030695AbcCQTKr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 15:10:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0275E4C657;
	Thu, 17 Mar 2016 15:10:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ud9HZDksJtnNPJ1or1l+rDTWrpw=; b=qXtbeN
	vUF7TkbEMZ4o41J60+m1JeObkDRAbpwbpErupecwYAt7OhYKzg3CkGmeWzQ6m/3l
	tbKB/CwcDvzgwMdHN90q4CNYv6EwYjTGR1Ij5jL4J+fzAkjsXgIvMMoIjubmGaoe
	tiEnbhSXq2WOQgFLw/83H+FOChE/tu3VdWNZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p9BD8zff4o5geICAJ4cbSkdd26oatf2G
	IPheNdMGzzFuAGcnYUu3ygix1j3UnrHE8JhlOPaxCcaj4ru1f6WAtnDji7E6wZeF
	A2F+ljsRatzOLLqnQIejkiiVF7bDq0DHqbW6orU19p5uJWJk+l+it0/GO+loKPxL
	aLwx1fWcjMc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EB2014C656;
	Thu, 17 Mar 2016 15:10:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6C2444C655;
	Thu, 17 Mar 2016 15:10:45 -0400 (EDT)
In-Reply-To: <CAGZ79kbcwFcPSJ9xwE6xi4gQ871m3brtfAut2TChGNzL-foxdQ@mail.gmail.com>
	(Stefan Beller's message of "Thu, 17 Mar 2016 11:37:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F374ADD4-EC73-11E5-B782-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289152>

Stefan Beller <sbeller@google.com> writes:

> For now I would just go with 3 directories:
>
> non-git/ (or util, helpers, or anything that could be ripped out and be useful
>     e.g. strbufs, argv-array run-command, lockfile
> git/ (maybe called lib? All stuff that is pure Git and is used for libgit
>
> builtin/ (as we have it today + all that stuff that doesn't go into
> git/ very well?)

It is unclear where you want to have standalone programs in the
above.  I'd say lib/ and src/ for the first two, where lib/ is for
things that could be lifted without any Git dependencies and src/
for everything else.

Aren't there some folks who link directly with our codebase (I am
thinking about cgit, but hjemli.net/git/cgit does not seem to be
responding anymore)?
