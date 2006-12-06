X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb: Add committags support (take 2)
Date: Wed, 6 Dec 2006 13:51:01 +0100
Message-ID: <200612061351.02712.jnareb@gmail.com>
References: <200612040001.13640.jnareb@gmail.com> <200612041133.44816.jnareb@gmail.com> <7vmz64ortu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 6 Dec 2006 12:49:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VnkpMzFZdDrSIj0O21TBGN1bHTWbOWRahz50TaydqG27syYhjib6I9VRruVrzmlPxBfgfu8RKpxM30ZVLfF1j2hxW0BfHv7ej0TvWZNyECPtMoNrAKv+thqSjp0p7yabf5DAUnJAeaqCoBlyUxg5tvT8XHLgMSuTPCzNcnp3Lls=
User-Agent: KMail/1.9.3
In-Reply-To: <7vmz64ortu.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33448>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrwD1-0004Di-Sq for gcvg-git@gmane.org; Wed, 06 Dec
 2006 13:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760568AbWLFMs6 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006 07:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760569AbWLFMs6
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 07:48:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:49477 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760568AbWLFMs5 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 07:48:57 -0500
Received: by ug-out-1314.google.com with SMTP id 44so129429uga for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 04:48:56 -0800 (PST)
Received: by 10.67.92.1 with SMTP id u1mr722033ugl.1165409336590; Wed, 06 Dec
 2006 04:48:56 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id k28sm24785507ugd.2006.12.06.04.48.56; Wed, 06 Dec
 2006 04:48:56 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
>
>> I have thought about putting %committags and @committags before
>> loading config file
>> =A0 do $GITWEB_CONFIG if -e $GITWEB_CONFIG;
>> which can load config file depending on the project, but perhaps
>> it is too complicated solution.
>=20
> I think you are talking about a gitweb-instance wide
> customization, but that's not what I meant. =A0I meant per-project
> configuration where w/git-gui.git and w/git.git are served by
> the same instance of gitweb but have pointers to different issue
> trackers.

It looks like the hardest part with committags support wouldn't be the=20
actual implementation of it, but coming with easy and fast way to set=20
up those committags.

gitweb-xmms2 project from which the idea of committags support in gitwe=
b=20
came (I think, correct me if I'm wrong) avoids this issue by having=20
issue tracker / bug tracker the same for all projects served by single=20
gitweb installation; the configuration is site-wide, and there is no=20
per project committags configuration.


I have imagined the following twofold solution.

1. Make it easier to have per repository gitweb configuration, for
   example by having gitweb configuration file in GIT_DIR for a project=
,
   "gitweb_conf.perl" by default:

  our $GITWEB_REPO_CONFIG =3D $ENV{'GITWEB_REPO_CONFIG'} ||
  	"++GITWEB_CONFIG++";
  do "$projectroot/$project/$GITWEB_REPO_CONFIG"
  	if -e "$projectroot/$project/$GITWEB_CONFIG";

2. Put the configuration in config file, using/like %features support.
   For example gitweb.committags.<committag name> would hold parameters
   for <committag>. Committags sequence would be given by sequence of
   entries in config file. Comittags without options would have sole
   variable entry (which I think is equivalent to being bool variable
   and having 1 or 'yes' as value).

   The trouble with this approach is not overriding defaults provided
   while still turning on/off specific committag. And of course the fac=
t
   that for that we need rather config reader in Perl (Git.pm or
   gitweb).

What do you think about it? Junio? Pasky?
--=20
Jakub Narebski
