From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] fast-{import,export}: use get_sha1_hex() directly
Date: Tue, 07 May 2013 07:38:29 -0700
Message-ID: <7v38tyn9cq.fsf@alter.siamese.dyndns.org>
References: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
	<1367793534-8401-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 07 16:38:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZj2U-0002If-7E
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 16:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061Ab3EGOid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 10:38:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33415 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752233Ab3EGOic (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 10:38:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA57B1AA0A;
	Tue,  7 May 2013 14:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=/B7FLXavtaOcfPG0c/nHq6oKqgc=; b=Srd/ig/E9IGNiUITgneX
	yhm8mpf9npudm1MiBiDbJ3R7gfkUaEgbG3A4EwvsMTnZG14WBs6QxA0BSYGm1hnY
	1jONZ6+YmszdtPVSTU4lSw1dQrpkjBuspcwQFxpinW7+KXQZ4CoI9qa/MaFRgwMx
	d3Jo3w8DdoKyrrfK2e7s3vM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=SPupLtbGeQVKYiBV1H73eTcs+r5z2qi6pgDYQ/dIaiyqwo
	kqMWYCPSzO6xPjSe1C7iofuMaD2iWdwMHyz/eNRCeM1MhRPsLLfaWojWPxkuuV7K
	qtwEnvIBQ9yNX5ta5lPvhWj1fSGAiXjZmARxuexgRW6UVmhpZol7nhVgiE82k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F0FB1AA09;
	Tue,  7 May 2013 14:38:31 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1EDA21AA05;
	Tue,  7 May 2013 14:38:31 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C9C47CD6-B723-11E2-BFAE-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223574>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It's wrong to call get_sha1() if they should be SHA-1s, plus
> inefficient.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

It appears that "they should be SHA-1s" assumption does not hold;
this patch breaks at least 3303, 9020, and 9300.

Also assuming these are always 40-hex goes directly against what is
documented in Documentation/git-fast-import.txt (look for "Here
committish is any of the following").  My bad while reviewing the
earlier round.

I've redone 'pu' (which was failing the test last night) after
dropping this and keeping only patches 2 and 3 from the series.
