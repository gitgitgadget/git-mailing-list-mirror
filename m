From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: Restore object-named links in item lists
Date: Tue, 24 Oct 2006 01:38:34 -0700 (PDT)
Message-ID: <569338.82223.qm@web31805.mail.mud.yahoo.com>
References: <20061024033610.7959.4028.stgit@rover>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 10:38:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcHoA-0000yS-D8
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 10:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbWJXIig (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 04:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbWJXIig
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 04:38:36 -0400
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:18826 "HELO
	web31805.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965118AbWJXIif (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 04:38:35 -0400
Received: (qmail 83232 invoked by uid 60001); 24 Oct 2006 08:38:34 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=smV8OzN41+f5iS6CAqRnGlD9AceN1newTk2XQz+SeFDdzMlMmN8lMbQLx17BlKGxZGY6Ztk1yMVQxAmoJza0mTbkzr81CZ8Al/6mmH4p8DlvicF59w0Xh1aruJn1qZEUCDSLKzN24lRBzaRWRCrLj9zs10xYA3UsjpFSoQQb5Vk=  ;
X-YMail-OSG: ycAyVV8VM1lkNTQ3xxJ7XNbhWSkGaT.HBODUlBn2xDKbvoRlYqQW5dae9OUz5ns3qponGDpN2POw9WwXUpRF1NM6ckyE6Yilefb28VbpJa8AhBGVXMUDg_wkMk2uNxB2gImMOSnQMR8-
Received: from [71.80.233.118] by web31805.mail.mud.yahoo.com via HTTP; Tue, 24 Oct 2006 01:38:34 PDT
To: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <20061024033610.7959.4028.stgit@rover>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29945>

--- Petr Baudis <pasky@suse.cz> wrote:
> This restores the redundant links removed earlier. It supersedes my patch
> to stick slashes to tree entries.
> 
> Sorry about the previous version of the patch, an unrelated snapshot link
> addition to tree entries slipped through (and it it didn't even compile);
> I've dropped the idea of snapshot links in tree entries in the meantime
> anyway.
> 
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> ---

http://marc.theaimsgroup.com/?t=116059799500003&r=1&w=2

    Luben


> 
>  gitweb/gitweb.perl |   28 ++++++++++++++++++++++------
>  1 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 4a2025c..661d1dd 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1793,16 +1793,18 @@ sub git_print_tree_entry {
>  			                       file_name=>"$basedir$t->{'name'}", %base_key),
>  			        -class => "list"}, esc_html($t->{'name'})) . "</td>\n";
>  		print "<td class=\"link\">";
> +		print $cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
> +					     file_name=>"$basedir$t->{'name'}", %base_key)},
> +			      "blob");
>  		if ($have_blame) {
> -			print $cgi->a({-href => href(action=>"blame", hash=>$t->{'hash'},
> +			print " | " .
> +			      $cgi->a({-href => href(action=>"blame", hash=>$t->{'hash'},
>  				                           file_name=>"$basedir$t->{'name'}", %base_key)},
>  				            "blame");
>  		}
>  		if (defined $hash_base) {
> -			if ($have_blame) {
> -				print " | ";
> -			}
> -			print $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
> +			print " | " .
> +			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
>  			                             hash=>$t->{'hash'}, file_name=>"$basedir$t->{'name'}")},
>  			              "history");
>  		}
> @@ -1819,8 +1821,12 @@ sub git_print_tree_entry {
>  		              esc_html($t->{'name'}));
>  		print "</td>\n";
>  		print "<td class=\"link\">";
> +		print $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
> +					     file_name=>"$basedir$t->{'name'}", %base_key)},
> +			      "tree");
>  		if (defined $hash_base) {
> -			print $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
> +			print " | " .
> +			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
>  			                             file_name=>"$basedir$t->{'name'}")},
>  			              "history");
>  		}
> @@ -1903,6 +1909,9 @@ sub git_difftree_body {
>  				print $cgi->a({-href => "#patch$patchno"}, "patch");
>  				print " | ";
>  			}
> +			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
> +			                             hash_base=>$parent, file_name=>$diff{'file'})},
> +				      "blob") . " | ";
>  			print $cgi->a({-href => href(action=>"blame", hash_base=>$parent,
>  			                             file_name=>$diff{'file'})},
>  			              "blame") . " | ";
> @@ -1948,6 +1957,9 @@ sub git_difftree_body {
>  				}
>  				print " | ";
>  			}
> +			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
> +						     hash_base=>$hash, file_name=>$diff{'file'})},
> +				      "blob") . " | ";
>  			print $cgi->a({-href => href(action=>"blame", hash_base=>$hash,
>  			                             file_name=>$diff{'file'})},
>  			              "blame") . " | ";
> @@ -1988,6 +2000,9 @@ sub git_difftree_body {
>  				}
>  				print " | ";
>  			}
> +			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
> +						     hash_base=>$parent, file_name=>$diff{'from_file'})},
> +				      "blob") . " | ";
>  			print $cgi->a({-href => href(action=>"blame", hash_base=>$parent,
>  			                             file_name=>$diff{'from_file'})},
>  			              "blame") . " | ";
> @@ -2155,6 +2170,7 @@ sub git_shortlog_body {
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
