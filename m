From: Junio C Hamano <gitster@pobox.com>
Subject: Re: sb/submodule-parallel-fetch,
Date: Fri, 11 Dec 2015 15:07:22 -0800
Message-ID: <xmqqvb84d1p1.fsf@gitster.mtv.corp.google.com>
References: <xmqqmvthhqgf.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaA6Lo1W-SudX6v5styyGrX-igGC7i=u5AYOvFYK0DOGA@mail.gmail.com>
	<xmqqvb85g8v9.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY8M-Xv1s4-s7HnjxZ_X19SR4PsWMtQ3yogqN=vjDiMwQ@mail.gmail.com>
	<566B4207.8020009@kdbg.org>
	<CAGZ79kYOtoWHCzpeHGrCEjTUuKYB3rogfV2dxL_TL5Pcu59RSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 00:07:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7Wmj-0007KX-2V
	for gcvg-git-2@plane.gmane.org; Sat, 12 Dec 2015 00:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274AbbLKXH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 18:07:26 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62772 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755218AbbLKXHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 18:07:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA68432E25;
	Fri, 11 Dec 2015 18:07:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XeZHID4RxURkTqMhE5M26ChdU48=; b=TeCEfK
	m7C7V8SyYkqts7Z8iVaki4eHW1d6+2tJqBkSIAOENZBqaHMOJM+7TM5t0SSerH50
	3wYDERIE2XtX7yeRONlsGnsaKC9qaCFAmRPyjQX5vmDZkYwkbFoj788KWTAAO14F
	y+DvZFB7dJDENBY60FWb9du2xnjItLH5ijBdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w17eOGZCW4Rj83wKz0XF1ODLCJD8Ll1f
	kydBiLQbraLHe9Ua7Rk9wy+7jp5eE/B+hp/kmzh4+YXBRl4LlDl/g0mlVSz8OYSg
	QSTP6JVL9lUgAUDkQCfIyMcbL39REPFn+E17V5hG2BNikgLkcRHsOfKQs9WOMRsr
	JuGKP9ujVlg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B0E9C32E24;
	Fri, 11 Dec 2015 18:07:24 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4806B32E23;
	Fri, 11 Dec 2015 18:07:24 -0500 (EST)
In-Reply-To: <CAGZ79kYOtoWHCzpeHGrCEjTUuKYB3rogfV2dxL_TL5Pcu59RSg@mail.gmail.com>
	(Stefan Beller's message of "Fri, 11 Dec 2015 14:52:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F08F5A56-A05B-11E5-9A0C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282284>

Stefan Beller <sbeller@google.com> writes:

> On Fri, Dec 11, 2015 at 1:37 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>>
>> Generally, I'm already quite satisfied with the state of the
>> infrastructure at the tip of the branch.
>
> I was about the rework the patch series.

OK.

I think the very early part of the series, up to 8fc3f2ee (sigchain:
add command to pop all common signals, 2015-09-30), may be fine
as-is (i.e. just rebase on top of updated 'master').

The step after that, i.e. asynch processor, is the most interesting
and important one.  Since it was written, I think the improvements
that we want to be rolled into it from the beginning are:

 - do not rely on waitpid(-1);

 - no need for set_nonglocking(), squashing a4433fd4a and
   6f963a895a9 in;

 - correct the early-shutdown bug 79f38577 and again in 63ce47e1;

 - child_process_clear() in 1c53754a, which probably will become
   unnecessary if the series is rebuilt on top of updated 'master';

 - follow-up fixes and enhancements to the tests in c3a5d11 and
   74cc04d;

 - debugging support in 7eb93e91069 (from the other series that
   builds on top).

That would slim down not just the total number of patches, but also
the amount of the code that needs to be looked at (as we would not
add code only to later remove or fixup).
