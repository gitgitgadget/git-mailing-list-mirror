From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Introduce new build variables
 INSTALL_MODE_EXECUTABLE and INSTALL_MODE_DATA.
Date: Thu, 31 Jan 2013 07:51:18 -0800
Message-ID: <7vtxpxic5l.fsf@alter.siamese.dyndns.org>
References: <5109D230.2030101@iam.tj>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: TJ <git@iam.tj>
X-From: git-owner@vger.kernel.org Thu Jan 31 16:51:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0wQR-0002br-N9
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 16:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942Ab3AaPvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 10:51:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65032 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342Ab3AaPvV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 10:51:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2ACBC021;
	Thu, 31 Jan 2013 10:51:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t42oljBcRj83R1oPVYjukTDdVGY=; b=qcj1pU
	6MwoTkHc3/Vf9JNvnMMcul+JUAR/7HY5ZCNd/vfx45a//GhQNRccxUg6xNlBUpy8
	v/uEDC4ZSSd8ydMxlE8jOT1JAEMWfafmpmFiYwAB3mmNZBitbFgxENV4q8n+sSin
	WPSJ8B6mqOl82sTQJBt2bJoGa/Fp8rC3uVzs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cLeXPNvLqqedrkW5elSxIi9Vzo0KpOZA
	KdYvpfNmV55mvarcbiLBERi+irwAjYlWWx0xqE324ovq+4fSGyuw/b2pg6rWOmMC
	WnT2hLzRuof0aIJNpi68PXeQMEAgq+0x+aIxVi6E4Y2idVRhwP7CafK8xBPEtTZ0
	sCWs19mHH44=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B468CC020;
	Thu, 31 Jan 2013 10:51:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACA46C00B; Thu, 31 Jan 2013
 10:51:19 -0500 (EST)
In-Reply-To: <5109D230.2030101@iam.tj> (TJ's message of "Thu, 31 Jan 2013
 02:08:48 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E3FCDCC-6BBE-11E2-B4C8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215119>

TJ <git@iam.tj> writes:

> +	$(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) $(DESTDIR)$(man1dir)
> +	$(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) $(DESTDIR)$(man5dir)
> +	$(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) $(DESTDIR)$(man7dir)
> +	$(INSTALL) -m $(INSTALL_MODE_DATA) $(DOC_MAN1) $(DESTDIR)$(man1dir)
> +	$(INSTALL) -m $(INSTALL_MODE_DATA) $(DOC_MAN5) $(DESTDIR)$(man5dir)
> +	$(INSTALL) -m $(INSTALL_MODE_DATA) $(DOC_MAN7) $(DESTDIR)$(man7dir)

I'm tempted to suggest

    INSTALL_DIR = $(INSTALL) -d -m 755
    INSTALL_DATA = $(INSTALL) -m 644
    INSTALL_PROGRAM = $(INSTALL) -m 755

The number of lines the patch needs to touch will be the same, but
the resulting lines will not have many $(INSTALL_MODE_BLAH) shouting
at us.

Besides, you would want to differentiate the two kinds of 755 anyway
(I'd prefer INSTALL_PROGRAM to use -m 555 personally, for example).
