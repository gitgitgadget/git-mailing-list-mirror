From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Accessing the reflog remotely
Date: Wed, 04 Nov 2009 10:03:56 -0800
Message-ID: <7vbpjii2ur.fsf@alter.siamese.dyndns.org>
References: <vpqljimpr95.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Nov 04 19:04:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5kDL-0005uZ-6z
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 19:04:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757530AbZKDSD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 13:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757447AbZKDSD7
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 13:03:59 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60965 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932116AbZKDSD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 13:03:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C5B1E92ADF;
	Wed,  4 Nov 2009 13:04:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Ol3GWAeC56/7WcMnTz3FETo9S1Q=; b=C+DY6MXZSAfx5GwrBp7HdYy
	5lF6EH2eMtDFOSM2MZa4QPWFsrgSflBCZZPP3wmqNpUTPRGlSsNbcQxibnDGco/l
	v6MUs/6SY0LAV9LRaQkG7G5pyO4/cOpLRk7fRh3+D3nhGINbcmZIMR3RKmPJlsvA
	ZU3y6IR9Rk1lKajjVjfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=OeunAauUGmtHFy5+svtZkwoIzKbWkMfKSeYKbsS+LZWV53Go0
	pyZmnCVFx8AWyqBL7A4F79jbi0u5aWSYY/rRTQd2qHpPx60W3avu5WdRZlbVupTH
	DsT4jvFEozbMeUPYT7TS5BR5wBVgykueAuyl1xuU7ybR9/npc/Y30rjUkk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A30C392ADE;
	Wed,  4 Nov 2009 13:04:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8C5BF92ADD; Wed,  4 Nov 2009
 13:03:57 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6DF4D89A-C96C-11DE-97A3-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132102>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I guess the answer is "no", but I'll still ask in case ...
>
> Is it possible to access the reflog of a remote repository other than
> logging into this repository?
>
> My use-case is the following: I want to checkout "the last revision
> pushed in master on ssh://host/repo/ on day D at midnight" (to fetch
> the project of my students ;-) ). If it were locally, I'd do

This won't solve your problem but I'll mention it anyway as it may be
related.

A distribution point repository like this is often bare, and reflogs are
not enabled in bare repositories (primarily due to my stupidity^Wbeing
overly cautious---I was very skeptical about reflogs when we introduced
it).  It may make sense to enable reflogs everywhere by default in some
major version bump.

Also a distribution point repository is often served by gitweb and it
would be really nice if there were an option to allow its summary view
to show commits annotated with reflog entries, e.g.

    ----------------------------------------------------------------
    2 days ago          JCH Merge branch 'maint'
    (pushed 6 hrs ago)
    ----------------------------------------------------------------
    2 days ago          DVL Makefile: add compat/bswap.h to LIB_H
    ----------------------------------------------------------------
    3 days ago          JCH Revert "Don't create the $GIT_DIR/branches directory on init"
    (pushed 60 hours ago)
    ----------------------------------------------------------------
    4 days ago          JCH fixup tr/stash-format merge
    ----------------------------------------------------------------
        ...
