From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: A tracking tree for the active work space
Date: Sun, 11 Mar 2007 16:35:50 -0400
Message-ID: <9e4733910703111335j20c0acf4wa12c2d410580898b@mail.gmail.com>
References: <9e4733910703110706m14abae25r2a965b644d8c3bbb@mail.gmail.com>
	 <7vhcsrwn8d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 21:35:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQUlo-00015U-4B
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 21:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbXCKUfx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 16:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbXCKUfx
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 16:35:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:17537 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbXCKUfw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 16:35:52 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1757946nfa
        for <git@vger.kernel.org>; Sun, 11 Mar 2007 13:35:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TAJOcOiCnZlA0KZeVEPcoF3U3U0Ux6FW9a5n3uGam9bxqSb9MmXavUopUELYo7vSCbxIEc102RhAjDu5/a3dIOmbNuaozjMWsKEykofnlnbkzUJ4hjjLdoThSFaa1kMXwCMUDmdt+r01CysvgvnjSCcULTGMlEHz4MdhvmVu0Eg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zw2OsGVWyl2bcLt5vh7bDgbW8zVeU5EtgkTMdpSC48R4bggL+fap9CUyU2wJaPTwrJ1/JK8sEssj8MOIszkkHhUE+n/RSSRH+glRLjt7rBxSIH3ns0Hozr8TiSAAMp/i2uTITCNMOq9BSkXmGViMszOgTSowK0T9i/2sfU7phOs=
Received: by 10.114.39.16 with SMTP id m16mr1006019wam.1173645350267;
        Sun, 11 Mar 2007 13:35:50 -0700 (PDT)
Received: by 10.114.194.9 with HTTP; Sun, 11 Mar 2007 13:35:50 -0700 (PDT)
In-Reply-To: <7vhcsrwn8d.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41977>

On 3/11/07, Junio C Hamano <junkio@cox.net> wrote:
> "Jon Smirl" <jonsmirl@gmail.com> writes:
>
> > Reading the other thread on tracking temporary changes made me think
> > of using inotify with git. The basic idea would be to a daemon running
> > that uses inotify to listen for changes in the working tree. As these
> > changes happen they get committed to a tracking tree.
>
> I think it is an interesting idea, but can be used with any SCM
> not just git ;-).

As for the part about 'git grep'  Shawn and I have been talking off
and on about experimenting with an inverted index for a packfile
format. The basic idea is that you tokenize the input and turn a
source file into a list of tokens. You diff with the list of tokens
like you would normally do with text. There is a universal dictionary
for tokens, a token's id is it's position in the dictionary.

Tokenized text is one of the most compact compression schemes known.
It can get even more compact by tokenizing common phrases and using
variable length token ids. Compression schemes like this are used in
web search engines. Of course you keep a check in place for input that
doesn't tokenize (binary) and fallback to gzip.

To build 'git grep' you make a bitmap index for each token in the
dictionary and put a one in it if the file has the token. Gzip these
indexes and then there are algorithms for doing and/or operations on
the zipped indexes without expanding them. grep is almost instant over
gigabytes of text if indexes like this are available.

Keeping everything up to date on a dual core system is pretty much
free since that second core is rarely doing anything while you are
editing.

-- 
Jon Smirl
jonsmirl@gmail.com
