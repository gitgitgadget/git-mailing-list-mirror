From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v15 7/7] t/t7507: tests for broken behavior of status
Date: Tue, 03 May 2016 08:47:55 -0700
Message-ID: <xmqq4mafp2hg.fsf@gitster.mtv.corp.google.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
	<1462046616-2582-7-git-send-email-pranit.bauva@gmail.com>
	<xmqq7ffcqct1.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPOAWh48YCxA3B+kRxVpkwN32OHW7Qrb9ajs2Cy0S8sjLw@mail.gmail.com>
	<CAPig+cR7pPHZv_z3G+BsLPqP7WYSVUb_7c2qmM+0y-TFeWjaSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 03 17:48:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axcYP-0007lX-Pv
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 17:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933329AbcECPsC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 11:48:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59427 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933769AbcECPr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 11:47:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A2B3173D6;
	Tue,  3 May 2016 11:47:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g7sgbf91eFYfWFjpewyWDyU0WoI=; b=gYvc97
	E3rShDBDGUW7J12m4LENOdkflST5vt/p2xgdS4LWiqNxF7oHckYKI7a0hOwHPirt
	odGLF7981NoHJhRKf42yEV3nmOmm+ufGezFIh/jQBXzC0V44XgZzWDmDHKkxJ+lI
	cZUw7jCb2esk+wEnG2Thx86CfefDgcZGeuNiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d/+Nzb1IoMUnujSInPuvlRtfRqSe5kj4
	KB4BZiBJ/tTrA/vmjNFGD38EejqJftQpYiIRpke82iFOv8GbCU4HBJVubNwCPU47
	yN3+41l87Yug+u03JiViohxZoEbWO7gQ0MAVBqcFfHrlWd9FiACSjSAFTRKizecA
	f6Ox2lKOSfI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 91DEF173D4;
	Tue,  3 May 2016 11:47:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 097B1173D3;
	Tue,  3 May 2016 11:47:56 -0400 (EDT)
In-Reply-To: <CAPig+cR7pPHZv_z3G+BsLPqP7WYSVUb_7c2qmM+0y-TFeWjaSg@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 3 May 2016 01:12:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 67F01012-1146-11E6-860B-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293405>

Eric Sunshine <sunshine@sunshineco.com> writes:

>>>> One previous commit (title: commit: add a commit.verbose config
>>>> variable) introduced a new config variable named commit.verbose,
>>>> so care should be taken that it would not affect the behavior of
>>>> status.
>>>>
>>>> Another previous commit (title: "parse-options.c: make OPTION_COUNTUP
>>>> respect "unspecified" values") changes the initial value of verbose
>>>> from 0 to -1. This can cause git-status to display a verbose output even
>>>> when it isn't supposed to.
>>>> ...
>
> This patch's commit message is perhaps a bit too detailed about what
> could have gone wrong in earlier patches in this series; indeed, it
> misled Junio into thinking that patches in this series did break
> behavior, when in fact, it was instead previous rounds of this series
> which were buggy.

Indeed.  Please forget everything I said about expect-failure, if
the top two paragraphs are describing breakages that this series
does *NOT* introduce.  I was misled by them--and others will, too.
These two paragraphs do not belong to the log message.

Thanks for clarifying.
