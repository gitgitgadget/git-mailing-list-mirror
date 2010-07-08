From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 05/13] Drive the debug editor
Date: Thu, 8 Jul 2010 08:04:53 +0200
Message-ID: <20100708060453.GA3264@debian>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
 <1278461693-3828-6-git-send-email-artagnon@gmail.com>
 <20100707182631.GB2617@burratino>
 <20100707190813.GA16065@debian>
 <20100707195321.GB2911@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, dev@subversion.apache.org,
	Julian Foad <julian.foad@wandisco.com>,
	Mark Phippard <mphippard@collab.net>,
	Stefan Sperling <stsp@elego.de>,
	Will Palmer <wmpalmer@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 08:03:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWkCc-00068t-FE
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 08:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887Ab0GHGDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 02:03:13 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53077 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509Ab0GHGDM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 02:03:12 -0400
Received: by eya25 with SMTP id 25so45745eya.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 23:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2uja+2y23OsRKFMGCIcrY1MjmJT8JLNOD6vRSCl7dok=;
        b=wa/IvBKlTV05jltOvw10JUKZa2Zu3l/hB51D7SvU5U7ZQl7Jt2qC6R+Lb0JpIHFqQD
         10ycLAzHjL57WQnNm1H4EuEl7ibljSP368OtTD1PCFQ0OcraPZ55kSwu6uom1P3BhfgO
         HNFBIiLJo6J8/gbm/ZyPtVl4VqiUqxhIooOgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hVVmB1pbDyWKAS+wpYeO+t8XlrNbH9JMX0ItmhfHA3C8bWt7aEYIO/O4pgZXpx3amr
         Tl904myPAq14tdVoSj7aPLAuOqtEQqQSmoNFJWN7mq2WsTXMDenDD7IXtpZPLxsByl1z
         T8mbkOfsD4+gIzSarnVzxy9kgn9Xt6dKtRWTk=
Received: by 10.213.20.78 with SMTP id e14mr6297158ebb.7.1278568990827;
        Wed, 07 Jul 2010 23:03:10 -0700 (PDT)
Received: from debian (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id a48sm68152633eei.18.2010.07.07.23.03.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 23:03:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100707195321.GB2911@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150537>

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> > Jonathan Nieder writes:
> >> Ramkumar Ramachandra wrote:
> 
> >>> -	de->apply_textdelta = apply_textdelta;
> >>> +	/* de->apply_textdelta = apply_textdelta; */
> [...]
> > Without this, the program segfaults because the necessary setup for
> > applying a text delta hasn't been set up. Perhaps I should explain
> > this in my commit message?
> 
> Is the default apply_textdelta not a no-op?  What work does it have to
> do, and can the skeleton editor be convinced to do the same in patch 4?

The default editor does this:
  *handler = svn_delta_noop_window_handler;
  *handler_baton = NULL;
  return SVN_NO_ERROR;

Fixed.

> >>> +{
> >>> +	/* Extract editor and editor_baton from the replay_baton and
> >>> +	   set them so that the editor callbacks can use them */
> >>
> >> This comment just paraphrases the code.  What in particular requires
> >> explanation here?
> >
> > This concept took me some time to wrap my head around: I had to stuff
> > the replay_baton with the editor/ editor_baton so that I could set
> > them for use in the callback functions.
> 
> Ah, okay.  Then I suppose it belongs in the commit message.
>
> Alternatively: why does the tree editor have to persist between calls
> replaying the various revisions?  That information could help the
> reader understand what is going on.

Right. The editor_baton is the key item that's guaranteed to be passed
around. Fixed.

-- Ram
