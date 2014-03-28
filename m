From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Borrowing objects from nearby repositories
Date: Fri, 28 Mar 2014 10:02:31 -0700
Message-ID: <xmqq8urucl3s.fsf@gitster.dls.corp.google.com>
References: <BFF5FBC7-8F53-4958-8D56-90EADD3AD626@kellerfarm.com>
	<CACBZZX5teZuqtNkPT4PdXJn=g34cOhRH2oNehROT8kJ_M2cgfg@mail.gmail.com>
	<xmqqtxammctc.fsf@gitster.dls.corp.google.com>
	<xmqqvbv1kjoc.fsf@gitster.dls.corp.google.com>
	<3533946C-DE97-4214-9B55-F5B788DDD952@kellerfarm.com>
	<xmqqbnwskgwd.fsf@gitster.dls.corp.google.com>
	<8030ADEA-B11F-47E8-AFE7-8F46E861F560@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git List <git@vger.kernel.org>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 18:02:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTaAx-000360-Ls
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 18:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbaC1RCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 13:02:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59443 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751760AbaC1RCf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 13:02:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F21E77281;
	Fri, 28 Mar 2014 13:02:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b/ObeCt8lvonl5Ko7odLzaszzp4=; b=M3CTrc
	ViaDMLzzhfLiKgLPLKXtfJ5GlTD90PhfzyqNUxLS2WuxjjeBgeNjLd6EPG68t4nY
	gJyqGcegp6Bz8dJqJWFqy3bd2KxwD4+BzXbDaq1gHb6oyB7Or+YApyKj0Auqxd0b
	Joh/klJvgExdk1a7AmpD+CtScbXS38+a57MbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rcrHkf0RFX07kf4boboF7LGEm0yWjdOv
	UQHYGxnq1piROIvLq/wpxB9iMb+ZKygViVNNG77VpDx1XLV4RRnxt/JW6t0/04fH
	ovbR7XF9jXDyK7k682fBy3QNBh6yugsXPOUpCdLYuckImpGNa0LUsgmeP2nM5SIs
	u4Ws029dTEI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7152977280;
	Fri, 28 Mar 2014 13:02:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76A5F7727E;
	Fri, 28 Mar 2014 13:02:33 -0400 (EDT)
In-Reply-To: <8030ADEA-B11F-47E8-AFE7-8F46E861F560@kellerfarm.com> (Andrew
	Keller's message of "Fri, 28 Mar 2014 10:52:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C1448C32-B69A-11E3-8912-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245397>

Andrew Keller <andrew@kellerfarm.com> writes:

> Okay, so to re-frame my idea, like you said, the goal is to find a user-
> friendly way for the user to tell git-clone to set up the alternates file
> (or perhaps just use the --alternates parameter), and run a repack,
> and disconnect the alternate.  And yet, we still want to be able to use
> --reference on its own, because there are existing use cases for that.

Here are a few possible action items that came out of this
discussion:

 1. Introduce a new "--borrow" option to "git clone".

    The updates to the SYNOPSIS section may go like this:

    -'git clone' [--reference <repository>] ...other options...
    +'git clone' [[--reference|--borrow] <repository>] ...other options...

    The new option can be used instead of "--reference" and they
    will be mutually incompatible.  The first implementation of the
    "--borrow" option would do the following:

      (1) run the same "git clone" with the same command line but
          replacing "--borrow" with "--reference"; if this fails, exit
          with the same failure.

      (2) in the resulting repository, run "git repack -a -d"; if this
          fails, remove the entire directory the first step created,
          and exit with failure.

      (3) remove .git/objects/info/alternates from the resulting
          repository and exit with success.

    and it may be acceptable as the final implementation as well.


 2. Make "git repack" safer for the users of "clone --reference" who
    want to keep sharing objects from the original.

    - Introduce the "repack.local" configuration variable that can
      be set to either true or false.  Missing variable defaults to
      "false".  

    - A "repack" that is run without "-l" option on the command line
      will pretend as if it was given "-l" from the command line if
      "repack.local" is set to "true".  Add "repack --no-local"
      option to countermand this configuration variable from the
      command line.

    - Teach "git clone --reference" (but not "git clone --borrow")
      to set "repack.local = true" in the configuration of the
      resulting repository.
