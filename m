From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [nit] diff func headers ignore context
Date: Wed, 14 Sep 2011 12:01:00 -0700
Message-ID: <7vpqj3t0cz.fsf@alter.siamese.dyndns.org>
References: <20110913215026.GA26743@sigill.intra.peff.net>
 <20110913215824.GG24490@sigill.intra.peff.net>
 <20110913220421.GA24549@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 14 21:01:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3uhq-0003jw-Ph
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 21:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686Ab1INTBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 15:01:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37855 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932462Ab1INTBD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 15:01:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B345554B0;
	Wed, 14 Sep 2011 15:01:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uJLacBRma+Dkwas01na+Ex94jKo=; b=GP1+FL
	4OMxCM8q6H3PTtNM9rBaDszhUhlajW6srxJqyK/5bkDu14D+0fGCMf22jHqBmqVi
	MGOBx8ft+XliVsCzC0tbfGFhp7K23zDFmquehxHb/Pvbztqy3kFi5Nb9lt1DI79W
	6+A7KJDlOR1qJhFcr9eJQxFUf2a/T0kJk9Zqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G1c++oBoe4+SXUQ+sm6/JrK+aLCyHP50
	FFuEZEodSkXXiVqom5EIUmBoAQckvrWuThIvA9qxr05d9vbuL94muvBGYcGxF9F5
	x9XTJD1k6cOkCDlUIG8uXmMGWlKU6+ERSwMFDOyaErn02bSVSi1FY3pQ5OHvzYTI
	2XgvGdVvDe4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA98B54AF;
	Wed, 14 Sep 2011 15:01:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 300B254AE; Wed, 14 Sep 2011
 15:01:02 -0400 (EDT)
In-Reply-To: <20110913220421.GA24549@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 13 Sep 2011 18:04:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3DF5C70-DF03-11E0-8CEB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181385>

Jeff King <peff@peff.net> writes:

> On Tue, Sep 13, 2011 at 05:58:25PM -0400, Jeff King wrote:
>
>> @@ -609,26 +610,23 @@ int finish_async(struct async *async)
>>  int run_hook(const char *index_file, const char *name, ...)
>>  {
>>  	struct child_process hook;
>> -	const char **argv = NULL, *env[2];
>> +	struct argv_array argv = ARGV_ARRAY_INIT;
>
> I find this diff function header pretty confusing. Of course we're not
> in finish_async, as you can see by the fact that the context contains
> the start of run_hook.
>
> I don't think this is something that can be solved with xfuncname
> config; we would have to teach xdiff to look at context lines when
> picking a header line.
>
> Am I the only one who finds this confusing? Can anyone think of a reason
> to keep showing finish_async in this example?

Would this be sufficient?  Instead of looking for the first line that
matches the "beginning" pattern going backwards starting from one line
before the displayed context, we start our examination at the first line
shown in the context.

 xdiff/xemit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 277e2ee..5f9c0e0 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -131,7 +131,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 
 		if (xecfg->flags & XDL_EMIT_FUNCNAMES) {
 			long l;
-			for (l = s1 - 1; l >= 0 && l > funclineprev; l--) {
+			for (l = s1; l >= 0 && l > funclineprev; l--) {
 				const char *rec;
 				long reclen = xdl_get_rec(&xe->xdf1, l, &rec);
 				long newfunclen = ff(rec, reclen, funcbuf,
