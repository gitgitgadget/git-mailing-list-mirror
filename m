From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH maint-1.6.5] block-sha1: avoid unaligned accesses on some
 big-endian systems
Date: Sat, 14 Jul 2012 14:50:22 -0500
Message-ID: <20120714195022.GB23242@burratino>
References: <20120713233957.6928.87541.reportbug@electro.phys.waikato.ac.nz>
 <20120714002950.GA3159@burratino>
 <5000CBCA.8020607@orcon.net.nz>
 <20120714021856.GA3062@burratino>
 <50010B84.5030606@orcon.net.nz>
 <20120714075906.GD3693@burratino>
 <CA+55aFy+y=TCoJUQarinaduibt4i-46TAuvpp7fsAmjDZj_+3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Cree <mcree@orcon.net.nz>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 14 21:50:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sq8ML-00047J-1p
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 21:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614Ab2GNTu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jul 2012 15:50:29 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53163 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab2GNTu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2012 15:50:27 -0400
Received: by obbuo13 with SMTP id uo13so6858969obb.19
        for <git@vger.kernel.org>; Sat, 14 Jul 2012 12:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rrOTNPuzUuLl5ruXG4qFjjL5ZCKW7XrmZ8tTIpJtEQ8=;
        b=BSdyLgojtmS7IzChTblXLYMymlFB20PIQCdI/1RAX3QNHG2z0rzUx7AWh1tiri1PJU
         6OFnVztedb+nHsrb6/Jwjq/JUDYpd5TGzaiT5663fWYqtEWqCChtkoIuYosi/GbOyMn/
         eYBWyWDb5NbHQzSP7uycdmNpGt3WShtNO41Hb+z41nPJ8L/3fZudwt+S/F17bBUcjcAp
         42wA+XAXoyCtBLHsCVARgKvo0PKALKDfRYHtXR9XlGKSgH88mUtmtIqF1pnAjA/M2LCD
         gXY8Roo1/irlnOWhhqnmfQr0sLK+PRmtOpiVQVzjadnG8xwdDkmKQuyI2sEiA97XgWLP
         80xw==
Received: by 10.50.197.194 with SMTP id iw2mr2032658igc.31.1342295426807;
        Sat, 14 Jul 2012 12:50:26 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id bo7sm9823072igb.2.2012.07.14.12.50.25
        (version=SSLv3 cipher=OTHER);
        Sat, 14 Jul 2012 12:50:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+55aFy+y=TCoJUQarinaduibt4i-46TAuvpp7fsAmjDZj_+3w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201449>

Linus Torvalds wrote:
> On Sat, Jul 14, 2012 at 12:59 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Unfortunately, on big-endian architectures, if p is a pointer to
>> unsigned int then current gcc assumes it is properly aligned and
>> converts this construct to a 32-bit load.
>
> This patch seems to entirely depend on the location of the cast. And
> as far as I can tell, that workaround will in turn depend on just what
> gets inlined.

After the patch, what reason does gcc have to expect that 'block' is
32-bit aligned except when it is?  The code (including the code I
didn't touch) never casts from char * to int * except in get/put_be32
on arches that don't mind unaligned accesses.

[...]
> Anyway, the whole "noticed on alpha" makes no sense, since alpha isn't
> even big-endian. So the commit log is insane and misleading too.

Yes, true.  Thanks for catching it.

Jonathan
