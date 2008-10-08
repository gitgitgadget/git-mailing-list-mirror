From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2 v2] check-attr: Add --stdin-paths option
Date: Wed, 8 Oct 2008 08:24:43 -0700
Message-ID: <20081008152443.GA4795@spearce.org>
References: <bb6f213e0809220312m6cb8022csa3843cfaccc5b69b@mail.gmail.com> <1223173855-6173-1-git-send-email-dpotapov@gmail.com> <1223173855-6173-2-git-send-email-dpotapov@gmail.com> <48E9B997.1010006@viscovery.net> <20081007001652.GR21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 17:45:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Knawp-00077q-GW
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 17:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbYJHPYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 11:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbYJHPYp
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 11:24:45 -0400
Received: from george.spearce.org ([209.20.77.23]:52064 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbYJHPYo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 11:24:44 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B39603835F; Wed,  8 Oct 2008 15:24:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081007001652.GR21650@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97802>

Dmitry Potapov <dpotapov@gmail.com> wrote:
> This allows multiple paths to be specified on stdin.

> diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
> index 2b821f2..0839a57 100644
> --- a/Documentation/git-check-attr.txt
> +++ b/Documentation/git-check-attr.txt
> @@ -9,6 +9,7 @@ git-check-attr - Display gitattributes information.
>  SYNOPSIS
>  --------
>  'git check-attr' attr... [--] pathname...
> +'git check-attr' --stdin-paths attr... < <list-of-paths

I wonder if the option should just be "--stdin".  And since its being
used mostly by automated tools (gitk/git-gui) I wonder if a -z should
also be supported for input termination with NUL instead of LF.

> diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
> index 3d8e06a..f6901b4 100755
> --- a/t/t0003-attributes.sh
> +++ b/t/t0003-attributes.sh
> @@ -47,6 +47,23 @@ test_expect_success 'attribute test' '
>  
>  '
>  
> +test_expect_success 'attribute test: read paths from stdin' '

A test case for the quoting might also be good.

> +
> +	cat <<EOF > expect
> +f: test: f
> +a/f: test: f
> +a/c/f: test: f
> +a/g: test: a/g
> +a/b/g: test: a/b/g
> +b/g: test: unspecified
> +a/b/h: test: a/b/h
> +a/b/d/g: test: a/b/d/*
> +EOF
> +
> +	sed -e "s/:.*//" < expect | git check-attr --stdin-paths test > actual &&
> +	test_cmp expect actual

-- 
Shawn.
