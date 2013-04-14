From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] Add public function
 read_blob_data_from_index_path()
Date: Sat, 13 Apr 2013 23:55:42 -0700
Message-ID: <7vsj2t61ox.fsf@alter.siamese.dyndns.org>
References: <1365787573-597-1-git-send-email-git@cryptocrack.de>
 <1365859712-8400-1-git-send-email-git@cryptocrack.de>
 <7vwqs56418.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lukas Fleischer <git@cryptocrack.de>
X-From: git-owner@vger.kernel.org Sun Apr 14 08:56:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URGr1-0002AG-9g
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 08:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303Ab3DNGzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 02:55:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37367 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766Ab3DNGzp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 02:55:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79463101D9;
	Sun, 14 Apr 2013 06:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F74xtXKylm534ixkufYqiMTA5Tc=; b=ex69oQ
	axi2NGFFdchXCsG1oJtOOEiyXzmvmWDKv1isRab4QtPxyCJIicWWq+GtBqzAV5T9
	Kj3LVMKtjBhNQJyUxMf6Fhj/4kWtMVj+39CZ2YDHcH8gNP765raGjLgZpVCCAL3k
	Q5vds4n2G9MnCcMvNyYJOYZJouT8PCbpBdf3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sErT/Zfp6M9b9zBIq7iJh9eNQw6uFOiU
	0cU6er9G+jwaGEvzdSL64rmaUzeuI/pqhHM55B1iPyb7uc7GCjRHDFS0e+MeyXJE
	vYcOdy8EXgnzGd3RQIfUuIHGXGu+B/MeC57SESFoIbC1up2jxtmI2zLOwi+itX6p
	VT4CoFyox2E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D084101D7;
	Sun, 14 Apr 2013 06:55:44 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E51E7101D6; Sun, 14 Apr
 2013 06:55:43 +0000 (UTC)
In-Reply-To: <7vwqs56418.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 13 Apr 2013 22:49:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 53BB3D5A-A4D0-11E2-AB7B-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221085>

Junio C Hamano <gitster@pobox.com> writes:

> diff --git a/attr.c b/attr.c
> index a668a63..46bde57 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -387,7 +387,7 @@ static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
>  	char *buf, *sp;
>  	int lineno = 0;
>  
> -	buf = read_blob_data_from_index_path(path, use_index);
> +	buf = read_blob_data_from_index(use_index, path);

This was wrong.

The one I'll push out will have:

	buf = read_blob_data_from_index(use_index ? use_index : &the_index, path);
