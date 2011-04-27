From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-completion: fix zsh support
Date: Tue, 26 Apr 2011 21:21:17 -0500
Message-ID: <20110427022117.GA16697@elie>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Mark Lodato <lodatom@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 04:21:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEuNf-0005BY-10
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 04:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756556Ab1D0CVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 22:21:25 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59928 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755479Ab1D0CVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 22:21:25 -0400
Received: by gyd10 with SMTP id 10so458538gyd.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 19:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OpDTQO0ZgOPCesS3PN3lc+JDYknW0pafB8WaO5lh9Mk=;
        b=aMCrNRhPk1ZGiVHuglIuJBRd1xn00imd+NKhprHijN5Gq3KeQN2oP2geDaw0N6Ofoz
         zkLvud+s0tNIPdg8AntgmRsOiqhcCfH3y/OjtzzHz3DmnBiVZp4/+SdJHXAL1+gUnzbJ
         G8H1O9f541H1likvqP8GhgvtShLB+yhQ3EOGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Kjl5L4+Y5QLIViIiBNekfASLOSci6RFbLWp2MhCz1BIfdhwNPj/BkgALaPyf9M35AC
         GQd9AiUTQ2PIROfDDpOlIfhEJMAUJV2NDDhfOQeKLMjH4IN3jl+lNiFAYXQ9giymGzT2
         pW6zf/gpomnjkH4K8AgU0pAZaAVJzfo9y0CqU=
Received: by 10.101.167.37 with SMTP id u37mr1015236ano.33.1303870884080;
        Tue, 26 Apr 2011 19:21:24 -0700 (PDT)
Received: from elie (adsl-68-255-96-190.dsl.chcgil.ameritech.net [68.255.96.190])
        by mx.google.com with ESMTPS id d36sm354228and.4.2011.04.26.19.21.21
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Apr 2011 19:21:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172157>

Felipe Contreras wrote:

> +++ b/contrib/completion/git-completion.bash
[...]
> @@ -739,12 +739,12 @@ __git_complete_revlist ()
>  
>  __git_complete_remote_or_refspec ()
>  {
> -	local cur words cword
> -	_get_comp_words_by_ref -n =: cur words cword
> -	local cmd="${words[1]}"
> +	local cur cwords cword
> +	_get_comp_words_by_ref -n =: cur cwords cword

Hmm, on second thought, this will break the following case, in bash:

	. /etc/bash_completion;	# defines _get_comp_words_by_ref
	. contrib/completion/git-completion.bash

Not sure how to salvage that.  Maybe we need a git-specific API
that wraps _get_comp_words_by_ref when the latter is available.

	if type _get_comp_words_by_ref >/dev/null 2>&1; then
		_git_get_comp_words_by_ref () {
			_get_comp_words_by_ref "$@"
			if test "${words+set}"
			then
				cword="${words[@]}"
			fi
		}
	else
		_git_get_comp_words_by_ref () {
			...
		}
	fi
