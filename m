From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bundle doc: 'verify' is not about verifying the bundle
Date: Wed, 02 Mar 2016 10:18:40 -0800
Message-ID: <xmqqbn6w4ubj.fsf@gitster.mtv.corp.google.com>
References: <xmqqd1rd7uey.fsf@gitster.mtv.corp.google.com>
	<20160302092236.GB30065@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 19:18:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abBMH-0008TF-4T
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 19:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbcCBSSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 13:18:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752106AbcCBSSo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 13:18:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 79FA647AB3;
	Wed,  2 Mar 2016 13:18:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dgOSVWcih1ZEL2KZ/iWF1uVpM8o=; b=mVjwO4
	IRGsOkzZOzKgJJBK6GIdW5DNyj4xhIisJJeTz+x4A7LJiM/tgljrj7vaMV67E6ph
	cXUiJrKi+12YjWDakkiRErVU2/5qvjHDq2ztyKaOEhoXOOP8egQkJRo3mWyja5Pr
	0ROc/d3OLDB171T7ZJSI/wHQ4I0OpBm4Y9OPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WpCIZus3tL2llxIDwGK1kmdfUfGNHYfE
	2Cw5EJNY0qqhq+fhqm7I/yE3Mr+GtTqCVdh27lehDMeH2Dn8D8PcA2wuwnK7ArdT
	5YGCM2OgEW4cfBhQRoW8p4CZ+pYGBzStTLMombMGBW3DuyS+ByhXwvUHRGcGrd4G
	mMqLFPRNuMI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7241447AB2;
	Wed,  2 Mar 2016 13:18:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D018947AB0;
	Wed,  2 Mar 2016 13:18:41 -0500 (EST)
In-Reply-To: <20160302092236.GB30065@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 2 Mar 2016 04:22:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3173CACA-E0A3-11E5-A518-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288141>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 01, 2016 at 01:36:05PM -0800, Junio C Hamano wrote:
>
>> Even though the command does read the bundle header and checks to
>> see if it looks reasonable, the thin-pack data stream that follows
>> the header in the bundle file is not checked.  More importantly,
>> because the thin-pack data does not have a trailing checksum like
>> on-disk packfiles do, there isn't much "verification" the command
>> can do without unpacking the objects from the stream even if it
>> wanted to.
>
> Are you sure about that trailing checksum thing?

No.  I misread the fact that we do not say the final csum on the
command output from pack-objects in the --stdout case. We do call
the sha1close() to append the csum at the end of the pack stream;
we just do not make it available to the caller who is driving the
pack-object procedure.
