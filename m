From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] sh-setup: work around "unset IFS" bug in some shells
Date: Fri, 07 Dec 2012 17:37:29 -0500
Message-ID: <50C26FA9.6060007@xiplink.com>
References: <50C22B15.1030607@xiplink.com> <7vvccdhhod.fsf@alter.siamese.dyndns.org> <50C22F72.6010701@xiplink.com> <7vwqwtfzis.fsf@alter.siamese.dyndns.org> <50C24ED7.90000@xiplink.com> <7vsj7hfw6q.fsf@alter.siamese.dyndns.org> <50C25539.9010206@xiplink.com> <7vobi5fu3c.fsf@alter.siamese.dyndns.org> <7va9tpfq46.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 23:37:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th6Y3-0000kI-Dn
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 23:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242Ab2LGWhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 17:37:18 -0500
Received: from smtp130.ord.emailsrvr.com ([173.203.6.130]:33960 "EHLO
	smtp130.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab2LGWhR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 17:37:17 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp13.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 6C2C71980E3;
	Fri,  7 Dec 2012 17:37:19 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp13.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 10D0A1980B0;
	Fri,  7 Dec 2012 17:37:19 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7va9tpfq46.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211200>

I like your patch's subject line better than mine.

		M.


On 12-12-07 05:34 PM, Junio C Hamano wrote:
> With an unset IFS, field splitting is supposed to act as if IFS is
> set to the usual SP HT LF, but Marc Branchaud reports that the shell
> on FreeBSD 7.2 gets this wrong.
> 
> It is easy to set it to the default value manually, so let's do so.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  git-sh-setup.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index ee0e0bc..107c144 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -12,8 +12,11 @@
>  # But we protect ourselves from such a user mistake nevertheless.
>  unset CDPATH
>  
> -# Similarly for IFS
> -unset IFS
> +# Similarly for IFS, but some shells (e.g. FreeBSD 7.2) are buggy and
> +# do not equate an unset IFS with IFS with the default, so here is
> +# an explicit SP HT LF.
> +IFS=' 	
> +'
>  
>  git_broken_path_fix () {
>  	case ":$PATH:" in
> 
