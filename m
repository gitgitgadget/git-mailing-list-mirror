From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] gitweb: make static files accessible with PATH_INFO
Date: Tue, 27 Jan 2009 17:07:41 -0800
Message-ID: <7vocxsz19e.fsf@gitster.siamese.dyndns.org>
References: <1233103932-6325-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 02:09:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRyve-0005wZ-Gq
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 02:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbZA1BHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 20:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbZA1BHy
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 20:07:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbZA1BHx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 20:07:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5F4E11D6C2;
	Tue, 27 Jan 2009 20:07:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 882C41D6C1; Tue,
 27 Jan 2009 20:07:48 -0500 (EST)
In-Reply-To: <1233103932-6325-1-git-send-email-giuseppe.bilotta@gmail.com>
 (Giuseppe Bilotta's message of "Wed, 28 Jan 2009 01:52:12 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1664BE5E-ECD8-11DD-8675-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107441>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> When PATH_INFO is defined, static files such as the default CSS or the
> shortcut icon are not accessible beyond the summary page (e.g. in
> shortlog or commit view).
>
> Fix this by adding a <base> tag pointing to the script's own URL.
>
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 931db4f..55e3081 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2901,6 +2901,11 @@ sub git_header_html {
>  <meta name="robots" content="index, nofollow"/>
>  <title>$title</title>
>  EOF
> +# the stylesheet, favicon etc urls won't work correctly with path_info unless we
> +# set the appropriate base URL
> +	if ($ENV{'PATH_INFO'}) {
> +		print "<base href=\"$my_url\" />\n";
> +	}

Perhaps this is a stupid question, but is $my_url already safe to include
in the output without any further quoting at this point in the codepath?
