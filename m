From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/6] GITWEB - Load Checking
Date: Thu, 10 Dec 2009 16:52:22 -0800 (PST)
Message-ID: <m34onye3h8.fsf@localhost.localdomain>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
	<1260488743-25855-2-git-send-email-warthog9@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: "John 'Warthog9' Hawley" <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 11 01:52:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NItkE-0007aq-IP
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 01:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758005AbZLKAwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 19:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757287AbZLKAwR
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 19:52:17 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:58284 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755750AbZLKAwR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 19:52:17 -0500
Received: by fxm21 with SMTP id 21so523759fxm.1
        for <git@vger.kernel.org>; Thu, 10 Dec 2009 16:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=UV5WHQj9uB9oVR30zFxpS8aGIsRYYRq3VyRy8ZayoTM=;
        b=tnOMNWDPimbvcFvmYr6xyUR8NQgvB2gOzC5Y44fMeiywozL0WAxDm5iazwX/FtxRoB
         ALAmorgkDRhkMWWpUs56FPXG/OSTTKKy8nNoPdb5oDaHgmekBT4ZCf0vgjHd7/b92iIn
         uxi2uOmS0kpaX2XqI/daVuf6+AWNpPcSzm+Cg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=WpCaxnfPfa54QjoBAxFZdoZLBZAgvXTUczNRg47kBgrc2x9/WSw0Oul7qRQqe4/3XL
         76cBmmq9Oz2Nlasd8T0SMZjoSXHgzy9cY5njJMNH0yY04aytyKjNVxno3hknPY/vL4nP
         VI8lCEn1qiJxUz/o114gM3f81uO64o0OEU1EA=
Received: by 10.223.101.152 with SMTP id c24mr600641fao.95.1260492742691;
        Thu, 10 Dec 2009 16:52:22 -0800 (PST)
Received: from localhost.localdomain (abvy165.neoplus.adsl.tpnet.pl [83.8.222.165])
        by mx.google.com with ESMTPS id e17sm2114343fke.53.2009.12.10.16.52.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Dec 2009 16:52:22 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nBB0rFUQ025624;
	Fri, 11 Dec 2009 01:53:25 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nBB0qpZI025616;
	Fri, 11 Dec 2009 01:52:51 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1260488743-25855-2-git-send-email-warthog9@kernel.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135062>

"John 'Warthog9' Hawley" <warthog9@kernel.org> writes:

> This changes the behavior, slightly, of gitweb so that it verifies
> that the box isn't inundated with before attempting to serve gitweb.
> If the box is overloaded, it basically returns a 503 server unavailable
> until the load falls below the defined threshold.  This helps dramatically
> if you have a box that's I/O bound, reaches a certain load and you
> don't want gitweb, the I/O hog that it is, increasing the pain the
> server is already undergoing.
> 
> adds $maxload configuration variable.  Default is a load of 300,
> which for most cases should never be hit.

Your patch doesn't allow for *turning off* this feature.  Reasonable
solution would be to use 'undef' or negative number to turn off this
check (this feature).

> 
> Please note this makes the assumption that /proc/loadavg exists
> as there is no good way to read load averages on a great number of
> platforms [READ: Windows], or that it's reasonably accurate.

What about MacOS X, or FreeBSD, or OpenSolaris?

You should mention that it is intended that if gitweb cannot read load
average (for example /proc/loadavg does not exist), then the feature
is turned off, i.e. the check always succeeds.  Which is reasonable.

> 
> Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>

Why signoff is different from author (warthog9@kernel.org)?  Why this
email for signoff?  Just curious...

> ---
>  gitweb/gitweb.perl |   24 ++++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-) 

Please post patches inline, not as attachement.

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7e477af..813e48f 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -221,6 +221,11 @@ our %avatar_size = (
>  	'double'  => 32
>  );
>  
> +# Used to set the maximum load that we will still respond to gitweb queries.
> +# if we exceed this than we do the processing to figure out if there's a mirror
> +# and redirect to it, or to just return 503 server busy

I'd probably say:

+# Used to set the maximum load that we will still respond to gitweb queries.
+# If server load exceed this value then return "503 server busy" error,
+# (it is also possible to redirect to mirror, if it exists, instead).

> +our $maxload = 300;
> +
>  # You define site-wide feature defaults here; override them with
>  # $GITWEB_CONFIG as necessary.
>  our %feature = (
> @@ -551,6 +556,25 @@ if (-e $GITWEB_CONFIG) {
>  	do $GITWEB_CONFIG_SYSTEM if -e $GITWEB_CONFIG_SYSTEM;
>  }
>  
> +# loadavg throttle
> +sub get_loadavg() {
> +    my $load;
> +    my @loads;
> +
> +    open($load, '<', '/proc/loadavg') or return 0;

Why not use one of existing CPAN modules: Sys::Info::Device::CPU,
BSD::getloadavg, Sys::CpuLoad?

Style:

+    open (my $load, '<', '/proc/loadavg') or return 0;

and of course no "my $load" at beginning.  Also perhaps $fh, or
$loadfh instead of $load?  But this is a minor nit.

> +    @loads = split(/\s+/, scalar <$load>);
> +    close($load);
> +    return $loads[0];
> +}
> +
> +if (get_loadavg() > $maxload) {
> +    print "Content-Type: text/plain\n";
> +    print "Status: 503 Excessive load on server\n";
> +    print "\n";
> +    print "The load average on the server is too high\n";
> +    exit 0;

Why not use die_error subroutine?  Is it to have generate absolutely
minimal load, and that is why you do not use die_error(), or even
$cgi->header()?

Wouldn't a better solution be to use here-doc syntax?

+    print <<'EOF';
+Content-Type: text/plain; charset=utf-8
+Status: 503 Excessive load on server
+
+The load average on the server is too high
+EOF
+    exit 0;


> +}
> +
>  # version of the core git binary
>  our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
>  $number_of_git_cmds++;

-- 
Jakub Narebski
Poland
ShadeHawk on #git
