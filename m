From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 24/34] checkout: reject if the branch is already checked out elsewhere
Date: Mon, 01 Dec 2014 09:39:47 -0800
Message-ID: <xmqq1tojqnfg.fsf@gitster.dls.corp.google.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
	<1417335899-27307-25-git-send-email-pclouds@gmail.com>
	<547B5170.6050206@gmail.com> <20141201103818.GA20429@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 18:40:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvUx6-0004aV-Fa
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 18:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbaLARjz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Dec 2014 12:39:55 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52943 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753249AbaLARjv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Dec 2014 12:39:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 113A520331;
	Mon,  1 Dec 2014 12:39:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=q8lQ1S4agexK
	IdoLbJN+FAT3JHs=; b=fG9JLTEI/JEhgqUWc21kkgDRjkDt7yohqQPQC9jaafjQ
	es4VSi2zwMFOf53wT0ZumkUlPDbIB4SUUNgfW7z5BYzxhX3g8ZVSjTcBz0OD5+RH
	QM2XxvGz/vr0B7lQ7t2ex9xoB5Ou5yezTM2bEDyVD7lJtPCsjXLJCyq3EWcPN+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=c+FnXm
	kKA8h9DpVtMk/nxDqZaqolbvITxCAa6UqaIGvFEj1Fr+E1c/lY9puK23jSsMwkSQ
	C6+2MCpxLX41SxH5ke40nzaTdj9hjpNMejz2nrTul/7vUS5uMdCw6Q1iZK3LaQPR
	QEtsA8fxNDkLK4C4fezuZZplZ/DsJ8VilyVHI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0809220330;
	Mon,  1 Dec 2014 12:39:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 872232032E;
	Mon,  1 Dec 2014 12:39:49 -0500 (EST)
In-Reply-To: <20141201103818.GA20429@lanh> (Duy Nguyen's message of "Mon, 1
	Dec 2014 17:38:18 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0C83AB48-7981-11E4-88CD-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260496>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Nov 30, 2014 at 12:18:40PM -0500, Mark Levedahl wrote:
>> On 11/30/2014 03:24 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wr=
ote:
>> > One branch obviously can't be checked out at two places (but detac=
hed
>> > heads are ok). Give the user a choice in this case: --detach, -b
>> > new-branch, switch branch in the other checkout first or simply 'c=
d'
>> > and continue to work there.
>> >
>>=20
>> This seems too restrictive and is not "obvious" to me: I currently u=
se=20
>> git-new-workdir to have multiple checkouts of the same branch, with =
no=20
>> ill effect. While those who do not understand what is going on=20
>> underneath might be confused by one checkout suddenly showing=20
>> uncommitted diffs, I don't accept that as a reason to outright preve=
nt=20
>> such use. I suggest, at the very least, that this behavior be overri=
dden=20
>> by a --force flag?
>
> Prevention is a strong word. It's more about safety for the mere
> mortals. It's certainly possible to do something like this patch
> (--force can't be reused, it already carries some other meaning).
> Should I add this one in the next (hic) reroll?

Sorry, what is a hic?

If this were an existing feature like git-new-workdir, even though
it is from contrib, making it impossible to do something that used
to be possible, even if that something is what mere mortals would
never want to to to avoid risking confusion, would be a regression
that needs an escape hatch.

But this is a new feature.  I am not sure why you need to make this
overridable in the first place.  Those who want to have multiple
checkouts of the same commit can just detach HEAD at the same commit
in multiple working trees, as the first thing they need to do would
be to run "git reset --hard $branch" to synchronize the HEAD and the
working tree state to work in the other out-of-sync repositories
either case anyway.
