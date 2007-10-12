From: "Lars Hjemli" <lh@elementstorage.no>
Subject: Re: RCS keyword expansion
Date: Fri, 12 Oct 2007 13:21:58 +0200
Message-ID: <8c5c35580710120421x130c5d7dt6c9d9b5a55313180@mail.gmail.com>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se>
	 <86fy0hvgbh.fsf@blue.stonehenge.com>
	 <20071011155956.GC11693@cs-wsok.swansea.ac.uk>
	 <Pine.LNX.4.64.0710112144380.4174@racer.site>
	 <Pine.LNX.4.62.0710120723480.11771@perkele.intern.softwolves.pp.se>
	 <Pine.LNX.4.64.0710121057540.25221@racer.site>
	 <Pine.LNX.4.64.0710121144001.3682@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Peter Karlsson" <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Oct 12 13:22:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgIao-0005qy-54
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 13:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757139AbXJLLWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 07:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbXJLLWA
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 07:22:00 -0400
Received: from rv-out-0910.google.com ([209.85.198.185]:5317 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344AbXJLLV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 07:21:59 -0400
Received: by rv-out-0910.google.com with SMTP id k20so775651rvb
        for <git@vger.kernel.org>; Fri, 12 Oct 2007 04:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=rlh+nvOoGO+Ug775jJ91PmDRyYljQdE6Q++aLAtMOiw=;
        b=ApsKuKD8JvoQ0Ria6O0k+g1qDrh6NkdyoSzbC2X/r2WFe27QubAOvJweieo9greL8pPmkmTapRLGCMxLMkPsE/KwpUqeXI/j5xrwGIk9zq++XDhUu+8Sr6vWd9tN1+FmeZtIJozK8euNNAINebiknDMfnNyk+X7s1BoUCVhhPg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=TY4JS7Gn3c1r8DLqr8PaFBUmtoDpE3WUOTR1CDTNt1w4rXmcHKDuJI5mRXEPc793+AAqnSaQv1PE4+NGL0olTekVtg/ug77ztGfoc9jL44VCcvMbGYl+P66ZeMjGOXlJruA3WbbSzTUXAqhMq8C2DqeV452bmV7HV6b7jCsrXWo=
Received: by 10.114.154.1 with SMTP id b1mr3372936wae.1192188118407;
        Fri, 12 Oct 2007 04:21:58 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Fri, 12 Oct 2007 04:21:58 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710121144001.3682@ds9.cixit.se>
Content-Disposition: inline
X-Google-Sender-Auth: 073ae483a1be23d0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60675>

On 10/12/07, Peter Karlsson <peter@softwolves.pp.se> wrote:
> Johannes said:
> > So why not go for the contents?  With CVS/SVN you only have the
> > chance to do that by date or version number. With git, we have a more
> > powerful way: we do it by a hash of the contents.
>
> Yes, but the hash if of "everything". I'm not interested in
> "everything" in this context, and I don't want to have a separate git
> repository for each file...

Try this:

$ echo 'File revision $Id$' > index.html
$ echo "*.html ident" > .gitattributes
$ git add index.html .gitattributes
$ git commit

>From now on, the '$Id' in index.html gets expanded to the SHA1 of the
content of index.html (not the commit SHA1) each time you checkout
(and removed when you commit)

If you still want 'last modified date', the closest thing in git is
'commit date' which you can also get for free:

$ echo 'Last commit: $Format:%cd$' > index.html
$ echo "*.html export-subst" > .gitattributes
$ git add index.html .gitattributes
$ git commit
$ git archive --prefix=test/ HEAD | tar -x
$ cat test/index.html

For all supported keywords, take a look at the 'git-log --pretty=format' option

--
larsh
