From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Wed, 17 Jan 2007 15:00:32 +0100
Message-ID: <200701171500.33220.jnareb@gmail.com>
References: <200701150144.56793.jnareb@gmail.com> <200701171311.36358.jnareb@gmail.com> <Pine.LNX.4.63.0701171334410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Nikolai Weibull <now@bitwi.se>, Junio C Hamano <junkio@cox.net>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 15:00:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7BKl-0000tb-9H
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 15:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbXAQOAI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 09:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbXAQOAI
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 09:00:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:19422 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932186AbXAQOAG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 09:00:06 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1992590uga
        for <git@vger.kernel.org>; Wed, 17 Jan 2007 06:00:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZMntwb9d6NB6LN/lAuiJx5rpkCirOnmcWRHATm/lkjrxQe28YAtQvgNwt72ELOjCgAQjbxDx7bRPloC/53p2NpavvaGI+cZnVfyPmmH6kuhAIbS+kHLrcjZMINe4BZVt/X8ahpEZ8vw/mYiRkfwW+XiNFAJL8obXtiYyn3gGav0=
Received: by 10.67.21.11 with SMTP id y11mr9528891ugi.1169042405125;
        Wed, 17 Jan 2007 06:00:05 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id u1sm10490337uge.2007.01.17.06.00.04;
        Wed, 17 Jan 2007 06:00:04 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0701171334410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37003>

Johannes Schindelin wrote:
> 
> On Wed, 17 Jan 2007, Jakub Narebski wrote:
> 
>> No key or value can contain "\n".
> 
> I just tried this:
> 
> 	$ cat > .git/config << EOF
> 	[section] key = "Hello\nWorld"
> 	EOF
> 	$ git-repo-config -l
> 	section.key=Hello
> 	World
> 
> So, values _can_ contain newlines.

Sorry, my mistake. I haven't noticed that your previous example
the error was "\w", not embedded newlines, and that embedded newlines
work.
 
>> With "\n" as separator you can simply rrturn NUL in the noval case.
> 
> Which would buy you what exactly? You can tell that the user did not say 
> "noval = true", but "noval". Great. But the _effect_ should be the same!
> 
> Anyway, I realize you don't like my solution, so I will just shut up.

I like your solution.

The only ambiguity is how to deal with '[section] noval' case. You
propose to treat it as if it was '[section] noval = true' for --dump,
and not as if it was '[section] noval = ' or '[section] noval = ""'.
Good. But this _has_ to be explained in documentation.

That said, I still think that having alternate parser for a format
is a good idea. Otherwise it is not a format, but "something that
parser parses".

BTW. it looks like C escape sequences are parsed, but not octal
escape sequences, nor no-op escaping other character.

-- 
Jakub Narebski
Poland
