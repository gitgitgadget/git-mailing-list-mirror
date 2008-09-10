From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [RFC/PATCH] Use compatibility regex library for OSX/Darwin
Date: Wed, 10 Sep 2008 09:03:05 +0100
Message-ID: <e2b179460809100103t4266650bnac00097cfb86c0b1@mail.gmail.com>
References: <20080907184537.GA4148@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Arjen Laarhoven" <arjen@yaph.org>
X-From: git-owner@vger.kernel.org Wed Sep 10 10:05:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdKgU-0007N6-Ku
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 10:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbYIJIDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 04:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbYIJIDJ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 04:03:09 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:55230 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbYIJIDG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 04:03:06 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2283530rvb.1
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 01:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=j554br8vk51lkCKfTW8SoXk78vfkIlmvQx3QD1hRudw=;
        b=tS0WuTM/sSBw6eZHwsa60mmoMOzk6I77mUEcvrwTYsOqlA6vfR8Woz7ZGfYWZeCcF+
         V1IVwjLyxUhPwmUcd8K6HLhQLHX945Ce2rj76ij4+NoS8jbe9/WlmLYYmLqNqsMNXjc+
         WqjFtMnDVQnUrrjPaFAURz5Iq8y0nlx/t8bXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ePPk1d1eeqdTUaM0Z9yvEtsyckM7cB2DK2yUrGUIJBiP4ILJcu+EIAgP/+lXAEo1lz
         dIa61do3xjQ4c6pADwkq/5iiXrEJFAqziv90NHMqdU2hps1k2BCdgB+5PraS0LVItreV
         P7lmX/xwYmC6FDN5z3nyJNXkgfSNv/234/pAY=
Received: by 10.141.164.13 with SMTP id r13mr556125rvo.150.1221033785343;
        Wed, 10 Sep 2008 01:03:05 -0700 (PDT)
Received: by 10.140.143.2 with HTTP; Wed, 10 Sep 2008 01:03:05 -0700 (PDT)
In-Reply-To: <20080907184537.GA4148@regex.yaph.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95494>

2008/9/7 Arjen Laarhoven <arjen@yaph.org>
> The standard libc regex library on OSX does not support alternation
> in POSIX Basic Regular Expression mode.  This breaks the diff.funcname
> functionality on OSX.
>
> Also, I'm sure the problem occurs on more non-Linux systems (or non
> GNU libc systems).  If people who have access to those systems (BSD's,
> HP-UX, AIX, etc) can test it, I'd be happy to add those systems to the
> patch so it can fix for multiple systems at once.

I can confirm that the issue shown up by your new testcase is also
present in AIX 5.3.

Doing the mv's and adding regex.o to COMPAT_OBJS works fine and
compat/lib.a is suitably amended

ar -t compat/lib.a
regex.o
...

but I'm afraid I don't know how to get the combination of gcc + AIX ld
to link to this in preference to the system defined regex functions.
At least I guess this is what's happening.

Adding -lcompat/regex to COMPAT_CFLAGS as per your Darwin hunk
provokes lots of warnings:

gcc: -lcompat/regex: linker input file unused because linking not done
... (" for each .c file)
    LINK git-fast-import
collect2: library libcompat/regex not found

That said, I'm not specifically arguing in favour of the patch (I
wouldn't know a regex alternation if it bit me), someone writing
regexs on HP-UX might expect them to work like the rest of their OS...

If the shipped java funcname pattern requires alternation then the
testcase should stand though.

Mike
