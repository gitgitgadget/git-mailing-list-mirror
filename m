From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 7/7] web--browse: look at the BROWSER env var
Date: Fri, 3 Dec 2010 11:08:00 -0600
Message-ID: <20101203170800.GE12910@burratino>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291394861-11989-8-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 18:08:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POZ7Q-0002cu-7p
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 18:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338Ab0LCRIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 12:08:18 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33469 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab0LCRIR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 12:08:17 -0500
Received: by vws16 with SMTP id 16so1823790vws.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 09:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7snnaA7r6OhhY9zG7yJvcACWdhfspyxewE6r5km7ouU=;
        b=Wm0EuUPxGf28B0At+Zlv2s+0cFt4o+deVEqhaIkCTfTfqhMWlmTRmlOSlSnR0blFrI
         zKI+8V5cI4kUi6rXvW0NRiReW2WIkyuqbsx5JQJBdbRqbQA0NcrhDOEspM0EiGKM3AWi
         eAxsVSsfWjbqGQLKyr0Lyol6+Zx5vMxzth/9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FaUoVK1XMViFD8PfRXPYqNQgHRdcb6m8vsOmmFzZMKixJF1KaVQJs9ZqaueFMR9qCt
         jKvFUHWMnmrYKUs/vgxChsjvDwoYaaBCzHZQAK5r54N5FBxcLok5jEOls2A2jqD1DCCP
         a0lESY7eJteTns3XJScw/XDlswLcjYhBnsU3E=
Received: by 10.220.180.193 with SMTP id bv1mr478378vcb.12.1291396095388;
        Fri, 03 Dec 2010 09:08:15 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id w8sm330680vcr.24.2010.12.03.09.08.11
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 09:08:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291394861-11989-8-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162814>

Giuseppe Bilotta wrote:

> --- a/git-web--browse.sh
> +++ b/git-web--browse.sh
> @@ -138,6 +138,51 @@ then
[...]
> +if test -z "$browser" -a -n "$BROWSER"; then
> +	OLDIFS="$IFS"
> +	IFS=:
[...]
> +	IFS="$OLDIFS"

Micronit: on some shells (e.g., old ash[1]), IFS starts out unset if
it hasn't been inherited in the environment.  How about something like
this?

	LF="
"
	usual_ifs=" 	$LF"
	IFS=:
	...
				IFS=$usual_ifs
	...
	IFS=$usual_ifs

Based on [2] I would guess that any POSIX-style shell would also
support

	IFS=:
	...
				unset IFS
	...
	unset IFS

but maybe that's playing with fire.

The rest of this series looks quite nice, so
Acked-by: Jonathan Nieder <jrnieder@gmail.com>

[1] http://bugs.debian.org/95856
[2] http://www.in-ulm.de/~mascheck/various/ifs/
