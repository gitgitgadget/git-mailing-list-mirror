From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/8] Add stream helper library
Date: Thu, 15 Jul 2010 14:19:57 -0500
Message-ID: <20100715191957.GC2774@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <1279210984-31604-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 21:20:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZTzM-00081S-6M
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 21:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934353Ab0GOTUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 15:20:51 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53424 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934103Ab0GOTUu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 15:20:50 -0400
Received: by eya25 with SMTP id 25so268167eya.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 12:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kK/EGN9pre4PMlUVTiClzSjE/h32Cp/4oyBZ0Asj29U=;
        b=b0pkc1xnOMO17LM7/rE56IMFMGr9IrujoFEuG8DR12jzsP8jf9or5E3DJRXhv06xdf
         cShzwtkJh3+yCRMif7/a9Z4S6NKnfZISOrNFY1ZaPPPmAHiIo1bN5BhMWeexqbhYl1C2
         vJzZQhGeKJenrWKgiDq9kCACUWrYdPCJK+tYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=w4j03ivRnOsUJhaT9qnvmLKlRUQHl+Bj18pnkfsHredaXOIlBbI4XChoW6VrEUxOm2
         YwVf1lDUMwmvxOji7fdE+LXiGpqhyRQ8EbUDFuCj+s9hdJ2u5YH5I0lFaSwCC9gYLi41
         wIB533JeQYMfN47YJrefbAdGeCvGdL6cGfVwE=
Received: by 10.213.112.212 with SMTP id x20mr3218974ebp.53.1279221648851;
        Thu, 15 Jul 2010 12:20:48 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id a48sm10637624eei.12.2010.07.15.12.20.46
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 12:20:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1279210984-31604-7-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151114>

Ramkumar Ramachandra wrote:

> From: David Barr <david.barr@cordelta.com>
> 
> This library provides thread-unsafe fgets()- and fread()-like
> functions where the caller does not have to supply a buffer.  It
> maintains a couple of static buffers and provides an API to use
> them.
> 
> NEEDSWORK: what should buffer_copy_bytes do on error?

For consistency with the rest of vcs-svn, it should do nothing. :)

I would love to see svn-fe diagnosing and recovering somehow from
faulty input.  For now it follows the easier route of just ignoring
(and skipping) confusing input.

Probably this should be mentioned in the man page somewhere.

[...]
> +void buffer_copy_bytes(uint32_t len)
> +{
[...]
> +		if (ferror(infile) || ferror(stdout))
> +			/* NEEDSWORK: handle error. */

The next input/output operation will fail, causing svn-fe to quit
early, so it would not be easy for such an error to go unnoticed.
