From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git show -m with a parent number
Date: Mon, 28 Mar 2016 12:31:20 -0700
Message-ID: <xmqqoa9yxuuv.fsf@gitster.mtv.corp.google.com>
References: <nd9gq6$412$1@ger.gmane.org>
	<20160328191608.GA22602@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Anatoly Borodin <anatoly.borodin@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 28 21:31:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akcsr-0005iB-GP
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 21:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbcC1TbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 15:31:25 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64759 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751164AbcC1TbY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 15:31:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5051B4EFD6;
	Mon, 28 Mar 2016 15:31:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oU+EtQ2xzrYAUw2M/4NK6+hCTB0=; b=BAnLxE
	K01aphyInde/o172qydNtEVEZFRgFB6tqqGqH1WrfwdMV1QaEG7pZLAKP+MNsjF8
	oN8+AI/3f9STZU+0czVs8pjtdXkKKveg8qkVCRE/gwM/FKrDp6HuVNRggNqcsh5t
	+xXC0cqOZoGpq1hXOXxi+irXB0ZAdUgcp4N4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wYTvGOZ4sT1w2y/htmaHwd4Ri+e87ry8
	hbaLMPi5Ywl3BT5UitzumQD/U1PTOH8izdYmaLEjKtYrACVVAIK03wepVQ1e57t+
	JGY5Qr/+mFlgtuj2LwVe51s31q+mfAmMDnGn7LziP5+eEbCooyRYf4Ue2kdapPYO
	JO52g+512sM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 467FC4EFD5;
	Mon, 28 Mar 2016 15:31:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B8FC04EFD4;
	Mon, 28 Mar 2016 15:31:21 -0400 (EDT)
In-Reply-To: <20160328191608.GA22602@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 28 Mar 2016 15:16:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A6E6889C-F51B-11E5-B5C5-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290059>

Jeff King <peff@peff.net> writes:

> On Sun, Mar 27, 2016 at 08:46:02PM +0000, Anatoly Borodin wrote:
>
>> is there a good reason for `git show -m` to not accept the number of a
>> parent of a merge commit? I can run `git show --first-parent COMMIT`,
>> but need to write `git diff COMMIT^2 COMMIT` every time I want to diff
>> with the second parent!
>
> I think it could, but nobody has yet found it useful enough to
> implement.

For "git show" that does not traverse the history, there may be
occasions where showing a diff with the second parent might make
sense (e.g. the user merged two histories in a wrong direction in
the past and it is too late to rewrite).

I think there are two reasons behind the current state.  Because it
does not make any sense for "git log -m 2" to show diff with its
second parent while traversing many commits, the "git log" codepath
is not prepared to show diff with only nth parent.  Because "git
show" started its life merely as a thin wrapper around "git log",
"git show" does not use such an underlying machinery to show diff
with only nth parent that does not exist.
