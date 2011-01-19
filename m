From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] fast-export: Introduce --inline-blobs
Date: Wed, 19 Jan 2011 15:48:27 -0600
Message-ID: <20110119214827.GA31733@burratino>
References: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
 <1295415899-1192-5-git-send-email-artagnon@gmail.com>
 <7vtyh4smer.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 22:49:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pffta-0005FR-RG
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 22:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440Ab1ASVsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 16:48:45 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60706 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973Ab1ASVso (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 16:48:44 -0500
Received: by eye27 with SMTP id 27so826578eye.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 13:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=9/BdWOYVx5bAkSEPfRoYdQMbMx5vKoAqMFuqLtsihzM=;
        b=jgv/9brAKS3Xt8m1CpRuFBb5fO+iuf9usi/R7Q3SFQiVuewOFJdvC84F92r9MxCqiG
         SeRvLaDVNehoYdlMGtaTBrO7JNoe0xFeXylMAAdnFR2tvuTXg2zni2e1D6td2q31pF9M
         Z8ypt9V/eF6uzJFmEYsnG081gHO0zH9sNKicQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dIvo5s72dpu09u92RR0YKWJen8bh1oF7B8TlLdSrfJ1zid1qH401ZMQasBfPgTI/3K
         UVPUhULtXPtmyuGgc6/hOUyIKmHISZt97vSh2Yb/BfDpERK0MZ3ykwpaGUJ023UV8+lt
         M3YrrJbV1ONjhFiv5VVr+42ytXuvjiE5FQVzs=
Received: by 10.227.209.206 with SMTP id gh14mr1431654wbb.217.1295473723457;
        Wed, 19 Jan 2011 13:48:43 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.sbcglobal.net [69.209.76.37])
        by mx.google.com with ESMTPS id q18sm5457779wbe.17.2011.01.19.13.48.40
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 19 Jan 2011 13:48:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vtyh4smer.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165295>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:

>> Introduce a new command-line option --inline-blobs that always inlines
>> blobs instead of referring to them via marks or their original SHA-1
>> hash.
[...]
> Hmm, this smells somewhat fishy.
>
> Wasn't G-F-I designed to be a common stream format for other SCMs to
> generate streams, so that importers and exporters can be written once for
> each SCM to interoperate?

Here is one way to sell it:

	With the inline blobs feature, fast-import backends have to
	maintain less state.  Using it should speed up exporting.

	This is made optional because ...

I haven't thought through whether it ought to be optional or measured
the effect on import performance.

A separate question is what an svn fast-import backend should do with
all those blobs that are not ready to be written to dump.  As a hack
while prototyping, one can rely on the "current" fast-export output,
even though that is not flexible or futureproof.  Longer term, the
folllowing sounds very interesting

> Just thinking aloud, but is it possible to write a filter that converts an
> arbitrary G-F-I stream with referenced blobs into a G-F-I stream without
> referenced blobs by inlining all the blobs?

to avoid complexity in the svn fast-import backend itself.
(Complicating detail: such a filter would presumably take responsibility
for --export-marks, so it might want a way to retrieve commit marks
from its downstream.)
