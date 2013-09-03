From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: introduce --exclude=<glob> to tame wildcards
Date: Tue, 03 Sep 2013 08:45:46 -0700
Message-ID: <xmqq8uzdvrh1.fsf@gitster.dls.corp.google.com>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com>
	<7vhae7k7t1.fsf@alter.siamese.dyndns.org>
	<CAMP44s1y2kvSnF3dKDMr9QtS40PNSW93DWCxFUoL658YkqYeVA@mail.gmail.com>
	<CAPc5daVSqoE74kmsobg7RpMtiL3vzKN+ckAcWEKU_Q_wF8HYuA@mail.gmail.com>
	<CAMP44s0P=XF5C8+fU2cJ-Xuq57iqcAn674Upub6N=+iiMpQK0g@mail.gmail.com>
	<xmqqeh9b15x6.fsf@gitster.dls.corp.google.com>
	<xmqq1u5aybri.fsf_-_@gitster.dls.corp.google.com>
	<CAMP44s1hhoPbeBsmN8NL_VtCz3bO-jg1sPP7hovL1kPBhbrXFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 17:45:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGsnh-0006BQ-TT
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 17:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745Ab3ICPpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 11:45:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61437 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755243Ab3ICPpt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 11:45:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E33473E122;
	Tue,  3 Sep 2013 15:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uGKf58qvzLwjQw0jix6C7RYQxIc=; b=ZedhVt
	GRhEGBCZ3m9eyFtXvAWIFvdANDsqotijpOiiqdYSAKLCTpBUXXjfnVYkEff52N2L
	RsEnwSeDwmV9rlM8ZtFcqDLhESy0ZB2QhiLexU2fIU3vroUUCaIf9Ubz965wLGsJ
	evn13KGrHym6CFKba2MfIqsWORyMyj3Xu13Ho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JaRXzxr9EHq93z+dKHVcyl9M3YYQRtvj
	Zf3tfq7SCGedEw4DmtAqU1FH88RTH3D++Krao0yk64AHV1BTDnSepefzOfpdMqm8
	UdDW+BqPwYudLvLth5tQY58x7FmYtUWE/dN6PEpDUYY+3Q2bC3i3wTKcfIjlar/V
	4HG8sM4IwyA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6E693E121;
	Tue,  3 Sep 2013 15:45:48 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31EFB3E11B;
	Tue,  3 Sep 2013 15:45:48 +0000 (UTC)
In-Reply-To: <CAMP44s1hhoPbeBsmN8NL_VtCz3bO-jg1sPP7hovL1kPBhbrXFQ@mail.gmail.com>
	(Felipe Contreras's message of "Sat, 31 Aug 2013 14:33:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E735C74A-14AF-11E3-8BE7-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233731>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Fri, Aug 30, 2013 at 6:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> People often find "git log --branches" etc. that includes _all_
>> branches is cumbersome to use when they want to grab most but except
>> some.  The same applies to --tags, --all and --glob.
>
> This idea looks very familiar, from the wording of this commit message
> it seems you came with the idea out of nowhere. Did you?

As the comment after three-dash quotes, the inspiration came from
this suggestion:

 > It may be a good idea to step back a bit and think of this topic as
 > a way to enhance the --branches option and its friends with only the
 > inclusive wildcard semantics.

which is not anything new.  It takes from J6t's

      To unclutter 'git branch' output, I rename work-in-progress branches
      to begin with "wip/", ready-to-merge branches do not carry this
      prefix. To inspect unmerged work of the latter kind of branches I
      would like to type... what?

But the thing is, that is nothing new, either.

Pretty much ever since we added --branches --tags and later --glob,

 (1) traversing from "almost all but minus some branches", and
 (2) stopping traversal at "almost all but minus some branches"

were what people sometimes wanted to have (which is pretty much what
the first paragraph of the proposed commit message says) using
"negative glob". Looking the phrase in the list archive finds for
example $gmane/159770 from 2010, but I would not be surprised if you
find older message wishing the same.
