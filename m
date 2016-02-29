From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv19 00/11] Expose submodule parallelism to the user
Date: Mon, 29 Feb 2016 13:19:31 -0800
Message-ID: <xmqqwppn8ba4.fsf@gitster.mtv.corp.google.com>
References: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
	<1456444119-6934-1-git-send-email-sbeller@google.com>
	<56D4AE8A.2050403@kdbg.org>
	<xmqq1t7v9qou.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY5nxDQ_o0L_MOYFOx4FPH1apW-TuB88UypuwDaLuKGNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 22:19:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaVEB-0008C3-2r
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 22:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbcB2VTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 16:19:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62521 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750755AbcB2VTe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 16:19:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0240448479;
	Mon, 29 Feb 2016 16:19:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VlGSEzpn/kdJ4YnyLOoVWKfFc6I=; b=U/lWAz
	+qo8/QNNHq6LEe4fJIKjjxL6bmoOZJ70MDHWDBNdk6+Bs0ingv7J5dQuURkY9TUc
	An0mLiRLC7gLtgY6+BK7qtfmuHuwXKzwQymNHQo27yd1/IoXceS5cnnxSN/7Qgnm
	NWv80TiMJrQ/Im88OV81mZONlwdXW8CqKSQQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IxGzCrRLgAKyPXTlZkCeg6ncFWzOp1rT
	ncOZFwVK2CbabhDl78GDRQ5Yk9qbW12xXf/C+MGHSWKsKDfUxsF8oaABQLDkIMsM
	t37t78EOlbCDCvXIfnVD3DX7F1T+qGUgHTZFj75wmOLvXTnA6Ss/nmA3uYHWBWiN
	njwCFlfLssg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E415048478;
	Mon, 29 Feb 2016 16:19:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4A6D948477;
	Mon, 29 Feb 2016 16:19:32 -0500 (EST)
In-Reply-To: <CAGZ79kY5nxDQ_o0L_MOYFOx4FPH1apW-TuB88UypuwDaLuKGNQ@mail.gmail.com>
	(Stefan Beller's message of "Mon, 29 Feb 2016 13:06:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 200AC7A4-DF2A-11E5-92F7-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287903>

Stefan Beller <sbeller@google.com> writes:

> Maybe we want to remove the struct child_process from the
> function signature of the callbacks and callbacks need to rely on
> the data provided solely thru the pointer as passed around for
> callback purposes, which the user is free to use for any kind
> of data.

I think that is the most sensible.

> As a rather quickfix for 2.8 (and 2.7) we could however just
> breakup the finish_command function and call child_process_clear
> after the callbacks have run.

That would not fix the case where run_command() fails, clears child
and then start failure callback, no?
