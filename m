From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] crlf: Add test showing double warning on commit
Date: Sat, 14 May 2016 11:45:38 -0700
Message-ID: <xmqqoa887a25.fsf@gitster.mtv.corp.google.com>
References: <20160514111755.GG2345@dinwoodie.org>
	<baea5604-e786-5773-aa68-f311efb23752@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat May 14 20:45:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1eZP-00080f-7Y
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 20:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbcENSpm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 May 2016 14:45:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63227 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932183AbcENSpl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2016 14:45:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8EA94187CD;
	Sat, 14 May 2016 14:45:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jDnV05VJezY/
	SlVxUzVB7UPVZlc=; b=GBwCOnCM3zagWU6aQ2AU78C+rCLG64Ms8EpqZog7erZl
	MluFiZm3eN68SQBJY0VG8NoYakzE4G2a6beQtCCDJvVSRws76n+yJcbsueFy3J5x
	RVn0OWgvFKSoavozaolzHU0tD/5fCVY6fVxEaX9B3p7XM4bJ8sPuCUQbe7QXYpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BxITX9
	QJ9seZDu4x6HO1EHL8puuu6HmTyCDb+HWW9OGbTCQyYaU05BdP/LinvFi2GeQabq
	YvYHK18scTj84t+ifUYd0GfQln6Mu0Ikm/7KoueRSqPvZYgemPIzz6dFcisAqdfn
	WcnHyz/+4DbkIMGYN1GCZ01r1/YQmApyIScD8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8576B187CC;
	Sat, 14 May 2016 14:45:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EC2EE187CB;
	Sat, 14 May 2016 14:45:39 -0400 (EDT)
In-Reply-To: <baea5604-e786-5773-aa68-f311efb23752@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Sat, 14 May 2016 18:20:22
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0E14C5DA-1A04-11E6-923C-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294623>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Do we need to run diff_populate_filespec() twice when src=3D=3Ddst ?

Of course we do.

src and dst may have the same path, but are coming from different
places (src may be an indexed blob while dst may be a file in the
working tree).

> If yes, we may need to introduce a flag besides
> #define CHECK_SIZE_ONLY 1
> #define CHECK_BINARY    2
> to suppress the conversion warning ??

I do not think that belongs to diff_populate_filespec() at all.

Why should conversion routine give this warning when called by
diff_populate_filespec() in the first place?  Shouldn't it be silent
by default, and is allowed to talk _ONLY_ when we are attempting to
actually replace the data in the index, e.g. "git add" and "git
commit -a"?
