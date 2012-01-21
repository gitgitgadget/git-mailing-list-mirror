From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix git-gui crash due to uninitialized variable
Date: Sat, 21 Jan 2012 14:13:37 -0800
Message-ID: <7v1uqsbt66.fsf@alter.siamese.dyndns.org>
References: <20120121175724.GA7319@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Jan 21 23:13:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RojBx-0006OX-04
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 23:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629Ab2AUWNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jan 2012 17:13:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36436 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399Ab2AUWNk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2012 17:13:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2C4274D2;
	Sat, 21 Jan 2012 17:13:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ywwy27INgxjU2TdAoXP3kVgJ7Eg=; b=Zip1hf
	FPYUiGRE+YvzmlnPbi9W8M+G5GCeml40d3kFbhoLZq3hp9oY9Q5xQu8GTqCXA7sj
	/g07vkRCO5/dXWs3Tl3QoceXwFamb9XSlkAdsBs45hXoRguJ278fZgESNTcxr2O4
	wZ2ea2LUUcjqd430h4e8htfg2Gkeims62vAek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B7Cht/Cjm5XIRyRL2Z2mvorm6MLSFQ/s
	zq5meb0KMXjNx2Rn+0AqjYG21PPivXs/swZidzkM+l1Y1+HsylIXIes+Yy6Qnqsa
	rfmNnFIxLT8mMDMfoPDaOI6tjdSS00qgv+wGJfutSk6ylL5MG0kvCiUts//tAqqs
	NIJhIIVNlpM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA06274D1;
	Sat, 21 Jan 2012 17:13:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FBCC74D0; Sat, 21 Jan 2012
 17:13:39 -0500 (EST)
In-Reply-To: <20120121175724.GA7319@ecki> (Clemens Buchacher's message of
 "Sat, 21 Jan 2012 18:57:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2BB5395A-447D-11E1-812B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188936>

Clemens Buchacher <drizzd@aon.at> writes:

> Recently, a clone initiated via git gui on Windows crashed on me due to
> an "unknown variable cdone". It turns out that there is a code path
> where this variable is used uninitialized.
>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ---

Thanks, but Clemens, please don't Cc: me git-gui patches, which I won't
take directly.

Pinging Pat.

> Looking at the output of display(), it's not clear to me now the
> function below could ever be called with total=0. But I can't delve into
> it more deeply right now, and this seems like an obvious fix.
>
>  git-gui/lib/status_bar.tcl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/git-gui/lib/status_bar.tcl b/git-gui/lib/status_bar.tcl
> index 95cb449..02111a1 100644
> --- a/git-gui/lib/status_bar.tcl
> +++ b/git-gui/lib/status_bar.tcl
> @@ -77,6 +77,7 @@ method start {msg uds} {
>  
>  method update {have total} {
>  	set pdone 0
> +	set cdone 0
>  	if {$total > 0} {
>  		set pdone [expr {100 * $have / $total}]
>  		set cdone [expr {[winfo width $w_c] * $have / $total}]
