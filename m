From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] qgit: Default the log window to wider than the file list and set monospaced font
Date: Thu, 8 Feb 2007 20:29:42 +0100
Message-ID: <e5bfff550702081129x6c94eaa4p40cf09e70c4e09cd@mail.gmail.com>
References: <200702072138.36787.andyparkins@gmail.com>
	 <200702081020.44202.andyparkins@gmail.com>
	 <e5bfff550702081106u1e02f371g3a91c7462ff5e442@mail.gmail.com>
	 <200702081913.09952.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 20:29:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFExq-0006L6-Nk
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 20:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423257AbXBHT3p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 14:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423261AbXBHT3p
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 14:29:45 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:44264 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423257AbXBHT3o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 14:29:44 -0500
Received: by wr-out-0506.google.com with SMTP id i21so602783wra
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 11:29:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XvqXz5P2W5LPyPPRI+m8Vh3ra+5jU7MMGmRAumx9ls8Kd+dkshSCK+Y69EYF2ppzyfSOtX5QeDQSbt8LSPBPoHlfzxdGVTxdH8gNWboBqhdMRsIG1tUgNWGs92+X3zsvmCcnVPpDwTx4WETnpVK7rowv397ZoEuClx2/OdaH1QE=
Received: by 10.115.76.1 with SMTP id d1mr4745837wal.1170962982370;
        Thu, 08 Feb 2007 11:29:42 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Thu, 8 Feb 2007 11:29:42 -0800 (PST)
In-Reply-To: <200702081913.09952.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39076>

On 2/8/07, Andy Parkins <andyparkins@gmail.com> wrote:
> On Thursday 2007, February 08 19:06, Marco Costalba wrote:
>
> > I have applied and pushed all your patches. BTW you are referring to
> > qgit4 at Pasky http://repo.or.cz/ site, not the stable qgit in
> > kernel.org repo!
>
> My apologies - that was the first one I found when I typed qgit4
> repository.
>

No problem, stable qgit has less layout problems, probably the only
patch I will back port is the fixed font in log viewer.

qgit4 seems to have more layout weirdeness also in patch and file
tabs. I didn't fixed it until because I'm still wondering if it is
enough fixing the layout using stretch factors or bite the bullet and
implement a geometry persistent saving with QSettings (Qt4 is quite
powerful in this regard), of course saved geometry should work both
with maximized and not-maximized window, so perhaps saving
panes/splitters factors is better then save absolute value at least
for 'internal' widget, and use absolute window geometry only for qgit
main window.

>
> > P.S: Yes, I have noted this Qt::convertFromPlainText() misbehaviour,
> > but I don't know if are the spaces that are not escaped correctly by
> > the function or the QTextEdit rendering engine that eats the
> > (escaped) spaces anyway.
>
> I definitely think this is a bug in Qt; QTextBrowser will show the
> spaces in HTML mode if <pre> is used, so I don't think it's a fault in
> QTextBrowser.
>

Please add dbg(text) line in git.cpp, just below
Qt::convertFromPlainText(text) call

		text.append("\n\n    " + colorMatch(c->shortLog(), shortLogRE) +
		            '\n' + colorMatch(c->longLog(), longLogRE));
	}
	text = Qt::convertFromPlainText(text);
dbg(text);
	// highlight SHA's
	//
	// added to commit logs, we avoid to call git rev-parse for a
possible abbreviated
	// sha if there isn't a leading trailing space or an open parenthesis and,



This will print the converted text as plain string, as you can see
there is 'something' instead of spaces but I cannot guess what.

> > P.P.S: Give a try to Bitstream Vera Sans Mono as fixed width font,
> > it's muuuuuch better then Monospace IMHO ;-)
>
> No need to persuade me; that's what I already use.  Monospace isn't a
> font on most systems - it's an alias to the default monospaced font -
> and for me it's aliased to Bitstream Mono :-)
>
> It seems to be done by the following in /etc/fonts/
>
>     <alias>
>         <family>Bitstream Vera Sans Mono</family>
>         <family>DejaVu Sans Mono</family>
>         <family>Courier</family>
>         <family>Courier New</family>
>         <family>Andale Mono</family>
>         <family>Luxi Mono</family>
>         <family>Cumberland AMT</family>
>         <family>Nimbus Mono L</family>
>         <family>NSimSun</family>
>         <family>FreeMono</family>
>         <default><family>monospace</family></default>
>     </alias>
>
> In case that helps you.
>

Thanks
