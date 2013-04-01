From: =?UTF-8?B?U2ViYXN0aWFuIEfDtnR0ZQ==?= <jaseg@physik.tu-berlin.de>
Subject: Re: [PATCH v8 3/5] merge/pull: verify GPG signatures of commits being
 merged
Date: Mon, 01 Apr 2013 14:53:01 +0200
Message-ID: <5159832D.3030400@physik.tu-berlin.de>
References: <20130331144452.GF2286@serenity.lan> <cover.1364742659.git.jaseg@physik-pool.tu-berlin.de> <51585E10.8090505@physik.tu-berlin.de> <7vsj3bm0gr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 01 14:53:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMeFB-0003wb-9Z
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 14:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164Ab3DAMxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 08:53:21 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:50998 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756471Ab3DAMxU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 08:53:20 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-2) with esmtp 
	id 1UMeEd-00066f-Hz; Mon, 01 Apr 2013 14:53:19 +0200
Received: from [94.45.252.143] (unknown [94.45.252.143])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id 7E69F11402;
	Mon,  1 Apr 2013 14:53:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <7vsj3bm0gr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219684>

On 04/01/2013 04:47 AM, Junio C Hamano wrote:
> I'll squash in something like the following and push out the result
> on 'pu' tonight.  Please check to see if I made silly mistakes while
> doing so.
> 
> Thanks.
> 
>  builtin/merge.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 7a33d03..e57c42c 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1245,16 +1245,18 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  			check_commit_signature(commit, &signature_check);
>  
>  			strcpy(hex, find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
> -			switch(signature_check.result){
> -				case 'G':
> -					break;
> -				case 'B':
> -					die(_("Commit %s has a bad GPG signature allegedly by %s."), hex, signature_check.signer);
> -				default: /* 'N' */
> -					die(_("Commit %s does not have a GPG signature."), hex, hex);
> +			switch (signature_check.result) {
> +			case 'G':
> +				break;
> +			case 'B':
> +				die(_("Commit %s has a bad GPG signature "
> +				      "allegedly by %s."), hex, signature_check.signer);
> +			default: /* 'N' */
> +				die(_("Commit %s does not have a GPG signature."), hex);
>  			}
>  			if (verbosity >= 0 && signature_check.result == 'G')
> -				printf(_("Commit %s has a good GPG signature by %s\n"), hex, signature_check.signer);
> +				printf(_("Commit %s has a good GPG signature by %s\n"),
> +				       hex, signature_check.signer);
>  
>  			free(signature_check.gpg_output);
>  			free(signature_check.gpg_status);
Looks fine to me.
