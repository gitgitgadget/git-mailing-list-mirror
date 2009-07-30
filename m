From: Josh ben Jore <jbenjore@whitepages.com>
Subject: Re: Null deref in recursive merge in
 df73af5f667a479764d2b2195cb0cb60b0b89e3d
Date: Thu, 30 Jul 2009 00:24:54 -0700
Message-ID: <C69698D6.61E1C%jbenjore@whitepages.com>
References: <7vtz0uk5z3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 09:25:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWQ0e-0003Mk-On
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 09:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbZG3HY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 03:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752174AbZG3HY4
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 03:24:56 -0400
Received: from mail0.w3data.com ([38.112.225.178]:21871 "EHLO
	hub.corp.w3data.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751454AbZG3HY4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jul 2009 03:24:56 -0400
Received: from post.corp.w3data.com ([172.18.0.206]) by hub ([172.25.0.29])
 with mapi; Thu, 30 Jul 2009 00:25:02 -0700
Thread-Topic: Null deref in recursive merge in
 df73af5f667a479764d2b2195cb0cb60b0b89e3d
Thread-Index: AcoQ4+qEwNrsWQbATmmqOORw1/evoQAAuq++
In-Reply-To: <7vtz0uk5z3.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124447>

On 7/30/09 12:03 AM, "Junio C Hamano" <gitster@pobox.com> wrote:

> Josh ben Jore <jbenjore@whitepages.com> writes:
> 
>> I know more now.
> 
> Thanks.  The log was a bit hard to read with linewrapping; here is what I
> could glean out of it anyway.

Sorry about that. I didn't realize it was wrapped. I thought I'd use my
work's Outlook since I was addressing a problem for work.

> Since I do not have an access to exact details, nor reproducible history,
> this is shot in the dark, but I think this may fix it.

It is a very accurate shot in the dark. It appears to have fixed it when
applied to 0a53e9ddeaddad63ad106860237bbf53411d11a7 GIT 1.6.4. I'll be
trying this against v1.6.0.4 tomorrow.

> The codepath saw that one branch renamed dev-ubuntu/ stuff to dev/ at that
> "unmerged" path, while the other branch added something else to the same
> path, and decided to add that at an alternative path, and the intent of
> that is so that it can safely resolve the "renamed" side to its final
> destination.  The added update_file() call is about finishing that
> conflict resolution the code forgets to do.
> 
>  merge-recursive.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/merge-recursive.c b/merge-recursive.c
> index d415c41..868b383 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -955,6 +955,7 @@ static int process_renames(struct merge_options *o,
>                                 new_path = unique_path(o, ren1_dst, branch2);
>                                 output(o, 1, "Adding as %s instead",
> new_path);
>                                 update_file(o, 0, dst_other.sha1,
> dst_other.mode, new_path);
> +                               update_file(o, 0, src_other.sha1,
> src_other.mode, ren1_dst);
>                         } else if ((item = string_list_lookup(ren1_dst,
> renames2Dst))) {
>                                 ren2 = item->util;
>                                 clean_merge = 0;
> 

Thanks very much,
Josh
