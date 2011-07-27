From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/19] Provide access to the name attribute of git_attr
Date: Wed, 27 Jul 2011 13:02:38 -0700
Message-ID: <7vr55bo47e.fsf@alter.siamese.dyndns.org>
References: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
 <1311689582-3116-8-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 27 22:32:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmAlw-0004H6-8T
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 22:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715Ab1G0Ub6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 16:31:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32931 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838Ab1G0Ub4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 16:31:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A73FA3B48;
	Wed, 27 Jul 2011 16:31:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=c5YblJ/hl0vpQyEg2Gw+DtfbKSk=; b=pT27qTPE7lJVLwGi2lLr
	JzLczm5K5MMSflo0O9VyvUy9H9slDS18uuEAGlCIQ9ENq+6o6BDT/mLTh9B3Re9C
	lEyK/i3S5Qhe6ZEx+HzeW2J8EqMYGLs0HoVlYslcxMQCeXKBijMu5+nY56VmUCQ9
	bsI51igzzDUSZkaPLwXcTxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=SXN2A+XWLDYLVYp7EWPsssxJcE06xAOI9wyXIRCU4T5jHG
	oXt8Vz6jfBKUFK4kuKXhemBMzhdVct/LulIPPko/Tb0R1Dtmn3H7CNoVYxbI+sM1
	f5odnkSc7GccKCjCMgATLMeKc4MQ6uCfFtdS63hsh4s6oTICGCRlUrzrYCpI0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EA223B47;
	Wed, 27 Jul 2011 16:31:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FB3C3B46; Wed, 27 Jul 2011
 16:31:53 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76A3E5D0-B88F-11E0-B85D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177997>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It will be present in any likely future reimplementation, and its
> availability simplifies other code.

Looks good to me except for minor nits.

> struct git_attr is an opaque structure containing, among other things,
> the name of the attribute that it represents.  This patch adds a
> function git_attr_name(struct git_attr *) that allows the name to be
> read from the structure.  This functionality will be convenient for
> later patches.
>
> This seems harmless to me.  It is hardly conceivable that the
> implementation will change so dramatically that it becomes impossible
> to derive the attribute name from the git_attr.

The original design of attribute API wanted to make sure that the callers
do not have to care what _other_ attributes are on the path, and defined
only "if you have a specific name, you can ask if that is set". Of course
once you start wanting to enumerate the attributes without knowing what
attributes may exist in the world, you would need an API to grab all the
attributes and then find out the name of each of them. So I think this is
not just harmless but is necessary.

> diff --git a/attr.c b/attr.c
> ...
> +char *git_attr_name(struct git_attr *attr) {
> +	return attr->name;
> +}

(Style)

	char *git_attr_name(struct git_attr *attr)
	{
		return attr->name;
	}

> diff --git a/attr.h b/attr.h
> ...
> +/*
> + * Return the name of the attribute represented by the argument.  The
> + * return value is a pointer to a null-delimited string that is part
> + * of the internal data structure; it should not be modified or freed.
> + */

should not be modified NOR freed?
