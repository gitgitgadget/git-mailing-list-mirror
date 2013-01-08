From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git clone depth of 0 not possible.
Date: Tue, 08 Jan 2013 09:24:16 -0800
Message-ID: <7vk3rnfv0f.fsf@alter.siamese.dyndns.org>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
 <20130108062811.GA3131@elie.Belkin> <7vip78go6b.fsf@alter.siamese.dyndns.org>
 <7vd2xggm8a.fsf@alter.siamese.dyndns.org>
 <CACsJy8BJ3eBv-wjq=eTzR4SeEXW2MF5k1w5SFRt7fWRU4vKb_Q@mail.gmail.com>
 <50EC2DE5.2050704@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 18:24:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tscum-0000RR-8B
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 18:24:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756728Ab3AHRYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 12:24:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36213 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756346Ab3AHRYU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 12:24:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20F8ABEAB;
	Tue,  8 Jan 2013 12:24:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w8Hder1x61yz64dXT5Km3GgAgFg=; b=Tc2Ygw
	fZrpp4lWl8FmwjmUYRoiyu0K4xhJWTklkGoZdym6F5EW/B+ixk1FQ1GfakTCS0Rp
	1yzgsazOODtbMiQxpRQBcoP1Cd1QkyY6+Xo0qE9zIzpYi8SfQMLNIVq0j34nZCKi
	oz1aBIJAdG6TuPJbLiuixaVsSc6/Duip1EP6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KaLRzgsmdSbiWalS20GITbw7D5BX6ULH
	LL8zzKMNst9K6TC73OuvMZeXAd7uKvOlN/t+C4zgrKhPRutQ4x908A/AVq1N4CFo
	WFaCHNzcYwQ4yTvj+R7IBg16dMlJjGBsTlzQjUgkDxCx8Efqvk+05G5+bjsbCxMS
	Qb/M0yulveA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16D4EBEAA;
	Tue,  8 Jan 2013 12:24:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A16CBEA9; Tue,  8 Jan 2013
 12:24:18 -0500 (EST)
In-Reply-To: <50EC2DE5.2050704@googlemail.com> (Stefan Beller's message of
 "Tue, 08 Jan 2013 15:32:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3BB4AE52-59B8-11E2-9B03-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212979>

Stefan Beller <stefanbeller@googlemail.com> writes:

> On 01/08/2013 03:28 PM, Duy Nguyen wrote:
>> On Tue, Jan 8, 2013 at 2:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Speaking of --depth, I think in Git 2.0 we should fix the semantics
>>> of "deepening" done with "git fetch".
>> 
>> Speaking of 2.0, we should support depth per ref. Well we don't have
>> to wait until 2.0 because we could just add shallow2 extension to the
>> pack protocol. We should also apply depth to new refs when fetching
>> them the first time.
>
> Would this mean I could do something along?
> $ git clone --since v1.8.0 git://github.com/gitster/git.git
>
> So tags would be allowed as anchors?

As the end-user facing UI, I think it would be much easier to use
for users who want to get only the recent part of history that is
relevant to their development if you allowed them to ask "starting
from this one, I do not care anything older than that" with such an
interface.  The current "count how many more generations you want"
interface is crazy in that it forces you to count what you have not
even seen; I suspect the only reason it was done in such a hacky
manner was implementation expediency.

At the syntax level, however, I do not think we can use --since
there, because the keyword has a very different meaning already.

I personally do not think "depth per ref" deserves "it would be nice
to support in 2.0", let alone "2.0 *should* support", label.  Some
may find it an interesting mental exercise to think about corner
cases it will introduce and have to deal with (e.g. you ask 100 from
master and 2 from maint, but maint is behind master by less than
100---what should happen?), but I do not particularly see any
practical use cases, and I highly doubt that there is much value in
bringing in extra complexity such a "feature" requires to do it
right.
