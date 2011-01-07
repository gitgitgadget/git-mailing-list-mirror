From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvs*: Make building (and testing) of CVS interface
 scripts optionally selectable
Date: Fri, 07 Jan 2011 14:05:59 -0800
Message-ID: <7v39p45pyw.fsf@alter.siamese.dyndns.org>
References: <1294433290-9262-1-git-send-email-robbat2@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Fri Jan 07 23:06:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbKS4-00051u-FF
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 23:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143Ab1AGWGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 17:06:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54023 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988Ab1AGWGK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 17:06:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DFC162956;
	Fri,  7 Jan 2011 17:06:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e9EA5KdFYpIOHRnU2AWIF841WsQ=; b=RFCJzG
	AiBBnrJy3YJcNgLi1aHaaD52I+uQ97mP+OS+1Nnn/Ms9vQTFwBHa68BvDLg5jviM
	EXiJi3rxdb3kc1fsUjhRmsOmofQIB7Q2T5aNHbaaFFcd3BsSx6WujfdxYtPP7lKT
	ySAkrF6BfNMJpRo5OjkSEfOSu46xDfq5HaqlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rSsW4uJMET3/QEBmd9N9S/7h0twYQqnk
	Fk/YsIisGEPpUFB3P/3PMc+VJS1UrnMtHYYJgU8FRAoGb+QXjdru+16NkshfA4Qk
	pe19Bik792Yp++m2TdkDp4DnMp7UNSPWtVpuA7jRcOO25XWiWejcvmKhRdbGiBhz
	dRB0vYQLtHM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AD66E2955;
	Fri,  7 Jan 2011 17:06:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 924832954; Fri,  7 Jan 2011
 17:06:39 -0500 (EST)
In-Reply-To: <1294433290-9262-1-git-send-email-robbat2@gentoo.org> (Robin H.
 Johnson's message of "Fri\,  7 Jan 2011 20\:48\:10 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 696E0798-1AAA-11E0-918D-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164772>

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> Presently, the CVS interface scripts are always built, and their
> test-suites run based on a binary named 'cvs' happening to return zero.
> If there something other than the real CVS there, bad things happened
> during the test-suite run.

Is that a problem?

It makes sense to let people whose system happens to have a working cvs to
omit cvs interoperability bits when they know the do not want them, and
that alone would be a good enough motivation.

I'd even consider the above justification of yours detrimental---it would
be an excuse for other people to add patches to support NO_CAT, NO_DIFF,
NO_LS, ... saying "if a binary 'cat' that is not cat is there, things
break, so work it around".  That is a road to nonsense land.

> This patch implements NO_CVS in the manner of NO_PERL, and ensures that
> the CVS scripts get the unimplemented variant when appropriate, as well
> as making sure that the tests properly declare CVS as a prerequisite
> (shortcut to test_done like the Perl prerequisites).

While the patch looks good, some people seem to prefer skipping individual
tests without shortcut; see 900eab4 (t/t9600-cvsimport.sh: change from
skip_all=* to prereq skip, 2010-08-13) for example.  I am slightly in
favor of the short-cut as I haven't heard convincing argument against it
other than "skipped statistics" which I don't think is interesting nor
accurate anyway.

I wonder if "check PERL and CVS prerequisite and say test_done" should be
made into a helper in lib-cvs.sh or somewhere instead of repeating them in
individual tests, but that is a minor point.
