From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Multiple fetches when unshallowing a shallow clone
Date: Sat, 05 Dec 2015 20:00:28 -0800
Message-ID: <xmqqmvtons4j.fsf@gitster.mtv.corp.google.com>
References: <CACs8u9STLLHr3c3O9kQKGEN52DLfJ2LatjWkeaeeLA-xP=gC5Q@mail.gmail.com>
	<CAGZ79ka=RxVZ49D0wkqTRqspKb=Ce5Ay01muBt_Gk6_rDbH6KA@mail.gmail.com>
	<20151204212712.GA22493@sigill.intra.peff.net>
	<CACs8u9Qvqn4KDMKo+RHsQaf+dw+CGtWrOpoUJzaZAqD1rFRiuw@mail.gmail.com>
	<20151204215158.GA27987@sigill.intra.peff.net>
	<xmqqh9jxrfy5.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BSNm6=E6Mo6etv_Lvdd2kpqQ7EEMBAoP-AQraYy3xU8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Jason Paller-Rzepka <jasonpr@google.com>,
	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 05:00:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5QVN-0001rp-Ax
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 05:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbbLFEAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2015 23:00:52 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65250 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754244AbbLFEAb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2015 23:00:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6A0AF306A4;
	Sat,  5 Dec 2015 23:00:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KnHtIqJVqphHHhJlyee781BC23Y=; b=dhkmAW
	S/LWzDmjvuPkXCInXfsvlDUsDe3rnhKqEBIDnN2m/ROowDDlDHlypVa6x1qzGq7S
	TVTXOeFStG4b5HXn8ZJOb0ARX1QPWbadSF2Se5qagCqMDueMGxGOIM3JQ8L3PDGZ
	Bx98wWOXHs8V4fXIo4gHw0XwYv9OzXzYEAshI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=llsAvik/jT7T/fmzx44DFnWZjAMAvx6m
	tOC2C76HJ38URPGSu4ghVXY6V/mH/GoaHgtt9Ie5QwAZAVGiAQ7+z4E+oxe+o83R
	TyfiYEIL+zaLyKfUKUsAtzcRV0r9pkmM/DTMtrhDoWFeocvhIiiG9/wmC9qySY1d
	KVpHpvRLycI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 62A7D306A3;
	Sat,  5 Dec 2015 23:00:30 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DBD5D306A2;
	Sat,  5 Dec 2015 23:00:29 -0500 (EST)
In-Reply-To: <CACsJy8BSNm6=E6Mo6etv_Lvdd2kpqQ7EEMBAoP-AQraYy3xU8w@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 5 Dec 2015 06:33:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E3EBB336-9BCD-11E5-A920-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282041>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Dec 4, 2015 at 11:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> just like a regular fetch that auto-follows tags, where it has to
>> make a second fetch if the primary fetch fails to include everything
>> that is needed for propagating the tag for whatever reason.
>>
>> Having said that, IIRC, these days a depth limited clone is created
>> implicitly with --single-branch option, and I am not sure what the
>> right behaviour for the auto-following of tags in such a repository.
>
> I suppose followtags feature has been around long enough that we can
> simply trust that and skip the second fetch?

Hmmmm, I wonder why the code needs the backfill fetch while talking
to a server that has the include-tag capability, then?
