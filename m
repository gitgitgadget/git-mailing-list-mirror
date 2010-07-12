From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] revert: don't print "Finished one cherry-pick." if
 commit failed
Date: Mon, 12 Jul 2010 11:39:35 -0500
Message-ID: <20100712163934.GA1869@burratino>
References: <20100712115455.12251.47449.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jul 12 18:40:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYM3T-0003LI-6H
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 18:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361Ab0GLQkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 12:40:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41341 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab0GLQkW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 12:40:22 -0400
Received: by iwn7 with SMTP id 7so4812632iwn.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 09:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=e1EBhHErVCS0JMFK8ZFyJXMwG+QxRmbHwXOLb5gL1Ug=;
        b=cefiBr3VRH6Ivg4co6FE1nxInGb4TUFZLUprg503LGChYOasVXuU1ucUCFpLYCVTiQ
         LNGElfZAsj0gweoHN39wAgZdsU6EcFBHDgTvbER9rAXEqGCnH+gOce21B2lARadBlWyD
         PElZjfPQmQOB+whNuzRwLJ/jHi4aRhT3dpk7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gxg9dgCevfn3y3HKLtaoUQXM6Q1doFR7u4wTsFlDQCpJBXibic4oQ8IyMpnp3iflWS
         w7hOeHqYAH/hugfLwsQQ9ojkb9exr3KoNX1CEaBPntJUlPidDl3FnLrsJqskP0zE1aBL
         gc9dy961ynTfG0FjGlJezpPR3VYv/gKuNDNtk=
Received: by 10.231.169.10 with SMTP id w10mr2343635iby.106.1278952821447;
        Mon, 12 Jul 2010 09:40:21 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm20415586ibk.3.2010.07.12.09.40.19
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Jul 2010 09:40:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100712115455.12251.47449.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150825>

Christian Couder wrote:

> And, while at it, refactor commit code into a new run_git_commit()
> function.

Probably should be two patches.

> +++ b/builtin/revert.c
> @@ -492,48 +518,17 @@ static int do_pick_commit(void)
>  			mebuf.buf, help_msg());
>  		rerere(allow_rerere_auto);
>  	} else {
> -		fprintf(stderr, "Finished one %s.\n", mebuf.buf);
> +		if (!no_commit)
> +			res = run_git_commit(defmsg);
> +		if (!res)
> +			fprintf(stderr, "Finished one %s.\n", mebuf.buf);
>  	}

Ack for this part.  Thanks.
