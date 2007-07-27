From: Tomash Brechko <tomash.brechko@gmail.com>
Subject: Re: index-pack died on pread
Date: Fri, 27 Jul 2007 13:50:13 +0400
Message-ID: <20070727095013.GA5047@moonlight.home>
References: <333e1ca10707230552i34c2a1cfq9fae94f20023e9d7@mail.gmail.com> <alpine.LFD.0.999.0707230956390.3607@woody.linux-foundation.org> <200707260115.13234.robin.rosenberg.lists@dewire.com> <alpine.LFD.0.999.0707251636490.3607@woody.linux-foundation.org> <81b0412b0707260542o58fcb73bu81ae09aa1df84c81@mail.gmail.com> <alpine.LFD.0.999.0707260911040.3442@woody.linux-foundation.org> <7vps2e5x4y.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.999.0707262231280.3442@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Michal Rokos <michal.rokos@gmail.com>,
	GIT <git@vger.kernel.org>
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 11:50:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEMT1-0007iM-CK
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 11:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbXG0JuY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 05:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbXG0JuX
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 05:50:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:25983 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964946AbXG0JuU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 05:50:20 -0400
Received: by ug-out-1314.google.com with SMTP id j3so682349ugf
        for <git@vger.kernel.org>; Fri, 27 Jul 2007 02:50:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=BnbnEns06DsQxv5ULNILKE9LDQYSvgA7DuABJG+R3sAD6pZjuqXwiirdM2QuwBCsEuxCT9m2acsU2GEhAPGCaakUf7odHWZk5seyiDK7NZJLnD92BN/pVhKZ7xQUjeF1OiQSz+/GrOlJSnrjhOTKDLwJnc7PC4WeTEw+mX3x1ko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=RI8EdZD7DwY+Mb7YCDaKdaaQys5cMwh/ZDhj0Hj2byxjtqPOjYJCfyxJz4J+efCmDZLVkdrjkIwQ71SSTSUvKDmldQmVt3ouLuI1t19cxk1Jqn2cVDmNVGenhyqb8B8ih1Z0jpBKycJWRVL7559prApY/dpMMtXWikUdoEaYCH8=
Received: by 10.86.68.16 with SMTP id q16mr1842237fga.1185529819076;
        Fri, 27 Jul 2007 02:50:19 -0700 (PDT)
Received: from moonlight.home ( [80.246.71.156])
        by mx.google.com with ESMTPS id 6sm11170109nfv.2007.07.27.02.50.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Jul 2007 02:50:18 -0700 (PDT)
Received: from moonlight.home (localhost.localdomain [127.0.0.1])
	by moonlight.home (Postfix) with ESMTP id 427B93A8BC;
	Fri, 27 Jul 2007 13:50:15 +0400 (MSD)
Received: (from tomash@localhost)
	by moonlight.home (8.13.1/8.13.1/Submit) id l6R9oDbu014993;
	Fri, 27 Jul 2007 13:50:13 +0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707262231280.3442@woody.linux-foundation.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53911>

Maybe this may help:

I compiled Git under Linux with NO_PREAD=1, and also _disabled_
file position save/restore in git_pread().  Now (I clone small repo to
save traffic):

  moonlight:/tmp$ git-clone git://people.freedesktop.org/~keithp/parsecvs
  Initialized empty Git repository in /tmp/parsecvs/.git/
  remote: Generating pack...
  remote: Done counting 476 objects.
  remote: Deltifying 476 objects.
  remote:  100% (476/476) done
  Indexing 476 objects...
  remote: Total 476 (delta 339), reused 0 (delta 0)
   100% (476/476) done
  Resolving 339 deltas...
   100% (339/339) done
  error: packfile /tmp/parsecvs/.git/objects/pack/pack-dda2f32249fab26059a035bd273dce9feaf6bade.pack does not match index
  error: packfile /tmp/parsecvs/.git/objects/pack/pack-dda2f32249fab26059a035bd273dce9feaf6bade.pack cannot be accessed
  error: packfile /tmp/parsecvs/.git/objects/pack/pack-dda2f32249fab26059a035bd273dce9feaf6bade.pack does not match index
  error: packfile /tmp/parsecvs/.git/objects/pack/pack-dda2f32249fab26059a035bd273dce9feaf6bade.pack cannot be accessed
  fatal: failed to unpack tree object HEAD

Errors are different, but seems Git is sensitive to pread() that messes
file position.  The problem may be in index-pack.c:

	static const char *open_pack_file(const char *pack_name)
	{
		if (from_stdin) {
	                ...
			pack_fd = output_fd;
		} else {
	                ...
			pack_fd = input_fd;
		}
	        ...
	}

There's no dup() call, so when we mess pack_fd (that is used in
pread() only), we also mess one more file descriptor that is used
sequentially (output_fd in my case), and so may corrupt the pack.


-- 
   Tomash Brechko
