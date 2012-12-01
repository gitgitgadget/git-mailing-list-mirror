From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] reset: learn to reset to tree
Date: Sat, 01 Dec 2012 01:24:17 -0800
Message-ID: <7vd2yunn0e.fsf@alter.siamese.dyndns.org>
References: <CANiSa6isDKAgxHWqh5XiQ-adT3-ASFtvAshp028DTcotjQxzmQ@mail.gmail.com>
 <1354213975-17866-1-git-send-email-martinvonz@gmail.com>
 <1354213975-17866-2-git-send-email-martinvonz@gmail.com>
 <7v4nk8qmaj.fsf@alter.siamese.dyndns.org>
 <7vzk20p6ik.fsf@alter.siamese.dyndns.org>
 <CANiSa6hWYsfm0t+s_q7=CcD78yNfpuduxkRc35xW8qDOy97W3g@mail.gmail.com>
 <CANiSa6i2f-4jXFUpYV6+fYnpG-tSRRA3cRg_v-v=UrgfwfFz_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 10:25:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TejKR-0000Xy-7f
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 10:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748Ab2LAJY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 04:24:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63956 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751602Ab2LAJY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 04:24:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 447D57076;
	Sat,  1 Dec 2012 04:24:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xfKyLcL02F+LqnQ73Mi5ewx708E=; b=TNof+3
	DSUmHSy3tad4MqffLe63Ct9G2TF2yyKAFgqJyZITgn/QwWfEe/BWANCSfyoAHpDF
	3m2gWkO9hZUTtwxQzhpnWQjx/Sp9ueTM1cIkIk0duf978Cn5VKV1abdu9PTEZqMc
	bS3Gf0Uqo1P+OaNLmYjUmPfg8W2Y3OCH15VTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OhtKtteiu2eHOP7SWR2RLi40hBr1/1dQ
	IbD/AHw/dlYECs3GFQli6K7+k39MAcEe+JJUuJjn1mHqaF1U/bk7C9k1pFlkR0zh
	kaz/bbpuldbWCXfG5d4LFOCcTrgKQnJFGBpLPO4Ch92PhNf+cC24OQHMJ9spiJHF
	6GS/x3UIODI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 321C17075;
	Sat,  1 Dec 2012 04:24:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1015C7072; Sat,  1 Dec 2012
 04:24:23 -0500 (EST)
In-Reply-To: <CANiSa6i2f-4jXFUpYV6+fYnpG-tSRRA3cRg_v-v=UrgfwfFz_g@mail.gmail.com> (Martin
 von Zweigbergk's message of "Fri, 30 Nov 2012 08:45:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E5301130-3B98-11E2-A119-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210956>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> On Thu, Nov 29, 2012 at 2:00 PM, Martin von Zweigbergk
> <martinvonz@gmail.com> wrote:
>> Slightly off topic, but another difference (or somehow another aspect
>> of the same difference?) that has tripped me up a few times is that
>> "git checkout $rev ." only affects added and modified files...

"checkout $commit pathspec" has always been about checking out the
contents stored in the paths that match the pathspec from the named
commit to the index and also o the working tree.  "checkout
pathspec" is similar, but the stuff comes out of the index.

When pathspec is "dir/", it does not match the directory whose name
is "dir".  The pathspec matches the paths that store blobs under
that directory.

In other words, "checkout dir/" (or "checkout HEAD~4 dir/) has never
been about "please remove everything in dir/, and then check out
everything in dir/ from the index (or from HEAD~4)".  The "please
remove everything in dir/" part is not the job of "checkout"; of
course, you can do it as a separate step (e.g. "rm -fr dir/").
