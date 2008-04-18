From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: branch description
Date: Fri, 18 Apr 2008 23:58:30 +0200
Message-ID: <200804182358.31041.jnareb@gmail.com>
References: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com> <1c5969370804152046h8d67630m697ca71b523b04d9@mail.gmail.com> <200804161029.18601.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Matt Graham <mdg149@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Russ Dill <russ.dill@gmail.com>,
	Stephen Sinclair <radarsat1@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Apr 19 09:01:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmycH-00048z-QD
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 23:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbYDRV6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2008 17:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbYDRV6h
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 17:58:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:57409 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbYDRV6g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2008 17:58:36 -0400
Received: by ug-out-1314.google.com with SMTP id z38so169201ugc.16
        for <git@vger.kernel.org>; Fri, 18 Apr 2008 14:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=QACygObzN5reo4GiNebGlbO7lVqQHvECxAAs2DUasPI=;
        b=TB6LMXyuOWJeBB1OtLmUenZ8e+yDKo0Q49sGLj+LaSomkQIo36c4TmPng7U41C2uEhAZTT45vYpGFopArbNwSK75Y/Uc1j3vVl79UeaFNMLo6U+icFzCx9k+3XmCBYUFvc9Synl44gcyj+S/i5LISIKZBLOdNqSh5tts7xQk7A8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BNSAovTx7OnL9TMHhc4dJ8gPVKZLNjJsy9PFjdCuSYoqsbKQtN/74eu6Utfwj+iZYBX1fvdjnJHFUngdwAk/gKdXjTCBt9tXNd6y3XfWIw3RVY0wRLxj3aE9N65QCRmAMHAke6xbPtrX+M6dnjB2o2trZ4Ge41BuXGkqdJdfZkc=
Received: by 10.67.121.2 with SMTP id y2mr1284046ugm.78.1208555913304;
        Fri, 18 Apr 2008 14:58:33 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.208.125])
        by mx.google.com with ESMTPS id z40sm245493ugc.82.2008.04.18.14.58.29
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Apr 2008 14:58:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200804161029.18601.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79874>

On Wed, 16 April 2008, Johan Herland wrote:

[cut that being able to propagate description of branches is a good idea]

> However, I do agree that putting branch description inside the working tree
> is not the right solution. So far, the best proposal I've seen, is Hommey's
> suggestion of storing the description after the sha1 in the ref file itself.
> Of course, git would have to be taught (a) to handle ref files with
> descriptions, and (b) to propagate descriptions along with refs.

(c) find a place for branch descriptions in packed refs.


Let me sum up here proposals where to put branch description:
1. Put them in branch.<name>.description in repository config. Not easily
   (automatically) propagated for dumb transports.
2. Put them in-tree, which is a bad idea because branches are
   un-versioned (or versioned separately), so branches description
   should also be un-versioned.
3. Put them in GIT_DIR/info/refs_description, in some format.  It makes
   it very easy to add support for propagation for dumb transports.
   Native transport probably would need some extension.  Should not
   interfere with the rest of git code.
4. Store description after sha1 in the ref file itself.  Automatic
   propagation for dumb transport (whether we want it or not).  Native
   transport as above.  Very high probabily of interfering with the rest
   of code, especially shell part of Git.  Need to find a place for
   descriptions in pack-refs.
5. Store them as value of 'refs/heads/<branch>' file in a tree for
   a commit for a special '<description>' separate special branch; at least
   if I understand this proposal correctly.  Something like IIRC the
   'notes' / 'annotations' idea was implemented (on git mailing list;
   it never got into mainline).


I think that the best proposal is (3), not (4) as you say.
-- 
Jakub Narebski
Poland
