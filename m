From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 1/3] remote: Add warnings about mixin --mirror and other
 remotes
Date: Sun, 23 Jun 2013 23:43:31 +0200
Message-ID: <1372023811.24315.15.camel@localhost>
References: <1371809051-29988-1-git-send-email-dennis@kaarsemaker.net>
	 <1371809051-29988-2-git-send-email-dennis@kaarsemaker.net>
	 <7v8v23mhjy.fsf@alter.siamese.dyndns.org>
	 <1371994516.24315.8.camel@localhost>
	 <7vvc54ed53.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 23:43:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uqs4T-0001BZ-90
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 23:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754Ab3FWVnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 17:43:37 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:48090 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437Ab3FWVng (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 17:43:36 -0400
Received: by mail-wi0-f171.google.com with SMTP id hj3so2012209wib.16
        for <git@vger.kernel.org>; Sun, 23 Jun 2013 14:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:x-mailer:mime-version:content-transfer-encoding
         :x-gm-message-state;
        bh=lpfqUBzl3pbjxKuX5JdwYGriI9ymlLDEejsSF/PcEfE=;
        b=ZS1hnBZO+L6/llzSloH2BGN/nIpmX6dNx+G16CBSQk4ATF3C193YQrTFyIwuhpJrfq
         qNdwub+0X+2pgG4SCmd8LZajTJSvI6m9W1jLuz6GtoEjfW6OHaA8/IgSA2vHujiSl2b8
         8tJlK5DT7y0Joo1/0IWnnMuo7vDPyshtSmryfgJEIY1iSRimnE9noDh0o7R9y0Z+jtPu
         jelE2PGB+qEXS9rEvpZqIYHRIRP0mIpUpRroh6eG/UsMNxNDOTiQNvD01/ZGr6ybAzMw
         MXsFDiSPmYLEFjXg66C0DG1jTU9BVPz4h1/KtIaaawHNSiyBjCHicc3uEoF7d/3bZnY/
         IoPw==
X-Received: by 10.194.157.99 with SMTP id wl3mr14842067wjb.76.1372023815434;
        Sun, 23 Jun 2013 14:43:35 -0700 (PDT)
Received: from [10.42.1.4] (82-168-11-8.ip.telfort.nl. [82.168.11.8])
        by mx.google.com with ESMTPSA id fs8sm12587948wib.0.2013.06.23.14.43.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 23 Jun 2013 14:43:33 -0700 (PDT)
In-Reply-To: <7vvc54ed53.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
X-Gm-Message-State: ALoCoQlpszbdwOn4ETBEPGtEUYjzKGhvOnvNHKNUOtTBO9V8Z6F8pARlhVoClal2xVzF8ohuLnXv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228762>

On zo, 2013-06-23 at 14:22 -0700, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > Equality for
> > wildcards is allowed and tested for, so do we really want to 'outlaw'
> > equality of non-wildcard refspecs?
> 
> I am not sure what you mean by "equality for wildcards is allowed".
> Do you mean this pair of remote definition is sane and not warned?
> 
> 	[remote "one"]
>         	fetch = refs/heads/*:refs/remotes/mixed/*
> 
> 	[remote "two"]
>         	fetch = refs/heads/*:refs/remotes/mixed/*

I personally don't consider them very sane and didn't originally support
that. But this behavior is tested for in t5505-remote.sh test 27, which
started failing until I stopped warning for equal refspecs. This support
for "alt remotes" in prune was added by c175a7ad in 2008. The commit
message for that commit give a plausible reason for using them.

> For non-wildcard ones, I think these pairs are both suspects for
> possible clashes and want to be warned.
> 
> (1) literal-vs-literal
> 
> 	[remote "one"]
>         	fetch = refs/heads/master:refs/heads/origin
> 
> 	[remote "two"]
>         	fetch = refs/heads/master:refs/heads/origin

I agree, but c175a7ad would disagree.

> (2) literal-vs-wildcard
> 
> 	[remote "one"]
>         	fetch = refs/heads/*:refs/remotes/origin/*
> 
> 	[remote "two"]
>         	fetch = refs/heads/master:refs/remotes/origin/master
> 

Agreed and was already covered in v1.
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
