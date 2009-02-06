From: Nigel Magnay <nigel.magnay@gmail.com>
Subject: Re: [JGIT] maven build fails on OS X
Date: Fri, 6 Feb 2009 20:08:18 +0000
Message-ID: <320075ff0902061208l6671c2a0m3d4b07b97025b53a@mail.gmail.com>
References: <320075ff0902060708m5ec566b9g755829c25c7727d8@mail.gmail.com>
	 <20090206153155.GL26880@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 06 21:09:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVX1L-000833-EO
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 21:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbZBFUIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 15:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753643AbZBFUIW
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 15:08:22 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:38968 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399AbZBFUIV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 15:08:21 -0500
Received: by ewy14 with SMTP id 14so1568266ewy.13
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 12:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sB8t/dXqZEshYvs5375ntV4NcXmcWvpU7rWpLW/4kcA=;
        b=LpYjtEXioozwVy8Z2+FiXdePmvsBZ+PB+0FD8JDPGFLCdisUwOuEEUAHPKH712hGwY
         G9jtYtk4J7kt+2FrNhBA69c3Fwn9n2q88qYnK2cQ+TYHp3cCSsHLA+ot2NCOPjb9rcF6
         Hix/zbFpwQlXotJeM7XrIGV6YNBPIV9FMJLDM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jY31e1vz8E7f7hhb+VemQ04z/EYTwHb70cckJTlJFOgOgmrreyDS8uVu0IRDTWH7+N
         oaOAC9egd0mTUAvB0D+tbXThw3PiQEL4kFmUO5RTE0uA9v3GJJMqE5OVFYwc9e8kOgHt
         FxDGdtDdOErD8wNyWUkepc3fQYaScnAvqFIek=
Received: by 10.103.92.8 with SMTP id u8mr919912mul.34.1233950898434; Fri, 06 
	Feb 2009 12:08:18 -0800 (PST)
In-Reply-To: <20090206153155.GL26880@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108780>

> I've looked at it and gave up.  I don't know what Maven is doing here
> on the Mac.  Maybe fresh eyes will have a better chance at fixing it.
>
> My experience with Maven is it works about 5% of the time, and the
> other 95% of the time you have to work around it by skipping tests,
> or by writing massive blocks of XML in your pom.xml file, or by
> redesigning your entire project directory structure and revision
> control system to use SVN instead of Git.

Ok. It's not (just) a Maven problem as I can get the same tests to
fail in Eclipse by setting the Console Encoding to MacRoman (which is
the default Charset.defaultCharset() when running a java app on OS X).

Doing some digging, just on testGetText_DiffCc :- where it fails, I
look at the output of each doing getBytes() - so will be in MacRoman -
(cols are byte no, exp before the replace, after the replace and the
result of fh.getScriptText. I get :

94 32 32,32
95 43 43,43 ++
96 116 116,116 tt
97 101 101,101 ee
98 115 115,115 ss
99 116 116,116 tt
100 32 32,32
101 -127 -127,-59 !!!!!!!!!!!!!!!!!!!!!!!!!!!! ??
102 110 110,110 nn
103 103 103,103 gg
104 115 115,115 ss
105 116 116,116 tt
106 114 114,114 rr
107 -102 -102,-10 !!!!!!!!!!!!!!!!!!!!!!!!!!!! ??
108 109 109,109 mm
109 10 10,10

-10 (F6) is ^, and -59 (C5) is some wavy lines..

However, I'm slightly confused - possibly because I don't know what
/should/ be the case. In

 exp.replace("\303\205ngstr\303\266m", "\u00c5ngstr\u00f6m")

is \303\205 really meant to represent U+00C3 and U+0085 ? Shouldn't
the replace be being done on bytes rather than strings?
