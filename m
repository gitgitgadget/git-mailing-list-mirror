From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] archive: do not read .gitattributes in working
 directory
Date: Wed, 15 Apr 2009 22:17:36 -0700
Message-ID: <7vhc0pnpn3.fsf@gitster.siamese.dyndns.org>
References: <1239848917-14399-1-git-send-email-gitster@pobox.com>
 <1239848917-14399-2-git-send-email-gitster@pobox.com>
 <1239848917-14399-3-git-send-email-gitster@pobox.com>
 <1239848917-14399-4-git-send-email-gitster@pobox.com>
 <1239848917-14399-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 07:19:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuK0K-00020e-LH
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 07:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbZDPFRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 01:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbZDPFRn
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 01:17:43 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbZDPFRn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 01:17:43 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E4B8EFD3B;
	Thu, 16 Apr 2009 01:17:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3F969FD39; Thu,
 16 Apr 2009 01:17:38 -0400 (EDT)
In-Reply-To: <1239848917-14399-5-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Wed, 15 Apr 2009 19:28:36 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E87C4E02-2A45-11DE-8400-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116669>

Junio C Hamano <gitster@pobox.com> writes:

> diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
> index 0713bca..760ea9d 100644
> --- a/builtin-tar-tree.c
> +++ b/builtin-tar-tree.c
> @@ -36,6 +36,14 @@ int cmd_tar_tree(int argc, const char **argv, const char *prefix)
>  		argv++;
>  		argc--;
>  	}
> +	if (2 <= argc && !strcmp(argv[1], "--fix-attributes")) {
> +		argv++;
> +		argc--;
> +	}
> +
> +	/* tar-tree defaults to fix-attributes as before */
> +	nargv[nargc++] = "--fix-attributes";
> +
>  	switch (argc) {
>  	default:
>  		usage(tar_tree_usage);

I screwed up this part; nargv[] array needs to be enlarged by one element
because of this change.  It resulted in a funny breakage in tests that
triggered only when run from the toplevel of the tree but did not surface
when the individual test was done from t/ directory, which my final
testing on the k.org machine caught, and that is why I still haven't
managed to push the result out for tonight.
