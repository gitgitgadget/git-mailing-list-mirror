From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] rev-parse: fix some options when executed from subpath of main tree
Date: Fri, 06 May 2016 10:08:49 -0700
Message-ID: <xmqq8tzn5d26.fsf@gitster.mtv.corp.google.com>
References: <1461361992-91918-2-git-send-email-rappazzo@gmail.com>
	<20160429135051.15492-1-szeder@ira.uka.de>
	<CANoM8SWBzFiHGc3zAwndyx+GUkWQGDoaewVVQtH-06jazAn8uQ@mail.gmail.com>
	<20160506161312.Horde.7i8_sE5ISIqccneOIfinvCX@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Rappazzo <rappazzo@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri May 06 19:08:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayjFJ-0001CA-MS
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 19:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758565AbcEFRIx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2016 13:08:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51629 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758223AbcEFRIx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 13:08:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F098172AC;
	Fri,  6 May 2016 13:08:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KhLhQhcnxwOv
	nhjgplD4g1YDpVQ=; b=DNN3HUw1vaWgJwuIC1DReUVvIvbSmK/sV/f2ZZCgqiLW
	0WwpEx2UjbgGdM+Ji1JZpSI0JfExQL4v7Q+aY3T7/fwagNYJJIz2DL2S0o9yBcTJ
	p8slY5F6FywPlc4ktoHpuePL52I3RnOEECTBkwfvzfgX/VhBixOGDJ5SxTfr2FM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pValUw
	CRse1IbTHQJtTCzJbWUq4rrbDHeZZEd27W9AVQW7jAfIOmbTwWl2sXsDNr2YrT77
	IXrJhl2EDLY1yuccJrSWZcMFKkegqR4YwuO7vyeC2qz5dUkKqZYo6BQ6f4SYgshw
	tZca3vzcLR1x0216iJLGW+snvL6OLJf8ptDQE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 97856172AB;
	Fri,  6 May 2016 13:08:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 13E4D172AA;
	Fri,  6 May 2016 13:08:51 -0400 (EDT)
In-Reply-To: <20160506161312.Horde.7i8_sE5ISIqccneOIfinvCX@webmail.informatik.kit.edu>
	("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Fri, 06 May 2016 16:13:12
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3472A1C8-13AD-11E6-B0CF-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293833>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

>> I agree with this, but at one point Junio suggested that it should
>> return the relative path[1],
>
> I wasn't aware of Junio's suggestion.

Mike justified his position to change everything to absolute, citing
that it is what "rev-parse --show-toplevel" does when run from a
subdirectory.  I just gave a counter-example that rev-parse does not
always talk in absolute with "rev-parse -C t --show-cdup".

It hinted that his justification may not be strong enough to choose
absolute over relative, but wasn't meant to be a suggestion to
choose relative at all.  At most, I was saying "either is equally
plausible".

> It shouldn't really matter in practice, because both the absolute and
> relative paths will ultimately lead to the same place.  However, I
> still think that for consistency's sake absolute paths would be bette=
r
> when executed in a subdir of the working tree.

Sure.

One thing I'd be worried about is that people may be using it to
compute paths and store them in $GIT_DIR/somewhere, and expecting
that they can later do a wholesale "mv" of directory hierarchy and
relative paths still work.  I wouldn't be one of those who does the
"mv" so I personally do not care, but I suspect some do.
