From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 16/21] refs: check submodules ref storage config
Date: Wed, 13 Jan 2016 09:02:20 -0800
Message-ID: <xmqqtwmhpg4j.fsf@gitster.mtv.corp.google.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
	<1452561740-8668-17-git-send-email-dturner@twopensource.com>
	<xmqqtwmiqqk9.fsf@gitster.mtv.corp.google.com>
	<1452702766.16226.0.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:02:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJOoV-0001vt-Bn
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 18:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243AbcAMRCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 12:02:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750901AbcAMRCX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 12:02:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5A24A3A422;
	Wed, 13 Jan 2016 12:02:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wU2LYdiM3PO/AxqCrgaLldO5OMg=; b=RjchY/
	FarQ6ZMiVF3vlGznxx6eTseVVGIxfIt/oIBjkxXSvH5/VgEfQxDvpKh6nzydbAZ4
	QPw5v5bFFrntuiC5gVr3BPR8+tEjdWhgGrCpudI/mc8559cR9635Msq5ob1I56ZP
	KHH/IMvmYt7dbu7NPUDGDoPAzq16XUMSUdflw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gIWO1EC8B52/8sLAMliEKYh5LpgCfm+1
	+/rkK/tyi42tXZIENiw66W6YXQtYEUaE7Q9vxh+JtWXz/nkPEPWduxZQR7+GHYur
	TsDIMuwswTf0j7S2xrTaSEXtzJXL9sPvCu2bQHb4tWJSfaUihgmVQEGcG6ydUJsv
	sP6In8fC5KU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 41F0E3A421;
	Wed, 13 Jan 2016 12:02:22 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A93913A420;
	Wed, 13 Jan 2016 12:02:21 -0500 (EST)
In-Reply-To: <1452702766.16226.0.camel@twopensource.com> (David Turner's
	message of "Wed, 13 Jan 2016 11:32:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6939B6DE-BA17-11E5-89FE-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283936>

David Turner <dturner@twopensource.com> writes:

>> > +static int submodule_backend(const char *key, const char *value,
>> > void *data)
>> > +{
>> > +	char **path = data;
>> > +	if (!strcmp(key, "extensions.refstorage"))
>> > +		*path = xstrdup(value);
>> > +}
>> 
>> This should return "int" (namely 0).
>
> Fixed, thanks.

By the way, I initially thought "this function should return void",
until I realized that this is a callback function that is required
to have a fixed function signature.  It would save future readers a
similar confusion if it is named with "config" somewhere and/or
"_cb" at the end.

Thanks.
