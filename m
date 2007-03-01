From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cvsserver: Make always-binary mode a config file option
Date: Thu, 1 Mar 2007 22:13:37 +1300
Message-ID: <46a038f90703010113o256f19a2qb1c16f4c85e5bd1c@mail.gmail.com>
References: <7v4ppedj3r.fsf@assigned-by-dhcp.cox.net>
	 <200702281301.58026.andyparkins@gmail.com>
	 <46a038f90702281540o520cc214xa929a3e3c4e70883@mail.gmail.com>
	 <200703010840.54377.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 10:13:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMhM6-0003Ae-CB
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 10:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933180AbXCAJNk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 04:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933177AbXCAJNj
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 04:13:39 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:51901 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933180AbXCAJNi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 04:13:38 -0500
Received: by nf-out-0910.google.com with SMTP id o25so832328nfa
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 01:13:37 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P+zER0xJOIheLM5uprwGtm+BW5W1HQlY6x58EK7UF4EknnBCG+OeJJEWtH93Bcm4rFWBKo9sqDm6picT+CuklU193Yurb5GDcAhJjMfTFBSFX4Cty+i44GaKMD5w1bVzisXS2VdrdLsEysbDD5QpmtbcFdIdY2zmZezI+Br0vts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eBKtxyeyALB/wwQcbkenCZaM4XBUhGWoAK0g6YB6BajBRg5pwcPZCb4jkAuJQvc+pot2w2JK+jxzRHm1tpo5CiMBg+58M5QrAWmq202rtNQ+2oSPORByw0WlHhmCZxD9P2OxsK3OkLN5oK38x3S9BsMt8VIujMI/+ZA/4Um9oeM=
Received: by 10.49.94.18 with SMTP id w18mr5261503nfl.1172740417201;
        Thu, 01 Mar 2007 01:13:37 -0800 (PST)
Received: by 10.48.215.2 with HTTP; Thu, 1 Mar 2007 01:13:37 -0800 (PST)
In-Reply-To: <200703010840.54377.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41059>

On 3/1/07, Andy Parkins <andyparkins@gmail.com> wrote:
> On Wednesday 2007 February 28 23:40, Martin Langhoff wrote:
>
> > I guess what I mean is that the common case on windows is going to be
> > for users who want their binary files un-corrupted, and their text
> > files newline-converted.
>
> Given that windows editors/tools generally cope quite well with UNIX line
> endings, the common case could well be that no one cares that the new line
> conversion isn't happening (it's certainly the case for me).

Well... the guys working on the MinGW port of git have railroaded us
with the opposite position. If it's going to work in Windows, you
better accept it has to handle newline conversion correctly or it's
broken...

...

> > I agree with the idea of doing something smart with -kb flags, but
> > this is not a good move. For the common case among Windows TortoiseCVS
> > users, the switch proposed introduces the ability to switch between
> > one broken mode to another broken mode.
>
> I don't understand.  What is broken about it?

The interesting case to fix this for is a mixed binary and text repo
with windows users wanting newline conversion (if they really don't,
they can tell TortoiseCVS as much). For that scenario, current
behaviour is broken (binaries get mangled), and setting -kb on
everything breaks newline conversion.

And that scenario can only be addressed sending appropriate flags for
each file, not with a blanket switch.

>  As you say - both modes are broken, so
> supplying a switch isn't crazy because one broken mode might suit better than
> another.

Except that it's not that hard to do something better -- I was hoping
to prep a patch today, but things got frantic at the office.

> I think I'm missing something that you are worrying about and that I haven't
> noticed.  Does -kb do something that I'm not aware of?  Is there a more
> correct way of telling the client that a file is binary?

Just that I think it's easy enough to implement something that sets
-k mode on file extension, which is actually _much_ better and makes
the blanket setting pointless. And perhaps we can get binary
autodetection working well but accepting overrides.

cheers,


martin
