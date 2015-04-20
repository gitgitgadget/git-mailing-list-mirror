From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 2/4] cat-file: teach cat-file a '--literally' option
Date: Sun, 19 Apr 2015 22:30:02 -0700
Message-ID: <xmqq7ft7nz8l.fsf@gitster.dls.corp.google.com>
References: <552E9816.6040502@gmail.com>
	<1429117174-4968-1-git-send-email-karthik.188@gmail.com>
	<20150419002807.GA11634@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Apr 20 07:30:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yk4Hv-0004go-9k
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 07:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487AbbDTFaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 01:30:14 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50109 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754456AbbDTFaK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 01:30:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A1473BEBC;
	Mon, 20 Apr 2015 01:30:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ueUOBLHwfVvVigBzngIcrytQo2I=; b=HntFAG
	fa7NGHaNbJ83b67uLvFOiDMStWe3bQmstqUy4ZS5bjfaN+2tcuEVi5n/PGdBuUlK
	0YTr+oN+R2nXC5q+AvlBSj8DM0aKSnBcC0EI52QdzmTz0PyBCtikR4otN8GYAa1/
	bwUJ/Q1Le15S0Atjwj/BL8vXGN2rTD81Tl0FA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xs2dyFDoXQGA+8tZZ24gMKSE9qTmSc11
	wulh+Fht1UHuAjpFjAJvv4AIkY8VVYAPw1hsmgKhoXQJKTCw+rQmB7u8aB19Tts3
	DaCjuk/EBVbyZwEcl/5KB8c4hbdjOvPsZlS57K2z69m7CyQ716BX6MO5cOG38Nql
	Qy/TW7ZLweI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 823193BEBB;
	Mon, 20 Apr 2015 01:30:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0CAFE3BEB9;
	Mon, 20 Apr 2015 01:30:03 -0400 (EDT)
In-Reply-To: <20150419002807.GA11634@hashpling.org> (Charles Bailey's message
	of "Sun, 19 Apr 2015 01:28:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4C279A9C-E71E-11E4-91A5-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267449>

Charles Bailey <charles@hashpling.org> writes:

> I'm sorry to come in with such a fundamental question at such a late
> revision of this patch series, but am I the only person to wonder about
> the choice of option name?
>
> To me, cat-file already output objects "literally" (without -p) as
> opposed to show. From the description, it feels more like it should be
> "--unchecked" or perhaps something better that I haven't thought of?

Yeah, it was conceived as a way to grok what hash-object --literally
would create, but the operation by "cat-file --literally" is not
about showing the contents literally without interpreting (the
general "cat-file <type> <objectname>" does the literal output
already).  So it was my fault to suggest that name, but I do not
think of a better alternative.

> The option isn't a true opposite of hash-object's --literally because
> that also allows the creation of known types with invalid contents (e.g.
> corrupt trees) whereas cat-file is quite happy to show the _contents_ of
> such corrupt objects even without --literally.

Not really.  If you create an object with corrupt type string (e.g. "BLOB"
instead of "blob"), cat-file would not be happy.
