From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] gitk: Allow displaying time zones from author and commit timestamps
Date: Sun, 29 May 2011 22:35:08 -0700 (PDT)
Message-ID: <m3mxi4yco5.fsf@localhost.localdomain>
References: <alpine.DEB.2.02.1101191445130.23868@dr-wily.mit.edu>
	<alpine.DEB.2.02.1101191447340.23868@dr-wily.mit.edu>
	<20110529044656.GA8881@brick.ozlabs.ibm.com>
	<alpine.DEB.2.02.1105291740410.23145@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=macintosh
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon May 30 07:35:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQv8N-0007km-NS
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 07:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325Ab1E3FfM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 01:35:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46650 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449Ab1E3FfL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 01:35:11 -0400
Received: by fxm17 with SMTP id 17so2253153fxm.19
        for <git@vger.kernel.org>; Sun, 29 May 2011 22:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=1fmFXgd7ttZogU6wYTK0EuvVHFnGK2pRyyX/5EC5cN8=;
        b=oWIxhEh0ZQs75JfFcUtq8znLyvrzARICkwghPSjjXpfGLqvX7CAnWC/oYeNjJ6oNYj
         ITVVTpw+HTYVCQiL/pKEsDZOulXet20M+xJjrIzIpXIRooYFvbnicyJaGEIPn0Jvegq4
         nFzS3xCq1VE9M6/8TmagrIP2qHE7lGi5DIIVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=H+59Qkxd9RIj5pI2YP/WQVhGueUjL59+R7oNjuoA3UcMtQC+POlyb5ZhVxB0hZVjVE
         VpoqzjKb0RLAYO7rLr1+wCTS1r8Lvsu9IIc0eO/Qwpa8N17CFqlsdqVEKdJicg1AsSKC
         3BQey4ceX2c0zZBKuHES6VyaBV2N7k2q+jlxM=
Received: by 10.223.27.18 with SMTP id g18mr5114886fac.52.1306733709520;
        Sun, 29 May 2011 22:35:09 -0700 (PDT)
Received: from localhost.localdomain (abvg56.neoplus.adsl.tpnet.pl [83.8.204.56])
        by mx.google.com with ESMTPS id b25sm593276fab.28.2011.05.29.22.35.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 May 2011 22:35:08 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p4U5YY92006386;
	Mon, 30 May 2011 07:34:45 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p4U5YIMp006379;
	Mon, 30 May 2011 07:34:18 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.2.02.1105291740410.23145@dr-wily.mit.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174722>

Anders Kaseorg <andersk@MIT.EDU> writes:
> On Sun, 29 May 2011, Paul Mackerras wrote:

> > > @@ -11018,7 +11018,18 @@ proc prefsok {} {
> > >  proc formatdate {d} {
> > >      global datetimeformat
> > >      if {$d ne {}} {
> > > -	set d [clock format [lindex $d 0] -format $datetimeformat]
> > > +	if {[string match {*%[zZ]*} $datetimeformat]} {
> > > +	    if {[catch {set d [clock format [lindex $d 0] -timezone [li=
ndex $d 1] -format $datetimeformat]}]} {
> > > +		# Tcl < 8.5 does not support -timezone.
> > > +		global env
> > > +		set zone [lindex $d 1]
> > > +		set env(TZ) "IDK[string range $zone 0 2]:[string range $zone 3=
 end]"
> >=20
> > What is this about?  Where is the IDK prefix for timezones defined =
or
> > described?
>=20
> Yeah, sorry, that deserved a bit more explanation.  This is a kludge =
to=20
> get Tcl 8.4 to format dates in the right timezone.  IDK is an arbitra=
ry=20
> made up 3-letter code (=D2I Don=D5t Know=D3), since a UTC offset can=D5=
t generally=20
> be converted into a zone name.  The format of TZ is described at:
> http://www.gnu.org/software/libc/manual/html_node/TZ-Variable.html
> http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap08.ht=
ml
>=20
> Actually, reading that again, I just realized that I need to invert t=
he=20
> sign.  Also that it can be longer than 3 letters; I=D5ll use =D2Unkno=
wn=D3=20
> instead.

Why not use UTC+N timezone (note: please check of for +HHMM it is
UTC+HH or UTC-HH) for timezone with given numeric offset from
Coordinated Universal Time?

BTW. UTC because http://www.nist.gov/pml/div688/utcnist.cfm#cut
--=20
Jakub Narebski
Poland
ShadeHawk on #git
