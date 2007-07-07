From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats
Date: Sat, 07 Jul 2007 13:52:36 -0700
Message-ID: <7vir8w6inf.fsf@assigned-by-dhcp.cox.net>
References: <1183053733.6108.0.camel@mattlaptop2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt McCutchen <hashproduct@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 07 22:52:57 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7HGx-0002Hm-RQ
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 22:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273AbXGGUwj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 16:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbXGGUwj
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 16:52:39 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:45856 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbXGGUwh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 16:52:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070707205237.UHJQ1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 7 Jul 2007 16:52:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Lksc1X0091kojtg0000000; Sat, 07 Jul 2007 16:52:37 -0400
cc: jnareb@gmail.com, pasky@suse.cz, ltuikov@yahoo.com
In-Reply-To: <1183053733.6108.0.camel@mattlaptop2> (Matt McCutchen's message
	of "Thu, 28 Jun 2007 14:02:13 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51844>

Matt McCutchen <hashproduct@gmail.com> writes:

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index dbfb044..f36428e 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -101,6 +101,15 @@ our $mimetypes_file = undef;
>  # could be even 'utf-8' for the old behavior)
>  our $fallback_encoding = 'latin1';
>  
> +# information about snapshot formats that gitweb is capable of serving
> +# name => [mime type, filename suffix, --format for git-archive,
> +#          compressor command suffix]
> +our %known_snapshot_formats = (
> +	'tgz'  => ['application/x-gzip' , '.tar.gz' , 'tar', '| gzip' ],
> +	'tbz2' => ['application/x-bzip2', '.tar.bz2', 'tar', '| bzip2'],
> +	'zip'  => ['application/zip'    , '.zip'    , 'zip', ''       ],
> +);
> +
>  # You define site-wide feature defaults here; override them with
>  # $GITWEB_CONFIG as necessary.
>  our %feature = (
> @@ -131,20 +140,22 @@ our %feature = (
> ...
>  	'snapshot' => {
>  		'sub' => \&feature_snapshot,
>  		'override' => 0,
> -		#         => [content-encoding, suffix, program]
> -		'default' => ['x-gzip', 'gz', 'gzip']},
> +		'default' => ['tgz']},
>  
>  	# Enable text search, which will list the commits which match author,
>  	# committer or commit text to a given string.  Enabled by default.

This is a very nice clean-up, and I agree we should go this
route in the longer term.

This however will break people's existing gitweb configuration,
so if we were to do this it should be post 1.5.3, I would say.
