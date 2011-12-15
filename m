From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Do not create commits whose message contains NUL
Date: Thu, 15 Dec 2011 11:35:05 -0800
Message-ID: <7v62hhocgm.fsf@alter.siamese.dyndns.org>
References: <1323777368-19697-1-git-send-email-pclouds@gmail.com>
 <1323871699-8839-1-git-send-email-pclouds@gmail.com>
 <1323871699-8839-4-git-send-email-pclouds@gmail.com>
 <7vzkevow2j.fsf@alter.siamese.dyndns.org>
 <20111214182953.GA6469@sigill.intra.peff.net>
 <7vehw5oepj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Miles Bader <miles@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 20:35:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbH5J-0006Ew-BF
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 20:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759416Ab1LOTfK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Dec 2011 14:35:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63874 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756453Ab1LOTfJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Dec 2011 14:35:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 656AD68F9;
	Thu, 15 Dec 2011 14:35:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GTChIOjdLjyy
	Kuo+Hq44wNV+4uU=; b=dy1z7crsnMSMizzNUz2HpTe78WoAqVLgPxLr/6KipViA
	Q5MRQeATrkYgbiPeg/XxuD12JLdpZvPFEfroGpI7ARnrAgHHd0pj9ja8CaUVRVC8
	VTqKll2ucnPHtIOOLtalICJ/7FVHWu8fUOChiV3nK4KpcpJvlfvRr2V9rDWSHco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tCb0U4
	+0jHXf1kpHq+8boT1aU1Hst+tm1xUvumpyczJoR2XJHj82zw5LYym8aiHunXGhgb
	hTJVlWCJbI7DDMp3QAR9wi1ArdpYUfHLAbVBLFW7nrcCZ3s3ksZJ49zagQF/WpWN
	AdSqJSb2orwJplwPl/6RrYihD0s7lT+JyMiTM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C51368F8;
	Thu, 15 Dec 2011 14:35:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D05FF68EB; Thu, 15 Dec 2011
 14:35:06 -0500 (EST)
In-Reply-To: <7vehw5oepj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 15 Dec 2011 10:46:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4965A2C-2753-11E1-A241-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187224>

Junio C Hamano <gitster@pobox.com> writes:

>> My gut feeling is that it should store the literal binary contents.
>> However, I don't think this has ever been the case. Even in the init=
ial
>> version of commit-tree.c, we read the input line-by-line and sprintf=
 it
>> into place.
>
> Yeah, you are right. Perhaps we should tweak updated 3/3 to check at =
the
> lower level commit_tree() then.
>
> I've rewrote the log message for 2/3 as follows so we can go either w=
ay
> ;-)

s/rewrote/rewritten/ obviously...

>     Convert commit_tree() to take strbuf as message
>    =20
>     There wan't a way for commit_tree() to notice if the message the =
caller
>     prepared contained a NUL byte, as it did not take the length of t=
he
>     message as a parameter. Use a pointer to a strbuf instead, so tha=
t we can
>     either choose to allow low-level plumbing commands to make commit=
s
>     that contain NUL byte in its message, or forbid NUL everywhere by
>     adding the check in commit_tree(), in later patches.
>    =20
>     Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds=
@gmail.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

And 3/3 looks like this:

    commit_tree(): refuse commit messages that contain NULs
   =20
    Current implementation sees NUL as terminator. If users give a mess=
age
    with NUL byte in it (e.g. editor set to save as UTF-16), the new co=
mmit
    message will have NULs. However following operations (displaying or
    amending a commit for example) will not keep anything after the fir=
st NUL.
   =20
    Stop user right when they do this. If NUL is added by mistake, they=
 have
    their chance to fix. Otherwise, log messages will no longer be text=
 "git
    log" and friends would grok.
   =20
    Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
