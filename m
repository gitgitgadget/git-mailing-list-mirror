From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH 2/4] git-prompt.sh: refactor colored prompt code
Date: Sat, 22 Jun 2013 14:37:03 +0000 (UTC)
Message-ID: <loom.20130622T162818-125@post.gmane.org>
References: <cover.1371780085.git.erdavila@gmail.com> <354a860e12a3463ce5d031c0dc46d095841f717d.1371780085.git.erdavila@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 22 16:37:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqOwa-0002aM-5g
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 16:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755896Ab3FVOhX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Jun 2013 10:37:23 -0400
Received: from plane.gmane.org ([80.91.229.3]:55491 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754920Ab3FVOhW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 10:37:22 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UqOwJ-0002Is-MB
	for git@vger.kernel.org; Sat, 22 Jun 2013 16:37:19 +0200
Received: from 147.137.202.84.customer.cdi.no ([84.202.137.147])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 16:37:19 +0200
Received: from oystwa by 147.137.202.84.customer.cdi.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 16:37:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 84.202.137.147 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.22 (KHTML, like Gecko) Ubuntu Chromium/25.0.1364.160 Chrome/25.0.1364.160 Safari/537.22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228708>

Eduardo R. D'Avila <erdavila <at> gmail.com> writes:

> +		local c_red=3D'\[\e[31m\]'
> +		local c_green=3D'\[\e[32m\]'
> +		local c_lblue=3D'\[\e[1;34m\]'
> +		local c_clear=3D'\[\e[0m\]'
>  	fi
> -	local c_red=3D'\e[31m'
> -	local c_green=3D'\e[32m'
> -	local c_lblue=3D'\e[1;34m'
> -	local c_clear=3D'\e[0m'

I've gotten the impression it's better to use tput to generate the esca=
pe=20
sequences instead of hardcoding them. So something like:

	local c_red=3D'\['"$(tput setaf 1)"'\]'
	local c_green=3D'\['"$(tput setaf 2)"'\]'
	local c_green=3D'\['"$(tput setaf 4)"'\]'
	local c_clear=3D'\['"$(tput sgr0)"'\]'

which is technically cleaner, if not visually.
=20
The problem with that approach is that tput will be run several times f=
or=20
each prompt, so it would be best if the color variables were global. An=
other=20
thing is that you rely on tput being available.

=C3=98sse
