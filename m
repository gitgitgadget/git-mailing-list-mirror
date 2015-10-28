From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9] submodule update: expose parallelism to the user
Date: Wed, 28 Oct 2015 15:20:52 -0700
Message-ID: <xmqqtwpaskhn.fsf@gitster.mtv.corp.google.com>
References: <1445969753-418-1-git-send-email-sbeller@google.com>
	<1445969753-418-6-git-send-email-sbeller@google.com>
	<xmqqk2q8ni2i.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbm_aucoEADLFt3VjShP5Kgi0Wwyb6m1dRJtQWu9_ZtBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 23:21:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZ5Y-0005i8-1R
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 23:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbbJ1WUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 18:20:55 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54358 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750843AbbJ1WUy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 18:20:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1FE3F268E8;
	Wed, 28 Oct 2015 18:20:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JndR6MwKZN5zotHsFlHSkmNdx7I=; b=vkQnN/
	KaTRI1mVtjcdkMIHcGlDCc//nzzn2sr0gUjccLXupZ9a8N9qkaMkBDqfBIpZZue1
	hpr2r6g0LGwO4xQUb6u7n1Ju2ZMmMjKqzv/MNkgNWsjT8pHrgMVk8dTWpFXDNlRg
	+/+CngUiN7yfHwIWpQRiTKY3WWdUBlVwpapzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UhYh8d//wcj2/OpWA99CCRkjYsKUBCAt
	D7ULOrGcIbTY7/zHuDMJM/lw0LR56qDUQUtqbJ429JeoL0JNvqPYmMUzMjpNlWbI
	6Go8MEq8HGm86uznxf0iiUM5D3nP3Q4BTz0SQjQRDJfVBGBaOFr1X8x8bCZ/m3HZ
	e96Klo57O2M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 178D8268E7;
	Wed, 28 Oct 2015 18:20:54 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8D4A7268E5;
	Wed, 28 Oct 2015 18:20:53 -0400 (EDT)
In-Reply-To: <CAGZ79kbm_aucoEADLFt3VjShP5Kgi0Wwyb6m1dRJtQWu9_ZtBA@mail.gmail.com>
	(Stefan Beller's message of "Wed, 28 Oct 2015 14:40:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2706F920-7DC2-11E5-BFFE-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280399>

Stefan Beller <sbeller@google.com> writes:

> On Tue, Oct 27, 2015 at 1:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> And when 0 starts to meaning something special, we would need to
>> describe that here (and/or submodule.jobs entry in config.txt).
>> As I already said, I do not think "0 means num_cpus" is a useful
>> default, and I would prefer if we reserved 0 to mean something more
>> useful we would figure out later.
>
> Ok I'll add that, too.

Sorry, but I take it back.  We just can document that (1) "-j 0"
will give you some default, (2) we do not promise that the default
will be optimal for you from day one, (3) we reserve the right to
"improve" it over time, and (4) we promise that we won't make it an
insanely wrong value.  And let's keep "0 currently means num_cpu",
which may or may not be optimal but it cannot be an "insanely wrong"
value.
