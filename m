From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Vendor branches workflow
Date: Wed, 8 Dec 2010 03:09:08 -0600
Message-ID: <20101208090908.GA4640@burratino>
References: <AANLkTi=s9p3RycRCrocHEzfc4L-pnU6S9xCKfEL7TP=i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Leonid Podolny <leonidp.lists@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 10:09:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQG1m-0001uc-GM
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 10:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865Ab0LHJJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 04:09:28 -0500
Received: from mail-gw0-f42.google.com ([74.125.83.42]:40895 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639Ab0LHJJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 04:09:26 -0500
Received: by gwb20 with SMTP id 20so763599gwb.1
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 01:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=obpAcZJ0QVSiFX2Y7Eyv0ncI795UQ/K8cfkEgJ2hiBQ=;
        b=ilZWdyKDNd5pcqa0jfC4Kde3U3/qQ9iXF9NQqmm79vXtqkUTcPy36ixkozeNR/n0Je
         8gBajLqyO72YCtuw6r6KIDMCRwi4gRTPz3vXmxe1aoR8tnwCPIs2d5HesoUp6GHQsWQ8
         oaz+5Xtbs1s3jEC2i4DwID+vGMwCCSbJBEhOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mKDgU0TAYoy4hE7qqz1qBkV6X8bA4P/EhFd8lKs38wHVTNhljmS7gTZjX2fEWxBjmC
         6kjVuxwuobHwcYgZ9O6Igw0nLDqYyluf2luy/8ugJtTA+pjpfifPgByD+SwSk5oIbhmF
         GJTVY6eGrfFqwiXZgsC1MG959+L4D4PVL+K9o=
Received: by 10.150.198.3 with SMTP id v3mr3724527ybf.81.1291799361283;
        Wed, 08 Dec 2010 01:09:21 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id q14sm295824ybk.19.2010.12.08.01.09.19
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 01:09:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=s9p3RycRCrocHEzfc4L-pnU6S9xCKfEL7TP=i@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163179>

Hi Leonid,

Leonid Podolny wrote:

> In our project, we have two upstreams, which are rather massively
> patched. One of the upstreams is an SF svn repository, the other
> arrives in form of tgz's with sources. Now git is tracking the patched
> version, and I want to add a vendor branch to simplify future vendor
> drops.
>
> Out of the SVN upstream, we use only specific directories.

If I were in this situation, I would use "git svn" with its
ignore-paths option.  Like so:

	git svn -Rsvn init --ignore-paths='^(?!directory-a|directory-b)' \
		$url/trunk

This way, using "git svn fetch" causes the history of these files to
be fetched, and one can use gitk, git log -S, git bisect, and other
familiar tools to browse through it.

Alternatively, a more usual vendor branch workflow (manually
committing the relevant files) can work well, too.  In either case I
would only track the upstream files relevant to the history of my
project.  A .gitignore file can be useful to avoid accidentally
tracking other files (like the .svn metadata).

Hope that helps,
Jonathan
