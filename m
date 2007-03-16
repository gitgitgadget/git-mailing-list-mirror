From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 19:20:26 +0100
Message-ID: <e5bfff550703161120o4571769eq18c13ae29ac79957@mail.gmail.com>
References: <20070316042406.7e750ed0@home.brethil>
	 <20070316045928.GB31606@spearce.org>
	 <7vejnpycu1.fsf@assigned-by-dhcp.cox.net>
	 <20070316060033.GD31606@spearce.org>
	 <7vps79wueu.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
	 <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Rocco Rutte" <pdmef@gmx.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 16 19:20:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSH2X-0007kI-BF
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 19:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965816AbXCPSUa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 14:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965821AbXCPSUa
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 14:20:30 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:61193 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965816AbXCPSU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 14:20:29 -0400
Received: by wr-out-0506.google.com with SMTP id 41so631599wry
        for <git@vger.kernel.org>; Fri, 16 Mar 2007 11:20:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hlioqf+pKL52u+U2UW2kEo8KwF5C9GM2APYBMLPDKr8xXRri83Qr9Npd9XXrEey6Ss2NvhFz2mr30jjwqXe1zrDz9OLMhM8hpBXfBjqdT79IkZc9HkejVB+s6nRQdRxHJXRAwadROd8AZ8fpzKMZb4NhZynQBJpFU2NBwyaFc0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kVpiK1ISFySJ0eNtnejLXIPcrEpV+KMzEFi08L7YKpzE+TUhhVoVJrK1MCK1gTGEdqdFZZph5rwOD6d+znmkNlLraoFrZoHzTj03hz8KO7uqUqzL6gEO2vJ8Rsd816JAFt8epyq6RMTNLkPYI7+h6EWiH0i/haOGmKoScUr+LvM=
Received: by 10.114.122.2 with SMTP id u2mr830330wac.1174069226305;
        Fri, 16 Mar 2007 11:20:26 -0700 (PDT)
Received: by 10.114.60.16 with HTTP; Fri, 16 Mar 2007 11:20:26 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42389>

On 3/16/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > Porting things like qgit to it or writting proper perl/python bindings
> > is wasted time since you'd have to rewrite all of it once you decided
> > which functions to expose and which structures to use (calling the
> > main() routines of builtin's doesn't count as real libifaction, it would
> > rather be a performance improvement only).
>
> Nope. It is _not_ a complete rewrite. More likely, it is minimal
> adjustments. It's not like we will replace apples with cars...
>

IMHO probably the truth is in the middle. I wouldn't call it a trivial
porting, at least for me, but anyway it would be interesting to have
fun with linking libgit.

*The most important thing for a libgit to be used by qgit is reentrancy*

Currently an unlimited number of tabs could be open in qgit, I'm not
talking about tabs open on different repos, but different views on the
same repo: main view, file history of file A, file history of file B,
tree view, i.e. select some files/directory from directory tree and
view the revisions that modified that repo subset, and so on. Other
different views could be added in the future. Because each view has a
dedicated tab and each tab calls _his_ 'git rev-list' instance (could
be called also at the same time) this libgit thing should be able to
support many instance of the libified git-rev-list function running at
the same time.

Perhaps currently this need is only for qgit among the GUI browsers,
but it would be not too difficult to foreseen a multi view GUI
interface as a relative common feature in the future also for the
remaining crop of git tools.

    Marco
