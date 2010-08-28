From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] t6200-fmt-merge-msg: Exercise 'merge.log' to
 configure shortlog length
Date: Sat, 28 Aug 2010 16:05:39 +0530
Message-ID: <20100828103536.GA12205@kytes>
References: <1282918490-5190-1-git-send-email-artagnon@gmail.com>
 <1282918490-5190-2-git-send-email-artagnon@gmail.com>
 <20100828020018.GD2004@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 28 12:37:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpIn1-0003Vh-11
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 12:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616Ab0H1Kh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 06:37:27 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:64142 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab0H1Kh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 06:37:26 -0400
Received: by pxi10 with SMTP id 10so1408542pxi.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 03:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=IIih2K1qMH77JOKAH/j8Q2vgOwGQZulHtNJ61iT8dNs=;
        b=PwRQFN63g3DcVEpoUhsUja+jZRdDPWFRIkE+V8lI70EdagBXJ0DqjXe6P0DHh247ji
         VbfNdJwPO+aQ4BHB2Dl0ciGtQOaEHP0XNtfxyw1c21F0DflUuYX1q0ZVfOlSm+kx/qoY
         hjzYwKecG+e9JmRU+Iz8EjANxzwj4Pz05l/LQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RWGKwQjNRa1FiyMzKjfZYRNIMFd3e//SbmobvWo7NnSHPDhT0ffOB/9CaJjy8Y6p7J
         1MYgfm3lo+QKbTkX17rIdiLBNGDMvRp3H2Xr9e6EqJq78FNMcPufRiNKQpBobasbmxMg
         1R5iURAwpVYizVfIu+I4qojZTny7B8S2q7LqE=
Received: by 10.114.67.8 with SMTP id p8mr224041waa.102.1282991845342;
        Sat, 28 Aug 2010 03:37:25 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id 33sm8700071wad.6.2010.08.28.03.37.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 03:37:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100828020018.GD2004@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154636>

Hi Jonathan,

Jonathan Nieder writes:
> I suspect this test would be easier to understand if split up (yes, I
> know I'm guilty of the same in other tests from this file).

I sort of tried to follow what was done in the rest of the file. If
this style is desired instead, I'll post an alternative series
instead.

> 	test_expect_success 'setup: clear [merge] configuration' '
> 		test_might_fail git config --unset-all merge.log &&
> 		test_might_fail git config --unset-all merge.summary
> 	'
> 
> 	test_expect_success 'set up FETCH_HEAD' '
> 		git checkout master &&
> 		git fetch . left
> 	'

Okay.

> 	test_expect_success 'merge.log=3 limits shortlog length' '
> 		test_might_fail git config --unset merge.log &&
> 		test_might_fail git config --unset merge.summary &&

Redundant, as you pointed out in another email.

> 		cat >expected <<-\EOF &&
> 		  Left #3
> 		  ...
> 		EOF
> 		git -c merge.log=3 fmt-merge-msg <.git/FETCH_HEAD >msg &&
> 
> 		tail -n 2 msg >actual &&
> 		test_cmp expected actual
> 	'

Ok. I don't like the `tail` thing. Why are you doing it instead of
comparing full outputs like the tests in the rest of the file?

> 	test_expect_success 'shortlog length defaults to 20' '
> 		[...]
> 	'

Actually, we can't test this unless we actually create a branch with
20 commits and merge it. I've dropped this- you might like to add it
during the cleanup.

> 	test_expect_success 'merge.log=5 does not limit shortlog length' '
> 		[...]
> 	'

Okay.

> 	test_expect_success 'merge.log=6 does not limit shortlog length' '
> 		[...]
> 	'

I thought this was a bit of an overkill, so I removed it.

> 	test_expect_success 'merge.log=0 disables shortlog' '
> 		[...]
> 	'

Okay.

> 	test_expect_success 'merge.log=-1 does something sane' '
> 		[...]
> 	'

Thanks! I found a bug and fixed it (patch will come in a moment).

> I can clean up the earlier tests afterwards. :)

Okay, sounds good.

-- Ram
