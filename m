From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: Re: [PATCH] 3-way merge with file move fails when diff.renames = copies
Date: Mon, 10 Nov 2008 16:06:04 -0800 (PST)
Message-ID: <953073.59787.qm@web52406.mail.re2.yahoo.com>
References: <1226355970-2542-1-git-send-email-ddkilzer@kilzer.net> <7v63mv3zww.fsf@gitster.siamese.dyndns.org>
Reply-To: "David D. Kilzer" <ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 01:14:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzgtS-00037c-PK
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 01:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754349AbYKKAMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 19:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754202AbYKKAMs
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 19:12:48 -0500
Received: from web52406.mail.re2.yahoo.com ([206.190.48.169]:40524 "HELO
	web52406.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754079AbYKKAMr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 19:12:47 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Nov 2008 19:12:47 EST
Received: (qmail 60354 invoked by uid 60001); 11 Nov 2008 00:06:05 -0000
X-YMail-OSG: S_Tp_VYVM1l.h7ISYIXANxbxCKhxeTPXEfatTScZoKINxiOtPGR2OGWqpEywoK9s3s3WkRWEzK1N4A7cSjkdccVEq7Y4b_5hmjU22hLeKc7zIln0yW3xHhqpQUD3u8J1PdT6h9pMddQjY1_YDjxcyxj97y4FyA2ltB5AjXf._4P8
Received: from [17.202.20.50] by web52406.mail.re2.yahoo.com via HTTP; Mon, 10 Nov 2008 16:06:04 PST
X-RocketYMMF: ddkilzer
X-Mailer: YahooMailRC/1155.20 YahooMailWebService/0.7.260.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100604>

Junio C Hamano <gitster@pobox.com> writes:

> If new_name that is not related at all to old_name happens to exist in the
> current tree you are applying the patch to, you can grab the contents of
> the unrelated file as the preimage and try to merge the changes in.
> 
> When running --index-info for the purpose of "am -3" (hence rebase), the
> expectation is that the tree you are applying the changes to is _similar_
> to the preimage of the change, i.e. old_name.  Shouldn't missing old_name
> be treated as a fatal condition?  new_name does not have to even exist
> because otherwise you cannot accept a patch that creates the path.
> 
> Wouldn't this be a better patch, I wonder...
> 
> builtin-apply.c |    3 +--
> 1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git i/builtin-apply.c w/builtin-apply.c
> index 4c4d1e1..7de70e9 100644
> --- i/builtin-apply.c
> +++ w/builtin-apply.c
> @@ -2573,8 +2573,7 @@ static void build_fake_ancestor(struct patch *list, const 
> char *filename)
>         else if (get_sha1(patch->old_sha1_prefix, sha1))
>             /* git diff has no index line for mode/type changes */
>             if (!patch->lines_added && !patch->lines_deleted) {
> -                if (get_current_sha1(patch->new_name, sha1) ||
> -                    get_current_sha1(patch->old_name, sha1))
> +                if (get_current_sha1(patch->old_name, sha1))
>                     die("mode change for %s, which is not "
>                         "in current HEAD", name);
>                 sha1_ptr = sha1;


Yes, this change makes more sense to me, but I'll defer to Johannes' opinion before submitting another patch.

Dave
