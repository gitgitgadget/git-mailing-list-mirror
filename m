From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] honour GIT_ASKPASS for querying username in git-svn
Date: Tue, 27 Dec 2011 17:00:57 +0100
Message-ID: <201112271700.58078.jnareb@gmail.com>
References: <4EC52508.9070907@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Tue Dec 27 17:01:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfZSz-0003qQ-Lg
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 17:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596Ab1L0QBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 11:01:04 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:45724 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467Ab1L0QBD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 11:01:03 -0500
Received: by eekc4 with SMTP id c4so11746340eek.19
        for <git@vger.kernel.org>; Tue, 27 Dec 2011 08:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=gFBWmgHfLQ84KLXDweoVGNNCDXep6U2fAG1Bw6esOtQ=;
        b=aiPQ75W8NMkYu4FjSvg2/1mYYpTBF3DY53WHNE2bBRHHfeHIhC8QX/gz6Iw/0Y5cUj
         WPrPeS0rnxjYrNEVdFW67hG9QbzxZEzoLrHqVQH0V00eNY0iwv2FOnBDLHm2/59Xy8RS
         eRft0IzQrosJVezGdakNEBrgiy6fcaD1VONes=
Received: by 10.213.17.203 with SMTP id t11mr9083175eba.93.1325001661185;
        Tue, 27 Dec 2011 08:01:01 -0800 (PST)
Received: from [192.168.1.13] (abwg97.neoplus.adsl.tpnet.pl. [83.8.230.97])
        by mx.google.com with ESMTPS id a60sm108142238eeb.4.2011.12.27.08.00.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Dec 2011 08:01:00 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4EF9D8B9.9060106@tu-clausthal.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187715>

On Tue, 27 Dec 2011, Sven Strickroth wrote:
> Am 27.12.2011 15:33 schrieb Jakub Narebski:

>>> +sub prompt {
>>> +	my ($self, $prompt) = _maybe_self(@_);
>>> +	if (exists $ENV{'GIT_ASKPASS'}) {
>>> +		return _prompt($ENV{'GIT_ASKPASS'}, $prompt);
>>> +	} elsif (exists $ENV{'SSH_ASKPASS'}) {
>>> +		return _prompt($ENV{'SSH_ASKPASS'}, $prompt);
>>> +	} else {
>>> +		return undef;
>>> +	}
>>> +}
>> 
>> ...and provide some kind of fallback even if neither of GIT_ASKPASS
>> nor SSH_ASKPASS are set (perhaps assuming that some Perl packages from
>> CPAN are installed).
> 
> If neither of GIT_ASKPASS nor SSH_ASKPASS are set the caller has to
> handle the request. This has to be done this way, because of lots of
> different needs (username, password (no echo) and so on).

I think that Git.pm and therefore git commands written in Perl should
behave the same as git command written in C; and I think builtins do
use common gitprompt fallback.
 
>>> +sub _prompt {
>>> +	my ($self, $askpass, $prompt) = _maybe_self(@_);
>>> +	my $ret;
>>> +	open(PH, "-|", $askpass, $prompt);
>>> +	$ret = <PH>;
>>> +	$ret =~ s/[\012\015]//g; # strip \n\r
>>> +	close(PH);
>>> +	return $ret;
>>> +}
>> 
>> Please, use modern Perl, in particula use lexical filehandles instead
>> of typeglobs (which are global variables), i.e.
> 
> I used the same style as I found in Git.pm (see lines I removed in patch 2).

Yes, that should be fixed (together with host of other issues), but
one should use modern and _better_ way (no possibility of action at
distance).

-- 
Jakub Narebski
Poland
