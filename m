From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH v4] completion: ignore =?utf-8?b?Y2hwd2RfZnVuY3Rpb25z?= when cding on zsh
Date: Thu, 9 Oct 2014 19:47:08 +0000 (UTC)
Message-ID: <loom.20141009T214418-680@post.gmane.org>
References: <xmqqlhop6rmj.fsf@gitster.dls.corp.google.com> <1412881298-64117-1-git-send-email-bt@brandonturner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 21:47:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcJgL-0004bh-87
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 21:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbaJITrW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Oct 2014 15:47:22 -0400
Received: from plane.gmane.org ([80.91.229.3]:42235 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141AbaJITrV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 15:47:21 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1XcJgE-0004YM-KZ
	for git@vger.kernel.org; Thu, 09 Oct 2014 21:47:18 +0200
Received: from 80.156.189.109.customer.cdi.no ([109.189.156.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Oct 2014 21:47:18 +0200
Received: from oystwa by 80.156.189.109.customer.cdi.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Oct 2014 21:47:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.189.156.80 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:32.0) Gecko/20100101 Firefox/32.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Turner <bt <at> brandonturner.net> writes:

> +__git_ls_files_helper ()
> +{
> +	(
> +		test -n "${CDPATH+set}" && unset CDPATH
> +		cd -q "$1"
> +		if [ "$2" =3D=3D "--committable" ]; then
> +			git diff-index --name-only --relative HEAD
> +		else
> +			# NOTE: $2 is not quoted in order to support multiple options
> +			git ls-files --exclude-standard $2
> +		fi
> +	) 2>/dev/null
> +}
> +

(Sorry about this; I should've caught it the first time around). Zsh
does not split string expansions into several words by default. For
example:

    $ str1=3D'hello world'
    $ str2=3D'goodbye moon'
    $ printf '%s\n' $str1 $str2
    hello world
    goodbye moon

This can be enabled on a "per-expansion basis" by using =3D while
expanding:=20

    $ str1=3D'hello world'
    $ str2=3D'goodbye moon'
    $ printf '%s\n' $=3Dstr1 $str2
    hello
    world
    goodbye moon

So the $2 in your patch should be $=3D2.

BUT: Over a year ago Git learned the -C argument. Couldn't we use that
here? That way we would not have to unset CDPATH and can get rid of the
subshell and cd -q. If we allow the other functions to use several
arguments to pass options with we can get rid of the whole seperation
between bash and zsh altogether.

=C3=98sse
