From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] gitweb: standarize HTTP status codes
Date: Wed, 18 Jun 2008 17:51:38 -0700 (PDT)
Message-ID: <m3y752melj.fsf_-_@localhost.localdomain>
References: <1213564515-14356-1-git-send-email-LeWiemann@gmail.com>
	<1213748115-4038-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 02:52:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K98OK-0002Az-Nl
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 02:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756866AbYFSAvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 20:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756796AbYFSAvo
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 20:51:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:17492 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887AbYFSAvm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 20:51:42 -0400
Received: by ug-out-1314.google.com with SMTP id h2so882657ugf.16
        for <git@vger.kernel.org>; Wed, 18 Jun 2008 17:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=BeC5V9ANm1wxynH6cSmkjQkgw2fjrBHfsNA/499+XDk=;
        b=D9BxE3K7VyZ5HUn14gNPBUUxBBi4KIWf13bniggBLRA10AwjfMmvF1t/wZtk89JShV
         xDQdOBG98mM08Whs05PY0G8+dbIwIcyWJSdHoUpf35T8JKlWoOskFrEWV+ZZX9o0s4Sa
         IVLc9uZoS4L0vait5nbb0EMlyFFDXttbdrbl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=h47O7H63JS+OEiIzBNkWdspRzf6dVKaKxW2wF+1j77ZvQTrbODouCuM2ad1aYse8ou
         +yBX6IBjseJe6oF/24uQmb3rJujbj0WQzdSR9bQD3yNESNpTBBlADrAog/DkhBv4v7on
         TDfNaQGciNoo6AXGxZxVV8p9M3/uQzqGDT4dI=
Received: by 10.210.52.9 with SMTP id z9mr1258094ebz.139.1213836699859;
        Wed, 18 Jun 2008 17:51:39 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.255.188])
        by mx.google.com with ESMTPS id c24sm14212889ika.4.2008.06.18.17.51.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Jun 2008 17:51:38 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5J0pciu013884;
	Thu, 19 Jun 2008 02:51:38 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5J0pb7x013881;
	Thu, 19 Jun 2008 02:51:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1213748115-4038-1-git-send-email-LeWiemann@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85437>

Lea Wiemann <lewiemann@gmail.com> writes:

> Many error status codes simply default to 403 Forbidden, which is not
> correct in most cases.  This patch makes gitweb return semantically
> correct status codes.

O.K.

> For convenience the die_error function now only takes the status code
> without reason as first parameter (e.g. 404 instead of "404 Not
> Found"), and it now defaults to 500 (Internal Server Error), even
> though the default is not used anywhere.

_Whose_ convenience?

IMHO using "bare" status code is bad idea for the following reasons:

 * I don't think that RFC 2616 allows blanket replacing reason phrase
   by generic "Error", as I don't think that for example "Error" is
   'local equivalent' of "Not Found" for 404 client error.  And even
   if it would allow it, I don't think it is best / recommended
   practice.

   If the fragment cited below isn't what you mean by "RFC 2616 allows
   this" please point me out to the fragment that states this.

   > +	# Use a generic "Error" reason, e.g. "404 Error" instead of
   > +	# "404 Not Found".  This is permissible by RFC 2616.
   > +	git_header_html("$status Error");


 * Test::WWW::Mechanize displays both HTTP error status code and
   reason phrase when get_ok(...) fails:

   not ok 18 - GET http://localhost/?p=non-existent.git
   #   Failed test 'GET http://localhost/?p=non-existent.git
   #   at ../t9503/test.pl line 105.
   # 403
   # Forbidden

   It does not display error _page_, so it helps if reason phrase
   explains the error.


 * From the point of view of someone examinimg gitweb.perl code, 400,
   403, 404, 500 are _magic numbers_; one would have to take a look at
   RFC 2616 (or Wikipedia) to check what given number means.  It is
   much more readable to have e.g. '404 Not Found' there.


Posible solution would be to use constants similar to the ones in
HTTP::Status (but best without requiring this module, as it might be
not present), for example HTTP_OK, HTTP_INVALID, HTTP_FORBIDDEN,
HTTP_NOT_FOUND, HTTP_SERVER_ERROR or similar (HTTP::Status uses
RC_OK (200), RC_BAD_REQUEST (400), RC_FORBIDDEN (403),
RC_NOT_FOUND (404), RC_INTERNAL_SERVER_ERROR (500)).

..................................................................
Relevant fragment of RFC 2616 (http://tools.ietf.org/html/rfc2616)

  6.1.1 Status Code and Reason Phrase

     The Status-Code element is a 3-digit integer result code of the
     attempt to understand and satisfy the request. These codes are
     fully defined in section 10. The Reason-Phrase is intended to
     give a short textual description of the Status-Code. The
     Status-Code is intended for use by automata and the Reason-Phrase
     is intended for the human user. The client is not required to
     examine or display the Reason-Phrase.

     [...]

     (...) The reason phrases listed here are only recommendations --
     they MAY be replaced by local equivalents without affecting the
     protocol.
..................................................................

> Also documented status code conventions in die_error.

Putting copy of those status code conventions in the commit message,
and not only in the comment section, would be also good idea.

> Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
> ---
> Changes since v1:

Would be better to change subject to contain "[PATCH v2]", too?
 
> - Changed subject per Jakub's suggestion.

It was just suggestion.  IMVHO current version reads better, but again
I am not a native English speaker.

> - Resolved merge conflict caused by "[PATCH v2] gitweb: quote commands
>   properly when calling the shell".
> - Added the following documentation to die_error (I know Jakub might
>   disagree with me on the last line ;-)):

No, I won't disagree.  "403 Forbidden" is bad catch-all, and bad
default.  "404 Not Found" or "500 Internal Server Error" are much
better default values.

> # die_error(<http_status_code>, <error_message>)
> # Example: die_error(404, 'Hash not found')

As I mentioned above, I'd rather have
  # Example: die_error(HTTP_NOT_FOUND, 'Hash not found')
here, where HTTP_NOT_FOUND is expanded to '404 Not Found'.

> # By convention, use the following status codes (as defined in RFC 2616):
> # 400: Invalid or missing CGI parameters, or
> #      requested object exists but has wrong type.
> # 403: Requested feature (like "pickaxe" or "snapshot") not enabled on
> #      this server or project.
> # 404: Requested object/revision/project doesn't exist.

Note that all above 4xx client errors make one look at URL to check if
it is correct in the case of errors.

> # 500: The server isn't configured properly, or
> #      an internal error occurred (e.g. failed assertions caused by bugs), or
> #      an unknown error occurred (e.g. the git binary died unexpectedly).

Note that all 5xx server errors make one search for webmaster /
network administrator email (or other contact info, like IM or contact
form) to notify about error.
 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 3a7adae..3ca45fd 100755
[...]
> @@ -399,21 +399,21 @@ if (defined $project) {
>  	    ($export_ok && !(-e "$projectroot/$project/$export_ok")) ||
>  	    ($strict_export && !project_in_list($project))) {
>  		undef $project;
> -		die_error(undef, "No such project");
> +		die_error(404, "No such project");
>  	}
>  }

