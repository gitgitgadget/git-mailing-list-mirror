From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] war on echo in scripts
Date: Fri, 9 Jul 2010 09:30:11 -0500
Message-ID: <20100709143011.GA1980@burratino>
References: <7vpqyz278o.fsf@alter.siamese.dyndns.org>
 <20100707091633.GB31048@genesis.frugalware.org>
 <AANLkTinFu08juNtz5eYyjzxuW6zbyGyn5f4S3wh0TI0E@mail.gmail.com>
 <20100707094620.GC31048@genesis.frugalware.org>
 <7v7hl6stna.fsf@alter.siamese.dyndns.org>
 <20100708103552.GF31048@genesis.frugalware.org>
 <20100708171418.GA18229@burratino>
 <m2k4p58tum.fsf@igel.home>
 <20100709024633.GA13739@dert.cs.uchicago.edu>
 <7vocehmfe9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 16:31:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXEbd-0000zN-12
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 16:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757073Ab0GIObE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jul 2010 10:31:04 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45937 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756995Ab0GIObB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 10:31:01 -0400
Received: by wyf23 with SMTP id 23so1570199wyf.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 07:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=TWEFGpKERCt5hzG/Uozjp28eCfx0oaQ8E9v7NUksSsQ=;
        b=eFRexyXSkhjS6rqZqTuTAjajfWihHbzwHO59/kVfzkLxo8o49vAVI0f5qKfFEg9JyQ
         Mfccsfdx7l1oNk3ixUiW6Gji4oawKR2pf4gfRnZOq/18ddKdGYH7EkPHsBW0HA55TuYa
         nFzLwV0b4BiTWa0k3IXyQR4fd5wgEuy7LvrSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=WArctSVoUDngZ1W/DEMiu6DlyCmCPM5eCU3gP2zFl7ZrmzftsOOZ5ftUrrYTQ3ThKn
         +2UKunYjloBGX+ybV1fICszBLwRETOA604tX0Jcwwwb4ypHIRsWa07mA549zeFdplxSA
         EzEudVpjgx12B4kkCD+s+SXQ4F0YennylkLCM=
Received: by 10.227.146.202 with SMTP id i10mr8428252wbv.42.1278685857868;
        Fri, 09 Jul 2010 07:30:57 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id i25sm6903739wbi.4.2010.07.09.07.30.55
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 07:30:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vocehmfe9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150672>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> +echo() {
>> +	printf '%s\n' "$*"
>> +}
>
> As long as we don't have "echo -n" and "echo -e", this should
> work, but...

Yes, it=E2=80=99s ugly.  And it could make for surprises in user script=
s.

"echo -n" has been disallowed in core git since v0.99.9m^2~52 (Use
printf rather than echo -n, 2005-12-06).  Some echos seem to
expect '\c' instead.

"echo -e" is not allowed either, to support the Almquist shell
and its descendents; see v1.2.0~4 (avoid echo -e, there are systems
where it does not work, 2006-02-12).

Maybe we can avoid impacting user scripts by making this opt-in?
i.e., something like

 if test -n "$GIT_FIX_ECHO"
 then
	echo() {
		printf '%s\n' "$*"
	}
 fi

I am still not sure about the portability of overriding builtins.
