From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 7/8] remote-bzr: reorganize the way 'wanted' works
Date: Tue, 28 May 2013 21:31:07 -0500
Message-ID: <51a5686ba7f2c_807b33e189951a@nysa.mail>
References: <1369448666-17515-1-git-send-email-felipe.contreras@gmail.com>
 <1369448666-17515-8-git-send-email-felipe.contreras@gmail.com>
 <7vvc632g1s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 04:33:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhWCV-0000lg-Vc
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 04:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759323Ab3E2CdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 22:33:16 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62286 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab3E2CdP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 22:33:15 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd20so3684286obb.33
        for <git@vger.kernel.org>; Tue, 28 May 2013 19:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=lc4QKoAl9jqxd+PFcy2yUnKXlM6VX2/4eBMTu2Vgcjg=;
        b=SMc3luU+8RUI2hEYgAfubsikS68O1m+HodsZi6DBr0xNJgT/n0ZtHjXt7HxW1Nkpbd
         NNLNl1ZVv+5oD7WnrJReCll216v691OTKkSU8JdLVhbCYxM7lWwGKZQUDVtb4masuPXa
         9i7DUKBbNp9pasKMONfQ1B/bZ/QjNEjosvtfSQ+DlfZzJqLNwAoOOElC2eKA1DmPYbhZ
         w1IW0j/MhdsTVfZUIMDQu7a1TPQZZ8mMZCgVs/XRmkiLUwj6wx+XF0zzkoml0rOV2z+u
         fri5aL4GsgnnZi0yb79jkbTg7qDPd+hhamVEfCwtKVzfakVCkVwuIAAa3ARU0aYf60td
         tIFg==
X-Received: by 10.60.121.106 with SMTP id lj10mr336199oeb.128.1369794794676;
        Tue, 28 May 2013 19:33:14 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x10sm38931501oes.6.2013.05.28.19.33.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 19:33:13 -0700 (PDT)
In-Reply-To: <7vvc632g1s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225699>

Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > +    wanted = get_config('remote-bzr.branches').rstrip().split(', ')
> 
> Two minor nits and one design suggestion:
> 
>  - Why rstrip() not strip()?

The purpose of the strip is to remove the _single_ "\n" at the end that
subprocess communicate. Maybe get_config() should do that.

> It appears that this only is helping
>    an end-user "mistake" like this:
> 
> 	git config remote-bzr.branches 'trunk, devel, test '
> 
>    without helping people who have done this:
> 
> 	git config remote-bzr.branches 'trunk,  devel, test'

No, that's tnot it.

>  - Is
> 
>      git config remote-bzr.branches trunk,devel,test
> 
>    a grave sin?
> 
>    In other words, wouldn't we want something like this instead?
> 
> 	map(lambda s: s.strip(), get_config('...').split(','))

Yeah, that might make sense.

>  - Doesn't allowing multi-valued variable, e.g.
> 
> 	[remote-bzr]
>             branches = trunk
>             branches = devel
>             branches = test
> 
>    make it easier for the user to manage this configuration by
>    e.g. selectively removing or adding tracked branches?

How would the 'git config' command look like?

Either way, that's orthogonal to this patch.

-- 
Felipe Contreras
