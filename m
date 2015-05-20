From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] tree-walk.c: fix some sparse 'NULL pointer' warnings
Date: Wed, 20 May 2015 13:04:21 -0400
Organization: Twitter
Message-ID: <1432141461.15896.6.camel@ubuntu>
References: <555BB633.8030204@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed May 20 19:04:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv7Py-0000jS-OR
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 19:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813AbbETRE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 13:04:26 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36737 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801AbbETREZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 13:04:25 -0400
Received: by igbpi8 with SMTP id pi8so107729746igb.1
        for <git@vger.kernel.org>; Wed, 20 May 2015 10:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=AU5iILZNapfX3tY8IAvadwiEbY/5zeDGXo/xWwi/5a4=;
        b=Jusxl6Eb6HMoInETNnqrOvBs4TELV2Iw23t3nCjpZtri5KJZpl5EV/pR9klaGG8MA0
         4YDN0ak0Vdh4As5J7OrP5PbdXVesl4pHrfwZVRCxSDYqVN99OuGc3h6NKPv9cEDunVBr
         DWaKGUNfwJQp6mXCX1zgvmev5DjRfXyonK+uMvE2lQNwuv4trbTyAosERrPax1POsOPJ
         nAdpG2B035TgOHiqlOsLiPy26RnGH73dgqSmNns+1VHHljrkb3vDv++otJzyUtXi5/yW
         bsjfm3bmtq/XbWrYLYj6SD83MBpXIYI3llXZ+lLVPwAp35DV8wbmmzxnGQE+m5EdHdws
         2Nbw==
X-Gm-Message-State: ALoCoQmk/mrK77CvcQU2VCqXkv35VNcQkSf/9rDhidn10oRbZJmEwS1QMYgJ1I/taIlildVg9OpV
X-Received: by 10.107.160.141 with SMTP id j135mr44673186ioe.43.1432141465093;
        Wed, 20 May 2015 10:04:25 -0700 (PDT)
Received: from [172.18.162.4] ([8.25.196.25])
        by mx.google.com with ESMTPSA id n9sm1988576igv.13.2015.05.20.10.04.22
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2015 10:04:22 -0700 (PDT)
In-Reply-To: <555BB633.8030204@ramsay1.demon.co.uk>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269477>

re-rolled, thanks.

On Tue, 2015-05-19 at 23:16 +0100, Ramsay Jones wrote:
> Commit 811cd77b ("tree-walk: learn get_tree_entry_follow_symlinks",
> 14-05-2015) introduced a new function to locate an object by path
> while following symlinks in the repository. However, sparse now
> issues some "Using plain integer as NULL pointer" warnings as
> follows:
> 
>       SP tree-walk.c
>   tree-walk.c:517:31: warning: Using plain integer as NULL pointer
>   tree-walk.c:521:28: warning: Using plain integer as NULL pointer
> 
> The first warning relates to the use of an '{0}' initializer for
> the 'struct tree_desc' t. The first field of this structure has
> pointer type. A simple solution would replace the initializer
> expression with '{NULL}'. However, we choose to remove the
> initializer expression and make the initialization more explicit
> with a call to the 'init_tree_desc' function.
> 
> The second warning relates to the '0' initializer for the buf
> field of the 'result_path' strbuf pointer. A simple solution
> would replace this initializer with 'NULL'. However, this would
> violate a strbuf invariant that the 'buf' field is never NULL.
> (see strbuf documentation in strbuf.h header.) Assuming the
> documentation of 'get_tree_entry_follow_symlinks' regarding the
> 'result_path' parameter is observed by callers (ie that the
> parameter points to an _unitialized_ strbuf), a better solution
> is to simply call the 'strbuf_init' function.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
> 
> Hi David,
> 
> If you need to re-roll the patches in your 'dt/cat-file-follow-symlinks'
> branch, could you please squash this, or something like this, into the
> relevant patch (commit 811cd77b).
> 
> Thanks!
> 
> ATB,
> Ramsay Jones
> 
>  tree-walk.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tree-walk.c b/tree-walk.c
> index 8031f3a..6dccd2d 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -514,13 +514,12 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_s
>  	ssize_t parents_nr = 0;
>  	unsigned char current_tree_sha1[20];
>  	struct strbuf namebuf = STRBUF_INIT;
> -	struct tree_desc t = {0};
> +	struct tree_desc t;
>  	int follows_remaining = GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS;
>  	int i;
>  
> -	result_path->buf = 0;
> -	result_path->alloc = 0;
> -	result_path->len = 0;
> +	init_tree_desc(&t, NULL, 0UL);
> +	strbuf_init(result_path, 0);
>  	strbuf_addstr(&namebuf, name);
>  	hashcpy(current_tree_sha1, tree_sha1);
>  
