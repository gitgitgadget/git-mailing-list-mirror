From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Out of memory on git log --simplify-by-decoration
 --first-parent
Date: Fri, 08 Jun 2012 13:09:10 -0700
Message-ID: <7vwr3hbm6x.fsf@alter.siamese.dyndns.org>
References: <4FD24330.2030805@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Fri Jun 08 22:09:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd5Uj-0002cB-Al
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 22:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759234Ab2FHUJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 16:09:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50898 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759167Ab2FHUJM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 16:09:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48BFE892C;
	Fri,  8 Jun 2012 16:09:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fLaOdhGGOOSV6hTifHSwlITzHEU=; b=wn8h3d
	rj5bV99Dj6VWzxRMdVDhtxchDTxB8W4QyGYAGLBBDpFCIdEIG7esVSNSX5sqeabs
	2iyugSW30uY+qMnAQG0gIQ7sssGF4XO9IABl5lIij2XSwJLzfgRgZYm6NR5cti6U
	/wwSZA0DMF4NyjZEcKil5cFWWSRui8RglhQ5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=voOZv6QhO6bwPvBBH0oXHpMiMccGAhOO
	Y5MUC0HbLaLUNwHLLiOukyvv+sIS0/6zuqk9l9xWtknUW/Gv0t3ebyoBYJOk+2Zm
	oyKwgQfUMzRGndBzJix+cydTe8JH+rMYy4QwFQAMZ4o0m4hErM21SSKyqXutuFnG
	jLW/bH1zesY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 406D28929;
	Fri,  8 Jun 2012 16:09:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD5558925; Fri,  8 Jun 2012
 16:09:11 -0400 (EDT)
In-Reply-To: <4FD24330.2030805@lyx.org> (Vincent van Ravesteijn's message of
 "Fri, 08 Jun 2012 20:23:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D01E847A-B1A5-11E1-8B19-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199528>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> git dies after calling the following command on the git repo:
>
> $ git log f623ca1c...b9cfa4e9 --simplify-by-decoration --first-parent

I wouldn't be surprised anything random happens when --first-parent
is used together with simplify_merges(); the function needs full
analysis of all commits in the specified range, and first-parent
traversal specifically tells us not to descend into other parents.
It might not be a bad idea to forbid this combination when the
command line options are parsed.

What information were you trying to get out of the above command?
