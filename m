From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 2/2 (version C)] gitweb: Introduce common system-wide settings for convenience
Date: Thu, 26 May 2011 16:58:17 +0200
Message-ID: <201105261658.20140.jnareb@gmail.com>
References: <1306341328-11108-1-git-send-email-jnareb@gmail.com> <1306341328-11108-4-git-send-email-jnareb@gmail.com> <7v8vtu4nmy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Drew Northup <drew.northup@maine.edu>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 16:58:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPc1G-00048R-EB
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 16:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757774Ab1EZO6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 10:58:33 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43734 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab1EZO6c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 10:58:32 -0400
Received: by bwz15 with SMTP id 15so498458bwz.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 07:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=rSr/pulTAHnmFQzGgcksCJtljCIYsCLnPCQjFEsKIQs=;
        b=nNdE682Gv4ofERKVXxWIPVqo0fEe8D42rf99b/MJlW2B1Lnl7vEtqb7V1ic+r6Yv2d
         Pz3wOhyeZAw5jUWEArJm7AR8GrrWszfuX3aes9WIDiSOGLa9Dy4A5oXYpyH+9RN/Ik+b
         91S7PIniRdyTJZp8FSBDDK4mSi8HK8Yk0bPxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=rXlJLdbppJ5c8rdY/oF7Cu6tb+G3MXkCvXe8RSRWGBWdWpkhkPh4uIGn5IhAPj+WgV
         562YtFmgZOzhOBd+lfqNDrnf1FRZBWBpCm6yCZAHUddmI9AFyBCq9rycAfn37kpBsfAd
         2zXFzdN1P4P/zB1UFa7IshMtPAcNiSaM7aeqw=
Received: by 10.204.35.18 with SMTP id n18mr715635bkd.91.1306421910875;
        Thu, 26 May 2011 07:58:30 -0700 (PDT)
Received: from [192.168.1.13] (abwq7.neoplus.adsl.tpnet.pl [83.8.240.7])
        by mx.google.com with ESMTPS id af13sm539857bkc.7.2011.05.26.07.58.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 May 2011 07:58:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v8vtu4nmy.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174517>

Because of backward compatibility we cannot change gitweb to always
use /etc/gitweb.conf (i.e. even if gitweb_config.perl exists).  For
common system-wide settings we therefore need new configuration
file: /etc/gitweb-common.conf.


Long description:

gitweb currently obtains configuration from the following sources:

  1. per-instance configuration file (default: gitweb_conf.perl)
  2. system-wide configuration file (default: /etc/gitweb.conf)

If per-instance configuration file exists, then system-wide
configuration is _not used at all_.  This is quite untypical and
suprising behavior.

Moreover it is different from way git itself treats /etc/git.conf.  It
reads in stuff from /etc/git.conf and then local repos can change or
override things as needed.  In fact this is quite beneficial, because
it gives site admins a simple and easy way to give an automatic hint
to a repo about things the admin would like.

On the other hand changing current behavior may lead to the situation,
where something in /etc/gitweb.conf may interfere with unintended
interaction in the local repository.  One solution would be to
_require_ to do explicit include; with read_config_file() it is now
easy, as described in gitweb/README (description introduced in this
commit).

But as J.H. noticed we cannot ask people to modify their per-instance
gitweb config file to include system-wide settings, nor we can require
them to do this.

Therefore, as proposed by Junio, for gitweb to have centralized config
elements while retaining backwards compatibility, introduce separate
common system-wide configuration file, by default /etc/gitweb-common.conf

Noticed-by: Drew Northup <drew.northup@maine.edu>
Helped-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Inspired-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
On Wed, 25 May 2011, Junio C Hamano <gitster@pobox.com> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > This commit should be thought as exclusive to
> >
> >   [PATCH 2/2 (version A)] gitweb: Mention read_config_file in gitweb/README
> >
> > We have to choose one or the other.
> 
> Who says?  We do not have to.  Why not do this instead?
> 
> 	our $GITWEB_CONFIG_COMMON = $ENV{'GITWEB_CONFIG_COMMON'} ||
> 		"/etc/gitweb-common.conf";
> 
> 	# common system-wide settings for convenience
>         read_config_file($GITWEB_COMMON);
> 
>         # as always, use the per-instance GITWEB_CONFIG if exists,
>         # otherwise use GITWEB_SYSTEM_CONFIG
>         read_config_file($GITWEB_CONFIG) ||
>         	read_config_file($GITWEB_CONFIG_SYSTEM);
> 
> There is no risk of hurting any existing installations, and people who do
> have things that needs to be shared do not have to go around and update
> all the per-instance configuration files.

