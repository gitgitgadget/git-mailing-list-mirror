From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 6/9] receive-pack: Prepare for addition of the new
 'limit-*' family of capabilities
Date: Mon, 16 May 2011 15:12:17 -0700
Message-ID: <7vd3jijnwe.fsf@alter.siamese.dyndns.org>
References: <201105151942.29219.johan@herland.net>
 <1305495440-30836-1-git-send-email-johan@herland.net>
 <1305495440-30836-7-git-send-email-johan@herland.net>
 <7vaaenm957.fsf@alter.siamese.dyndns.org>
 <BANLkTimUWHiUdxbBfvvcomqmzQxLPhUsZA@mail.gmail.com>
 <7vhb8ujo4e.fsf@alter.siamese.dyndns.org>
 <BANLkTimge=rPe6K3rYRqYDGQTN_wbi3a2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 17 00:12:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM61k-0002IA-0C
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 00:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754427Ab1EPWMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 18:12:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65331 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860Ab1EPWMb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 18:12:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 845274F61;
	Mon, 16 May 2011 18:14:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KAg1g/iLrW0q4mN65si9Dp06llM=; b=vhBhcr
	1KRALgnLg+2ZI+cyQ17KEzWpYMhuEg7CtI4OCqS4byQBkm+1SkuzCRX0drT2PqGO
	HRjSTccmIinYecyOPqwU8NFY6xTmKqRnZZ+XqC47ZTLV7SMSjo8aiqWwv/svZRlc
	PNpdbAY3pqWc9R1vQmyuPszItObLC45B05zdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WcCbzizRHgAHu+bU2isAcJ9ge8RgLYPP
	+80nk93+fMhj9KoVTpPdJAlXuHDFk0T3qI1M8F/3D0ug06hCfm+viauVjapNtVag
	10UrI03KQeHw5IpAeXlS7lYoVyGil97fiXC24brIKRrdu0KwFsopTBw7CyoS46Pg
	RqUwL08d1t0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2EE2C4F60;
	Mon, 16 May 2011 18:14:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A71934F29; Mon, 16 May 2011
 18:14:26 -0400 (EDT)
In-Reply-To: <BANLkTimge=rPe6K3rYRqYDGQTN_wbi3a2A@mail.gmail.com> (Sverre
 Rabbelier's message of "Mon, 16 May 2011 15:09:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0871530-8009-11E0-959E-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173770>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Mon, May 16, 2011 at 15:07, Junio C Hamano <gitster@pobox.com> wrote:
>> The old clients treat it as SP separted list, e.g. "featurea featureb featureb",
>> from the beginning of how capabilities[] code was writte, so I do not see
>> a point. I would expect an arbitrary string values would be encased in
>> something like base64, base85 or hex.
>
> Right, that's my point, do we want to leave it up to each individual
> option to decide what encoding to use?

I do not see any point in deciding that right now without even knowing
what kind of strings (short? mostly ascii? etc.) we would typically want
as payload and tie our hands with a poor decision we would end up making
out of thin air.

That is what I meant by "I do not see a point".
