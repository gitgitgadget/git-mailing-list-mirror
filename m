From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/6] worktree: new config file hierarchy
Date: Thu, 28 Jan 2016 10:45:59 -0800
Message-ID: <xmqqsi1hilug.fsf@junio.mtv.corp.google.com>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
	<1453808685-21235-1-git-send-email-pclouds@gmail.com>
	<1453808685-21235-5-git-send-email-pclouds@gmail.com>
	<xmqq7fiu7je7.fsf@gitster.mtv.corp.google.com>
	<CACsJy8C3wXL-nE1TfS7V8BFNwaQTjMtkQibCswycpX_teaATpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Max A.K." <max@max630.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 28 19:46:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOra6-0004Qa-MH
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 19:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477AbcA1SqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 13:46:05 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55084 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754840AbcA1SqE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 13:46:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6F3B13E855;
	Thu, 28 Jan 2016 13:46:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+/XH1DDhPsWzcqemB6zMstbG2hg=; b=PJlwIK
	4ZL/gTsDhLzDLKOTRaEC1nw0MoUn7NlLJXDbGRbh5igLZ/Sdpj7rDK7SiKQK8V/L
	BcDmk/H91KKIOir91tcgBKYOfZ6gpJMf6BHMQuca1kKBoFB9l0M+Yars4gvwPsPy
	QsWaRURm+u0mY0reoGof0ZN85PxBCUrhb/WaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z5sa3Vrnl1Ft3CIOgR1n9f3eyuBDTKap
	xl4ctcxOuGrf3uCiPetMh4IZSMyVThPs1LHdaVEyqZHhwDSIddIXx+D1qzfCr06S
	NCx8+uuX0rn5M0wcYYG5Ms1/GNf0s7KU04Gi+Y6l8f/IDZrrCnINVZFy+AX4RIoA
	WcHi039hU/I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6719E3E854;
	Thu, 28 Jan 2016 13:46:02 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.88])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E8C4E3E850;
	Thu, 28 Jan 2016 13:46:00 -0500 (EST)
In-Reply-To: <CACsJy8C3wXL-nE1TfS7V8BFNwaQTjMtkQibCswycpX_teaATpQ@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 28 Jan 2016 19:03:38 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6064263C-C5EF-11E5-BD55-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285021>

Duy Nguyen <pclouds@gmail.com> writes:

>> I cannot see why it cannot live in $C/common/config, which would be
>> read as the fourth alternative in your earlier enumeration.  What I
>> am missing?
>
> I wasn't clear. The last paragraph is about already released git
> binaries, which does not care about $C/common/config. Suppose you add
> a new worktree with new git binary, which will move common stuff out
> of .git/config to common/config, on a shared repo. If the old binary
> reads that repo, it does not see common config, but it does not know
> where common config is either.

Ah, OK.

Would it make it simpler to invent a specific value for 'xxx' that
denotes the main worktree (hence $C/worktrees/xxx/config will always
be read by worktrees including the primary one), not to add
$C/common/ anything, and use $C/config as the common one instead?

Then the repository format version can live in $C/config that would
be noticed by existing versions of Git.
