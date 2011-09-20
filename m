From: Shumkin Alexey <zapped@mail.ru>
Subject: Re: [PATCH v2] post-receive-email: explicitly set Content-Type header
Date: Tue, 20 Sep 2011 14:42:56 +0400
Message-ID: <20110920104256.GA11656@zapped.homeip.net>
References: <1316505154-3904-1-git-send-email-zapped@mail.ru>
 <1316506023-5098-1-git-send-email-zapped@mail.ru>
 <4E785DC6.80105@viscovery.net>
Reply-To: zapped@mail.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 20 12:43:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5xnX-0005P3-Fu
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 12:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331Ab1ITKn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 06:43:26 -0400
Received: from smtp12.mail.ru ([94.100.176.89]:51111 "EHLO smtp12.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755194Ab1ITKn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 06:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Reply-To:Message-ID:Subject:Cc:To:From:Date; bh=llhHcYuPWXc1dlp5F20F+C6K4tP56+wHIhM7wUYFYqE=;
	b=D/y/9uNV5lMWeIKYKp9/2C8xCJ67Kd06bAWlCXlev7U8hDGhu6ovhE0AJW1EVItRvFXsd/UTCR95bUbQqfHjYLTk3E9UzbxUJBkbLjCzsIIXTCZfMgNW1VeCtFUjKGx2;
Received: from [91.77.19.104] (port=38933 helo=zappedws)
	by smtp12.mail.ru with asmtp 
	id 1R5xnQ-00076t-00; Tue, 20 Sep 2011 14:43:24 +0400
Received: from Alex by zappedws with local (Exim 4.76)
	(envelope-from <zapped@mail.ru>)
	id 1R5xmy-000341-Qu; Tue, 20 Sep 2011 14:42:56 +0400
Content-Disposition: inline
In-Reply-To: <4E785DC6.80105@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam: Not detected
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181752>

[ resent to mailing list ]
On Tue, Sep 20, 2011 at 11:32:54AM +0200, Johannes Sixt wrote:
> Am 9/20/2011 10:07, schrieb Alexey Shumkin:
> > Some email clients (e.g. claws-mail) incorrectly display
> > message body when there is no Content-Type header and charset
> > explicitly defined.
> > So, set explicitly Content-Type header and charset
> > can be defined with hooks.emailcharset config variable.
> 
> Please write full sentences with complete punctuation and capitalization.
> Perhaps you meant to say:
> 
>   Some email clients (e.g. claws-mail) display the message body
>   incorrectly when the charset is not defined explicitly in a
>   Content-Type header. Insert a Content-Type header in the message.
> 
>   The charset can be defined with the config variable
>   hooks.emailcharset.
Thanks for the correction. English is not my native language
(although it is not for you, too, I guess :) ).
I read it and take on ear fine but I have no enough practice to write on it.

> > +# hooks.emailcharset
> > +#   The charset used in Content-Type header. UTF-8, if not
> > specified.
> 
> How can you be sure that the output produced by git log etc. that are
> used in the script are in the encoding specified by this variable?
> IOW, wouldn't log.outputencoding be the better choice to use in the
> Content-Type header?
Yes, you're right, we cannot be sure in UTF-8 encoding of output
and using i18n.logoutputencoding would be a better choice
instead of new config variable.

But at the present
1. post-send-mail uses description file of a repo
2. gitweb also uses this file and AFAIK it assumes one to be in UTF-8
  (I do not know whether it can be changed there but I tested gitweb once long
    time ago)
3. So if i18n.logoutputencoding is not UTF-8 we get a message composed
	with mixed encodings. This fact oblidge us to encode headers
	(as quoted printable at least) and synchronize body message that contain
	repo description (in UTF-8) and diffstat (in i18n.logoutputencoding).
	This is a more complicated task for a shell script
	than just specifying Content-Type header (may be git-send-email suits here?)

So that was a quick solution for me :)
