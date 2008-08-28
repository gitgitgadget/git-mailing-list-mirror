From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] dir.c: avoid c99 array initialization
Date: Thu, 28 Aug 2008 16:45:33 -0500
Message-ID: <4KsgvHQW6DRyM-ubFIcJEblIIJPpRQFHIc-4QMPGe5YzXAU8P5wWCA@cipher.nrlssc.navy.mil>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil> <G-ipWASixyGW7nvO1KquifehvBB7FNKwjPtIB0ukyEJ1Si1CJWM34w@cipher.nrlssc.navy.mil> <871w09kvew.fsf@lysator.liu.se> <GwKOGVPR0AVw4_Phmw1TSNzzMDtafrawMMahm2DQwh44k6uTOHkjTQ@cipher.nrlssc.navy.mil> <7vhc95dldz.fsf@gitster.siamese.dyndns.org> <ojPuT0s3trguL5yp3hozXVxP1WsidV5hbSISvFZjv5JUCO31lWTzEw@cipher.nrlssc.navy.mil> <81b0412b0808281412j2a5643ceu49a49cf62002f0be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?RGF2aWQgS8OlZ2VkYWw=?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 23:47:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYpKX-0000Fu-Df
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 23:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091AbYH1Vpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 17:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755234AbYH1Vpw
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 17:45:52 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34757 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754390AbYH1Vpv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 17:45:51 -0400
Received: by mail.nrlssc.navy.mil id m7SLjXTL000831; Thu, 28 Aug 2008 16:45:33 -0500
In-Reply-To: <81b0412b0808281412j2a5643ceu49a49cf62002f0be@mail.gmail.com>
X-OriginalArrivalTime: 28 Aug 2008 21:45:33.0273 (UTC) FILETIME=[65DFA490:01C90957]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94186>

Alex Riesen wrote:
> 2008/8/28 Brandon Casey <casey@nrlssc.navy.mil>:
>> diff --git a/builtin-cat-file.c b/builtin-cat-file.c
>> index 7441a56..d954c09 100644
>> --- a/builtin-cat-file.c
>> +++ b/builtin-cat-file.c
>> @@ -212,7 +212,7 @@ int cmd_cat_file(int argc, const char **argv, const char *pr
>>        int opt = 0, batch = 0;
>>        const char *exp_type = NULL, *obj_name = NULL;
>>
>> -       const struct option options[] = {
>> +       struct option options[] = {
>>                OPT_GROUP("<type> can be one of: blob, tree, commit, tag"),
> 
> #ifdef HAVE_CONST
> #define gitconst const
> #else
> #define gitconst
> #endif
> 
> -	const struct option options[] = {
> +	gitconst struct option options[] = {
> 
> ?

The problem is not that the const modifier is unrecognized. You can see in
the above patch that the const modifier was not removed from exp_type or
obj_name.

I think the warning on line 217 is the most important where it complains
about a non-constant initializer, followed by complaints that the left
operand must be a modifiable lvalue.

I notice now that some functions have the 'struct option' and all of its
parameters declared static. I think this would satisfy the compiler, but
then the options would not be reinitialized if the function was called
again. Or are cmd_*() functions defined to only ever be called once?

-brandon
