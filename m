From: Junio C Hamano <junkio@cox.net>
Subject: Re: Patch for http-fetch.c and older curl releases
Date: Mon, 18 Sep 2006 17:14:42 -0700
Message-ID: <7vzmcwogp9.fsf@assigned-by-dhcp.cox.net>
References: <20060918225445.GF1261@artsapartment.org>
	<7v4pv4pyey.fsf@assigned-by-dhcp.cox.net>
	<20060918235753.GG1261@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 19 02:15:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPTGN-0008WO-5f
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 02:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbWISAOq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 20:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbWISAOq
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 20:14:46 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:4265 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030324AbWISAOn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 20:14:43 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060919001443.LZYM12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Mon, 18 Sep 2006 20:14:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Q0Ek1V00V1kojtg0000000
	Mon, 18 Sep 2006 20:14:44 -0400
To: "Art Haas" <ahaas@airmail.net>
In-Reply-To: <20060918235753.GG1261@artsapartment.org> (Art Haas's message of
	"Mon, 18 Sep 2006 18:57:53 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27263>

"Art Haas" <ahaas@airmail.net> writes:

> Here's a patch that does that. I patched 'http.h' as there is already
> a number of other curl tests in that file. On the machine where the 
> build was failing, the 'curl-config --vernum' returned '070908',
> and on my home machine where things build without issue the same
> command returns '070f05', so I took that value to do the comparison.
> Perhaps an intermediate value would work as well, but I don't have
> a suitable version to check.
>
> Signed-off-by:  Art Haas <ahaas@airmail.net>
>
> diff --git a/http.h b/http.h
> index 9ca16ac..aeff988 100644
> --- a/http.h
> +++ b/http.h
> @@ -22,6 +22,10 @@ #if LIBCURL_VERSION_NUM < 0x070c04
>  #define NO_CURL_EASY_DUPHANDLE
>  #endif
>  
> +#if LIBCURL_VERSION_NUM < 0x070f05
> +#define CURLE_HTTP_RETURNED_ERROR CURLE_HTTP_NOT_FOUND
> +#endif
> +
>  struct slot_results
>  {
>  	CURLcode curl_result;
>

Eh, why not

        #ifndef CURLE_HTTP_RETURNED_ERROR
        #define CURLE_HTTP_RETURNED_ERROR CURLE_HTTP_NOT_FOUND
        #endif
