From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] fast-export: add --signed-tags=warn-strip mode
Date: Mon, 15 Apr 2013 21:47:18 -0700
Message-ID: <7vk3o3nktl.fsf@alter.siamese.dyndns.org>
References: <CAGdFq_g+kk-Fy1fcV6D5x4kroRXX63T8wjKNUqqfu39wUkSO6A@mail.gmail.com>
 <cover.1365936811.git.john@keeping.me.uk>
 <8716b887972b0eb1671afd2692416efd588f7d1d.1365936811.git.john@keeping.me.uk>
 <CAGdFq_jCO_+qj87rtcFyFG2tot8Ah2706X2dm82F6=GBV-g6nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 06:47:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URxni-000205-3F
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 06:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892Ab3DPErW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 00:47:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64309 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752861Ab3DPErV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 00:47:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1DDD11008;
	Tue, 16 Apr 2013 04:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sjOj+M+cKRcN0ve20fBYBwFSNmw=; b=TxG5Ia
	akdAh4YwljqLWKQ9OtMFphxLqzn7hWYFtz5PoI2x3veZ0TMxVjSMYzCIZKwMTXXC
	NrSWRvF22FDrEBuDFi9MzWygdKSukY7spoFQJZFyFBIDTN133nWxVDDiwFjavfbX
	qDJEyqpgpnAJ3ZCvO/vNBMD+OulWc6aho3Smg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OoRgZ2p544hci9SryRbL+d1g3xwmkH7Q
	JQm6S3Y9osgC6fQ3kElqKgOFYCUemrkXoG4IoT5XxoA6lqKm8EppwCU4ctaaklCv
	YbC2UfEL8Unx2sVt+AYmB235app9Y3nk85YuXVNi436z1ZbpSlHrlXtDMMfOcHEc
	EXEYbyvuvD8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6FFE11006;
	Tue, 16 Apr 2013 04:47:20 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C22811005; Tue, 16 Apr
 2013 04:47:20 +0000 (UTC)
In-Reply-To: <CAGdFq_jCO_+qj87rtcFyFG2tot8Ah2706X2dm82F6=GBV-g6nw@mail.gmail.com> (Sverre
 Rabbelier's message of "Mon, 15 Apr 2013 21:09:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8CCD2C2-A650-11E2-8B2E-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221363>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Sun, Apr 14, 2013 at 3:57 AM, John Keeping <john@keeping.me.uk> wrote:
>> This issues a warning while stripping signatures from signed tags, which
>> allows us to use it as default behaviour for remote helpers which cannot
>> specify how to handle signed tags.
>
> Perhaps it makes sense to instead count the number of signed tags and
> emit "Stripped signature from %d tags"? For example, for git.git it
> would be on the order of a hundred warning lines.

When you see 78 in the output and you know you have 92 tags in the
repository, is that sufficient to let you go on, or do we also need
an easy way to tell which ones are those 78 that were stripped and
the remaining 14 were not stripped?

There is no reason to worry about "some signed tags are stripped but
not others", so it feels that the number alone should be sufficient,
I guess.  If those remaining 14 weren't stripped, that is (at least
at the moment) by definition because they are unsigned, annotated
tags.
