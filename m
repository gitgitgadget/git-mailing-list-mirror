From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [SIGNED-OFF] remotes-hg: bugfix for fetching non local remotes
Date: Wed, 24 Jul 2013 15:51:58 -0700
Message-ID: <7vhafj606p.fsf@alter.siamese.dyndns.org>
References: <1374615616-4730-1-git-send-email-dev@joernhees.de>
	<CALWbr2zRsCk1N5xUUDQeWX6CbvLHYWnxiYpea+etoWvXHNhPEA@mail.gmail.com>
	<F0461ED2-7B5F-4657-B0D4-3CBBE15FDD48@joernhees.de>
	<CALWbr2wDqo29kRJ2eHsozRCN_fT3tumYz23pQa5P-9dm27OL6A@mail.gmail.com>
	<7v7ggg6l2o.fsf@alter.siamese.dyndns.org>
	<665576E7-6083-4535-9CE0-773236A0E9ED@joernhees.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: =?utf-8?Q?J=C3=B6rn?= Hees <dev@joernhees.de>
X-From: git-owner@vger.kernel.org Thu Jul 25 00:52:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V27ui-0007HZ-VD
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 00:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872Ab3GXWwE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Jul 2013 18:52:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46538 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752418Ab3GXWwC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jul 2013 18:52:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12EC833FA1;
	Wed, 24 Jul 2013 22:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=61GX7zQjrb+Q
	CTf0a2dPEfJR4F8=; b=SfCi5H0yvXmNYuV2KjFKnGkx1HSHXaF4yNcdv7V8ld+Y
	deXB3BMdGfjEUdUv5+7o5UqlizrX90vsyoOxERCCRFdxX5wMIaJk8bQMdK+rTF3W
	EH5ePcOW8ytmXUc3wYJ4uJgDAMTtvrb8DAbGgOBONXZ1c1958mlc8Km8jJgd4SE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VAF7lx
	UkjxV5e+ha8yPp1aoOAk44BNuSeb31sFhH9j0+9BU+UcrI2/ZmavAhiog8Ml/frR
	2xxgzNbIcAqJ6g9Mv0hic7PaElA586Uv3C+CMw930BQOa9O6A5kgn1IwPyflLn6m
	AJgbG4P3S9m+JcZRj00lvQ4eywpIkN/keqZo8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0636433FA0;
	Wed, 24 Jul 2013 22:52:01 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4862833F9E;
	Wed, 24 Jul 2013 22:52:00 +0000 (UTC)
In-Reply-To: <665576E7-6083-4535-9CE0-773236A0E9ED@joernhees.de>
 (=?utf-8?Q?=22J=C3=B6rn?=
	Hees"'s message of "Wed, 24 Jul 2013 17:28:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A66DAE6A-F4B3-11E2-B085-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231120>

J=C3=B6rn Hees <dev@joernhees.de> writes:

> On 24 Jul 2013, at 17:20, Junio C Hamano <gitster@pobox.com> wrote:
>
>> 	Goes and looks...
>>=20
>> OK, the tracking branches for these are created under refs/hg/*
>> using the same name.
>> ...
>> A refname shouldn't begin or end with a dot, because the range
>> ... ellided a correct description of the reason behind rule, which i=
s
>> ... irrelevant to the topic
>
> I think there is a slight misunderstanding here:
>
> .git/hg/<remote_name> will be the actual directory for a hg::
> remote, which will then use mercurial internal magic to refer to
> the shared repo .git/hg/.shared in case the remote is not
> somewhere on the local filesystem, otherwise that path is used.

Yes, it is not a "slight" but a "huge" misunderstanding.

I saw the caller of get_repo(url, alias) doing a

    'refs/hg/%s' % alias

immediately after the call, and somehow assumed that the proposal
would result in stuffing .shared to the "alias", which is not the
case.  The hg/$name directories may be used to store Hg repositories
for 'alias' that is passed by the caller, but hg/.shared thing you
guys were discussing is internal to get_repo() implementation and
there won't be refs/hg/.shared created because of this change.
