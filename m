From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH 1/2] git-svn, perl/Git.pm: add central method for prompting
 passwords honoring GIT_ASKPASS and SSH_ASKPASS
Date: Wed, 28 Dec 2011 17:17:12 +0100
Message-ID: <4EFB4108.5040704@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de> <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5EB3.4000802@tu-clausthal.de> <7vboqt2zm4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 17:17:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfwBr-00031a-9L
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 17:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026Ab1L1QRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Dec 2011 11:17:14 -0500
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:58129 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989Ab1L1QRN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2011 11:17:13 -0500
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id BF62942203F;
	Wed, 28 Dec 2011 17:17:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=rjz2ZkQig7IC6S/qI7kXCkMNuQI=; b=yI9vJ1JBZVO1F17Wz7gBIrjxA/91
	9JZkHZk5MbDS2fA1AE5jkXmz+fY0s3uaOaklBWC9xSp/QTOT4+Tjz7FQ+ic7R7iW
	UUTx+f5m/XoedxuvsNWjM4CAWNlEgr3hnkHgphAG3vn/FUgxtmYgRNfJ8LHj75bU
	Zezr2pPkq+i0rr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=m4c7jtYWy6qGinskEWlLi6KTc/MJnNVfFyjpnLdJcjHRhg2S1u81h7m
	pyta0VejbGqNmQFKyWtIS4HucfsqZNCEcI5YA6xz3LPaMnkYtx6NMbrfTy4L4/la
	4hjmHZZm9HxwoGgph0CoC4R/WWWlQ75d/ERabIEv4qrWM70CL6+8=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 8308642203D;
	Wed, 28 Dec 2011 17:17:11 +0100 (CET)
Received: from [84.132.183.113] (account sstri@tu-clausthal.de HELO [192.168.178.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25261897; Wed, 28 Dec 2011 17:17:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <7vboqt2zm4.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187751>

Am 28.12.2011 03:34 schrieb Junio C Hamano:
>> +	close ($fh);
> 
> It seems that we aquired a SP after "close" compared to the
> original. What's the prevailing coding style in our Perl code?
> 
> This close() of pipe to the subprocess is where a lot of error checking
> happens, no? Can this return an error?
> 
> I can see the original ignored an error condition, but do we care, or not
> care?

close() can return a number in case of an error, but we already got our
response/line, so why care?

-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
