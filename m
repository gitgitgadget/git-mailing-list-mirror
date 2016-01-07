From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 14/15] ref-filter: introduce contents_atom_parser()
Date: Thu, 07 Jan 2016 10:04:46 -0800
Message-ID: <xmqqziwh4669.fsf@gitster.mtv.corp.google.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
	<1451980994-26865-15-git-send-email-Karthik.188@gmail.com>
	<xmqqio37iuvj.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQY09yqDVELb9ObTnWfU-9nRyxJiV=_2tHbZPk_oe8sGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 19:04:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHEvd-0002Kh-2Z
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 19:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbcAGSEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 13:04:49 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63828 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752241AbcAGSEs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 13:04:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F2AFD38B29;
	Thu,  7 Jan 2016 13:04:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wNugBJhlUsKUiaoGsjkj72BQc18=; b=sZ285s
	unmwQTEGF3zlu24rPGJAdKVnugppWGXxI0svAXTUvURSu7jKlc8nmRg/0Ft8yJBx
	Pnoq5k0c+iIloOnVUxtttwz2pBGqSG60dJtaoZOF5v8wIO/tCtU0x0vfhSTvIaUj
	i4W15emE4czcAUcE0XezseovW+eOpvFjwasvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Znwn0LJwaylp9lYsR6fLN1577cdNngLF
	P4OeTlExvTgxtbWyqh8Yir9BmqQaJE6Ttq5lzoj26LE/ZMdbDUxvYnefHWZIDDaN
	kQ4WoqVt3Pt4Ft7nQv62GZIM2OSrJBnBXVMc/h8BwogzHsttUGxRIjnBqlLn6VIR
	7C7CTsu0WeE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EA7DB38B28;
	Thu,  7 Jan 2016 13:04:47 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6657638B26;
	Thu,  7 Jan 2016 13:04:47 -0500 (EST)
In-Reply-To: <CAOLa=ZQY09yqDVELb9ObTnWfU-9nRyxJiV=_2tHbZPk_oe8sGQ@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 6 Jan 2016 23:52:03 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 235FAF68-B569-11E5-97C3-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283498>

Karthik Nayak <karthik.188@gmail.com> writes:

>>> +static void contents_atom_parser(struct used_atom *atom)
>>> +{
>>> +     const char * buf;

const char *buf;

>>> +
>>> +     if (match_atom_name(atom->name, "subject", &buf) && !buf) {
>>> +             atom->u.contents.option = C_SUB;
>>> +             return;
>>> +     } else if (match_atom_name(atom->name, "body", &buf) && !buf) {
>>> +             atom->u.contents.option = C_BODY_DEP;
>>> +             return;
>>> +     } if (!match_atom_name(atom->name, "contents", &buf))
>>> +               die("BUG: parsing non-'contents'");
>>
>> Did you really intend to say "if" here, not "else if"?
>
> Not that it makes a difference here since both the previous
> condition return. I think "else if" would be better.

I am not sure if it is "Y would be better even though X and Y both
would work".  It looks to me "X and Y behave differently, X is a bug
and Y is correct".

The above would behave differently between "if" and "else if" (and
by the way, the code layout suggests it is "else if"; otherwise you
would be starting "if" on its own line) when you feed "subject:foo",
no?
