From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] gitweb: Add an option to force version match
Date: Tue, 02 Feb 2010 15:56:36 -0800 (PST)
Message-ID: <m3iqaf9oqu.fsf@localhost.localdomain>
References: <1265147814-13284-1-git-send-email-warthog9@eaglescrag.net>
	<1265147814-13284-2-git-send-email-warthog9@eaglescrag.net>
	<7vvdef1by2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 00:56:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcSbt-0003aC-9o
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 00:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872Ab0BBX4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 18:56:41 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:57562 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755828Ab0BBX4k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 18:56:40 -0500
Received: by fxm7 with SMTP id 7so805471fxm.28
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 15:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=TiM50I1RdI4d35T596gWzXNejZItsqsqe2YO60bLrXc=;
        b=aFnTFXtdTb2Y8ueFcb8LUL3N8gnT/BV3VErcdJ+bID1XEz5dlZM2iVDbN8gRBWTJ+q
         ZpFTkTUDhnwW6VWYDS5aRv16VWYeAs2WdyNWIaFfOaZ2ej9NBUgkaXUE1R20d1obe8Ll
         UoUciCYg+JpS31kQRRxFoPGR0nwqeD9ekddj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=SHQ60dFDmK5yx10VIwM+X6HCfnuhrIHAekWsLufDspHQ8KtYbbbu9PFdWY2MhCA/FV
         H3Jx7iKH6U2G95JdLS/7vfo6Ax6sotfy1B76omOr6B45Hv2L06jX4H1ix0kf+j6hgw2u
         BYrTQZb+QU8E5AroiZWmlymo6iHSdmaRmFMBg=
Received: by 10.103.79.35 with SMTP id g35mr4030081mul.82.1265154998507;
        Tue, 02 Feb 2010 15:56:38 -0800 (PST)
Received: from localhost.localdomain (abvx213.neoplus.adsl.tpnet.pl [83.8.221.213])
        by mx.google.com with ESMTPS id 12sm1746669muq.9.2010.02.02.15.56.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Feb 2010 15:56:36 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o12Nu1eR019293;
	Wed, 3 Feb 2010 00:56:11 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o12NtbJe019283;
	Wed, 3 Feb 2010 00:55:37 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vvdef1by2.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138790>

Junio C Hamano <gitster@pobox.com> writes:

> "John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> > @@ -583,6 +586,33 @@ sub get_loadavg {
> >  our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
> >  $number_of_git_cmds++;
> >  
> > +# Throw an error if git versions does not match, if $git_versions_must_match is true.
> > +if ($git_versions_must_match &&
> > +    $git_version ne $version) {
> > +	my $admin_contact =
> > +		defined $ENV{'SERVER_ADMIN'} ? ", $ENV{'SERVER_ADMIN'}," : '';
> > +	my $err_msg = <<EOT;
> > +<h1 align="center">*** Warning ***</h1>
> > +<p>
> > +This version of gitweb was compiled for <b>@{[esc_html($version)]}</b>,
> > +however git version <b>@{[esc_html($git_version)]}</b> was found on server.
> > +Running an instance of gitweb that is not matched to the git binaries may
> > +result in unexpected behavior of gitweb, and loss of functionality or
> > +incorrect data on displayed pages.
> > +</p>
> > +<p>
> > +Please update the git or gitweb installation so that their versions match, or
> > +if you feel you are sure that you wish to proceed with running gitweb
> > +with unmatched versions please contact the server administrator${admin_contact}
> > +to configure gitweb to allow mismatched versions.  This can be done by
> > +setting \$git_versions_must_match to @{[esc_html($git_versions_must_match)]}

Errr... the above line does not makes sense, as $git_versions_must_match
is true (true value), and not false (false value). so you would get something
like:

  'setting $git_versions_must_match to 1 (false value) [...]'

> > +(false value) in gitweb configuration file,
> > +'@{[esc_path(-e $GITWEB_CONFIG ? $GITWEB_CONFIG : $GITWEB_CONFIG_SYSTEM)]}'.
> > +</p>
> > +EOT
> > +	die_error(500, 'Internal server error', $err_msg);

As I wrote in my earlier response, this is not enough.  If this error
message (description of this situation) is meant to describe how to turn
this feature off, it has to deal with situation where config file does
not exist.  With this feature off by default we knew that it had to be
changed in some gitweb config file, so one of $GITWEB_CONFIG and
$GITWEB_CONFIG_SYSTEM must exists.  This is not true if this feature is
turned on by default.

You need to describe how to deal with the following situations:

* Both $GITWEB_CONFIG and $GITWEB_CONFIG_SYSTEM are empty or undefined.
  You might skip this situation, as by default both are set by
  gitweb/Makefile, $GITWEB_CONFIG to gitweb_config.perl and
  $GITWEB_CONFIG_SYSTEM to /etc/gitweb.conf
 
* Both $GITWEB_CONFIG and $GITWEB_CONFIG_SYSTEM are set and non-empty,
  but neither file exists (this means that $projects_list is set during
  build stage).

Current code deals correctly only with situation where either
$GITWEB_CONFIG or $GITWEB_CONFIG_SYSTEM exists, and it further assumes
that neither is undefined (you would get perl errors in case if either
is undefined).

> Why, why, why?
> 
> This is not even a "*** Warning ***".  You are refusing to let them do
> anything useful until they either flip the bit off or reinstall git and/or
> gitweb.  It is a _fatal error_ message.

Ooops.

> 
> To whom are you giving this _warning_?  Please read the message yourself
> again.

The original message (from "Gitweb caching v2" thread) was ment purely
for server administrator.  Current version tries to address both
ordinary user (which has to contact gitweb administrator) and gitweb
administrator (who needs to know how to remote error condition, either
by bringing git and gitweb versions in sync, or by changing
configuration).  And does it badly...

[...]
> So I have to ask a basic question I asked (at least I tried to) last night
> again.  Whom are you trying to help?
[...]

-- 
Jakub Narebski
Poland
ShadeHawk on #git
