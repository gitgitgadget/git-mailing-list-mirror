From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] GSoC2014 microprojects  Rewrite bulk-checkin.c:finish_bulk_checkin()
 to use a strbuf for handling packname
Date: Thu, 27 Feb 2014 22:34:02 +0100
Message-ID: <530FAF4A.1070102@alum.mit.edu>
References: <1393510842-31769-1-git-send-email-sunheehnus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sun He <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 22:34:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ8aq-0007We-GH
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 22:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbaB0VeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 16:34:07 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57344 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751905AbaB0VeF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 16:34:05 -0500
X-AuditID: 12074411-f79ab6d000002f0e-40-530faf4c7580
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id EB.15.12046.C4FAF035; Thu, 27 Feb 2014 16:34:04 -0500 (EST)
Received: from [192.168.69.148] (p57A24AC7.dip0.t-ipconnect.de [87.162.74.199])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1RLY2XP023579
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 27 Feb 2014 16:34:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1393510842-31769-1-git-send-email-sunheehnus@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqOuznj/YYNFDIYuuK91MFm23tzM6
	MHnsnHWX3ePzJrkApihum6TEkrLgzPQ8fbsE7ox1s20KfktXfDyr3cA4R6yLkZNDQsBE4uOh
	n4wQtpjEhXvr2boYuTiEBC4zSlx6P4cJwjnPJNG7awYbSBWvgLZE17EtLCA2i4CqxPKmrawg
	NpuArsSinmYmEFtUIFhi9eUHLBD1ghInZz4Bs0UEFCUOHt/K3MXIwcEsIC7R/48FZL6wQCOj
	xObGG0wgcSEBF4lfbeYg5ZwCrhIXF+1iBAlLAJX3NAaBhJkFdCTe9T1ghrDlJba/ncM8gVFw
	FpJls5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrqlebmaJXmpK6SZGSOgK7mCc
	cVLuEKMAB6MSD+8ET/5gIdbEsuLK3EOMkhxMSqK8NWuAQnxJ+SmVGYnFGfFFpTmpxYcYJTiY
	lUR4fecA5XhTEiurUovyYVLSHCxK4rx8S9T9hATSE0tSs1NTC1KLYLIyHBxKErzd64AaBYtS
	01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kGxG18MjF6QFA/Q3iMg7bzFBYm5QFGI1lOM
	uhy32359YhRiycvPS5US5/UBOVwApCijNA9uBSxRvWIUB/pYmHcdyCgeYJKDm/QKaAkT0JKj
	0jwgS0oSEVJSDYzqhuxplzY7eh9Jn/w1+FPTxpApJ9zypinIHyx5zMh87ufSKtf3z++mSG2J
	+jA5LMt0K1P12ial577uZcqTeyLYzpytky1dxsgVYbZk4qNltzesiC4W0BXdN2uy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242861>

On 02/27/2014 03:20 PM, Sun He wrote:
> Signed-off-by: Sun He <sunheehnus@gmail.com>
> ---
>  bulk-checkin.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 118c625..e3c7fb2 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -23,7 +23,8 @@ static struct bulk_checkin_state {
>  static void finish_bulk_checkin(struct bulk_checkin_state *state)
>  {
>  	unsigned char sha1[20];
> -	char packname[PATH_MAX];
> +    char *packname;
> +    struct strbuf sb;
>  	int i;
>  
>  	if (!state->f)
> @@ -43,6 +44,10 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
>  		close(fd);
>  	}
>  
> +     /* 64-1 is more than the sum of len(sha1_to_hex(sha1)) and len(".pack") */
> +    strbuf_init(&sb,strlen(get_object_directory())+64);
> +    packname = sb.buf;

Why is packname still needed?  Can't you just use sb.buf wherever
packname was used before?  And then you can also rename "sb", which is a
mostly meaningless name, to "packname".

> +
>  	sprintf(packname, "%s/pack/pack-", get_object_directory());



>  	finish_tmp_packfile(packname, state->pack_tmp_name,
>  			    state->written, state->nr_written,
> @@ -54,6 +59,9 @@ clear_exit:
>  	free(state->written);
>  	memset(state, 0, sizeof(*state));
>  
> +    /* release sb space */
> +    strbuf_release(&sb);
> +
>  	/* Make objects we just wrote available to ourselves */
>  	reprepare_packed_git();
>  }
> 

Please also adhere to the CodingGuidelines.  Either you or your mailer
have used spaces rather than tabs for indentation.  We also usually use
spaces around "+".

The following comments belong earlier, just after the "---" line.

> -- 1.7.1
>> Rewrite bulk-checkin.c:finish_bulk_checkin() to use a strbuf for handling packname, and explain why this is useful.
> 
> char packname[PATH_MAX] (PATH_MAX=4096) in a local function costs too much space, it may cause stack overflow.
> Using strbuf to deal with packname is more space-friendly.
> I only use the API strbuf_init to alloc enough space for packname. I didn't use other APIs because I want to make the change as little as possible that I don't have to fix other functions which may import new bugs.
> Because the space spared for sb is on heap, we must release it after it is not useful.

Saving stack space is nice, though given that it takes more time to
allocate space on the heap, it is nonetheless usually preferred to use
the stack for temporary variables of this size.

The problem has more to do with the fact that the old version fixes a
maximum length on the buffer, which could be a problem if one is not
certain of the length of get_object_directory().

The other point of strbuf is that you don't have to do the error-prone
bookkeeping yourself.  So it would be preferable to use strbuf_addf().

>> Also check if the first argument of pack-write.c:finish_tmp_packfile() can be made const.
> 
> Tht first argument of pack-write.c:finish_tmp_packfile() can be made const because we didn't use *name_buffer to change anything.

So, why don't you include a second patch making this change?

> Cheers,
> He Sun
> 
> PS: 
> Why I cannot sent email to git@vger.kernel.org via my Firefox?
> Can you receive my former emails?
> Thanks.

At least one earlier mail arrived at the list.  You can check the
mailing list archives at gmane.org to verify things like this.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
