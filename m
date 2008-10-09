From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [RFC PATCH 2/2] Replace calls to strbuf_init(&foo, 0) with static STRBUF_INIT initializer
Date: Thu, 9 Oct 2008 23:28:08 +0200
Message-ID: <81b0412b0810091428o6a4ea772q6a10cd295e4fcd7d@mail.gmail.com>
References: <UUi8gSMV6CruoYIkVNOQZ4FNzsbqZcSNu6jdYH8GqIo@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Oct 09 23:29:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko34U-0007GF-Bo
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 23:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316AbYJIV2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 17:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755281AbYJIV2K
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 17:28:10 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:22678 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755275AbYJIV2J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 17:28:09 -0400
Received: by wr-out-0506.google.com with SMTP id 69so114280wri.5
        for <git@vger.kernel.org>; Thu, 09 Oct 2008 14:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Nw337Lf5piKbBSvcXZb7pTY0F4WieG0FPUy1tfL1wNc=;
        b=p7ndXBAPGof6HKFojpfP1W3KqfsV3Y6kvgatqSxXjnaJOc9MAt/H9F4jbwnKPrdJHc
         AnoXzC9U9b1NHK2E4dv6zuLgPpIMc+g6gr6css81Drnjh0tMnygwgT3M+ykbluQUppuJ
         bf0AEeawEqKed4FDyHpALXuK+tNk9QzkmZi60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Y64I+L5ekeugR6xDljN2WwrdhzZ1TvBPz/N+JlEXmC61ZNoFIS6XOhR7YgKA1y/5W1
         I593eaAUJ7FrIf/u632tJ6GXnfojY5lO1blEAZMhcb74ytX4tdjfaApwqShCnm4B8jDM
         HrJ0cQys77JrO0E5SoXnQQ1HqNAFXMTbYEmEE=
Received: by 10.100.37.20 with SMTP id k20mr976172ank.120.1223587688459;
        Thu, 09 Oct 2008 14:28:08 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Thu, 9 Oct 2008 14:28:08 -0700 (PDT)
In-Reply-To: <UUi8gSMV6CruoYIkVNOQZ4FNzsbqZcSNu6jdYH8GqIo@cipher.nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97887>

2008/10/9 Brandon Casey <casey@nrlssc.navy.mil>:
> Many call sites use strbuf_init(&foo, 0) to initialize local strbuf variable
> "foo" which has not been accessed since its declaration. These can be
> replaced with a static initialization using the STRBUF_INIT macro which is
> just as readable, saves a function call, and takes up fewer lines.
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
>
>
> This does the same thing for strbuf_init() that the last one did for memset().
>

But it does this using a predefined interface (using the STRBUG_INIT macro),
so next time strbuf changed, the code using it may be left as is.

I didn't like the memset->zero-init, but I do like this one.
It is a bit unclear, by the way, why strbuf_init wasn't inlined.
