From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] remote.c: spell __attribute__ correctly
Date: Mon, 25 Apr 2016 22:50:53 +0100
Organization: OPDS
Message-ID: <2FDBFACB68254498A8F83367553AED80@PhilipOakley>
References: <D7C0C4062A7242B6912E56480CBB06F4@PhilipOakley> <20160425211030.GA10309@sigill.intra.peff.net> <20160425211523.GA11227@sigill.intra.peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:51:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auoPE-0005Yr-5d
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 23:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbcDYVu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 17:50:56 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:28511 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964944AbcDYVu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 17:50:56 -0400
Received: from PhilipOakley ([92.22.74.182])
	by smtp.talktalk.net with SMTP
	id uoP7anfecGr60uoP7aipxR; Mon, 25 Apr 2016 22:50:53 +0100
X-Originating-IP: [92.22.74.182]
X-Spam: 0
X-OAuthority: v=2.2 cv=WYJOUApX c=1 sm=1 tr=0 a=/ihZocdjyYGcUybBdHAawQ==:117
 a=/ihZocdjyYGcUybBdHAawQ==:17 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8
 a=xtxXYLxNAAAA:8 a=SdszgZqIeaT_11ukrfsA:9
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfGtrU/rwGPzY3qC2yQv5ajD4KCwLaWED6StpzPhseGwNqxQhvzPY4VhO82h8hWAW331+cL7RkBijS9oXHOp2qft8dVg4c+pntRl7c16zPrEoCHcprxrS
 fm/JWtNOTgAUG137iOeN676+mBZ4sYzBNvhWBccfApgCoAlUfpemm5ihcnSjXDiiAR2pciKqVPdGymnxQlHN0SVsRIJxIS0Ja80Fiz3TOvXSkKZA0ZbQXfhY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292572>

From: "Jeff King" <peff@peff.net>
> On Mon, Apr 25, 2016 at 05:10:30PM -0400, Jeff King wrote:
>
>> It should be handled in git-compat-util.h, which is included by cache.h,
>> which is included by remote.c.
>>
>> There we have:
>>
>>   #ifndef __GNUC__
>>   #ifndef __attribute__
>>   #define __attribute__(x)
>>   #endif
>>   #endif
>>
>> which should make it a noop on compilers which don't know about it. Is
>> VS (or another file) setting __GNUC__?
>
> Of course it helps if we spell the name right...
>
> -- >8 --
> Subject: remote.c: spell __attribute__ correctly
>
> We want to tell the compiler that error_buf() uses
> printf()-style arguments via the __attribute__ mechanism,
> but the original commit (3a429d0), forgot the trailing "__".
> This happens to work with real GNUC-compatible compilers
> like gcc and clang, but confuses our fallback macro in
> git-compat-util.h, which only matches the official name (and
> thus the build fails on compilers like Visual Studio).
>
> Reported-by: Philip Oakley <philipoakley@iee.org>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> remote.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/remote.c b/remote.c
> index 28fd676..ddc4f8f 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1660,7 +1660,7 @@ int branch_merge_matches(struct branch *branch,
>  return refname_match(branch->merge[i]->src, refname);
> }
>
> -__attribute((format (printf,2,3)))
> +__attribute__((format (printf,2,3)))
> static const char *error_buf(struct strbuf *err, const char *fmt, ...)
> {
>  if (err) {
> -- 

Thanks for clarifying that (sorry about the crossed emails). The compile is 
now looking good.
I'm just left with some unresolved external symbol link errors now.

The same naming issue in compat/regex/regcomp.c, compat/regex/regexec.c, 
compat/regex/regex_internal.c and compat/regex/regex_internal.h  was 
probably what lead me astray...

Philip
