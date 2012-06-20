From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 07/11] Makefile: split prefix flags from GIT-CFLAGS
Date: Wed, 20 Jun 2012 16:28:33 -0500
Message-ID: <20120620212833.GF6142@burratino>
References: <20120620182855.GA26948@sigill.intra.peff.net>
 <20120620183155.GG30995@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 23:28:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShSSC-0000hC-Eh
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 23:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758130Ab2FTV2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 17:28:39 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:49666 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754681Ab2FTV2i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 17:28:38 -0400
Received: by gglu4 with SMTP id u4so6105625ggl.19
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 14:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WLtzQ6ZQzuxbONKQOAbORO0ZSFnxi0trGVjDLyed3k8=;
        b=YUnRb5neqaOROpcP/nOnm4P0GDSHQ7F0N6c0Tg7MLtN0sWUH2mDLOTbxWK9etSwhTh
         0II+PEua9sq2kBx96iWT4vgjlmYoQPHae0Crd7Z35p5ZIzVAZxqi24MwTIVMH2puC7xM
         yOglOWPGUH9o4J6g87gDjJYlqT0fAVrZ5Ica9OAjEHYNndRIwS3hoEfqKlgfQz3uaKkL
         2nsOozv39LaLTK8JjVM7xIyn0LkSo0nWCg3+lxtF4SgCN9YZymLfA0LKdfJ/MEomzOer
         eeBPte9g8w3tR6ggGMerV93w9cNDZxUWsmcnGzkuAslNGJQeb5A8KQIi3kCnaTSHoz54
         CV8g==
Received: by 10.236.176.129 with SMTP id b1mr2169813yhm.126.1340227717923;
        Wed, 20 Jun 2012 14:28:37 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id j39sm42251214ani.3.2012.06.20.14.28.36
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Jun 2012 14:28:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120620183155.GG30995@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200366>

Jeff King wrote:

> Most of the build targets do not care about the setting of
> $prefix (or its derivative variables), but will be rebuilt
> if the prefix changes. For most setups this doesn't matter
> (they set prefix once and never change it), but for a setup
> which puts each branch or version in its own prefix, this
> unnecessarily causes a full rebuild whenever the branc is
> changed.

Micronit: s/branc/branch/.

[...]
> @@ -2385,14 +2391,22 @@ cscope:
>  	$(FIND_SOURCE_FILES) | xargs cscope -b
>  
>  ### Detect prefix changes
> -TRACK_CFLAGS = $(CC):$(subst ','\'',$(ALL_CFLAGS)):\
> -             $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ):\
> -             $(localedir_SQ):$(USE_GETTEXT_SCHEME)
> +TRACK_PREFIX = $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ):\
> +		$(localedir_SQ)
> +
> +GIT-PREFIX: FORCE
> +	@FLAGS='$(TRACK_PREFIX)'; \
> +	if test x"$$FLAGS" != x"`cat GIT-PREFIX 2>/dev/null`" ; then \
> +		echo 1>&2 "    * new prefix flags"; \
> +		echo "$$FLAGS" >GIT-PREFIX; \
> +	fi

Hmm, nothing to do with this particular patch but the above list
includes gitexecdir and not htmldir.  Is there any particular logic
behind the list of variables?

Nit: I think it would be easier to understand a name like GIT-PATHS
(making the absence of htmldir a bug, if not a particularly important
one).  No other complaints. :)

Thanks.
Jonathan
