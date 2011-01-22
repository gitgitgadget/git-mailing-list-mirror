From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/5] fast-export: Introduce --inline-blobs
Date: Sat, 22 Jan 2011 14:54:20 +0530
Message-ID: <20110122092416.GA7827@kytes>
References: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
 <1295415899-1192-5-git-send-email-artagnon@gmail.com>
 <7vtyh4smer.fsf@alter.siamese.dyndns.org>
 <20110119214827.GA31733@burratino>
 <20110120045046.GB9493@kytes>
 <1295531623.4298.26.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sat Jan 22 10:23:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgZh5-0000Fn-R0
	for gcvg-git-2@lo.gmane.org; Sat, 22 Jan 2011 10:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648Ab1AVJXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jan 2011 04:23:23 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:53507 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab1AVJXV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jan 2011 04:23:21 -0500
Received: by pxi15 with SMTP id 15so422199pxi.19
        for <git@vger.kernel.org>; Sat, 22 Jan 2011 01:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=9UJ/ru0upw4ZkBMkw/Oa7QTM+M9ie7jly3iEsYXDiFc=;
        b=nUOx34mfQaGuz7zP8xRRhQNnG8Leh68jzUjUNvvPRVBa5B7s/pmC0XXdaofELj0+JJ
         WXsstn6HgsElHtvjBWVWRpY8LJ0y6+dtigLd64P+OE0B/br3VhZVXKoOl1pzJBnzyiu4
         7DVMWE/bZvWvq/AF/JtlzWlr7PIr7NUewyoUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DOAE7WEaXxyfxkRvIJX2w4rLTJMkq9xq8cNEsHWVxYe9fbIv3gpTNepQweGJfPxIf1
         +NQcR0vQKdY+BO6zKZH/ZDf8Y50a8JLmlnio31rMbsom3DscPuAUQRJFjILMbdX2gTtE
         vFF1PvxUgjhQijdvDbZWwT4BbX07zmzf00iSQ=
Received: by 10.142.86.7 with SMTP id j7mr117274wfb.290.1295688201179;
        Sat, 22 Jan 2011 01:23:21 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id x18sm13937866wfa.11.2011.01.22.01.23.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 Jan 2011 01:23:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1295531623.4298.26.camel@drew-northup.unet.maine.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165408>

Hi Drew,

Drew Northup writes:
> On Thu, 2011-01-20 at 10:20 +0530, Ramkumar Ramachandra wrote:
> > Hi,
> > Jonathan Nieder writes:
> > > Junio C Hamano wrote:
> > > > Ramkumar Ramachandra <artagnon@gmail.com> writes:
> > > > Just thinking aloud, but is it possible to write a filter that converts an
> > > > arbitrary G-F-I stream with referenced blobs into a G-F-I stream without
> > > > referenced blobs by inlining all the blobs?
> > > 
> > > to avoid complexity in the svn fast-import backend itself.
> > > (Complicating detail: such a filter would presumably take responsibility
> > > for --export-marks, so it might want a way to retrieve commit marks
> > > from its downstream.)
> > 
> > This filter will need to persist every blob for the entire lifetime of
> > the program. We can't possibly do it in-memory, so we have to find
> > some way to persist them on-disk and retrieve them very
> > quickly. Jonathan suggested using something like ToyoCabinet earlier-
> > I'll start working and see what I come up with.
> 
> Is it worth including the extra dependency? Most systems that I'm in
> frequent contact with already have some lightweight BDB implementation
> already. I don't currently know of any with TokyoCabinet (or
> KyotoCabinet for that matter) already in place. Besides, if all you're
> doing is persisting blobs that you're likely to write out to disk
> eventually anyway you might as well just do so once you have them and
> keep an "index" (not to be confused with the Git Index, just lacking a
> better word right now) of what you have in some standard in-memory
> format (a heap?). From there you can build each commit into the Git
> Index in the proper order once you have the required parts for
> each--perhaps even re-using the blobs you've already dumped to disk
> (mv'ing them or something).

Agreed. I wouldn't like to introduce an extra dependency either. I was
talking about using it for prototyping- if the final version includes
an extra dependency, it's unlikely to get merged into git.git :) The
final design will probably use an in-memory B+ tree, but I haven't
thought about that hard enough.

-- Ram
