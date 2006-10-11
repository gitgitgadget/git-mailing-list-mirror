From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: Restore object-named links in item lists
Date: Wed, 11 Oct 2006 15:21:01 -0700 (PDT)
Message-ID: <20061011222101.36525.qmail@web31808.mail.mud.yahoo.com>
References: <20061011201812.26857.58295.stgit@rover>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 00:24:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXmSN-0001Yj-EY
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 00:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161570AbWJKWVH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 18:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161569AbWJKWVH
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 18:21:07 -0400
Received: from web31808.mail.mud.yahoo.com ([68.142.207.71]:14267 "HELO
	web31808.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161570AbWJKWVC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 18:21:02 -0400
Received: (qmail 36527 invoked by uid 60001); 11 Oct 2006 22:21:01 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Fveh6gGdhvD/96+67tPouZlIHdizy6avVKA0tIZWvXtbvl1D71pROJpOTuV7nn8PubbMZihkirQFUFEQVDo3BWDjAzVeDgr6nxAsyK89zlOXK8r0iUXGqLNibpZFO7zsfH5oVzggWZcN4LuNKAY3P3nWYARwV2jYol2kNkAQyFQ=  ;
Received: from [64.215.88.90] by web31808.mail.mud.yahoo.com via HTTP; Wed, 11 Oct 2006 15:21:01 PDT
To: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <20061011201812.26857.58295.stgit@rover>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28759>

--- Petr Baudis <pasky@suse.cz> wrote:
> This restores the redundant links removed earlier. It supersedes my patch
> to stick slashes to tree entries.

I NACK this, but it depends on Junio.

BTW, if you so much like to bring this back,
why don't you _revert_ the commit which removed them,
_resolve_, _commit_ and then submit that commit.

The reason is that we know that the original works
and here you're rewriting (untested as opposed
to the original) code.

NACK, I don't see the need for this.

But if this does go in, can you please remove the
"hidden" links so that _less_ identical code is left
to be maintained.  (I don't know anyone who's getting
paid to maintain gitweb, do you?)

   Luben

> 
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> ---
> 
>  gitweb/gitweb.perl |   42 ++++++++++++++++++++++++++++--------------
>  1 files changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a11fa38..d8298b9 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1785,18 +1785,20 @@ sub git_print_tree_entry {
>  					       file_name=>"$basedir$t->{'name'}", %base_key),
>  				 -class => "list"}, esc_html($t->{'name'})) . "</td>\n";
>  		print "<td class=\"link\">";
> +		print $cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
> +					     file_name=>"$basedir$t->{'name'}", %base_key)},
> +			      "blob");
>  		if ($have_blame) {
> -			print $cgi->a({-href => href(action=>"blame", hash=>$t->{'hash'},
> +			print " | " .
> +				$cgi->a({-href => href(action=>"blame", hash=>$t->{'hash'},
>  						     file_name=>"$basedir$t->{'name'}", %base_key)},
> -				      "blame");
> +					"blame");
>  		}
>  		if (defined $hash_base) {
> -			if ($have_blame) {
> -				print " | ";
> -			}
> -			print $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
> +			print " | " .
> +				$cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
>  			                             hash=>$t->{'hash'}, file_name=>"$basedir$t->{'name'}")},
> -			              "history");
> +					"history");
>  		}
>  		print " | " .
>  			$cgi->a({-href => href(action=>"blob_plain", hash_base=>$hash_base,
> @@ -1811,17 +1813,19 @@ sub git_print_tree_entry {
>  		              esc_html($t->{'name'}));
>  		print "</td>\n";
>  		print "<td class=\"link\">";
> +		print $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
> +					     file_name=>"$basedir$t->{'name'}", %base_key)},
> +			      "tree");
>  		if (defined $hash_base) {
> -			print $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
> +			print " | " .
> +				$cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
>  			                             file_name=>"$basedir$t->{'name'}")},
> -			              "history");
> -			if ($have_snapshot) {
> -				print " | ";
> -			}
> +					"history");
>  		}
>  		if ($have_snapshot) {
> -			print $cgi->a({-href => href(action=>"snapshot", hash=>$t->{'hash'})},
> -				      "snapshot");
> +			print " | " .
> +				$cgi->a({-href => href(action=>"snapshot", hash=>$t->{'hash'})},
> +					"snapshot");
>  		}
>  		print "</td>\n";
>  	}
> @@ -1902,6 +1906,9 @@ sub git_difftree_body {
>  				print $cgi->a({-href => "#patch$patchno"}, "patch");
>  				print " | ";
>  			}
> +			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
> +			                             hash_base=>$parent, file_name=>$diff{'file'})},
> +				      "blob") . " | ";
>  			print $cgi->a({-href => href(action=>"blame", hash_base=>$parent,
>  						     file_name=>$diff{'file'})},
>  				      "blame") . " | ";
> @@ -1947,6 +1954,9 @@ sub git_difftree_body {
>  				}
>  				print " | ";
>  			}
> +			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
> +						     hash_base=>$hash, file_name=>$diff{'file'})},
> +				      "blob") . " | ";
>  			print $cgi->a({-href => href(action=>"blame", hash_base=>$hash,
>  						     file_name=>$diff{'file'})},
>  				      "blame") . " | ";
> @@ -1987,6 +1997,9 @@ sub git_difftree_body {
>  				}
>  				print " | ";
>  			}
> +			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
> +						     hash_base=>$parent, file_name=>$diff{'from_file'})},
> +				      "blob") . " | ";
>  			print $cgi->a({-href => href(action=>"blame", hash_base=>$parent,
>  						     file_name=>$diff{'from_file'})},
>  				      "blame") . " | ";
> @@ -2154,6 +2167,7 @@ sub git_shortlog_body {
>  		                          href(action=>"commit", hash=>$commit), $ref);
>  		print "</td>\n" .
>  		      "<td class=\"link\">" .
> +		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") . " | " .
>  		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") . " | " .
>  		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree");
>  		if (gitweb_have_snapshot()) {
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
