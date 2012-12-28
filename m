From: Junio C Hamano <gitster@pobox.com>
Subject: Re: (unknown)
Date: Fri, 28 Dec 2012 11:33:31 -0800
Message-ID: <7vk3s2hsz8.fsf@alter.siamese.dyndns.org>
References: <20121228164322.B102B4413A@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: esr@thyrsus.com (Eric S. Raymond)
X-From: git-owner@vger.kernel.org Fri Dec 28 20:34:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tofgx-00013k-7d
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 20:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373Ab2L1Tdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 14:33:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59159 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932316Ab2L1Tde (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 14:33:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22401A31A;
	Fri, 28 Dec 2012 14:33:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fotmqbClnl6d7momPUjjyWbSx5U=; b=SWgbu4
	ZYl8xxK/jSK2eoupVUkxFr++zxps66frF8dnyit5vJsQpde91J7Bio7WydO2svqE
	XsxenYenGZp7lmabVX+iZjKQE4lqJ0zcmsG6BC0zD67jANiUr88+Rd+wJtUcTjkh
	LAIgZ/JjXBgQioKxLmDZ2/C05+kHCrn4ZKfQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BPjwQh/0B9wUHlNaEo+sthrK8x3Uq1OB
	YAPMc+XjS9Th+WL7pX3yi8gWuVaikOw/9mT2vHKCK4ra7C+WShiKEsIVUli7iJf1
	UHtXAYOTt2dM74ltRaPEPtgyNAeYOVg+8yxd3+tuYEEotGwevb3TvdrV2oZBBpJi
	egFm3LN8Y8s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10837A319;
	Fri, 28 Dec 2012 14:33:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C1B3A318; Fri, 28 Dec 2012
 14:33:33 -0500 (EST)
In-Reply-To: <20121228164322.B102B4413A@snark.thyrsus.com> (Eric S. Raymond's
 message of "Fri, 28 Dec 2012 11:43:22 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 777783BA-5125-11E2-B2C7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212252>

esr@thyrsus.com (Eric S. Raymond) writes:

> From: "Eric S. Raymond" <esr@thyrsus.com>
> Date: Fri, 28 Dec 2012 11:40:59 -0500
> Subject: [PATCH] Add checks to Python scripts for version dependencies.
>
> ---
>  contrib/ciabot/ciabot.py           | 8 +++++++-
> ...
> diff --git a/contrib/fast-import/import-zips.py b/contrib/fast-import/import-zips.py
> index 82f5ed3..b989941 100755
> --- a/contrib/fast-import/import-zips.py
> +++ b/contrib/fast-import/import-zips.py
> @@ -9,10 +9,15 @@
>  ##  git log --stat import-zips
>  
>  from os import popen, path
> -from sys import argv, exit
> +from sys import argv, exit, hexversion
>  from time import mktime
>  from zipfile import ZipFile
>  
> +if hexversion < 0x01060000:

I am assuming that you are carefully limiting what you import from
"sys" by adding only hexversion to the import above, but then can we
refer to sys.stderr below?

> +	# The limiter is the zipfile module
> +        sys.stderr.write("import-zips.py: requires Python 1.6.0 or later.\n")
> +        sys.exit(1)
> +
