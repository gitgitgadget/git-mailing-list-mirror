From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] gitweb: esc_html (short) error message in die_error
Date: Wed, 17 Feb 2010 17:21:16 +0100
Message-ID: <201002171721.17339.jnareb@gmail.com>
References: <20100207204539.11146.36972.stgit@localhost.localdomain> <20100207204803.11146.57731.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 17:21:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhmeZ-0000f8-52
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 17:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052Ab0BQQV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 11:21:26 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:57841 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194Ab0BQQVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 11:21:25 -0500
Received: by bwz19 with SMTP id 19so5692208bwz.28
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 08:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=FGo13GPhwTLeS3Nv9Mz1y5xNprSGiHqGdsMxBwt0BrI=;
        b=GQ4bMufPEa6XWcAKoiCDYqM2n3XfwTZ4mEK1Xr2forF1lBMDv9kpha379/H4Y/drGd
         qLYo/lE3CvxC+pLIP0uI4XeF60vKBZPIh2ESULnkSGLXqXGmkbLyUpamyRRqwrPU0Cvb
         j6+EE1szEYiIO9VsJN2YucfdesNFaQTQa2lZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=HYS+5L0D6Pp0jVhBqQhXKt3eiTLPm4h/cwbMHzcwWR1fzDp6eQHeyCZNClit+n/efQ
         wK6CvmpQtofhBpqrVPuCBYHdO2qyXDEEnj6a1Vw18b8KR0W4U2clZeboumFp7IzxQtbY
         EhG8C4L+zQje2LSVMcoap3AohuiNixLRgaCHg=
Received: by 10.204.5.213 with SMTP id 21mr2322510bkw.66.1266423682897;
        Wed, 17 Feb 2010 08:21:22 -0800 (PST)
Received: from ?192.168.1.13? (abuz209.neoplus.adsl.tpnet.pl [83.8.197.209])
        by mx.google.com with ESMTPS id 15sm3644622bwz.4.2010.02.17.08.21.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Feb 2010 08:21:19 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20100207204803.11146.57731.stgit@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140237>

On Sun, 7 Feb 2010, Jakub Narebski wrote:

> The error message (second argument to die_error) is meant to be short,
> one-line text description of given error.  A few callers call
> die_error with error message containing unescaped user supplied data
> ($hash, $file_name).  Instead of forcing callers to escape data,
> simply call esc_html on the parameter.
> 
> Note that optional third parameter, which contains detailed error
> description, is meant to be HTML formatted, and therefore should be
> not escaped.
> 
> While at it update esc_html synopsis/usage, and bring default error
> description to read 'Internal Server Error' (titlecased).
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> Alternate solution would be to do escaping in call sites for die_error.
> 
> But in error messages shown on 'die' via CGI::Carp qw(fatalsToBrowser)
> the error message is HTML escaped, so in fact we are following here
> this "calling convention".
> 
> Note that for any patch relied on 'Internal server error' as error
> message, it must be changed to not fail wrongly.

Ping!

On one hand it introduces different treatment for second parameter to
die_error (error message), which is now being HTML-escaped, and optional
third parameter to die_error (detailed description), which is taken as
formatted and not escaped.  On the other hand this is simple solution
not requiring changes in callsites, and allowing easy extending error
messages with relevant information.

Another related issue is how detailed should be our one-line error
messages, and what data should they include.  User provided input
($file_name, $hash, etc.) should be safe if HTML-escaped.  But what
about adding errno message: "$!"?  It can help in debugging the
problem, but theoretically it exposes information to a possible
attacker...

What do you think about it?
-- 
Jakub Narebski
Poland
