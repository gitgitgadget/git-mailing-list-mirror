From: Brandon Casey <drafnel@gmail.com>
Subject: Re: git ate my home directory :-(
Date: Mon, 25 Mar 2013 15:21:11 -0700
Message-ID: <CA+sFfMexDR50b5FnJ-4MS8pxPXmg0CCbzCLVc3vx5XjfqdY1nQ@mail.gmail.com>
References: <5150C3EC.6010608@nod.at>
	<20130325214343.GF1414@google.com>
	<7vboa7w2vm.fsf@alter.siamese.dyndns.org>
	<20130325221355.GH1414@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Richard Weinberger <richard@nod.at>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 23:21:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKFls-0008NO-0m
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 23:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758937Ab3CYWVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 18:21:13 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:50928 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248Ab3CYWVM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 18:21:12 -0400
Received: by mail-wi0-f177.google.com with SMTP id hm14so7290328wib.4
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 15:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=hfXo+5hXdXHyJ2m6vtyvCOCN7QTFCVavUoNt1fzFWd4=;
        b=P0+JVDGXa5HjXQEqAcS5Bd8yAYjpJFsLcWBYFVq1jQlCXC7j6zjndwxqcFTUVkIIiy
         Jp6vZ/ZYvKiJOq8ERcTcOjsu0a6KwdJth1N9BD0lWnbBeAvPLvKBAE1s+paPr/3iAco1
         aw4m+Ll3FBzP+oAjWwoeDSJ3KWzZ1xJTssXHmDPCxw3TE8oqigpyubEP2NQmOKQUSXtg
         v/iEVa8IteWh7SSXjnYlW366v4hJ88lApxn511hAmuFL9vhmWGwvl/sSxOKb9hexLXXu
         rynIICZTboHLcGaekOzDSIedXP/tLn5GJ+NI4GElQdHqAtk4XHe9iqysGyL6stCTuKIv
         rtWw==
X-Received: by 10.194.10.129 with SMTP id i1mr8609674wjb.21.1364250071172;
 Mon, 25 Mar 2013 15:21:11 -0700 (PDT)
Received: by 10.194.143.10 with HTTP; Mon, 25 Mar 2013 15:21:11 -0700 (PDT)
In-Reply-To: <20130325221355.GH1414@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219112>

On Mon, Mar 25, 2013 at 3:13 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Junio C Hamano wrote:
>
>>                                                            I do not
>> know how things will break when the end user sets and exports it to
>> the environment, and I do not think we would want to make any
>> promise on how it works.
>
> That's a reasonable desire, and it means it's a good thing we noticed
> this before the envvar escaped to "master".  People *will* use such
> exposed interfaces unless they are clearly marked as internal.  That's
> just a fact of life.
>
> Here's a rough patch to hopefully improve matters.
>
> Longer term, it would be nice to have something like
> GIT_IMPLICIT_WORK_TREE exposed to let scripts cache the result of the
> search for .git.  Maybe something like "GIT_BARE=(arbitrary value)"
> would be a good interface.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>
> diff --git a/cache.h b/cache.h
> index 59e5b53..8f92b6d 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -377,7 +377,7 @@ static inline enum object_type object_type(unsigned int mode)
>   * of this, but we use it internally to communicate to sub-processes that we
>   * are in a bare repo. If not set, defaults to true.
>   */
> -#define GIT_IMPLICIT_WORK_TREE_ENVIRONMENT "GIT_IMPLICIT_WORK_TREE"
> +#define GIT_IMPLICIT_WORK_TREE_ENVIRONMENT "GIT_INTERNAL_IMPLICIT_WORK_TREE"

Maybe the environment variable for internal-use-only should be
prefixed with an underscore?

-Brandon
