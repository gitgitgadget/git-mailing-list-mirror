From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] grep: stop looking at random places for
 .gitattributes
Date: Wed, 10 Oct 2012 12:56:16 -0700
Message-ID: <7vtxu2ayov.fsf@alter.siamese.dyndns.org>
References: <1349868894-3579-1-git-send-email-pclouds@gmail.com>
 <1349877544-17648-1-git-send-email-pclouds@gmail.com>
 <1349877544-17648-3-git-send-email-pclouds@gmail.com>
 <50758477.3030304@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 10 21:56:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM2OO-0007PK-Dr
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 21:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756897Ab2JJT4X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 15:56:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58896 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756791Ab2JJT4V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2012 15:56:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63FC88BFF;
	Wed, 10 Oct 2012 15:56:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DmgJCErRBLbv
	rvAV8LxdtTfgRcQ=; b=SqIphfuURXeTQ3107VV/ZZz2eCNefQxMk3lkx/Ebf65X
	1oIb99VE27EsFOFTKIYTWeD0CW+5f9t13ewsFqQWsN5F0X/YE6LUq2vqGlBauGrr
	UMn6NvcOFOOo308zIv0ce8CBmrMv+kHMhGVW04pW7fSLemRkFFsPx9R9MOQcP84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hAY4U3
	LjpN/rUadjM2IIGN0gUXOx84xFTax1UnRdAc8cqOVpiNLCEjo2mw5Lj2RrjDmEJN
	HnJ+fgGvobEi9EU2CzKK7BNz+7oFADdIMZz/Ik1TTK30EcqTYP9qXAS4WFL4mjPl
	L4Ahb1gN+y+Qd67NhERgfrmovvhLrJl4F19VI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5145F8BFE;
	Wed, 10 Oct 2012 15:56:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC99C8BFB; Wed, 10 Oct 2012
 15:56:17 -0400 (EDT)
In-Reply-To: <50758477.3030304@viscovery.net> (Johannes Sixt's message of
 "Wed, 10 Oct 2012 16:21:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8DFFA3E6-1314-11E2-877B-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207434>

Johannes Sixt <j.sixt@viscovery.net> writes:

> At any rate, I don't observe the warnings anymore with this series.

What kind of warnings have you been getting?  Earlier we had a bug
in the jk/config-warn-on-inaccessible-paths series that made it warn
when we tried to open a .gitattribute file and open() returned an
error other than ENOENT.  The bug was that we saw unnecessary errors
when a directory that used to exist no longer exists in the working
tree; we would instead get ENOTDIR in such a case that needs to be
ignored.

The problem was supposed to be "fixed" by 8e950da (attr: failure to
open a ".gitattributes" file is OK with ENOTDIR, 2012-09-13); if you
are still seeing the error, that error still may need to be
addressed, regardless of Nguy=E1=BB=85n's patch.
