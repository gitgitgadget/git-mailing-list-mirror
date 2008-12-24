From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH 2/2] gitweb: support hiding projects from user-visible
 lists
Date: Tue, 23 Dec 2008 20:40:31 -0500
Message-ID: <1230082831.2971.45.camel@localhost>
References: <4ba6b6c3fc183002407f322663d7ab53c1c28a91.1229202740.git.matt@mattmccutchen.net>
	 <1229203007.31181.6.camel@mattlaptop2.local>
	 <m3ljujg2eh.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 24 02:45:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFIo0-0008LW-W0
	for gcvg-git-2@gmane.org; Wed, 24 Dec 2008 02:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbYLXBkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 20:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbYLXBkf
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 20:40:35 -0500
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:37466 "EHLO
	jankymail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751169AbYLXBkf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Dec 2008 20:40:35 -0500
Received: from [192.168.1.46] (pool-71-163-191-168.washdc.east.verizon.net [71.163.191.168])
	by jankymail-a3.g.dreamhost.com (Postfix) with ESMTP id 669C464CA2;
	Tue, 23 Dec 2008 17:40:33 -0800 (PST)
In-Reply-To: <m3ljujg2eh.fsf@localhost.localdomain>
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103856>

On Sat, 2008-12-13 at 14:02 -0800, Jakub Narebski wrote:
> Cannot you do this with new $export_auth_hook gitweb configuration
> variable, added by Alexander Gavrilov in 
>    dd7f5f1 (gitweb: Add a per-repository authorization hook.)
> It is used in check_export_ok subroutine, and is is checked also when
> getting list of project from file
> 
> >From gitweb/INSTALL
> 
>   - Finally, it is possible to specify an arbitrary perl subroutine that
>     will be called for each project to determine if it can be exported.
>     The subroutine receives an absolute path to the project as its only
>     parameter.
> 
>     For example, if you use mod_perl to run the script, and have dumb
>     http protocol authentication configured for your repositories, you
>     can use the following hook to allow access only if the user is
>     authorized to read the files:
> 
>       $export_auth_hook = sub {
>           use Apache2::SubRequest ();
>           use Apache2::Const -compile => qw(HTTP_OK);
>           my $path = "$_[0]/HEAD";
>           my $r    = Apache2::RequestUtil->request;
>           my $sub  = $r->lookup_file($path);
>           return $sub->filename eq $path
>               && $sub->status == Apache2::Const::HTTP_OK;
>       };

$export_auth_hook would work, and it would have the nice (but not
essential) feature of including private projects in the list shown to
suitably authenticated users.  The only problem is that my Web host
doesn't support mod_perl.  Is there a practical way to accomplish the
same thing as the above example in a CGI script?  I would like to avoid
reimplementing Apache authentication-checking functionality if at all
possible.

-- 
Matt
