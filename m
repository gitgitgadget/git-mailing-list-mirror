From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] Move git-dir for submodules
Date: Tue, 16 Aug 2011 10:34:03 -0700
Message-ID: <7vhb5hi7lg.fsf@alter.siamese.dyndns.org>
References: <1313178913-25617-1-git-send-email-iveqy@iveqy.com>
 <1313178913-25617-3-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Aug 16 19:34:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtNWo-00069R-PK
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 19:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960Ab1HPReI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 13:34:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52207 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858Ab1HPReG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 13:34:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47C6646B5;
	Tue, 16 Aug 2011 13:34:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iYCXku2ahCnTX0xV4xhPQlEu0D0=; b=S5yT0l
	1sXkzJku83TffmhC/vbIgANwOljge+ps2PXQfDxueyTaYwWIUT/Rf4i3YQNqqx2L
	U8C8a49CoPw+uxRZXS/Rh1CbhmHKlrfSdkLZNgikIuVjFcEiJnmMHVsp4mukxkLc
	SN8SjYq+aEVJMZdVcAQuBzcJ63yz7RJ8TaKdA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GcfSyVk2dcjtOiOlsuFlxI5/S1uWgCAz
	pJ8Pq1ASADENTT3y7xeOS4XmfkUahw3xa69uxKcqJpjtoka14cydXUfp4uSuH6eU
	KpzI8As2v1b8+Ms55YiCJ5QTjAcJfUeP9TGQt6zhiNGJfGdAitxDkKVMeH3nDJJi
	TyqvWT2yVcc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DC1A46B4;
	Tue, 16 Aug 2011 13:34:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C359E46B3; Tue, 16 Aug 2011
 13:34:04 -0400 (EDT)
In-Reply-To: <1313178913-25617-3-git-send-email-iveqy@iveqy.com> (Fredrik
 Gustafsson's message of "Fri, 12 Aug 2011 21:55:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0150AAE-C82D-11E0-86D9-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179460>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> diff --git a/git-submodule.sh b/git-submodule.sh
> index bc1d3fa..ace6c1d 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -122,14 +122,53 @@ module_clone()
>  	path=$1
>  	url=$2
>  	reference="$3"
> +	gitdir=
> +	gitdir_base=
> +	name=$(module_name "$path")
> +	if test -z "$name"
> +	then
> +		name="$path"
> +	fi

This conditional is not needed; module_name dies when it cannot find the
name for the path, as it should.

If the defaulting to the path itself were a good idea (which I do not
think it is), that should be done in module_name so that other callers
that tried to find the name for a given path that does not have a named
module would get a consistent result.
