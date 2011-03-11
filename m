From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] refs_from_alternate: helper to use refs from
 alternates
Date: Fri, 11 Mar 2011 15:15:23 -0800
Message-ID: <7vaah1fdv8.fsf@alter.siamese.dyndns.org>
References: <1299876671-12838-1-git-send-email-gitster@pobox.com>
 <201103120008.27973.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Mar 12 00:15:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyBYm-0008J9-Om
	for gcvg-git-2@lo.gmane.org; Sat, 12 Mar 2011 00:15:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560Ab1CKXPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 18:15:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64458 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868Ab1CKXPj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 18:15:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 91B474F2A;
	Fri, 11 Mar 2011 18:17:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hzYTLa0OFXnyIIzT5rUgZtLSU2k=; b=dJDd66
	bG5KaG+8jCOAEkUBbVXutAuNzghQxG0TtrccyxM+vtJwpHUSc1ut1UXcUwmKQxmL
	H5p3XPnq/CHjP976nP7O6IskJ05Gtx8qasKko+MvGNGFpgB9zbnGvJky6vyr4M0E
	C/GbEMFI9Me933nRbz4CuPhfLEjRSQ6mjsn88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sb5bfgLB3i9e25MeG1orIM/DVfnMknxh
	cJQZmFMzjv28H7PmRs4n2rwTk7qnvoChbFJhnK9r53MLmRxw3NS/Egkmid1h9aW5
	kQ1mILmdRRr03ED0je4sHIRXiepAILvSLgMGXHWvpnoPaxQIKHPBmBSHlawBOaGJ
	T4r2vP/GInc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4F0184F26;
	Fri, 11 Mar 2011 18:17:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 34EDD4F1E; Fri, 11 Mar 2011
 18:16:57 -0500 (EST)
In-Reply-To: <201103120008.27973.j6t@kdbg.org> (Johannes Sixt's message of
 "Sat, 12 Mar 2011 00:08:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ABEB7F30-4C35-11E0-AF3C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168933>

Johannes Sixt <j6t@kdbg.org> writes:

> Can we have this without using dc? (We don't have it on Windows.)
>
> diff --git a/t/t5501-fetch-push-alternates.sh 
> b/t/t5501-fetch-push-alternates.sh
> index 564ef7c..eb844cf 100755
> --- a/t/t5501-fetch-push-alternates.sh
> +++ b/t/t5501-fetch-push-alternates.sh
> @@ -4,13 +4,11 @@ test_description='fetch/push involving alternates'
>  . ./test-lib.sh
>  
>  count_objects () {
> +	echo $(( $(
>  		git count-objects -v |
>  		sed -n -e 's/^count: \(.*\)/\1 +/p' \
> +		    -e 's/^in-pack: \(.*\)/\1/p'
> +		) ))
>  }

What does that do when there are only loose objects without packed ones?
