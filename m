From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH GSoC 2/3] git-instaweb: Configure it to work with a global  server root and projects list
Date: Wed, 19 May 2010 18:48:47 +0200
Message-ID: <201005191848.49922.jnareb@gmail.com>
References: <1273953520-25990-1-git-send-email-pavan.sss1991@gmail.com> <201005190105.59606.jnareb@gmail.com> <AANLkTimFrX6yE69ZNlZM11XJVNLS5rpbsdeNN984iNs7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 19 18:49:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEmSO-0005uf-0v
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 18:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215Ab0ESQtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 12:49:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:13392 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341Ab0ESQtA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 12:49:00 -0400
Received: by fg-out-1718.google.com with SMTP id d23so142520fga.1
        for <git@vger.kernel.org>; Wed, 19 May 2010 09:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=aIA8Egldyy4ooWrpaY4Co6qlyc1PSRlYIiRe1fJxhS8=;
        b=Abu0FVJtFM2y9xYkWllHnAVwNLCWc0fCrWls9sWGduG9gitZSSQSdp7rCcYUIx3L1q
         ME3DxB/NPpClaG3M6szpA5raoznY5Rh+sZVUFtAJFv9FZbi8UpgxgkszFQeVmfnUbvGl
         OSEuZlir4zY35qQdkRrwF7caBRIgXFkhZC8Do=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZZ0H5Hz+96pNbKf0sjGwC/T/SFKVRH3PN1Gu9S5ChijH6lpyND+QwFbF6QaP0N8MKR
         qYjjaJ5dmJRVI+i2CE7RkcTYjkG6Txlaf94NzXymedc6ruGBNVBS29NoY475+SWZkdK7
         rxvw/DN7fnpzQVYzFZrecd226chXB6L1JZlyg=
Received: by 10.87.70.10 with SMTP id x10mr119687fgk.5.1274287738502;
        Wed, 19 May 2010 09:48:58 -0700 (PDT)
Received: from [192.168.1.13] (abrz84.neoplus.adsl.tpnet.pl [83.8.119.84])
        by mx.google.com with ESMTPS id c28sm11187101fka.44.2010.05.19.09.48.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 May 2010 09:48:57 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTimFrX6yE69ZNlZM11XJVNLS5rpbsdeNN984iNs7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147334>

On Wed, 19 May 2010, Pavan Kumar Sunkara wrote:
> On Wed, 19 May 2010 01:05:57 +0200, Jakub Narebski wrote:

> > Well, I can understand that.
> >
> > There are two options how to resolve this issue without adding yet
> > another script (although on the other hand git-web-gui / git-client
> > could share code with git-instaweb just like git-difftool and
> > git-mergetool do).
> >
> > First is to leave git-instaweb similar to how it is now, with pid file,
> > server config file, gitweb config file, etc. in $GIT_DIR/gitweb, but
> > if it is invoked outside any git repository, start it in "repository
> > administration" mode, i.e. on the page that allows one to create new
> > repository or clone repository.
> 
> But this solution requires starting of many apache servers on many
> ports which is quite complicated and even messier.

I agree with that.  I guess that git-instaweb was created mainly for the
situation where you work in single repository, and does not support well
situation where you move from repository to repository, and run git-instaweb
in different repositories.


As I wrote earlier:

   Now, current git-instaweb behavior has its quirks, but having
   git-instaweb show _current_ repository is a very important feature,
   and I'd rather we didn't lose it in transition.

> > The alternate solution would be to follow the idea implemented in this
> > patch, namely per-user pid file, gitweb config file, server config file
> > etc. and the *list of projects* file in $HOME/.gitweb (or whenever
> > XDG / FHS / LSB says it should be named), _but_ add an easy way to add
> > a new project (a new repositoey) to list.
> 
> The feature *Adding repository to client* in my project proposal will
> take care of this.

That's good, but...

> >  Perhaps even make
> > 'git instaweb', when run from inside git repository, add automatically
> > current repository to list (unless it is present there already), and
> > perhaps open 'summary' page for said repository.
> 
> Yeah, we can do that but I think I will do it in another commit.

...this is really needed, in my opinion.

I agree that it should be in separate commit.

-- 
Jakub Narebski
Poland
