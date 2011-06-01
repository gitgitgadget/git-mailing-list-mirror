From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] git-am: provide configuration to enable signoff by
 default
Date: Wed, 01 Jun 2011 10:14:30 -0700
Message-ID: <7voc2hh3t5.fsf@alter.siamese.dyndns.org>
References: <1306917751-27999-1-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Sekhar Nori <nsekhar@ti.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 19:14:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRp0F-00005X-NF
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 19:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759021Ab1FAROj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 13:14:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380Ab1FAROh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 13:14:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 393704195;
	Wed,  1 Jun 2011 13:16:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q/AonzduNtd/PCfciHZfNpCvqZo=; b=hT7Qjg
	Tnxx8gHNiXcpg1Jh36YJzozXL6IMEWKM1geoJ1KGB2xaa8iwA9AlHk7DwlzfEcTt
	Jfa+AXW60KStLL+DYEklBEiLSrAn7nWea4m0Q1cLEntSEEf78OjEjkDHrDONh2Ur
	Iujb8cRIa3RrcAsSJETELNmKFSR1mSluGV6XA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YNR+WFND1Ux3Jgi2KJYL2LLftD3WQlaH
	z/jk9m1Prfy5O2XAhe5dnh9h4Q3zAx5e3pZQAa0KnA5s6ppeoDcaOwl7Ada5wEwZ
	XoSN39JvfoTqw/lxtH0aUjC3tHbrPA2Unu3mTMiFOOR5d8vK/Vo6b1Z/mt20OGtz
	A/QwY63QGBw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 15ACB4194;
	Wed,  1 Jun 2011 13:16:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 21A8F4193; Wed,  1 Jun 2011
 13:16:40 -0400 (EDT)
In-Reply-To: <1306917751-27999-1-git-send-email-nsekhar@ti.com> (Sekhar
 Nori's message of "Wed, 1 Jun 2011 14:12:31 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC511DD2-8C72-11E0-B940-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174883>

Sekhar Nori <nsekhar@ti.com> writes:

> +am.signoff::
> +	A boolean value which lets you enable the `-s/--signoff` option of
> +	am by default. *Note:* Adding the Signed-off-by: line to a patch
> +	should be a conscious act and means that you certify you have
> +	the rights to submit this work under the same open source license.
> +	Please see the 'SubmittingPatches' document for further discussion.

I see you already have done your homework, which is much better than
previous attempts by other people to add an option to add sign-off to
various commands (commit and format-patch), but there are at least three
problems here:

 * This is an end-user document, not a document for git developers, so
   they are not bound by SubmittingPatches at all. They do not necessarily
   have SubmittingPatches document in the first place;

 * Once you set this configuration variable, I do not see a way to
   countermand "This is not signed-off" from the command line for a single
   invocation of "am" in your patch;

 * If it should be a "conscious act", it shouldn't be "set once and forget
   about it" configuration option. You should be making the conscious
   decision for each piece of e-mail if it is in line with the project's
   Sign-off policy.

The last one means that the patch is internally inconsistent. In a project
(not this project) where sign-off is used but it does not require signing
off to be a conscious act, I see it may make sense to make it easier to
sign-off a patch when generating (i.e. "commit -s"), preparing to send
(i.e. "format-patch -s"), or accepting (i.e. "am -s"). And this option
might be a possible way to do so. But in that case, the option description
wouldn't say "it should be a conscious act".

Also if it doesn't have to be a conscious act, what value does such a
boilerplate have? Such a project may be better off not using sign-off at
all to begin with.
