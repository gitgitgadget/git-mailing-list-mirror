From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH] honour GIT_ASKPASS for querying username in git-svn
Date: Tue, 27 Dec 2011 15:39:53 +0100
Message-ID: <4EF9D8B9.9060106@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 27 15:40:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfYC6-0000k4-SL
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 15:39:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532Ab1L0Ojz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 09:39:55 -0500
Received: from poseidon.rz.tu-clausthal.de ([139.174.2.21]:16603 "EHLO
	poseidon.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754446Ab1L0Ojx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Dec 2011 09:39:53 -0500
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 8FDE029A8A8;
	Tue, 27 Dec 2011 15:39:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=uhq4qy6YTU6Crgm7Tt6iuXCgcL0=; b=fCxlnI8HE5DOhslaqTxO3cxP/oWa
	vqOizloTQmnajhYsW5qDaZa5eoFH3YW5gqpYGXdZZ6/SE5dfdTLEP0hW2fcj0mHw
	RCEmLVLhiBkzkXGhyDtt5VyGGYqahhF6MN/2ohSSDHWRk8fgzQdooasRBfXunRK7
	/9EwFtN8nfnlKP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=VEmSQadpD0TcUqp/IOdN5hBNxijuQVc9mwMWhwhuFGFFD5qNNuA0/D/
	qkLRNLzxpaorOuqTkjIGGYcxH/Vs86FNn1HyfuLFqW25JL6lthoE4RkyvGBQ/b6h
	JURoPdBzA2QTvUFHR+djBG/zt0i75Ho9mwjdJB0enXTYxo2iUMD8=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id 6E47929A8A6;
	Tue, 27 Dec 2011 15:39:52 +0100 (CET)
Received: from [84.132.185.69] (account sstri@tu-clausthal.de HELO [192.168.178.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25241807; Tue, 27 Dec 2011 15:39:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <m3d3baf5kd.fsf@localhost.localdomain>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187713>

Am 27.12.2011 15:33 schrieb Jakub Narebski:
>> +sub prompt {
>> +	my ($self, $prompt) = _maybe_self(@_);
>> +	if (exists $ENV{'GIT_ASKPASS'}) {
>> +		return _prompt($ENV{'GIT_ASKPASS'}, $prompt);
>> +	} elsif (exists $ENV{'SSH_ASKPASS'}) {
>> +		return _prompt($ENV{'SSH_ASKPASS'}, $prompt);
>> +	} else {
>> +		return undef;
>> +	}
>> +}
> 
> ...and provide some kind of fallback even if neither of GIT_ASKPASS
> nor SSH_ASKPASS are set (perhaps assuming that some Perl packages from
> CPAN are installed).

If neither of GIT_ASKPASS nor SSH_ASKPASS are set the caller has to
handle the request. This has to be done this way, because of lots of
different needs (username, password (no echo) and so on).

>> +sub _prompt {
>> +	my ($self, $askpass, $prompt) = _maybe_self(@_);
>> +	my $ret;
>> +	open(PH, "-|", $askpass, $prompt);
>> +	$ret = <PH>;
>> +	$ret =~ s/[\012\015]//g; # strip \n\r
>> +	close(PH);
>> +	return $ret;
>> +}
> 
> Please, use modern Perl, in particula use lexical filehandles instead
> of typeglobs (which are global variables), i.e.

I used the same style as I found in Git.pm (see lines I removed in patch 2).

-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
