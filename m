From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 04/10] column: add dense layout support
Date: Tue, 28 Feb 2012 10:27:08 -0800
Message-ID: <7vty2azudf.fsf@alter.siamese.dyndns.org>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 19:27:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Rle-0006hD-Ff
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 19:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755763Ab2B1S1M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 13:27:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63632 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754770Ab2B1S1K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2012 13:27:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58DC97330;
	Tue, 28 Feb 2012 13:27:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ttdMF5m6TmqB
	TZgXVcE68zq9IUM=; b=KokMTo7xQYCU/YNOIbfptPHZdPR/8QxZ0E0c6E83OgsH
	YE7YmCrzJOai0poaNNYcDComNETAm6HXrxzUhSAUI63LX3sjZ1UcQ3ZoNWtWHmK/
	aHZ/C4G3N4u8owTgQgio1uxxrNotmmjpW/qecpWhBO2jIg+GpRqrqoFiAeHNoHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Q9DQi0
	yKxEaQrI4ac/XP9kYp2K7FMorkjuZiM9zvcVj7RsSP4wkTH7mhk9J0HyNoel557D
	IEy39KzjMtLmPUkIfdw7dsg9OJVTdWWVslmNeBas/rSLIFnKeqogrCBMTfkGFy6G
	ZxA4Ypvbr9kZq6mr+B0dzIfb/FENYZBgueZoc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50410732F;
	Tue, 28 Feb 2012 13:27:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0882732E; Tue, 28 Feb 2012
 13:27:09 -0500 (EST)
In-Reply-To: <1330430331-19945-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 28 Feb
 2012 18:58:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D372B206-6239-11E1-BAA4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191757>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Normally, all items will be gone through once. The largest cell will =
set
> column width for all columns. With this strategy, one long item will
> stretch out all columns, wasting space in between them.
>
> With COL_DENSE enabled, it shrinks all columns to minimum, then attem=
pts
> to push the last row's cells over to the next column with hope that
> everything still fits even there's one row less. The process is repea=
ted
> until the new layout cannot fit in given width anymore, or there's on=
ly
> one row left (perfect!).

As you have given 4 bits for COL_MODE in the previous patch, I expected
that this will be one of the mode that you can use, e.g. column-first d=
ense,
or row-first no-dense, with two more bits for operating modes.  Not cal=
ling
it COL_MODE_DENSE and assigning a "are we dense of not?" bit out of COL=
_MODE
bits feels wrong.
