From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 6/9] receive-pack: Prepare for addition of the new
 'limit-*' family of capabilities
Date: Mon, 16 May 2011 15:07:29 -0700
Message-ID: <7vhb8ujo4e.fsf@alter.siamese.dyndns.org>
References: <201105151942.29219.johan@herland.net>
 <1305495440-30836-1-git-send-email-johan@herland.net>
 <1305495440-30836-7-git-send-email-johan@herland.net>
 <7vaaenm957.fsf@alter.siamese.dyndns.org>
 <BANLkTimUWHiUdxbBfvvcomqmzQxLPhUsZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 17 00:07:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM5x7-0008Qa-BM
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 00:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660Ab1EPWHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 18:07:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53258 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607Ab1EPWHm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 18:07:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 82A7C4E58;
	Mon, 16 May 2011 18:09:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=09BlRt46Eu4YCdsAOR9a/ji7tow=; b=j384cJ
	fDnWLtj4ZLzdPn1rOK6KvStaPW/+u2HCIx9GAJteS7nQo08N+/af7+Oyr51R9Hip
	ENrfYiZbNqIEx8uA9jueQI3x7mCgWLDn+phWyaQAakuy7NejPK76LFnSrUoQyAOp
	YHJ1IfqWfediWxhVWxO4QTT15kO/2Uk+p7Nwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TAxcs6AWOOK2RGoTnZB1Aek+k4d96uay
	KO0qDN2yPSKkA1sp8V5fLOX+yqFlsfp9b5sDhr97Wv3Mo52GKhoU7PiORtj+MD+n
	vBmWqSKh3zod3h4rzsUHCP+qTk5Bbgnt/ypPGpDUHhujPWxbxZeemSruDawfLIWH
	csqSkjH6Aoc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 429F84E57;
	Mon, 16 May 2011 18:09:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AB51F4E56; Mon, 16 May 2011
 18:09:38 -0400 (EDT)
In-Reply-To: <BANLkTimUWHiUdxbBfvvcomqmzQxLPhUsZA@mail.gmail.com> (Sverre
 Rabbelier's message of "Mon, 16 May 2011 15:02:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 34E9B7DC-8009-11E0-8199-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173768>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Sun, May 15, 2011 at 23:50, Junio C Hamano <gitster@pobox.com> wrote:
>> We should tighten this strstr() to make sure we are not matching in the
>> middle of a string, and the need to do so is even greater now that you are
>> going to introduce "foo=<value>" and the value could even be strings in
>> the future.
>
> If we are writing this down somewhere, should we also dictate how
> spaces should be escaped to be "forward-compatible"?

The old clients treat it as SP separted list, e.g. "featurea featureb featureb", 
from the beginning of how capabilities[] code was writte, so I do not see
a point. I would expect an arbitrary string values would be encased in
something like base64, base85 or hex.
