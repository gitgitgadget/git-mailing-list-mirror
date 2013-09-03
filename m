From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fast-export: refactor get_tags_and_duplicates()
Date: Tue, 03 Sep 2013 13:17:48 -0700
Message-ID: <xmqq38plr76b.fsf@gitster.dls.corp.google.com>
References: <1378019148-1565-1-git-send-email-felipe.contreras@gmail.com>
	<1378019148-1565-3-git-send-email-felipe.contreras@gmail.com>
	<xmqqsixlr8p2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 22:18:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGx36-0007Nh-VA
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 22:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760302Ab3ICUSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 16:18:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40573 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757015Ab3ICUR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 16:17:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92EB43ED08;
	Tue,  3 Sep 2013 20:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RKzAEnNpnxQcAV/gH+0QPsFW93g=; b=IeH+jV
	faML26Ifad6Z57YBcSCSMPG67Jwf4Ypgha6rdWmGhZlX28mJCdNtR3wzF4PeH5FQ
	vi0QRpHsHFkrRc48BEpWzSTIFeeIrBNk62tq8XnO/E0CF51i+abHpB41+fQ44MLF
	CEp/k4We/LSLbVfCxu/tO6xK0sqW22NZZsOTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oExR7uWFYpgBjWlFFZLGcSIkKL8XeDNW
	lyi6/OJKvWeAGt/lF4GutNZ1ye2GUk+GiNWVlKaJg9nZOKV4sF7vDB/DrynUtivO
	2ZdIdZ8MlfxIy1IdV8EUP/dVmYnLvsaq57lH/TnKvQx737eSMLaPyiS9sZ/vnjSu
	RKSWE3grBR4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 112793ECEE;
	Tue,  3 Sep 2013 20:17:55 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CA873ECCD;
	Tue,  3 Sep 2013 20:17:52 +0000 (UTC)
In-Reply-To: <xmqqsixlr8p2.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 03 Sep 2013 12:44:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E97F937A-14D5-11E3-A174-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233775>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Split into a separate helper function get_commit() so that the part that
>> finds the relevant commit, and the part that does something with it
>> (handle tag object, etc.) are in different places.
>>
>> No functional changes.
>
> Actually, the old code used to use commit unchecked if e->item->type
> said it is OBJ_COMMIT but e->item was somehow NULL.  The new code
> checks ...

Nah, I am an idiot.  We will segfault where we check e->item->type
before reaching that far down the code either way, so this is really
a no-op but makes it easier to fix (if we wanted to---I do not think
it matters that much).
