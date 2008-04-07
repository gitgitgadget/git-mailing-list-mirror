From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/4] log and rev-list: Fixed newline termination issues with --graph
Date: Mon, 07 Apr 2008 06:19:25 -0700 (PDT)
Message-ID: <m3hcedu7kd.fsf@localhost.localdomain>
References: <1207518444-5955-1-git-send-email-adam@adamsimpkins.net>
	<1207555281-9362-1-git-send-email-adam@adamsimpkins.net>
	<1207555281-9362-2-git-send-email-adam@adamsimpkins.net>
	<7vod8mqdlw.fsf@gitster.siamese.dyndns.org>
	<7vwsnaoxlz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Simpkins <adam@adamsimpkins.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:20:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JirGi-0004tx-0s
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 15:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757512AbYDGNTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 09:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757507AbYDGNTb
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 09:19:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:24062 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755950AbYDGNTa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 09:19:30 -0400
Received: by ug-out-1314.google.com with SMTP id z38so478655ugc.16
        for <git@vger.kernel.org>; Mon, 07 Apr 2008 06:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=kIfQrdDGKFhZzNKbtQ6b8uAk31gjtnPn9+MXA+YXrWA=;
        b=j3vhcQj9YBKZHSLee1oO/ggMe4jvBSKzy5zn/2zFyF1jjy8hQ9YyxFEcYJPxo5AmDHO2VR597/xcOHgBZAM+nP8mUF7cwtsGiYZpwLnk0TQwKOngDgYmjGfNM1Wm7Z9ZGs0ev+J1cqHPuy95Ft6YqBk7s3TZjHoI/jjfShhmT/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=Kx4WnFa6NfMyJVpzFxfPc+nnYLRbS2HpXvjikRzOHlJZTAShxReIrMhVqb59O5UHJGQ4/qcfLQ4oOaizHrhH91q5N7Deuc1EYQU5loTQ1odzKDczqKmqJPestg0o6qUhHwnGIZUCM2WuxT4Q5GB3jM8ywhrI5sSDRlAQprP0Jok=
Received: by 10.66.233.10 with SMTP id f10mr2174070ugh.25.1207574367342;
        Mon, 07 Apr 2008 06:19:27 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.237.250])
        by mx.google.com with ESMTPS id x37sm2218071ugc.76.2008.04.07.06.19.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Apr 2008 06:19:25 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m37DJ91q006243;
	Mon, 7 Apr 2008 15:19:10 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m37DIgU7006238;
	Mon, 7 Apr 2008 15:18:42 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vwsnaoxlz.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78974>

Junio C Hamano <gitster@pobox.com> writes:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I suspect that --pretty=format: (i.e. userformat) should have a way to
> > explicitly tell which is wanted.  Perhaps we can keep the separator
> > semantics not to break existing users, and introduce a dummy expand item
> > (say, '%_') and when it appears in the pattern it would ask for the
> > terminator semantics instead?
> >
> > In any case, I'm happy to see that somebody started looking into this, as
> > this "separator vs terminator" issue in userformat has been nagging me for
> > quite a while.  It might be good idea to have the change independently
> > from the graph extension first and then build the graph stuff on top of
> > the solidified base.  I dunno...
> 
> Some alternatives to specify terminator semantics I considered are:
> 
>  (1) Presence of %_ in "--pretty=format:..." triggers terminator
>      semantics and %_ itself interpolates an empty string; otherwise
>      separator semantics is used.

Or %_ might interpolate to _single_ separator, swallowing all
separators that follows it (something like collapsing whitespace).
Either that, or %_ interpolate to separator value, and %*_ collapses
separators (terminators).
 
Bit less hacky, bit more geeky.

>  (2) Presence of %n in "--pretty=format:..." means a multi-line output and
>      uses separator as before; lack of %n means it is a one-line format
>      and uses terminator.

I guess that literal newline in format would also mean multi-line
output.  Also '%b' (body) should mean multi-line output.


BTW. rpm uses [% ... ] to iterate over a set of (parallel) arrays
in --queryformat, which is a bit similar to --pretty=format:<fmt>,
e.g. 'rpm -q --queryformat "[%-50{FILENAMES} %10{FILESIZES}\n]'

BTW2. git-for-each-ref uses _different_ kind of format, %(<name>) and
not %<char>.

>  (3) A new option --pretty=tformat:... (i.e. tformat instead of format)
>      means LF (or NUL) is used as terminator instead of separator;
> 
>  (4) A new syntax --pretty=format/... (i.e. slash instead of the usual
>      colon) means LF (or NUL) is used as terminator instead of separator;
> 
> The first one is what I suggested in the message, but it feels somewhat
> hacky.  I suspect that the second one would catch 99% of the cases, but it
> is DWIM and it is known that DWIM can go wrong.  I favor design along
> the lines of (3) or (4), which I think would be much cleaner.
> 
> I however do not particularly like either "tformat" which is a non-word,
> nor ":" vs "/" whose differences do not intuitively translate to
> "separator vs terminator" distinction.

"|" instead of ":" wouldn't be a good idea?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
