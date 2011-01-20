From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/5] fast-export: Introduce --inline-blobs
Date: Thu, 20 Jan 2011 10:20:48 +0530
Message-ID: <20110120045046.GB9493@kytes>
References: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
 <1295415899-1192-5-git-send-email-artagnon@gmail.com>
 <7vtyh4smer.fsf@alter.siamese.dyndns.org>
 <20110119214827.GA31733@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 20 05:49:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfmT5-0002qz-BR
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 05:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755155Ab1ATEtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 23:49:50 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38118 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755023Ab1ATEtt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 23:49:49 -0500
Received: by yxt3 with SMTP id 3so52260yxt.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 20:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=hRKpE5pqoRGTeZnoA7SwTyHYCbWEFQ87KrLdKg15NE0=;
        b=p/Sbrg98w8PhNsgYqjrWEgERdCKO2XO4wo4KMy5hP/eAUjJNSU/e2KT8PhCcMMkNyi
         7GLH4swYrw0XFFBYYx0dmECvB+06mjstqc91nC1AYXhlyGBVvWYNfR2kfXG+AikY8Wue
         1mluNT9KVOEspnwJkyRlkLhsnj/m+hvv1daTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WwI1CqNfuHT/AS6kQr1fSwFEX+NZgMrHKmAPMqKjztX066vBFNKieYQl/FHer8jFIr
         tIwosk/m0x2DW9MsZNhdAuJK41f0OvrUMc3dL325v5kT2Iqwj3JqLmzE/71w/eFBV3ke
         oO4l/iDwVy1FhhrcQ18hu7a7VvFO0TqgkgBMA=
Received: by 10.90.72.14 with SMTP id u14mr1962563aga.195.1295498988957;
        Wed, 19 Jan 2011 20:49:48 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id c34sm9399536anc.30.2011.01.19.20.49.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Jan 2011 20:49:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110119214827.GA31733@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165303>

Hi,

Jonathan Nieder writes:
> Junio C Hamano wrote:
> > Ramkumar Ramachandra <artagnon@gmail.com> writes:
> 
> >> Introduce a new command-line option --inline-blobs that always inlines
> >> blobs instead of referring to them via marks or their original SHA-1
> >> hash.
> [...]
> > Hmm, this smells somewhat fishy.
> >
> > Wasn't G-F-I designed to be a common stream format for other SCMs to
> > generate streams, so that importers and exporters can be written once for
> > each SCM to interoperate?
> 
> Here is one way to sell it:
> 
> 	With the inline blobs feature, fast-import backends have to
> 	maintain less state.  Using it should speed up exporting.
> 
> 	This is made optional because ...
> 
> I haven't thought through whether it ought to be optional or measured
> the effect on import performance.

It simplifies other fast-import backends greatly, because persisting
blobs can be complicated and expensive. I was thinking of making
svn-fe support both inlined blobs, and blobs referenced by marks. When
it's possible to be cheap by optionally having inlined blobs, why not
optionally have them? The filter we develop later can be used for
older fast-import streams that don't have inlined blobs.

On a related note, does it make sense to version our fast-import
stream format? It's certainly going to keep evolving with time, and we
need backward compatibility.

> A separate question is what an svn fast-import backend should do with
> all those blobs that are not ready to be written to dump.  As a hack
> while prototyping, one can rely on the "current" fast-export output,
> even though that is not flexible or futureproof.  Longer term, the
> folllowing sounds very interesting

Good point. The functionality to persist blobs that are refenced by
marks probably shouldn't be in svn-fe at all.

> > Just thinking aloud, but is it possible to write a filter that converts an
> > arbitrary G-F-I stream with referenced blobs into a G-F-I stream without
> > referenced blobs by inlining all the blobs?
> 
> to avoid complexity in the svn fast-import backend itself.
> (Complicating detail: such a filter would presumably take responsibility
> for --export-marks, so it might want a way to retrieve commit marks
> from its downstream.)

This filter will need to persist every blob for the entire lifetime of
the program. We can't possibly do it in-memory, so we have to find
some way to persist them on-disk and retrieve them very
quickly. Jonathan suggested using something like ToyoCabinet earlier-
I'll start working and see what I come up with.

-- Ram
