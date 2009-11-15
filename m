From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH todo] dodoc: detect doctype-xsl version before making
 docs
Date: Sun, 15 Nov 2009 02:09:57 -0800
Message-ID: <7vy6m8m74a.fsf@alter.siamese.dyndns.org>
References: <20091112023139.GA1627@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 11:10:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9c3i-0003g2-QU
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 11:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbZKOKKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 05:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752585AbZKOKKB
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 05:10:01 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbZKOKKA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 05:10:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E1F27F71D;
	Sun, 15 Nov 2009 05:10:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=QSEHsDz0KI2LdVP85JMUGwFIfXA=; b=pwXu8qModgm3wzSMiIaUVxR
	Fvw9iRIT3uKt/zYg52fiLqGQFBS0etGAinAjD1tkNzm3whAeavLr6H7xfTK62KJA
	PV8uv5t9hSLoDvO4PYQWrPmBec5DICSyMTDLgVefBSII5T2r/Gw1lqYn3m2g+J4I
	if4WAAUBFInFYK3pc81I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=LJZfl+ShpXSr1EIiry+t0I4wABdDpURnq/aivdks51fbJbnw7
	4pvDpUumtnAmnAJJdy1BrrlYMMP12wqZnfotcIp2wQaPgFB9EtJSJjwffDka7O7P
	+dLdy75RvpLUeQ9PvUdBeW+hw5flUG1+NuYnCZiNJdn+981f9mlu82cBA4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 471BB7F71C;
	Sun, 15 Nov 2009 05:10:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64C0B7F719; Sun, 15 Nov
 2009 05:09:59 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0A833868-D1CF-11DE-B81F-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132927>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The manpages in the man branch of git.git appear to have acquired
> the dreaded escaped .ft disease when the docbook-xsl toolchain
> was upgraded to v1.74.3.
> ---
> It is hard work avoiding escaped nroff directives in output.  I am a
> bit confused at what happened here, since docbook-xsl v1.73.2 should
> have required the same settings.
>
> These changes are untested, unfortunately.  I hope they can be of some
> help nevertheless.
>
>  dodoc.sh |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
>
> diff --git a/dodoc.sh b/dodoc.sh
> index 5cbc269..bf49710 100755
> --- a/dodoc.sh
> +++ b/dodoc.sh
> @@ -77,6 +77,19 @@ asciidoc' 8'.*)
>  	export ASCIIDOC8 ;;
>  esac
>  
> +db_version_file=/usr/share/xml/docbook/stylesheet/nwalsh/VERSION
> +case "$(grep "<fm:Version>" "$db_version_file" 2>/dev/null)" in

Thanks, but there seem to be no such file on FC11.  In /etc/xml/catalog,
I see:

<rewriteURI
 uriStartString="http://docbook.sourceforge.net/release/xsl/current"
 rewritePrefix="file:///usr/share/sgml/docbook/xsl-stylesheets-1.74.3"/>

Unfortunately this seems highly distro dependent.  On my near-by Debian
box, /etc/xml/docbook-xsl.xml has

    <delegateURI
     uriStartString="http://docbook.sourceforge.net/release/xsl/"
     catalog="file:///usr/share/xml/docbook/stylesheet/nwalsh/catalog.xml"/>

and the _catalog_ file has comment v1.73.2 (or whatever) and also

    <rewriteURI
     uriStartString="http://docbook.sourceforge.net/release/xsl/1.73.2/"
     rewritePrefix="./"/>

For now I simply will give up to be portable and adjust the script for the
reality on k.org machine that is used to auto-generate the documentation.
