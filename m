From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: git mergetool broken when rerere active
Date: Thu, 6 Jan 2011 21:50:00 -0500 (EST)
Message-ID: <alpine.DEB.1.10.1101062058380.3800@debian>
References: <alpine.DEB.1.10.1101052119530.26654@debian> <7vbp3tc142.fsf@alter.siamese.dyndns.org> <7v62u1bzeg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Magnus Baeck <magnus.back@sonyericsson.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 03:50:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pb2PC-0003RN-0q
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 03:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466Ab1AGCuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 21:50:09 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62710 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924Ab1AGCuH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 21:50:07 -0500
Received: by qyj19 with SMTP id 19so28544qyj.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 18:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=YdrE4FtVrIORq1CRG4MiQ228eTQYcNl/iyw/mHNoNA4=;
        b=Ub95ctfpPBJWo0n4kCQQAxXBq9e3LevIh1a7NsAuDYI+1TPwyfAFjjUMfdrEbwxWSJ
         Mo0QFU0SPQho7ShjIbcT8vvNPqHFoQGN+ueJzbwJouJQ3IY6Mbb70gm9IQQNJ1z8eguU
         4n3B07BZNiY6l6pi573Fapj1xra3XVZ4GV0wQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=RXYJiGeOEOd1MrLUbcv72r9IW0mn0dzpK/RXUczGv5XSnh8E3KV7yfeAuDLbyCPPng
         HA3zGIVo0ZN6frv6vHitqia9qxgy3gJ2xGMQW7WObLMoCmV8gKClZ9gnQc4x/NzYQ/If
         X0YxLUnTSStpAXxtFCVGTgxnmdM1cl3oNebsU=
Received: by 10.229.230.10 with SMTP id jk10mr6819870qcb.245.1294368606583;
        Thu, 06 Jan 2011 18:50:06 -0800 (PST)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id g28sm14835795qck.1.2011.01.06.18.50.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Jan 2011 18:50:05 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <7v62u1bzeg.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164696>

On Thu, 6 Jan 2011, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Probably we would need a "git rerere remaining" sobcommand that is similar
> > to status but also includes the "punted" paths.
> 
> ... which may look like this.
> 
> Replace use of "git rerere status" in bb0a484 (mergetool: Skip
> autoresolved paths, 2010-08-17) with "git rerere remainder" and see what
> happens.

I think it almost works. The only thing I can see that is not handled
is the case where a file that had conflicts that have now been
resolved and the file has been added to the index. These files still
show up in 'git rerere remaining' and thus in 'git mergetool'. It is
of course possible in mergetool to calculate the set difference
between `git rerere remaining` and the set of added files, but would
that be the right thing to do? Should 'git rerere remaining' rather be
changed?

Would it be easier to add a 'git rerere resolved' that lists the files
for which all conflicts have been resolved by rerere?x We could then
make mergetool use the usual list of files from 'git ls-files -u' and
subtract these files.
