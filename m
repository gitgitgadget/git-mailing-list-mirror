From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool: Skip autoresolved paths
Date: Thu, 19 Aug 2010 20:52:46 -0700
Message-ID: <20100820035236.GA18267@gmail.com>
References: <7veie0gy3r.fsf@alter.siamese.dyndns.org>
 <1282036966-26799-1-git-send-email-davvid@gmail.com>
 <201008191202.36508.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Magnus =?utf-8?B?QsOkY2s=?= <magnus.back@sonyericsson.com>,
	Charles Bailey <charles@hashpling.org>,
	Avery Pennarun <apenwarr@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 20 05:52:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmIep-0003zF-6c
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 05:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716Ab0HTDwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Aug 2010 23:52:38 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54351 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab0HTDwg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 23:52:36 -0400
Received: by pzk26 with SMTP id 26so1055297pzk.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 20:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jC08eJgjQVpvC/vKIXsLfZdGDUMNPhA8q87gBWjgkXU=;
        b=phqSj1PJ+SQPoPUIbbQufjbWy0VJwJTC/kPqvIxihrZwa+pbiZgc1VX3r1LhZAbZ62
         yvFTjWR0N+HSQ+j/oBzFpUBEQ4gVOET2Mcy6jSPchXrvVPn5T+uJhDnHcUQSJ0I/A+gW
         qGBlyUkvyHuzeAANCIhafAyseXeXeJjeIj/Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WyIP/j8VSpp3GSx1pMhK9Ee1hsO5A0KZFCRNpgQLYpp1QW+I6lHKD0OGTYSMRztCBj
         FicFPItrzUdiHvh0rcKp/+Qz5PjHfOhncK+1pMN5WbPs9msLgG6tsq0BVqamX4i+tiQv
         1u6/hpyH9NMCSmzbPnDzLPMeEQgYktHpddg8Q=
Received: by 10.142.127.9 with SMTP id z9mr589126wfc.193.1282276356386;
        Thu, 19 Aug 2010 20:52:36 -0700 (PDT)
Received: from gmail.com (cpe-76-170-148-32.socal.res.rr.com [76.170.148.32])
        by mx.google.com with ESMTPS id t11sm2622276wfc.4.2010.08.19.20.52.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Aug 2010 20:52:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201008191202.36508.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153972>

On Thu, Aug 19, 2010 at 12:02:36PM +0200, Thomas Rast wrote:
> David Aguilar wrote:
> > When mergetool is run without path limiters it loops
> > over each entry in 'git ls-files -u'.  This includes
> > autoresolved paths.
> [...]
> > +test_expect_success 'mergetool merges all from subdir' '
> > +    cd subdir && (
> > +    git config rerere.enabled false &&
> > +    test_must_fail git merge master &&
> > +    git mergetool --no-prompt &&
> > +    test "$(cat ../file1)" = "master updated" &&
> > +    test "$(cat ../file2)" = "master new" &&
> > +    test "$(cat file3)" = "master new sub" &&
> > +    git add ../file1 ../file2 file3 &&
> > +    git commit -m "branch2 resolved by mergetool from subdir") &&
> > +    cd ..
> > +'
> 
> This test never worked in my automatic testing (it fails and bisects
> to this commit).
> 
> It might be because the cronjob doesn't have a tty, as I'm seeing the
> output below (note the error at the end).  Any insights?

It must be the tty.


> expecting success: 
>     cd subdir && (
>     git config rerere.enabled false &&
>     test_must_fail git merge master &&
>     git mergetool --no-prompt &&
>     test "$(cat ../file1)" = "master updated" &&
>     test "$(cat ../file2)" = "master new" &&
>     test "$(cat file3)" = "master new sub" &&
>     git add ../file1 ../file2 file3 &&
>     git commit -m "branch2 resolved by mergetool from subdir") &&
>     cd ..
> [...]
> /local/home/trast/git/t/valgrind/bin/git-mergetool: line 302: /dev/tty: No such device
>  or address
> /local/home/trast/git/t/valgrind/bin/git-mergetool: line 299: /dev/tty: No such device
>  or address


git-mergetool lines 295-307:

    files_to_merge |
    while IFS= read i
    do
	if test $last_status -ne 0; then
	    prompt_after_failed_merge < /dev/tty || exit 1
	fi
	printf "\n"
	merge_file "$i" < /dev/tty > /dev/tty
	last_status=$?
	if test $last_status -ne 0; then
	    rollup_status=1
	fi
    done

The reason the test fails without a tty is that we've never
exercised this code in the past.

This commit did not introduce the "< /dev/tty > /dev/tty"
idiom.  It was introduced in b0169d84 by Charles Bailey.
What this commit did do was add test coverage to it,
which is good because it uncovered this problem :-)

Charles, is there another way we can write this?
Is there a reason why we need the tty redirection?
Can we drop it or is there a portability concern?

FWIW, the merge_file call in the else clause that follows
this section does not use tty redirection.

-- 

	David
