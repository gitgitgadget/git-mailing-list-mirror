From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Added syntax highlight support for golang
Date: Fri, 07 Feb 2014 13:54:11 -0800
Message-ID: <xmqqiosqtwqk.fsf@gitster.dls.corp.google.com>
References: <1391807441-23049-1-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 22:54:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBtNm-00015f-H6
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 22:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbaBGVyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 16:54:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37384 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617AbaBGVyU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 16:54:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6FAB69F7D;
	Fri,  7 Feb 2014 16:54:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PsFIC0nM5CMGhQRflllw6U7zCe4=; b=q7tUwj
	9U3CZwx8G8pWyWLrs5VBkHFV1BCg9fegLTkhVJ7yXCW5O0ZNxQH6Xiy4VogCbpBc
	G/ykhLw+VlX6mcD+//QlZE7BF21M6kZMAs9eMIuoy37iWfS+TwMdiwbIn40DI8Qh
	T63U0rKIEASMGhAYKe0xTpHkobkCP2g7x8ih4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=brv7OfkNeFDGBH8R61aCd84HTiJZbFYL
	MnVaTlH1yDjs+sDM4x1tlRkMkCuUZ2i+jNb46iAeh0A821u74Bg2Ikj1u9A6JDoW
	4vMWIeHKYsjW2Yq0dQHjM5n3HqDtzASzGpGOxZNq5uzBX1cRSmLIhX1cV34yTeWJ
	JC4mlaPTxPg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8BA569F77;
	Fri,  7 Feb 2014 16:54:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 295BE69F6A;
	Fri,  7 Feb 2014 16:54:15 -0500 (EST)
In-Reply-To: <1391807441-23049-1-git-send-email-pavan.sss1991@gmail.com>
	(Pavan Kumar Sunkara's message of "Sat, 8 Feb 2014 02:40:41 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 62D916D2-9042-11E3-918B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241806>

Pavan Kumar Sunkara <pavan.sss1991@gmail.com> writes:

> Golang is quickly becoming one of the major programming languages.
>
> This change switches on golang syntax highlight support by default
> in gitweb rather than asking the users to do it using config files.

Looks trivially harmless ;-)

I haven't touched this part of our system, but the patch makes me
wonder if there is a way for us to _ask_ the installed 'highlight'
binary what languages it knows about.  This hash is used only in
guess_file_syntax sub, and it may not be unreasonable to populate it
lazily there, or at least generate this part by parsing output from
'highlight -p' at build-install time.

> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> ---
>  gitweb/gitweb.perl |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index bf7fd67..aa6fcfd 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -273,7 +273,7 @@ our %highlight_basename = (
>  our %highlight_ext = (
>  	# main extensions, defining name of syntax;
>  	# see files in /usr/share/highlight/langDefs/ directory
> -	(map { $_ => $_ } qw(py rb java css js tex bib xml awk bat ini spec tcl sql)),
> +	(map { $_ => $_ } qw(py rb java go css js tex bib xml awk bat ini spec tcl sql)),
>  	# alternate extensions, see /etc/highlight/filetypes.conf
>  	(map { $_ => 'c'   } qw(c h)),
>  	(map { $_ => 'sh'  } qw(sh bash zsh ksh)),
