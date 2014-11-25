From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] git-am: add --message-id/--no-message-id options
Date: Tue, 25 Nov 2014 10:33:46 -0800
Message-ID: <xmqqwq6jruyd.fsf@gitster.dls.corp.google.com>
References: <1416924056-29993-1-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Nov 25 19:33:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtKvz-0001iT-DG
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 19:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbaKYSdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 13:33:52 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62276 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751768AbaKYSdu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 13:33:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 214B41FBA2;
	Tue, 25 Nov 2014 13:33:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8YyCpuskJov7ba7RDM0T5I+BIDQ=; b=jatwvs
	E5zLF0WuNTi3yCBJmBIXnyt2Gr88BcauxY+905j4nNay1Ylkam4jD0gdX5feSUjW
	HbNm5kIQi4ftAC0tKKVP6geDve8pfyiodwsrk6fCdYgEETEtLoB5s/OCLqMTd4TC
	JvJxbVK28o/PJhUjZgoAmdifMUTMPUVKvrQdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gmU20W5HHp1TuEU6ZKabXGTrRwJzSCW5
	6IW0eeX5LLHT2uvE2Q8oqBJUiQq2b22RWHK2cqIgZ5Dp7teUDZZ4MDzNDMmF3rOT
	WcgUc+jpFhKkkIoNjlN9ihbA6LQCXEkSy8Bm+VFx1GAJ05wy4C1DqHet9kp7PMV+
	dQzz+CpiQTo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 183F11FBA1;
	Tue, 25 Nov 2014 13:33:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 762E31FB9F;
	Tue, 25 Nov 2014 13:33:48 -0500 (EST)
In-Reply-To: <1416924056-29993-1-git-send-email-bonzini@gnu.org> (Paolo
	Bonzini's message of "Tue, 25 Nov 2014 15:00:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 98967912-74D1-11E4-9017-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260235>

Paolo Bonzini <bonzini@gnu.org> writes:

> From: Paolo Bonzini <pbonzini@redhat.com>
>
> This series adds a --message-id option to git-mailinfo and git-am.
> git-am also gets an am.messageid configuration key to set the default,
> and a --no-message-id option to override the configuration key.
> (I'm not sure of the usefulness of a mailinfo.messageid option, so
> I left it out; this follows the example of -k instead of --scissors).
>
> This option can be useful in order to associate commit messages with
> mailing list discussions.
>
> If both --message-id and -s are specified, the Signed-off-by goes
> last.  This is coming out more or less naturally out of the git-am
> implementation, but is also tested in t4150-am.sh.

Nice.  So if you apply a message whose last sign-off is yourself
with both of these options, what would we see?

    1. S-o-b: you and then M-id: and then another S-o-b: you?
    2. M-id: and then S-o-b: you?
    3. S-o-b: you and then M-id:?

I do not offhand know which one of the above possibilities to favor
more over others myself.  Just asking to find out more about the
thinking behind the design.

Thanks.

>
> Paolo Bonzini (2):
>   git-mailinfo: add --message-id
>   git-am: add --message-id/--no-message-id
>
>  Documentation/git-am.txt       | 11 +++++++++++
>  Documentation/git-mailinfo.txt |  5 +++++
>  builtin/mailinfo.c             | 22 +++++++++++++++++++++-
>  git-am.sh                      | 21 +++++++++++++++++++--
>  t/t4150-am.sh                  | 23 +++++++++++++++++++++++
>  t/t5100-mailinfo.sh            |  4 ++++
>  t/t5100/info0012--message-id   |  5 +++++
>  t/t5100/msg0012--message-id    |  8 ++++++++
>  t/t5100/patch0012--message-id  | 30 ++++++++++++++++++++++++++++++
>  9 files changed, 126 insertions(+), 3 deletions(-)
>  create mode 100644 t/t5100/info0012--message-id
>  create mode 100644 t/t5100/msg0012--message-id
>  create mode 100644 t/t5100/patch0012--message-id
