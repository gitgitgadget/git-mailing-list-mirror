From: "Dana How" <danahow@gmail.com>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Wed, 19 Dec 2007 09:21:44 -0800
Message-ID: <56b7f5510712190921v4350384fx97ab4b89e481ed46@mail.gmail.com>
References: <20071218173321.GB2875@steel.home>
	 <alpine.LFD.0.9999.0712181711100.21557@woody.linux-foundation.org>
	 <56b7f5510712181752s7ecebca9m32794c635cba9fd@mail.gmail.com>
	 <200712191223.42446.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org,
	danahow@gmail.com
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 18:22:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J52cU-0000Hl-JC
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 18:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbXLSRVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 12:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbXLSRVr
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 12:21:47 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:32024 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbXLSRVq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 12:21:46 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1599266nfb.21
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 09:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6jZGirTK6nXy77S/K/FdgjDlQyje4hHI8INs8MIWLJM=;
        b=xt52SQdXLSgid1rhdBDi3achIjm11xwBIajYQosQm0LBA69z1W9cXleQ6iFh6RsvJD94m2QBgay/KKuGZTkcjoCbgrXifhlnbCjln2sMI9AUSoMcjX+i4h7iPdsw4+no+T9CBYaCV6b/hC8gJCAZqCeh+K4JPb1NfiIhDuyACr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cMmGjmWydFJB7jCPRBr1m79k+9UccHMonIN6qKM7bl5OQmkDh7w0fZDEl5NGUHeSbY+7qZfdnr1YpRfnIkynl0nVcXhS5Ap/44tgvSzvlA6Lzkmr6hcy9pOke7abv+x/7B4UDiyDsSCH/kJo4T8661c+wq9WIamsWD4NVacBcF8=
Received: by 10.78.159.7 with SMTP id h7mr12526461hue.17.1198084904933;
        Wed, 19 Dec 2007 09:21:44 -0800 (PST)
Received: by 10.78.130.1 with HTTP; Wed, 19 Dec 2007 09:21:44 -0800 (PST)
In-Reply-To: <200712191223.42446.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68923>

On Dec 19, 2007 3:23 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Wed, 19 Dec 2007, Dana How wrote:
> > I'd like to move some stuff currently in a p4 repository into git.
> > The directory structure within the repo is 13 levels deep;
> > I didn't design it nor can I change it.
> >
> > ...  The
> > basic commit:file syntax doesn't accept relative paths.  I am not
> > specifically hung up on the commit:./path syntax;  I just want some
> > notation that will get those 13 directories from $cwd instead of
> > making me type them again.
>
> I think new feature like this should be postponed after 1.5.4 is out;
> we are now in feature freeze (only bugfixes are accepted).
OK.  This is all the conversation that resulted from Alex's RFC.

> That said, does git-showrel solution proposed by  Johannes Schindelin
> in
>   Message-ID: <Pine.LNX.4.64.0712182250040.23902@racer.site>
>   http://permalink.gmane.org/gmane.comp.version-control.git/68840
> work for you?
>
> Below version of git-showrel script which uses proposed 'commit:./relpath'
> syntax (it could be improved, of course):
>
> cat > git-showrel <<\EOF
> #!/bin/sh
>
> rel=$(git rev-parse --show-prefix 2>/dev/null)
> git show $(echo "$@" | sed -e "s!:./!:${rel}!")
>
> EOF

It's definitely true I could use this for now.  In the long run
(meaning after the feature freeze) I don't view this as adequate
for 2 reasons:
(1) I would like a consistent interpretation of commit:path
wherever it is accepted; and
(2) If a novice types bad arguments to git-showrel ,  they
are probably going to be very confused by its error messages
which are a response to a munged version of their command line.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
