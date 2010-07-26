From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/24] Documentation: Add variable-substitution script
Date: Mon, 26 Jul 2010 14:17:57 -0700 (PDT)
Message-ID: <m3wrsikkol.fsf@localhost.localdomain>
References: <cover.1280169048.git.trast@student.ethz.ch>
	<049043aa444288fd9409a3706fe3190fd679cb7d.1280169048.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	=?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 26 23:18:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdV3o-0004aM-4O
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 23:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877Ab0GZVSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 17:18:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63398 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689Ab0GZVSA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 17:18:00 -0400
Received: by fxm14 with SMTP id 14so327139fxm.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 14:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=6aNWbpEuYkWJxdIiM6BeUahPEs2ZW+MHsMWqbO81bvg=;
        b=G3B6jgDG0ymS1ZmGBfvFX7PSKXtRqwCbLSxPQBNktZ5ucUd61rif/DLr9fgqI5qIt1
         jyblJ4EP03vzfliOiONAmEBgZbs39nZ7Swi/yNwQWL5f5FqGlt9l5WZqaQFToIC6DiWC
         yQdAYvhwPA4+fsrqU6Nr5a4o2oBG/zCOTMWMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=BeEop++xQ+qYpipHGEwCMBVgNys911eXAWZg7LDIzm0yWWGcJx72BtfwlCeFStyQzd
         qy0OFZag6p0gKPnfbYIo2iICMReLdJptvRn34ErI5i6r8+1vE+B8MgyIEBh80CjvyWJy
         2/ZJ0YfLrvA0rthvWV/WNXvvBQtVlu9iRzcBA=
Received: by 10.223.122.195 with SMTP id m3mr6962259far.86.1280179078551;
        Mon, 26 Jul 2010 14:17:58 -0700 (PDT)
Received: from localhost.localdomain (abwn25.neoplus.adsl.tpnet.pl [83.8.237.25])
        by mx.google.com with ESMTPS id 14sm1603432fav.26.2010.07.26.14.17.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 14:17:57 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o6QLHL05018760;
	Mon, 26 Jul 2010 23:17:32 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o6QLGxcQ018755;
	Mon, 26 Jul 2010 23:16:59 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <049043aa444288fd9409a3706fe3190fd679cb7d.1280169048.git.trast@student.ethz.ch>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151896>

Thomas Rast <trast@student.ethz.ch> writes:

> diff --git a/Documentation/subst-config.perl b/Documentation/subst-config.perl
> new file mode 100755
> index 0000000..a981670
> --- /dev/null
> +++ b/Documentation/subst-config.perl
> @@ -0,0 +1,74 @@
> +#!/usr/bin/perl
> +use 5.006002;
> +use strict;
> +use warnings;
> +use Getopt::Long;
> +
> +Getopt::Long::Configure qw/ pass_through /;
> +
> +my $rc = GetOptions(
> +    "varlist=s" => \my $varlist,
> +    "input=s"   => \my $input,
> +    "output=s"  => \my $output,
> +);
> +
> +if (!$rc or (!-r $varlist or !-r $input)) {
> +    print "$0 --varlist=<varlist> --input=<in> --output=<out>\n";
> +    exit 1;
> +}
> +
> +my $vars = read_varlist($varlist);                       # [1]
> +substitute_variables($vars, $input, $output);            # [2]
> +exit 0;
> +
> +sub read_varlist {
> +    my ($file) = @_;
> +
> +    open my $fh, "<", $varlist or die "cannot open $varlist: $!";

NITPICK

You are passing global variable $varlist to this function as parameter
$file, see place marked [1].  Why don't you use there $file instead of
$varlist?  Alternatively, why don't you name parameter as $varlist?

> +sub substitute_variables {
> +    my ($varlist, $in, $out) = @_;
> +
> +    open my $infh, "<", $input or die "Can't open $in for reading: $!";
> +    open my $outfh, ">", $output or die "Can't open $out for reading: $!";

Same here: $input or $in, $output or $out?

> +
> +    while (<$infh>) {
> +        if (/^\@\@CONFIG\((\S+)\)\@\@$/) {
> +            my $v = lc $1;
> +            die "Key $v not documented" unless exists $varlist->{$v};
> +            print $outfh @{$varlist->{$v}};
> +            print $outfh "\n";
> +        } else {
> +            print $outfh $_;
> +        }
> +    }
> +
> +    close $infh or die "closing input failed: $!";
> +    close $outfh or die "closing output failed: $!";
> +
> +    return;
> +}

Also, could you consitently start error messages (in die "sth") with
capital letter (upper-case), or with lower-case letter?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
