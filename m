From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] read_loose_refs(): treat NULL_SHA1 loose references as broken
Date: Wed, 03 Jun 2015 11:51:43 -0700
Message-ID: <xmqqr3pswrpc.fsf@gitster.dls.corp.google.com>
References: <cover.1433339279.git.mhagger@alum.mit.edu>
	<eb79f7d96ec74445f7adf62757119273280e09c9.1433339279.git.mhagger@alum.mit.edu>
	<20150603140803.GA23901@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 03 20:51:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0DlX-0006DG-9u
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 20:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758380AbbFCSvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 14:51:47 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37918 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758342AbbFCSvq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 14:51:46 -0400
Received: by igblz2 with SMTP id lz2so21957457igb.1
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 11:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Cg8ufocpDv5zawvqUSI1g8kPfMM4dxDA8dmpexW1pQs=;
        b=u/KGD49+ImOI7ROYKhbIEVhbOqlHgf7dstxqeqcQSqHw/psPq55sh8eBOekMbzCeqy
         qKl2HYbZRhj1nTe39Q7UkxV83WhxDXfGiuB/7oW9ZLXWDiE1IBdHYihEV81+tEeUgLzt
         LBX/8QKnQA28dTi0ROip/yFQbEpsB3w+mXkbGd0s/BwfC1kg/UVuR0GY0ID3NwYGvfGj
         k+qeCFoVLba8fCc9WMXHkLA4kfE6Xk8JPhMI4yg9E1sCAhHW3Uhd+97MYnNey1FwoU8m
         FMVt3tsDcNxBoLh1KjpWIMDZ5OuY2w09HW6gH/a8+lUpcBz1FHmT3KXftLsjbGn9HevP
         t95A==
X-Received: by 10.43.84.73 with SMTP id aj9mr21668icc.69.1433357505363;
        Wed, 03 Jun 2015 11:51:45 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:9816:1e41:550:d20e])
        by mx.google.com with ESMTPSA id z6sm5414956ign.13.2015.06.03.11.51.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jun 2015 11:51:44 -0700 (PDT)
In-Reply-To: <20150603140803.GA23901@peff.net> (Jeff King's message of "Wed, 3
	Jun 2015 10:08:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270722>

Jeff King <peff@peff.net> writes:

> On Wed, Jun 03, 2015 at 03:51:59PM +0200, Michael Haggerty wrote:
>
>> NULL_SHA1 is used to indicate of "invalid SHA-1" throughout our code
>
> s/of/an/ ?

Also possibly s/invalid SHA-1/invalid ref/?

>> (and the code of other git implementations), so it is vastly more
>> likely that a reference was set to this value due to a software bug
>> than that NULL_SHA1 is the legitimate SHA-1 of an actual object.
>> Therefore, if a loose reference has the value NULL_SHA1, consider it
>> to be broken.
>> 
>> Amusingly, each of the other 2^160-1 possible SHA-1 values is exactly
>> as unlikely as NULL_SHA1 to be the SHA-1 of an actual object. The
>> difference is that most of those other values are also very unlikely
>> to be written to a loose reference file by accident, whereas
>> accidentally writing NULL_SHA1 to a loose reference file would be an
>> easy mistake to make.
>
> FWIW, I think this justification (and the comment below) reads better
> than what you had before.

I agree, and further I think the second paragraph is redundant and
unnecessary.  If you update "... likely that a reference was set to
this value" to clarify that the "reference" it talks about is an
on-disk entity, not the in-core representation (which can
legitimately have NULL_SHA1 to signal "invalid ref", it would be
sufficient.  I.e.

	... so it is vastly more likely that an on-disk reference
	was set to this value due to a bug ...
