X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] Improve git-prune -n output
Date: Thu, 26 Oct 2006 18:33:35 +0100
Message-ID: <4540F16F.4060604@shadowen.org>
References: <200610261138.24761.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 17:34:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
In-Reply-To: <200610261138.24761.andyparkins@gmail.com>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30250>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd97U-0005P6-1q for gcvg-git@gmane.org; Thu, 26 Oct
 2006 19:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1945922AbWJZReO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 13:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945916AbWJZReN
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 13:34:13 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:50191 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S1945917AbWJZReL
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 13:34:11 -0400
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1Gd96l-00033q-AE; Thu, 26 Oct 2006 18:33:35 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:
> prune_object() in show_only mode would previously just show the path to the
> object that would be deleted.  The path the object is stored in shouldn't be
> shown to users, they only know about sha1 identifiers so show that instead.
> 
> Further, the sha1 alone isn't that useful for examining what is going to be
> deleted.  This patch also adds the object type to the output, which makes it
> easy to pick out, say, the commits and use git-show to display them.
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>
> ---
>  builtin-prune.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/builtin-prune.c b/builtin-prune.c
> index 7290e6d..e3bcf5f 100644
> --- a/builtin-prune.c
> +++ b/builtin-prune.c
> @@ -16,8 +16,13 @@ static struct rev_info revs;
>  
>  static int prune_object(char *path, const char *filename, const unsigned char *sha1)
>  {
> +	char type[20];
> +
>  	if (show_only) {
> -		printf("would prune %s/%s\n", path, filename);
> +		if (sha1_object_info(sha1, type, NULL)) {
> +			strcpy( type, "unknown type" );
> +		}
> +		printf("would prune %s %s\n", sha1_to_hex( sha1 ), type );
>  		return 0;
>  	}
>  	unlink(mkpath("%s/%s", path, filename));

If we are changing the format would it not make more sense to be in the
same order as the tool that lets you use it?

I thought that was git cat-file <type> <commit-ish>