Here is one thing worth considering: if project exists, but is
excluded due to either $export_ok or $strict_export being set,
should we use '404 Not Found' or '403 Forbidden'?

It is easier to use catch-all '404 Not Found', and I think this is
better for security reason, but I guess that is worth thinking about a
bit.

> @@ -483,7 +483,7 @@ our $searchtext = $cgi->param('s');
>  our $search_regexp;
>  if (defined $searchtext) {
>  	if (length($searchtext) < 2) {
> -		die_error(undef, "At least two characters are required for search parameter");
> +		die_error(403, "At least two characters are required for search parameter");
>  	}
>  	$search_regexp = $search_use_regexp ? $searchtext : quotemeta $searchtext;
>  }

Should gitweb use there '403 Forbidden', or '400 Bad Request'?
This is failing static validation of CGI parameters, not a matter of
some permissions...


> @@ -1665,7 +1665,7 @@ sub git_get_hash_by_path {
>  	$path =~ s,/+$,,;
>  
>  	open my $fd, "-|", git_cmd(), "ls-tree", $base, "--", $path
> -		or die_error(undef, "Open git-ls-tree failed");
> +		or die_error(500, "Open git-ls-tree failed");
>  	my $line = <$fd>;
>  	close $fd or return undef;
>

I'm sorry for my mistake in earlier email.

*All* "open ... or die_error" constructs should use '500 Internal
Server Error', as the only errors that can be detected on open are
very serious, server related ones: cannot find git binaries, git
binaries doesn't have executable permissions for web server, number of
available filehandles exceeded, cannot fork (because of limits), etc.

All of those are result of error on the server side, not the client
mangling URL or something like that.

> +	# Use a generic "Error" reason, e.g. "404 Error" instead of
> +	# "404 Not Found".  This is permissible by RFC 2616.
> +	git_header_html("$status Error");

See comments above.  In short: I don't think it is permissible, if it
is permissible I don't think it is recommended practice, if it is
common practice I don't think this is a good idea for gitweb.
  
> -	my ($have_blame) = gitweb_check_feature('blame');
> -	if (!$have_blame) {
> -		die_error('403 Permission denied', "Permission denied");
> -	}
> -	die_error('404 Not Found', "File name not defined") if (!$file_name);
> +	gitweb_check_feature('blame')
> +	    or die_error(403, "Blame not allowed");

That is a bit separate change, i.e. better explanation of an error
(although I'd say rather "Blame view not allowed").

But what about security reasons?

> -	die_error(undef, "Couldn't find base commit") unless ($hash_base);
> +	die_error(400, "Couldn't find base commit") unless ($hash_base);

Wound't it be '404 Not Found', as the explanation suggests?

>  	my %co = parse_commit($hash_base)
> -		or die_error(undef, "Reading commit failed");
> +		or die_error(404, "Commit not found");

Good!

>  	$/ = "\0";
>  	open my $fd, "-|", git_cmd(), "ls-tree", '-z', $hash
> -		or die_error(undef, "Open git-ls-tree failed");
> +		or die_error(500, "Open git-ls-tree failed");

O.K.

>  	my @entries = map { chomp; $_ } <$fd>;
> -	close $fd or die_error(undef, "Reading tree failed");
> +	close $fd or die_error(500, "Reading tree failed");
>  	$/ = "\n";

Not O.K.  Barring errors in gitweb code this might happen when object
given by CGI parameters does not exist ('fatal: Not a valid object
name foo'), project does not exist ('fatal: Not a git repository:
project'), or the object is not a tree-ish ('fatal: not a tree
object').  All those are clearly 4xx _client_ errors, and perhaps with
the exception of last one which could be '400 Bad Request', all are of
the '404 Nof Found'; but '404 Not FOund' is good also for the last
reason, so for simplicity catch-all '404 Not Found' would be best.

One should examine URL for mistakes, not contact server admin here...

>  sub git_commit {
>  	$hash ||= $hash_base || "HEAD";
> -	my %co = parse_commit($hash);
> -	if (!%co) {
> -		die_error(undef, "Unknown commit object");
> -	}
> +	my %co = parse_commit($hash)
> +	    or die_error(404, "Unknown commit object");

Good, although if it makes code more readable or not is a matter of
taste.

> -	close $fd or die_error(undef, "Reading git-diff-tree failed");
> +	close $fd or die_error(500, "Reading git-diff-tree failed");

Again, this is ussually 4xx client error, and one should examine URL
for mistakes, not contact server admin.
  
>  	} else {
> -		die_error('404 Not Found', "Not enough information to find object");
> +		die_error(400, "Not enough information to find object");
>  	}

I'm not sure if it should be '400 Bad Request' or '404 Not Found'
here.  RFC 2616 states:

  10.4.5 404 Not Found

     (...) This status code is commonly used when the server does not
     wish to reveal exactly why the request has been refused, or when
     no other response is applicable.

so I guess '404' _might_ be better here.  But this is IMVHO a matter
of taste here, a bit.


>  			close $fd
> -				or die_error(undef, "Reading git-diff-tree failed");
> +				or die_error(500, "Reading git-diff-tree failed");

Again, I think it is usually 4xx client error, i.e. '404 Nof Found'
and not '500 Internal Sever Error' should be used here.

>  			@difftree
> -				or die_error('404 Not Found', "Blob diff not found");
> +				or die_error(404, "Blob diff not found");

This, if I am not mistaken, can happen only if path limiters doesn'
catch anything.
 

>  			close $fd
> -				or die_error(undef, "Reading git-diff-tree failed");
> +				or die_error(500, "Reading git-diff-tree failed");

And again...

>  		} else {
> -			die_error('404 Not Found', "Missing one of the blob diff parameters");
> +			die_error(400, "Missing one of the blob diff parameters");
>  		}

O.K. here.

>  		if (@difftree > 1) {
> -			die_error('404 Not Found', "Ambiguous blob diff specification");
> +			die_error(400, "Ambiguous blob diff specification");
>  		}

Or perhaps '404 Not Dound' here?
 
>  	} else  {
> -		die_error('404 Not Found', "Missing one of the blob diff parameters")
> +		die_error(400, "Missing one of the blob diff parameters")
>  			unless %diffinfo;
>  	}

The "unless %diffinfo" makes it look more like '404 Not Found'...
  
>  	if (!defined $ftype) {
> -		die_error(undef, "Unknown type of object");
> +		die_error(500, "Unknown type of object");
>  	}

Errr... shouldn't be '400 Bad Request' here, per convention?
  
> -		my ($have_pickaxe) = gitweb_check_feature('pickaxe');
> -		if (!$have_pickaxe) {
> -			die_error('403 Permission denied', "Permission denied");
> -		}
> +		gitweb_check_feature('pickaxe')
> +		    or die_error(403, "Pickaxe is disabled");

"Pickaxe" is git jargon... (just mentioning it).

> @@ -5484,7 +5481,7 @@ sub git_feed {
>  	# Atom: http://www.atomenabled.org/developers/syndication/
>  	# RSS:  http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
>  	if ($format ne 'rss' && $format ne 'atom') {
> -		die_error(undef, "Unknown web feed format");
> +		die_error(400, "Unknown web feed format");
>  	}

That is a good example of unambiguously '400 Bad Request'.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
