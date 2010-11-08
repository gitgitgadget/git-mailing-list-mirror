From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'Unable to find remote helper'
Date: Mon, 08 Nov 2010 10:54:42 -0800
Message-ID: <7vzktjprwt.fsf@alter.siamese.dyndns.org>
References: <F815EC90C848458886E418CB6DE1DA8B@ssipboulton>
 <20101104224010.GA18693@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Boulton <philipb@ssimicro.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 19:55:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFWsB-00025k-Uf
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 19:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755066Ab0KHSyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 13:54:55 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44930 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754989Ab0KHSyx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 13:54:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7558B329C;
	Mon,  8 Nov 2010 13:54:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wYClGU5OS2waTmE86y09dBts6mA=; b=uBHjGr
	5R1iZU61LTQtfVptCJ9uiw72kSnZMpSo3eYyRwz7wrcXMZUbu7PwL5H/cvIdYZeX
	b7ghrKiIkybEWDzsiw3EuskT5KxbZL0W6NrN7bLZW6h4JauiTJZzyEza8lUx8spj
	dwybLzi4UrC7s5GQMV0vW0JwCWPMuzrVFUKeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vUe8QR0+0M9MkscvEcptwWWDlx8QxeL8
	xKt1NFDpRfx9oRHdt/F6v4YFxeXwbBEo9Vdmp4EuN8JyQSr6RrjM2k5lxlSWTzf6
	Mj3dmnbOrDC0z+fDLWYyjT0kpvV7jIniyOTCRl5gYdpmEvWwDS+g8gCE9e63qSkR
	Kr17UA5v+0s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 45BD1329A;
	Mon,  8 Nov 2010 13:54:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 231073296; Mon,  8 Nov 2010
 13:54:46 -0500 (EST)
In-Reply-To: <20101104224010.GA18693@burratino> (Jonathan Nieder's message of
 "Thu\, 4 Nov 2010 17\:40\:10 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AAB4C054-EB69-11DF-AE1F-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160969>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The "gmake clean" undoes the effect of "./configure".
>
> Hope that helps.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

You diagnosed the problem correctly, but I do not think the patch is
correct.  Why should the generated file *.autogen be kept around across
"clean"?

I do understand why we keep "configure" around (it is common for everybody
once it is generated), though.

> ---
> diff --git a/Makefile b/Makefile
> index d3dcfb1..c693652 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2229,7 +2229,7 @@ dist-doc:
>  ### Cleaning rules
>  
>  distclean: clean
> -	$(RM) configure
> +	$(RM) configure config.mak.autogen
>  
>  clean:
>  	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o vcs-svn/*.o \
> @@ -2240,7 +2240,7 @@ clean:
>  	$(RM) -r $(dep_dirs)
>  	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h $(ETAGS_TARGET) tags cscope*
>  	$(RM) -r autom4te.cache
> -	$(RM) config.log config.mak.autogen config.mak.append config.status config.cache
> +	$(RM) config.log config.mak.append config.status config.cache
>  	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
>  	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
>  	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
