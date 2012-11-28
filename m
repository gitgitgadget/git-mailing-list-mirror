From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/7] remote-bzr: update working tree
Date: Wed, 28 Nov 2012 09:38:12 -0800
Message-ID: <7vtxs9vda3.fsf@alter.siamese.dyndns.org>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
 <1352643598-8500-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 18:38:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdlag-00051I-GC
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 18:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708Ab2K1RiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 12:38:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41452 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324Ab2K1RiO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 12:38:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2709C8DE4;
	Wed, 28 Nov 2012 12:38:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vdviu4y088oIkgmyzUm/BRkDpXk=; b=fOWcgP
	893aDpoW/fWbuX/da36nwhIDJbliMEmsolpVRsLtD8UlnGZ3Yt4ffYhS62+/Qq5D
	5B1/B05KUW7YyI32XYT1uFC1Ax5alp4m+zw2taattjzlCjCUitWx+7YvXqN6i62K
	0uRDrxBOy1lBPW1crUMTvYow0JCASfN/TenGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oy9Ch6mBcD69KelOtyXgajMIyntuA6lX
	g1SstdSZhcflqr+cd0EFjW33QSr9N7S10iuGRYjvz2o31h4dd4llWeGk1jlq8UtZ
	FHjI+HY51fDsHsKMSk5YY5JP0rvParvS2PVcP+slb6Lfoji2gXumRJ37OZ1mjoKo
	SHllJH1B+kU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 146C98DE3;
	Wed, 28 Nov 2012 12:38:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6FB3C8DE2; Wed, 28 Nov 2012
 12:38:13 -0500 (EST)
In-Reply-To: <1352643598-8500-5-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sun, 11 Nov 2012 15:19:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6271208A-3982-11E2-ADF1-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210745>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-bzr | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
> index 2c05f35..5b89a05 100755
> --- a/contrib/remote-helpers/git-remote-bzr
> +++ b/contrib/remote-helpers/git-remote-bzr
> @@ -571,6 +571,8 @@ def do_export(parser):
>              repo.generate_revision_history(revid, marks.get_tip('master'))
>              revno, revid = repo.last_revision_info()
>              peer.import_last_revision_info_and_tags(repo, revno, revid)
> +            wt = peer.bzrdir.open_workingtree()
> +            wt.update()
>          print "ok %s" % ref
>      print

Shouldn't this be squashed as part of one of the earlier patches?
The split between 1/7 (import first) and 2/7 (then support export)
makes sense, but this one looks more like "oops, we forgot to touch
the working tree while updating the history in the previous steps
and here is a fix" to me.
