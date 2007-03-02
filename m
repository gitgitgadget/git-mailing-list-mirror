From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb not friendly to firefox?
Date: Fri, 02 Mar 2007 02:17:31 -0800
Message-ID: <7vabyweypw.fsf@assigned-by-dhcp.cox.net>
References: <989B956029373F45A0B8AF02970818902DA81B@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jakub Narebski" <jnareb@gmail.com>, <rea-git@codelabs.ru>,
	"Raimund Bauer" <ray@softwarelandschaft.com>, <git@vger.kernel.org>
To: "Li Yang-r58472" <LeoLi@freescale.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 11:17:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN4pT-0002s5-TO
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 11:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933299AbXCBKRd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 05:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933307AbXCBKRd
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 05:17:33 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:54823 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933299AbXCBKRc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 05:17:32 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070302101732.MSDA748.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 2 Mar 2007 05:17:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VmHX1W00C1kojtg0000000; Fri, 02 Mar 2007 05:17:32 -0500
In-Reply-To: <989B956029373F45A0B8AF02970818902DA81B@zch01exm26.fsl.freescale.net>
	(Li Yang-r's message of "Fri, 2 Mar 2007 17:36:36 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41181>

"Li Yang-r58472" <LeoLi@freescale.com> writes:

> Hi Jakub,
>
> Problem sovled, using the following patch.  I'm not an expert of perl,
> so I don't know if it is problem of the gitweb or problem with my perl
> environment.  My environment is perl-5.8.0 and perl-CGI-2.81.
>
> Signed-off-by: Li Yang<leoli@freecale.com>
> ---
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 653ca3c..8c9a291 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -591,7 +591,7 @@ sub esc_html ($;%) {
>         my %opts = @_;
>
>         $str = to_utf8($str);
> -       $str = escapeHTML($str);
> +       $str = $cgi->escapeHTML($str);
>         if ($opts{'-nbsp'}) {
>                 $str =~ s/ /&nbsp;/g;
>         }
>

This is puzzling....

 (1) we have two call sites of escapeHTML(), but your patch
     touches only one.

 (2) we do "use CGI qw(:standard :escapeHTML -nosticky);"
     upfront, presumably after doing this when we say
     escapeHTML() it means the same as CGI::escapeHTML().

 (3) we do "$cgi = new CGI" upfront.

So I am wondering how the patch can have any effect...

I am not saying that I do not believe you when you say the patch
fixes the problem for you.  I just do not understand why and I
hate not knowing why something works.
