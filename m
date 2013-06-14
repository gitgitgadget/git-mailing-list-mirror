From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] . git.el: use commit.template if available
Date: Fri, 14 Jun 2013 10:51:04 -0700
Message-ID: <7v1u84pomv.fsf@alter.siamese.dyndns.org>
References: <20130614172535.GA24983@higgs.cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, julliard@winehq.org
To: Curt Brune <curt@brune.net>
X-From: git-owner@vger.kernel.org Fri Jun 14 19:51:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnY9Y-0007ma-Nm
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 19:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330Ab3FNRvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 13:51:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62551 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752048Ab3FNRvG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 13:51:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48C8E27FB0;
	Fri, 14 Jun 2013 17:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X8VGf1hMgXJzaGtmH7g1VcrgLNw=; b=llNvCT
	GC6v17yLYe66Q7IePr6bUVSkN9MWco31MSDf4FCS3/TM37JVdfohFDsp4XwwI70k
	SvWPHMa3NJKG1hGM/wMQNnXvdJg6A2z9Dt2ZUBts6k093mYNRM32RKE4waZ2bC0B
	Gu11fReC8MauYQfBbMfxt08XV8ZXLp36PKEVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K9oWHVZtiOnPAb0o4ERQUoOXE9B+zroA
	0zChYzW7xiM5EDmL5owvZXZLSg03C8GSZJ6L3bBJumf9uMgjyFUnAAzW69cvkpCb
	2VsZTaxAOuYRn3GVnZalrJphhE1F1rYJ+bjDs+sU+Eb3sHPjszPWOwyQHL6S1IoL
	zNdApkShG5Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D30B27FAF;
	Fri, 14 Jun 2013 17:51:06 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D29627FAE;
	Fri, 14 Jun 2013 17:51:05 +0000 (UTC)
In-Reply-To: <20130614172535.GA24983@higgs.cumulusnetworks.com> (Curt Brune's
	message of "Fri, 14 Jun 2013 10:25:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC7E2BBC-D51A-11E2-88E8-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227904>

Curt Brune <curt@brune.net> writes:

> If the user's git config defines commit.template then include the
> contents of that file in the log buffer by default.
>
> In git-setup-log-buffer, instead of supplying the default commit
> message insert the user's commit.template.
>
> Signed-off-by: Curt Brune <curt@brune.net>
> ---

Interesting.

I wonder if git-do-commit still needs to reimplement the commit
logic using low-level plumbing in this era, which I think is the
cause of having to constantly catch up with what "git commit"
Porcelain does (like paying attention to configuration variables).

I often just do

	M-x compile<ENTER>git commit args...<ENTER>

while setting my EDITOR to 'emacsclient', and I have a suspicion
that the callchain from git-commit-file to git-setup-log-buffer can
be quite simplified if such an approach is used.  Enumerate the
marked file(s) to formulate the "git commit" command line and let
the underlying "git commit" do the heavy-lifting, that is.