Here it is, version C.

It is currently marked as RFC for the following (minor) reasons:

1. In gitweb.perl we now have

  +	# Protect against duplications of file names, to not read config twice.
  +	# Only one of $GITWEB_CONFIG and $GITWEB_CONFIG_SYSTEM is used, so
  +	# there possibility of duplication of filename doesn't matter.
  +	$GITWEB_CONFIG = ""        if ($GITWEB_CONFIG eq $GITWEB_CONFIG_COMMON);
  +	$GITWEB_CONFIG_SYSTEM = "" if ($GITWEB_CONFIG_SYSTEM eq $GITWEB_CONFIG_COMMON);

to protect against double inclusion of configuration files.  It is
necessary?  Should we protect against such user errors?  Note that in
most cases second include wouldn't matter anyway...


2. To use first of per-instance and system wide configuration files we
now have in gitweb.perl

  	read_config_file($GITWEB_CONFIG) and return;
   	read_config_file($GITWEB_CONFIG_SYSTEM);

Is it more readable than

  	read_config_file($GITWEB_CONFIG) or
   	read_config_file($GITWEB_CONFIG_SYSTEM);

or correctly indented

  	read_config_file($GITWEB_CONFIG) or
   		read_config_file($GITWEB_CONFIG_SYSTEM);

or even

  	read_config_file($GITWEB_CONFIG)
		or
   			read_config_file($GITWEB_CONFIG_SYSTEM);


3. In includes changes to documentation, but does not include new
tests.  Should it?

 gitweb/INSTALL     |   13 ++++++++++++-
 gitweb/Makefile    |    2 ++
 gitweb/README      |   27 ++++++++++++++++++++++++---
 gitweb/gitweb.perl |   18 +++++++++++++++---
 4 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 4964a67..a29ad0c 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -98,7 +98,7 @@ Gitweb config file
 See also "Runtime gitweb configuration" section in README file
 for gitweb (in gitweb/README).
 
-- You can configure gitweb further using the gitweb configuration file;
+- You can configure gitweb further using the per-instance gitweb configuration file;
   by default this is a file named gitweb_config.perl in the same place as
   gitweb.cgi script. You can control the default place for the config file
   using the GITWEB_CONFIG build configuration variable, and you can set it
@@ -108,6 +108,17 @@ for gitweb (in gitweb/README).
   GITWEB_CONFIG_SYSTEM build configuration variable, and override it
   through the GITWEB_CONFIG_SYSTEM environment variable.
 
+  Note that if per-instance configuration file exists, then system-wide
+  configuration is _not used at all_.  This is quite untypical and suprising
+  behavior.  On the other hand changing current behavior would break backwards
+  compatibility and can lead to unexpected changes in gitweb behavior.
+  Therefore gitweb also looks for common system-wide configuration file,
+  normally /etc/gitweb-common.conf (set during build time using build time
+  configuration variable GITWEB_CONFIG_COMMON, set it at runtime using
+  environment variable with the same name).  Settings from per-instance or
+  system-wide configuration file override those from common system-wide
+  configuration file.
+
 - The gitweb config file is a fragment of perl code. You can set variables
   using "our $variable = value"; text from "#" character until the end
   of a line is ignored. See perlsyn(1) for details.
diff --git a/gitweb/Makefile b/gitweb/Makefile
index 5d20515..1c85b5f 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -20,6 +20,7 @@ INSTALL ?= install
 # default configuration for gitweb
 GITWEB_CONFIG = gitweb_config.perl
 GITWEB_CONFIG_SYSTEM = /etc/gitweb.conf
+GITWEB_CONFIG_COMMON = /etc/gitweb-common.conf
 GITWEB_HOME_LINK_STR = projects
 GITWEB_SITENAME =
 GITWEB_PROJECTROOT = /pub/git
