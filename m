From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: [PATCH] mailinfo: better parse email adresses containg parentheses
Date: Mon, 21 Jul 2008 16:36:31 +0200
Message-ID: <48849EEF.6070403@etek.chalmers.se>
References: <1216647269-12287-1-git-send-email-book@cpan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Philippe Bruhat (BooK)" <book@cpan.org>
X-From: git-owner@vger.kernel.org Mon Jul 21 16:37:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKwW6-0005wv-8U
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 16:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbYGUOge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 10:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbYGUOge
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 10:36:34 -0400
Received: from atum.ita.chalmers.se ([129.16.4.148]:45263 "EHLO
	atum.ita.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbYGUOge (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 10:36:34 -0400
Received: from [192.168.0.82] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	(Authenticated sender: lukass)
	by atum.ita.chalmers.se (Postfix) with ESMTP id 6D5CC11EEF;
	Mon, 21 Jul 2008 16:36:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.14) Gecko/20080504 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <1216647269-12287-1-git-send-email-book@cpan.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89361>

Philippe Bruhat (BooK) wrote:
>     When using git-rebase, author fields containing a ')' at the last
>     position had the close-parens character incorrectly removed
>     because the From: parser incorrectly matched it as
> 
>         user@host (User Name)
> 
>     (removing parentheses), instead of
> 
>         User Name (me) <user@host>
> 
> Signed-off-by: Philippe Bruhat (BooK) <book@cpan.org>

ACK.

> ---
>  builtin-mailinfo.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
> index b99a5b6..5581c9f 100644
> --- a/builtin-mailinfo.c
> +++ b/builtin-mailinfo.c
> @@ -115,10 +115,10 @@ static void handle_from(const struct strbuf *from)
>  	 * the () pair at the end.
>  	 */
>  	strbuf_trim(&f);
> -	if (f.buf[0] == '(')
> +	if (f.buf[0] == '(' && f.len && f.buf[f.len - 1] == ')') {
>  		strbuf_remove(&name, 0, 1);
Note: The line above should obviously be "strbuf_remove(&f, 0, 1);",
another error from the strbuf conversion I made. Sigh.

> -	if (f.len && f.buf[f.len - 1] == ')')
>  		strbuf_setlen(&f, f.len - 1);
> +	}
>  
>  	get_sane_name(&name, &f, &email);
>  	strbuf_release(&f);

/Lukas
