From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git with custom diff for commits
Date: Wed, 19 Dec 2007 12:52:58 +1300
Message-ID: <46a038f90712181552i46ecb1aof55c7cdfe0f5c079@mail.gmail.com>
References: <60687a7d0712171456p14328817y5aa229f0df23c02f@mail.gmail.com>
	 <7vbq8o6gxw.fsf@gitster.siamese.dyndns.org>
	 <vpqk5ncz8fn.fsf@bauges.imag.fr>
	 <7vodco1him.fsf@gitster.siamese.dyndns.org>
	 <000001c841b5$89fcef00$762a14ac@na.acco.com>
	 <7vzlw7ybx7.fsf@gitster.siamese.dyndns.org>
	 <000101c841b7$5f1d1060$762a14ac@na.acco.com>
	 <vpqsl1zfz8r.fsf@bauges.imag.fr>
	 <000d01c841c5$386f7350$762a14ac@na.acco.com>
	 <Pine.LNX.4.64.0712182246230.23902@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Gerald Gutierrez" <ggmlfs@gmail.com>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 19 00:53:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4mFa-0000rK-38
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 00:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114AbXLRXxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 18:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754051AbXLRXxA
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 18:53:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:63901 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527AbXLRXw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 18:52:59 -0500
Received: by ug-out-1314.google.com with SMTP id z38so208427ugc.16
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 15:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qNotBc2mIwPxjBBBeHBu57Zc/KCTEmLJGdM2xlV5k1E=;
        b=QkmRs4Yjk/01VhrUHzDZ4+YvIXzl306cF7jTO9qhYSvBs9dTY7tB9UKJlMgyJ0ggIqs5sDQ15R4GOlAY6ICTMGgXBtY2cfFH5Y3W8hGthNAVdS+itGy1T8qorll6Q6FaiS7qS1iHts+tKIJkJFdRQZcRZl6Lc7DqvaL9rlKeWfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fbZtOhcD+8w6wxkGbjf/dcENqp+p/V4UyfpfDcfrwVC+Xe3ND5ODGehTte9c35/uAdjNfRTZ+4C9vsuObad0LHum9uQ9Hepsmroz3S6H3JyAJpJ4xuN3lwvGS/XjSsLJBDNRQABm9ZBn4pe93kXhaTW7wSBsu5hsFuojjlxCJwQ=
Received: by 10.66.249.8 with SMTP id w8mr1449520ugh.75.1198021978128;
        Tue, 18 Dec 2007 15:52:58 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Tue, 18 Dec 2007 15:52:58 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0712182246230.23902@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68850>

On Dec 19, 2007 11:48 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Yes.  Changes, as in "take this _file_ instead".  Not "edit this file,
> remove those lines, add these here, etc.".

Exactly. GIT is a "content tracker" that doesn't care about any
semantic meaning in your files. Here's the file, git will store it, as
is. No conversions, not fancy interpretations. Strict, safe and fast.
(There's a small exception there for DOS-style newlines, which was
much resisted.)

You can add external machinery that is aware of your content semantics
-- as you've done with calling GNU diff with ignore patterns to decide
whether to commit or not. But when you tell GIT to commit something,
there's no guessing or transformation involved.

A lot of what GIT achieves is based on that founding principle. Remove
it, and we're toast. For starters, the internal machinery is based on
SHA1 digests that change if you flip a single byte. That's what makes
git fast and realiable. It's not merely an end-user thing.

cheers,


m
