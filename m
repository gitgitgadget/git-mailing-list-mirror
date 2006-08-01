From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: use a hash to lookup the sub for an action
Date: Mon, 31 Jul 2006 19:50:29 -0700 (PDT)
Message-ID: <20060801025029.21850.qmail@web31802.mail.mud.yahoo.com>
References: <E1G7faj-0006W8-17@moooo.ath.cx>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Aug 01 04:50:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7kL3-00024R-AJ
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 04:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbWHACua (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 22:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbWHACua
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 22:50:30 -0400
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:37030 "HELO
	web31802.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030413AbWHACu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 22:50:29 -0400
Received: (qmail 21852 invoked by uid 60001); 1 Aug 2006 02:50:29 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=12sdUpUFO4SgXvzB/qHtGaCqezJa7o11EkuumxA6d3KSRePXUrDPUvErQweFq3Arrg1crsXQx+Z8thcdSoco3gz7psRgih0JMSBxa1RkQ7/a3sIezvI3/WXNLGPmwtiHsbwUQD0UBrLAZx9vf2qZT9s8PXvYhETUr3YYXKsluJk=  ;
Received: from [71.80.231.253] by web31802.mail.mud.yahoo.com via HTTP; Mon, 31 Jul 2006 19:50:29 PDT
To: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
In-Reply-To: <E1G7faj-0006W8-17@moooo.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24569>

--- Matthias Lederhofer <matled@gmx.net> wrote:
> Signed-off-by: Matthias Lederhofer <matled@gmx.net>

That's a great patch.

   Luben

> ---
>  gitweb/gitweb.cgi |   81 ++++++++++++++++-------------------------------------
>  1 files changed, 25 insertions(+), 56 deletions(-)
> 
> diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
> index c1ee79e..75390c8 100755
> --- a/gitweb/gitweb.cgi
> +++ b/gitweb/gitweb.cgi
> @@ -161,65 +161,34 @@ if (defined $searchtext) {
>  }
>  
>  # dispatch
> -if (!defined $action || $action eq "summary") {
> -	git_summary();
> -	exit;
> -} elsif ($action eq "heads") {
> -	git_heads();
> -	exit;
> -} elsif ($action eq "tags") {
> -	git_tags();
> -	exit;
> -} elsif ($action eq "blob") {
> -	git_blob();
> -	exit;
> -} elsif ($action eq "blob_plain") {
> -	git_blob_plain();
> -	exit;
> -} elsif ($action eq "tree") {
> -	git_tree();
> -	exit;
> -} elsif ($action eq "rss") {
> -	git_rss();
> -	exit;
> -} elsif ($action eq "commit") {
> -	git_commit();
> -	exit;
> -} elsif ($action eq "log") {
> -	git_log();
> -	exit;
> -} elsif ($action eq "blobdiff") {
> -	git_blobdiff();
> -	exit;
> -} elsif ($action eq "blobdiff_plain") {
> -	git_blobdiff_plain();
> -	exit;
> -} elsif ($action eq "commitdiff") {
> -	git_commitdiff();
> -	exit;
> -} elsif ($action eq "commitdiff_plain") {
> -	git_commitdiff_plain();
> -	exit;
> -} elsif ($action eq "history") {
> -	git_history();
> -	exit;
> -} elsif ($action eq "search") {
> -	git_search();
> -	exit;
> -} elsif ($action eq "shortlog") {
> -	git_shortlog();
> -	exit;
> -} elsif ($action eq "tag") {
> -	git_tag();
> -	exit;
> -} elsif ($action eq "blame") {
> -	git_blame2();
> -	exit;
> -} else {
> +my %actions = (
> +	"blame" => \&git_blame2,
> +	"blobdiff" => \&git_blobdiff,
> +	"blobdiff_plain" => \&git_blobdiff_plain,
> +	"blob" => \&git_blob,
> +	"blob_plain" => \&git_blob_plain,
> +	"commitdiff" => \&git_commitdiff,
> +	"commitdiff_plain" => \&git_commitdiff_plain,
> +	"commit" => \&git_commit,
> +	"heads" => \&git_heads,
> +	"history" => \&git_history,
> +	"log" => \&git_log,
> +	"rss" => \&git_rss,
> +	"search" => \&git_search,
> +	"shortlog" => \&git_shortlog,
> +	"summary" => \&git_summary,
> +	"tag" => \&git_tag,
> +	"tags" => \&git_tags,
> +	"tree" => \&git_tree,
> +);
> +
> +$action = 'summary' if (!defined($action));
> +if (!defined($actions{$action})) {
>  	undef $action;
>  	die_error(undef, "Unknown action.");
> -	exit;
>  }
> +$actions{$action}->();
> +exit;
>  
>  ## ======================================================================
>  ## validation, quoting/unquoting and escaping
> -- 
> 1.4.2.rc2.ge0bed
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
