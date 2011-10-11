From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Negation magic pathspec
Date: Tue, 11 Oct 2011 16:17:03 -0700
Message-ID: <7vwrcbce4w.fsf@alter.siamese.dyndns.org>
References: <1318373083-13840-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 01:17:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDlZR-0002l0-6p
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 01:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726Ab1JKXRH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Oct 2011 19:17:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59149 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751671Ab1JKXRF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2011 19:17:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E1816E95;
	Tue, 11 Oct 2011 19:17:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JtqahCLHYMNI
	vSPcX1fNZzUsb50=; b=yCrYLVKhCOeUJZe5d0wGfYTATI88ww7Oubs21tkCBfrq
	3agmlUwa5M/FMpZ0WuhDl1p2SwbOKw6IvIuPtVpsPdxk0CpJoD4zmBKhtvd8khTE
	ZA5WDjd6gLUM2b4PRu4ERkfSmW/z4JJAHMIG/i4FR3GGNDhurvdSdrUOdgykX+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=phYzud
	AQzNNg3YRjntZ1y1Yr1AhVGHkaAbYfXs2wHlFdBa5tat0exMkLIgBGLvlmqenwBc
	dxQAdUKm+YBbsTe8p2TXigvJZTXND5ATr5BiOb2BiRqsReRhkEeb/b+HwKk7m3xC
	SSV44PBkGnWCzl6+axMbZMNyw9tM1YzfQQcr8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 448C56E94;
	Tue, 11 Oct 2011 19:17:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4F6D6E91; Tue, 11 Oct 2011
 19:17:04 -0400 (EDT)
In-Reply-To: <1318373083-13840-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 12 Oct
 2011 09:44:37 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 21D0CF76-F45F-11E0-B4AD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183346>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> I'm still struggling with read_directory() rewrite so that struct
> pathspec can be used throughout git, but now realized we can at least
> enable magic for certain commands and die() on those that don't.
> This may help move magic pathspec patches forward.

I actually was thinking that teaching those that take bare "const char =
**"
to take "struct pathspec *" is much more important conversion before
adding more magic to those that already do take "struct pathspec *". Th=
e
ones that ask "does this path match the pathspec" would automatically
start honoring negative or quantum or whatever magic once we teach
the magic to match_pathspec(), but the ones that take "const char **" w=
ill
have no way of doing so before getting converted to "struct pathspec *"
interface.  If some parts of the system knows more magic and people sta=
rt
playing with them, the lack of the support in codepaths that haven't be=
en
converted will become real pain point.

That is not to say that these 6 patch series are wasted patches. I just
think it may be doing things in a wrong order.
