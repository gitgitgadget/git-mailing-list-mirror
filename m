From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs.c: enable large transactions
Date: Tue, 21 Apr 2015 11:00:11 -0700
Message-ID: <xmqqpp6xgy50.fsf@gitster.dls.corp.google.com>
References: <CAGZ79kY842JXB37++nwYjkX1WK9ja5m-G1aDj=QgLN-qKLo9Lg@mail.gmail.com>
	<1429576506-10790-1-git-send-email-sbeller@google.com>
	<xmqqegndieqd.fsf@gitster.dls.corp.google.com>
	<CAGZ79kay11Pd4ni1j6jSYbenSXVfUP-6irPBc_r1=gUZFe-Hjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 20:00:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkcTF-0008DZ-LU
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 20:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755817AbbDUSAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 14:00:18 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64859 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752150AbbDUSAN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 14:00:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E512D49280;
	Tue, 21 Apr 2015 14:00:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OPEkZG8eHLZKZEwmy8DVmkPgJtw=; b=cXnFXq
	o4Kdc1JkcwSqi1aoAsM8hcHDKl1CbihdrFINrmOXTqSpzORJtSnPk3+a3KfRaoU/
	Ne+tTQymhV925ILwkBtSt8xKg6bYT5gxF25uaq93Ea4eaaIacElJbzYjELhCTiXR
	haCqlj2FHKHqy/zr7qoPEWp1iCm0hr+U4x0yk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u+o+hyNmL+7WWZc6sB2x3r8XZdi8Pnlr
	qJpkhtR3gUhC19P6Zyln68Igaf88Xk/HBgDAOofWC4/HGCrrCEFTqhZk7fAZGzR6
	fiZBPB7ivFmyF91Ogbqj2D8SZC4Wx23VYS8uUSLESX3bJs0x0ORWK0lK8dAMssvg
	iHFzWQzIDuU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE9BB4927F;
	Tue, 21 Apr 2015 14:00:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65D874927D;
	Tue, 21 Apr 2015 14:00:12 -0400 (EDT)
In-Reply-To: <CAGZ79kay11Pd4ni1j6jSYbenSXVfUP-6irPBc_r1=gUZFe-Hjw@mail.gmail.com>
	(Stefan Beller's message of "Tue, 21 Apr 2015 10:24:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 41A4EF6A-E850-11E4-917D-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267543>

Stefan Beller <sbeller@google.com> writes:

> I thought about putting a cap on it to not let it go negative in the first
> place, but I did not find an easily accessible max() function, as I'd like
> to write it as
>
>     int remaining_fds = max(get_max_fd_limit() - 32, 0);
>
> to have it in one line. The alternative of
>
>     int remaining_fds = get_max_fd_limit() - 32;
>     ...
>     if (remaining_fds < 0)
>         remaining_fds = 0
>
> seemed to cuttered to me.

Just to set the standard yardstick straight, either is fine, but I
would say the latter is slightly preferrable from readability's
point of view.  Rows of dense single lines get tiring to read pretty
quickly.
