From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Ignore trailing spaces in .gitignore
Date: Sun, 09 Feb 2014 21:04:13 -0800
Message-ID: <7vfvnrlfsi.fsf@alter.siamese.dyndns.org>
References: <1391847004-22810-1-git-send-email-pclouds@gmail.com>
	<7vd2iv8vbo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 10 06:03:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCj1z-0007ds-40
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 06:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbaBJFDi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Feb 2014 00:03:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34549 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719AbaBJFDh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Feb 2014 00:03:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1458E6B4C4;
	Mon, 10 Feb 2014 00:03:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=15Q8tE59nwcF
	wZx0WXe8QPRJmqE=; b=C7NQwclrHx68aR0ZA1WEwNxq4ThWHuVBQlQ7D//1r9Dz
	i7lTRgMMW8RXUoGRVV9fYFlQiDRVbScCGM11wLZKUITw2g+LYBGTFpbSn14QSlUd
	Ea9K7fhD9hsNPg5oNHk6HdSsjd7WkPvZufh/yYDbB0rFdIx+IitcB9iR5VcMBNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=alb8fn
	r3MCu1lErZC9Pay8avbbqUz8TknxDImhvdaGglWnaaqWmoBeRiLCrA2GiQXtLYvj
	QY+TvyhMM4YWrP8tNAIe7gfV+U0TEQ/vwoUQrakJGvBRJ16gRHNzltr2/CWrW8zn
	0zV74L0KQd47FfRAe6K59lRL1OpN9iMnfElHg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE71E6B4C3;
	Mon, 10 Feb 2014 00:03:36 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30DBB6B4C2;
	Mon, 10 Feb 2014 00:03:35 -0500 (EST)
In-Reply-To: <7vd2iv8vbo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 09 Feb 2014 20:07:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: B1D7DC4E-9210-11E3-A26F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241901>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Trailing spaces are invisible in most standard editors (*). "git dif=
f"
>> does show trailing spaces by default. But that does not help newly
>> written .gitignore files. And trailing spaces are the source of
>> frustration when writing .gitignore.
>>
>> So let's ignore them. Nobody sane would put a trailing space in file
>> names. But we could be careful and do it in two steps: warn first,
>> then ignore trailing spaces. Another option is merge two patches in
>> one and be done with it.
>>
>> People can still quote trailing spaces, which will not be ignored (a=
nd
>> much more visible). Quoting comes with a cost of doing fnmatch(). Bu=
t
>
> Hmph, sorry but I fail to see why we need to incur cost for
> fnmatch().  We read and parse the file and keep them as internal
> strings, so your unquoting (and complaining the unquoted trailng
> spaces) can be done at the parse time, while keeping the trailing
> spaces the user explicitly told us to keep by quoting in the
> internal string that we eventually feed fnmatch() with _after_
> unquoting, no?
>
> Puzzled...

Heh, silly me. Yes, we _could_ parse and strip "\ " into " " if we
wanted to, but we can just give "\ " and let fnmatch(3) do its
thing, and that is the right thing to do for a rare corner case like
this (i.e. deliberate trailing spaces).

So I think I understand your reasoning, and I agree with it.
