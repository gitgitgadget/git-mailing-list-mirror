From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 4/4] completion: be nicer with zsh
Date: Mon, 30 Jan 2012 11:53:24 -0600
Message-ID: <20120130175324.GH10618@burratino>
References: <1327944197-6379-1-git-send-email-felipec@infradead.org>
 <1327944197-6379-5-git-send-email-felipec@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Lee Marlow <lee.marlow@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipec@infradead.org>
X-From: git-owner@vger.kernel.org Mon Jan 30 18:53:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrvQ9-0003kA-Eq
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 18:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531Ab2A3Rxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 12:53:33 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44920 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234Ab2A3Rxc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 12:53:32 -0500
Received: by yenm6 with SMTP id m6so1907636yen.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 09:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=peAuODkY8i3lgH1TWxNt8jKukhb2V/EH4smQSwo8lPE=;
        b=mRq3dLJ1DqlHMsoHcByryh69um7e3Z7U8ldMgiPc5kQktpQMxNR4gjOqEtVY8QQqZS
         PRzXg6MWhF6FOsLgxZZzPp4OC2nRGBQ45gKfd808voZD8KihsC0qjfbGPjm7nGpQhXpG
         NfTrp/v+99X+UtGwcPwPlPpaFeRZ/IOAxxxBA=
Received: by 10.236.184.8 with SMTP id r8mr27872294yhm.110.1327946012000;
        Mon, 30 Jan 2012 09:53:32 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id o61sm33086525yhk.10.2012.01.30.09.53.30
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 09:53:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1327944197-6379-5-git-send-email-felipec@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189383>

Felipe Contreras wrote:

> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -657,7 +657,8 @@ __git_merge_strategies=
>  # is needed.
>  __git_compute_merge_strategies ()
>  {
> -	: ${__git_merge_strategies:=$(__git_list_merge_strategies)}
> +	test "$__git_merge_strategies" && return
> +	__git_merge_strategies=$(__git_list_merge_strategies 2> /dev/null)

Why the new redirect?  If I add debugging output to
__git_list_merge_strategies that writes to stderr, I want to see it.

Why the 'test "$foo"' form instead of [[ -n which is more common in
this completion script?  Why use "return" instead of

	[[ -n $var ]] || var=$(...)

which feels a little simpler?
