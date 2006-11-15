X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git tag: don't complain of empty messages
Date: Wed, 15 Nov 2006 10:23:24 -0800
Message-ID: <7v64dgo9gj.fsf@assigned-by-dhcp.cox.net>
References: <ejfc1t$6am$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 18:24:11 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ejfc1t$6am$1@sea.gmane.org> (Han-Wen Nienhuys's message of "Wed,
	15 Nov 2006 16:34:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31459>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkPQa-0004s6-Ul for gcvg-git@gmane.org; Wed, 15 Nov
 2006 19:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030801AbWKOSXl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 13:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030806AbWKOSXl
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 13:23:41 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:63166 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1030801AbWKOSXk
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 13:23:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115182340.RLGX7157.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 13:23:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id n6Pm1V00f1kojtg0000000; Wed, 15 Nov 2006
 13:23:46 -0500
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys <hanwen@xs4all.nl> writes:

> Hello,
>
> GIT refuses to set annotated tags without a comment. I think this is a
> silly restriction when the message is explicitly set to the empty
> string.
>
> The attached patch should fix this;  Unfortunately, I've been unable
> to test it. Running the script with sh -x stops at
>
> ++exec /home/hanwen/usr/pkg/git/bin/git-sh-setup
>
> -- 
>  Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
> commit 446cfbd9edcfaf5fe76f597823e0e3314d091489
> Author: Han-Wen Nienhuys <hanwen@lilypond.org>
> Date:   Wed Nov 15 16:27:27 2006 +0100
>
>     always set tag if -m is given, even if empty
>

Please follow Documentation/SubmittingPatches.

> diff --git a/git-tag.sh b/git-tag.sh
> index ac269e3..f2533a3 100755
> --- a/git-tag.sh
> +++ b/git-tag.sh
> @@ -5,6 +5,7 @@ USAGE='-l [<pattern>] | [-a | -s | -u <k
>  SUBDIRECTORY_OK='Yes'
>  . git-sh-setup
>  
> +message_given=
>  annotate=
>  signed=
>  force=
> @@ -37,6 +38,7 @@ do
>      	annotate=1
>  	shift
>  	message="$1"
> +	message_given=1
>  	;;
>      -u)
>  	annotate=1

If you are going to do this, this hunk should be changed to
check if the command line ended with "-m" without next
parameter, in which case it should error out.

I do not have a strong objection against allowing tags without
messages, but at the same time I do not see a compelling reason
to allow them either.  Care to explain what workflow is helped
by an empty tag?
