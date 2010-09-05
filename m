From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/3] fast-import: give importers access to the
 object store
Date: Sun, 5 Sep 2010 12:31:04 -0500
Message-ID: <20100905173104.GA14020@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
 <20100905060854.GA15511@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 19:33:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsJ5m-0007js-Ot
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 19:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025Ab0IERdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 13:33:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45944 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836Ab0IERdR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 13:33:17 -0400
Received: by iwn5 with SMTP id 5so3429045iwn.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 10:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DbbBa/Jl7yFVC9/RjjnkcINibGTQY6NLeCPZnqTH2KY=;
        b=YHSirkYntOOqs1fkSQwDE4llegy2qEJDbWXJJX3bg6LgjknpC1qn4puR3+ITPn5Ajq
         0vV5mxd3B2zmKeP6bOCUmrUbOV3fSGo2PTA3d+i9ebazdZ2P0OJiSA0HpyuJlF88/z0g
         LxkYNhpX7rBW5qKsHa23p0PmC5FKEzv2++28U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ueovxgfHq3Qz7GHFo6H2rhgtj6vhl25okFJYxgDt+SCapZIOfp0exjCr85TYL0wIGb
         0barO3MxI/eAJrHzy6Z6P94vMw4+DmSWLigDciB/0wNCTuLsTEveeUnVdvU7xtQqjEz+
         gzx3GOG0/5OYw31/MXdqvSej5iT1hk8vpcvxE=
Received: by 10.231.154.73 with SMTP id n9mr4794740ibw.10.1283707996389;
        Sun, 05 Sep 2010 10:33:16 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id g31sm4801726ibh.4.2010.09.05.10.33.14
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 10:33:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100905060854.GA15511@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155465>

Ramkumar Ramachandra wrote:

> I finished writing tests for the svndiff0 applier
> and started modifying svn-fe to use it. I've applied your patches and
> rebased my work on top of it.

Nice.

> Ideally, we'd like to be able to supply a commit and a pathname.

To expand on this a little, avoiding dwim-ery of this kind was part
of the spirit I was going for: minimal as possible.  Either the
frontend or the backend is going to have to read the first line of
the commit:

 "tree ...tree name...
  parent [etc]"

and I thought, why not let the frontend do that for now?

Hopefully after using something just barely sufficient like this, we
will know what primitives are needed to make code clear and
efficient (ls?  cat --batch-check?  cat byte range?).  And such
primitives could be at a higher level of abstraction, which might make
the protocol guardians happier.

> On a related
> note, we should probably extend the git-remote-testgit helper to use
> this feature in future to facilitate writing unittests.

Hopefully t/t9011-svn-helper.sh will exercise it in the future.

Thanks for the comments,
Jonathan
