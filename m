From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] bisect: string commands emited by "filter_skipped"
 together with "&&"
Date: Thu, 26 Feb 2009 23:01:18 -0800
Message-ID: <7v4oygnz29.fsf@gitster.siamese.dyndns.org>
References: <20090227073146.6699964f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 27 08:02:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcwkG-0000aJ-6o
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 08:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451AbZB0HBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 02:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753281AbZB0HBZ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 02:01:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbZB0HBY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 02:01:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3B7AC22ED;
	Fri, 27 Feb 2009 02:01:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 995E122EC; Fri,
 27 Feb 2009 02:01:19 -0500 (EST)
In-Reply-To: <20090227073146.6699964f.chriscool@tuxfamily.org> (Christian
 Couder's message of "Fri, 27 Feb 2009 07:31:46 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 70D88E3E-049C-11DE-8B14-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111639>

Christian Couder <chriscool@tuxfamily.org> writes:

> diff --git a/git-bisect.sh b/git-bisect.sh
> index a9324b2..08e31d6 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -296,14 +296,14 @@ filter_skipped() {
>  	do
> ...
>  	done
> +	echo ':'

Is there a particular reason you moved this echo ':' out of the downstream
of the pipe as I wrote in my response?

It logically belongs to the downstream in this pattern:

        producer of the list of items | {
                preparatory steps
                while read one item
                do
                        process one item
                        echo "something &&"
                done
                echo ":" ;# to conclude the && chain
        }

But you changed it to:

        preparatory step that does not concern producer

        producer of the list of items |
                while read one item
                do
                        process one item
                        echo "something &&"
                done

        echo ":"

which looks to me a lot less logical code structure.
