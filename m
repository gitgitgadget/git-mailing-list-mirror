From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Gitk feature - show nearby tags
Date: Sun, 4 Jun 2006 12:42:16 +0200
Message-ID: <e5bfff550606040342q5e485ae2lcc00e36ed405be8c@mail.gmail.com>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com>
	 <7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550606030416s2ef6182crbde1395dd29e5b94@mail.gmail.com>
	 <7vodx9cm3g.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550606040254n1449b62ta70c209ad8e1a0c@mail.gmail.com>
	 <7vbqt9ck05.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550606040333h1180bbep88fa90ea9928d062@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 12:42:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmq46-0004Tz-9N
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 12:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWFDKmU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 06:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWFDKmT
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 06:42:19 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:57766 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932217AbWFDKmR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 06:42:17 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1144809wri
        for <git@vger.kernel.org>; Sun, 04 Jun 2006 03:42:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fq9Lz02/Id2I6srCA1NYhFvE7CPgv+qPbnRZkIvjaXBchFDCOkgOx3+CnAxjTVkq+mZJpKIABKNYo8VvnUw6rabWAyaE1wQf/AOj7rD23cGAHuup9q5xJm0YmROK1FMmGiCeKic3y6/mbhvf2qmQzz8JJnIVTNTC+x0SzLK5CZE=
Received: by 10.65.197.12 with SMTP id z12mr2798071qbp;
        Sun, 04 Jun 2006 03:42:16 -0700 (PDT)
Received: by 10.65.210.17 with HTTP; Sun, 4 Jun 2006 03:42:16 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <e5bfff550606040333h1180bbep88fa90ea9928d062@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21263>

On 6/4/06, Marco Costalba <mcostalba@gmail.com> wrote:
> On 6/4/06, Junio C Hamano <junkio@cox.net> wrote:
> > "Marco Costalba" <mcostalba@gmail.com> writes:
> >
> > > In a less corner case, just to better explaing my idea, consider this:
> > >
> > >          a---b---d---e---f---g---h
> > >          t1   \ /              t3
> > >             ---c
> > >                t2
> > >
> > > Where our sha1 is still "e", in this case
> > >
> > > git-rev-list  --topo-order <e>  ^a  ^c   ^g
> > >
> > > gives, as last revision in output list, "f"
> > > Then parentOf(<f>) is <g> and our looked for tag is t3
> >
> > Sorry, in the example time flows from left to right.  If you
> > exclude g then you are excluding everything that is reachable
> > from g so you would not see "f".

To better explain what I mean, that's the algorithm :

cmd = "git-rev-list --topo-order --parents " + sha;
for (uint i = 0; i < tagList.count(); i++)
	cmd.append(" ^" + tagList[i]);

output = run(cmd);

if (output.isEmpty()) {
	parent = parentOf(sha);
	return (parent && parent->isTag()) ? parent->tag() : NO_TAG;
}

lastSha = getLastLine(output);
parent = parentOf(lastSha);
return (parent && parent->isTag()) ? parent->tag() : NO_TAG;
