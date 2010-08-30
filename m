From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Detection of relocations within a file
Date: Mon, 30 Aug 2010 10:44:27 -0500
Message-ID: <20100830154427.GB3292@burratino>
References: <SNT124-W57C91CBC3A362218ACA23DC4890@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Bo Yang <struggleyb.nku@gmail.com>
To: Tim Mazid <timmazid@hotmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 17:46:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq6Z6-0004rG-VY
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 17:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821Ab0H3PqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 11:46:17 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:52878 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755776Ab0H3PqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 11:46:16 -0400
Received: by wwi14 with SMTP id 14so307801wwi.1
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 08:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kKWYIRyVq85McfUB2uJWUXK20gXvr3Fni/A7ZNDVxQ4=;
        b=lh3zzYHMXaijUj1kw32tv4Sq3boWRTJRB/DHqkA6xkxujI2QUOLgRnREoO7w7b5nz0
         Bh+lfUyhATHGu3c+thu0KaIJhHikf6ka56xw32dCeZwV4xUR+25/Vu2L7jTlOCH5HFlf
         Tqf04uueH9/ZegnG6KG+8kRO4R56TEl8eniSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=g8PRU5sjDNrdKGmNj0mDbMa7yeBDR8OHyhPh8nbUc7o1xWka9TH7fzOiuyKy+s9ZwG
         Axg36CM/N1cZK/tD0jdFaV4VNTqwCojp/WSXSR59fJmpZhjBTI9O9dzhZgJUcvqSd7xs
         +M2bc3qfC04ACSp9arTa1FY04Y6bs4Nfr2ZUw=
Received: by 10.227.37.8 with SMTP id v8mr4587135wbd.37.1283183174625;
        Mon, 30 Aug 2010 08:46:14 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id i14sm6620484wbe.6.2010.08.30.08.46.12
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 08:46:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <SNT124-W57C91CBC3A362218ACA23DC4890@phx.gbl>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154823>

Hi Tim,

Tim Mazid wrote:

> I was just wondering if git can/does detect relocations of sections of code/text within a file.
> 
> For example, moving a function from the top of a file to the end.

Depends what you are trying to do.

1. I am mystified by some piece of code, and I want to know where
it originated.  Code movements is uninteresting to me (so grepping
through a patch won't do it).  The command

 $ git log -S'const char git_more_info_string[] =
	"See 'git help COMMAND' for more information on a specific command.";' \
      -- git.c

tells the originating commit pretty quickly.

2. I am mystified not by some particular piece of code but by an
entire file.  The command

 $ git gui blame -- git.c

works okay.

3. The origins of some piece of code make enough sense, but the code
changes since then are a mystery to investigate.  The command

 $ git log -L '/int main(/,/}/' git.c

with git from the "next" branch can help.

4. I want a simple, easy-to-review patch representing a code movement.
No one I know of has worked on this, and if you have ideas for it,
that would be very neat.
