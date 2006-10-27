X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb.cgi and git instaweb
Date: Fri, 27 Oct 2006 00:05:20 -0700
Message-ID: <7v8xj2i6hb.fsf@assigned-by-dhcp.cox.net>
References: <ehr00n$vbe$1@sea.gmane.org> <45419F75.6060103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 07:05:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <45419F75.6060103@gmail.com> (Aneesh Kumar K. V.'s message of
	"Fri, 27 Oct 2006 11:26:05 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30296>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdLmP-0003TE-8b for gcvg-git@gmane.org; Fri, 27 Oct
 2006 09:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423758AbWJ0HFW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 03:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423759AbWJ0HFW
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 03:05:22 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:39059 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1423758AbWJ0HFV
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 03:05:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061027070520.GDDP12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Fri, 27
 Oct 2006 03:05:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id fK5Q1V00J1kojtg0000000 Fri, 27 Oct 2006
 03:05:25 -0400
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Sender: git-owner@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@gmail.com> writes:

> Aneesh Kumar K.V wrote:
>> I am getting errors as below with git instaweb.
>>
>>
>> kvaneesh@satan:/home/opensource/vanilla/linux-2.6-git$ git instaweb
>> 2006-10-27 00:12:56: (log.c.75) server started
>> kvaneesh@satan:/home/opensource/vanilla/linux-2.6-git$ [Fri Oct 27
>> 00:12:57 2006] gitweb.cgi: "our" variable $stylesheet masks earlier
>> declaration in same scope at
>>
>
> The attached patch should fix it.
>
> -aneesh
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ba7a42a..1962c76 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -55,8 +55,6 @@ our $stylesheet;
>  # default is not to define style sheet, but it can be overwritten later
>  undef $stylesheet;
>  
> -# URI of default stylesheet
> -our $stylesheet = "++GITWEB_CSS++";
>  # URI of GIT logo (72x27 size)
>  our $logo = "++GITWEB_LOGO++";
>  # URI of GIT favicon, assumed to be image/png type

Removing the extraneous undef would also be a good idea,
wouldn't it?

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index aceaeb7..7999b1a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -51,12 +51,10 @@ our $site_footer = "++GITWEB_SITE_FOOTER
 
 # URI of stylesheets
 our @stylesheets = ("++GITWEB_CSS++");
-our $stylesheet;
-# default is not to define style sheet, but it can be overwritten later
-undef $stylesheet;
-
 # URI of default stylesheet
-our $stylesheet = "++GITWEB_CSS++";
+# default is not to define style sheet, but it can be overwritten later.
+our $stylesheet = undef;
+
 # URI of GIT logo (72x27 size)
 our $logo = "++GITWEB_LOGO++";
 # URI of GIT favicon, assumed to be image/png type
