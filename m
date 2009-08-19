From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Continue git clone after interruption
Date: Wed, 19 Aug 2009 11:53:33 +0200
Message-ID: <200908191153.36006.jnareb@gmail.com>
References: <1250509342.2885.13.camel@cf-48> <m3fxbpneqe.fsf@localhost.localdomain> <2e24e5b90908182142n16201ed4ua41408878664e353@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Tomasz Kontusz <roverorna@gmail.com>,
	git <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 11:53:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdhra-0005RK-FD
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 11:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbZHSJxm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Aug 2009 05:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbZHSJxm
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 05:53:42 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:45001 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbZHSJxl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 05:53:41 -0400
Received: by fxm17 with SMTP id 17so3675820fxm.37
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 02:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ybSgOfAMG7A7syBfGJieJlxUtD5PdhA+IgEEMBTKn3c=;
        b=RIsyizZAs0XtKRZ0/qUGiTa7V/fP64SGVjsEhe/kQK+F2JX5WC1MXURYr42WAg9lTq
         jhzcJhn2zejWJ4xo9hJR6uLfEAOaZyV9FnEMh/Ij93a13Ex7hIC1QLr0pSI7GPEbRpah
         2UXp8jQ+k1PAyqnSI6CwCJbIlSFKIvdi+VhrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=yB8vgac9o73WXwpId7rX9C3iw+tyKOjQm26hhgeJUueMUJSkQR8ifgew4MdXzYkpcE
         qInsdDAPIHJJ3uKwAfNXbUg+vIT85bgwQpt0DJLyn/MCyIlYonuF9OhTzBmQ4ALBgMsr
         biWJ7rRXuQCDgRzB1YRp/vH7PCmNI1IjoEwOo=
Received: by 10.86.227.27 with SMTP id z27mr3981288fgg.66.1250675621797;
        Wed, 19 Aug 2009 02:53:41 -0700 (PDT)
Received: from ?192.168.1.13? (abvk137.neoplus.adsl.tpnet.pl [83.8.208.137])
        by mx.google.com with ESMTPS id 12sm10764119fgg.11.2009.08.19.02.53.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 02:53:40 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <2e24e5b90908182142n16201ed4ua41408878664e353@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126527>

On Wed, Aug 19, 2009, Sitaram Chamarty wrote:
> On Wed, Aug 19, 2009 at 12:15 AM, Jakub Narebski<jnareb@gmail.com> wr=
ote:

> > There is another way which we can go to implement resumable clone.
> > Let's git first try to clone whole repository (single pack; BTW wha=
t
> > happens if this pack is larger than file size limit for given
> > filesystem?). =A0If it fails, client ask first for first half of of
> > repository (half as in bisect, but it is server that has to calcula=
te
> > it). =A0If it downloads, it will ask server for the rest of reposit=
ory.
> > If it fails, it would reduce size in half again, and ask about 1/4 =
of
> > repository in packfile first.
>=20
> How about an extension where the user can *ask* for a clone of a
> particular HEAD to be sent to him as a git bundle?  Or particular
> revisions (say once a week) were kept as a single file git-bundle,
> made available over HTTP -- easily restartable with byte-range -- and
> anyone who has bandwidth problems first gets that, then changes the
> origin remote URL and does a "pull" to get uptodate?
>=20
> I've done this manually a few times when sneakernet bandwidth was
> better than the normal kind, heh, but it seems to me the lowest impac=
t
> solution.
>=20
> Yes you'd need some extra space on the server, but you keep only one
> bundle, and maybe replace it every week by cron.  Should work fine
> right now, as is, with a wee bit of manual work by the user, and a
> quick cron entry on the server

This is a good idea, i think, and it can be implemented with various
amount of effort and changes to git, and various amount of seamless
integration.

1. Simplest solution: social (homepage).  Not integrated at all.

   On projects homepage, the one where there is described where project
   repository is and how to get it, you add a link to most recent bundl=
e
   (perhaps in addition to most recent snapshot).  This bundle would be
   served as a static file via HTTP (and perhaps also FTP) by (any) web
   server that supports resuming (range requests).  Or you can make
   server generate bundles on demand, only when they are first requeste=
d.

   Most recent might mean latest tagged release, or it might mean daily
   snapshot^W bundle.

   This solution could be integrated into gitweb, either by generic=20
   'latest bundle' link in project's README.html (or in site's=20
   GITWEB_HOMETEXT, default indextext.html), or by having gitweb
   generate those links (and perhaps bundles as well) by itself.

2. Seamless solution: 'bundle' or 'bundles' capability.  Requires=20
   changes to both server and client.

   If server supports (advertises) 'bundle' capability, it can serve
   list of bundles (as HTTP / FTP / rsync URLs) either at client reques=
t,
   or after (or before) list of refs if client requests 'bundle'=20
   capability.

   If client has support for 'bundles' capability, it terminates=20
   connection to sshd or git-daemon, and does ordinary resumable HTTP
   fetch using libcurl.  After bundle is downloaded fully, it clones
   from bundle, and does git-fetch with the same server as before,
   which would then have less to transfer.  Client has also to handle
   situation where bundle download is interrupted, and do not do cleanu=
p,
   allowing for "git clone --continue".

3. Seamless solution: GitTorrent or its simplification: git mirror-sync=
=2E

   I think that GitTorrent (see http://git.or.cz/gitwiki/SoC2009Ideas)
   or even its simplification git-mirror-sync would include restartable
   cloning.  It is even among its intended features.  Also this would
   help to download faster via mirrors which can have faster and better
   network connection.

   But this would be most work.

You can implement solution 1. even now...
--=20
Jakub Narebski
Poland