@@ -129,6 +130,7 @@ GITWEB_REPLACE = \
 	-e 's|++GIT_BINDIR++|$(bindir)|g' \
 	-e 's|++GITWEB_CONFIG++|$(GITWEB_CONFIG)|g' \
 	-e 's|++GITWEB_CONFIG_SYSTEM++|$(GITWEB_CONFIG_SYSTEM)|g' \
+	-e 's|++GITWEB_CONFIG_COMMON++|$(GITWEB_CONFIG_COMMON)|g' \
 	-e 's|++GITWEB_HOME_LINK_STR++|$(GITWEB_HOME_LINK_STR)|g' \
 	-e 's|++GITWEB_SITENAME++|$(GITWEB_SITENAME)|g' \
 	-e 's|++GITWEB_PROJECTROOT++|$(GITWEB_PROJECTROOT)|g' \
diff --git a/gitweb/README b/gitweb/README
index a92bde7..8743471 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -124,9 +124,30 @@ You can specify the following configuration variables when building GIT:
 Runtime gitweb configuration
 ----------------------------
 
-You can adjust gitweb behaviour using the file specified in `GITWEB_CONFIG`
-(defaults to 'gitweb_config.perl' in the same directory as the CGI), and
-as a fallback `GITWEB_CONFIG_SYSTEM` (defaults to /etc/gitweb.conf).
+Gitweb obtains configuration data from the following sources in the
+following order:
+
+1. built-in values (some set during build stage),
+2. common system-wide configuration file (`GITWEB_CONFIG_COMMON`,
+   defaults to '/etc/gitweb-common.conf'),
+3. either per-instance configuration file (`GITWEB_CONFIG`, defaults to
+   'gitweb_config.perl' in the same directory as the installed gitweb),
+   or if it does not exists then system-wide configuration file
+   (`GITWEB_CONFIG_SYSTEM`, defaults to '/etc/gitweb.conf').
+
+Values obtained in later configuration files override values obtained earlier
+in above sequence.
+
+You can read defaults in system-wide GITWEB_CONFIG_SYSTEM from GITWEB_CONFIG
+by adding
+
+  read_config_file($GITWEB_CONFIG_SYSTEM);
+
+at very beginning of per-instance GITWEB_CONFIG file.  In this case
+settings in said per-instance file will override settings from
+system-wide configuration file.  Note that read_config_file checks
+itself that the $GITWEB_CONFIG_SYSTEM file exists.
+
 The most notable thing that is not configurable at compile time are the
 optional features, stored in the '%features' variable.
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ce92d67..25a2618 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -651,13 +651,25 @@ sub read_config_file {
 	return;
 }
 
-our ($GITWEB_CONFIG, $GITWEB_CONFIG_SYSTEM);
+our ($GITWEB_CONFIG, $GITWEB_CONFIG_SYSTEM, $GITWEB_CONFIG_COMMON);
 sub evaluate_gitweb_config {
 	our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
 	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
+	our $GITWEB_CONFIG_COMMON = $ENV{'GITWEB_CONFIG_COMMON'} || "++GITWEB_CONFIG_COMMON++";
 
-	# use first config file that exists
-	read_config_file($GITWEB_CONFIG) or
+	# Protect against duplications of file names, to not read config twice.
+	# Only one of $GITWEB_CONFIG and $GITWEB_CONFIG_SYSTEM is used, so
+	# there possibility of duplication of filename doesn't matter.
+	$GITWEB_CONFIG = ""        if ($GITWEB_CONFIG eq $GITWEB_CONFIG_COMMON);
+	$GITWEB_CONFIG_SYSTEM = "" if ($GITWEB_CONFIG_SYSTEM eq $GITWEB_CONFIG_COMMON);
+
+	# Common system-wide settings for convenience.
+	# Those settings can be ovverriden by GITWEB_CONFIG or GITWEB_CONFIG_SYSTEM.
+	read_config_file($GITWEB_CONFIG_COMMON);
+
+	# Use first config file that exists.  This means use the per-instance
+	# GITWEB_CONFIG if exists, otherwise use GITWEB_SYSTEM_CONFIG.
+	read_config_file($GITWEB_CONFIG) and return;
 	read_config_file($GITWEB_CONFIG_SYSTEM);
 }
 
-- 
1.7.5
