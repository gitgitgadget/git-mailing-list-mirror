From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Document clone of clone ... bug??
Date: Sat, 14 Jun 2008 13:34:35 -0700 (PDT)
Message-ID: <m3skvfpxgp.fsf@localhost.localdomain>
References: <20080614.150548.71104932.hanzl@noel.feld.cvut.cz>
	<20080614143117.GA8640@sigill.intra.peff.net>
	<20080614.221511.74741328.hanzl@noel.feld.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, git@vger.kernel.org
To: Vaclav Hanzl <hanzl@noel.feld.cvut.cz>
X-From: git-owner@vger.kernel.org Sat Jun 14 22:35:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7cTF-0003y5-Jz
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 22:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466AbYFNUej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 16:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754506AbYFNUej
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 16:34:39 -0400
Received: from hu-out-0506.google.com ([72.14.214.235]:57753 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446AbYFNUei (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 16:34:38 -0400
Received: by hu-out-0506.google.com with SMTP id 28so5791839hub.21
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 13:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=zD8ccme8Me9PeUZ9ojCdfk6X3+etyNSuO09ur2HRD5M=;
        b=WIIv1SxpWpBIuPyMH/VsT6oZhpku6BT/oYK5ITzZ9uJkS9UT2Azmm2FfREk3N+EZdx
         Ke3lb6MVnWqBUQ01nT/+a1eBYj/rqJIGQMNPACWR6rEMzwFtwslS9u8bgbzRX8OJVe+G
         9SoLmuNzN+xfiga10rt0ZHq3vvAF7h+3ZTLvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=A50JajBSK46UKxCuy0xdgX8Hnmhad/3CHBg8PsOheCGlg7wEAteXD1rAsyMCFIR8A+
         Fp15sOSenUdTiC3/pZ3/QcCMB6DWqxMNOhz2ZJhEM0O7b/Igy0hhH/PhaeURewXF+Ph0
         qHeTfFSKIr4VBzmBKYR9nEbXVSINep6tCbKO0=
Received: by 10.210.82.7 with SMTP id f7mr4256750ebb.185.1213475676594;
        Sat, 14 Jun 2008 13:34:36 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.239.84])
        by mx.google.com with ESMTPS id m5sm7877117gve.3.2008.06.14.13.34.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 13:34:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5EKYYm0027920;
	Sat, 14 Jun 2008 22:34:34 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5EKYUf5027917;
	Sat, 14 Jun 2008 22:34:30 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080614.221511.74741328.hanzl@noel.feld.cvut.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85041>

Vaclav Hanzl <hanzl@noel.feld.cvut.cz> writes:

> > The clone of clone does not have dangling objects; either it sees a ref
> > (because it is a branch in the clone) and it grabs the objects, or it
> > does not see it, in which case it does not download those objects.
> 
> Yes, there should not be a dangling object, but I actually got one. I
> was surprised, but I thought it is just an undocumented benign behavior
> (optimization overkill - clone rather gets those objects instead of
> thinking what it needs).
[...]
>  (cd B; git clone ../A/X)

_Local_ clone?  This is result of optimization; in cloning over local
filesystem case git-clone simply hardlinks object database (if
possible) instead of transferring objects.  This was only on request
in earlier versions of git.

You can use filr:// protocol to force generating of pack-file and
actual transfer of objects.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
