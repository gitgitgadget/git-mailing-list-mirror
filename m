From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test: add git apply whitespace expansion tests
Date: Sun, 18 Jan 2015 14:11:45 -0800
Message-ID: <CAPc5daXVk_ROUy7rmzS0aosWvE2wqw8tHZgomHHkay9CZjhbiw@mail.gmail.com>
References: <CAO2U3QjGUfnTRO_poS+=-MfE4aYGuWpVJTe20H-u=FgkVy-RYg@mail.gmail.com>
 <CAO2U3Qjn9o_eYayEMCC3S6DBr9kVH7mPL00QGrXAnV2iYRP-=A@mail.gmail.com>
 <CAO2U3Qj-Hg2tb72NgO6wb-aqAxFG7aga2ZDeZNDCPJzGtmHTAA@mail.gmail.com>
 <CAO2U3Qhd_DPP09BUyMr6NKUtOe4EQQ7G83BRg7MbtQXFPjKv8w@mail.gmail.com>
 <CAO2U3Qje-YwcV1d5BK_zZqrTki4AU=emdkUZzEEieRjmoQdmGg@mail.gmail.com>
 <CAO2U3Qi4TWZiNoOQVSW=Ycvp3bpBySZrCGmRLCbRJJes_n2Wkw@mail.gmail.com>
 <99579252-EF8A-4DAF-A49D-2AC5627ED9E3@gmail.com> <4157F6B0-DDF4-4F71-A09B-EE216537CA89@gmail.com>
 <xmqqbnly1oqo.fsf@gitster.dls.corp.google.com> <xmqqzj9iz3gu.fsf_-_@gitster.dls.corp.google.com>
 <102e322e68e78e39a7c227f3f3e102c@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Michael Blume <blume.mike@gmail.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 23:12:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCy4q-0001hD-UH
	for gcvg-git-2@plane.gmane.org; Sun, 18 Jan 2015 23:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbbARWMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2015 17:12:08 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:50826 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbbARWMG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2015 17:12:06 -0500
Received: by mail-ob0-f179.google.com with SMTP id nt9so26278311obb.10
        for <git@vger.kernel.org>; Sun, 18 Jan 2015 14:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=37CDq53FQsvfA5joPNKO6O6Ab37nb1tYloar6/mQY2A=;
        b=n2tx1hkDMeWSnTRs/FmHwVzTkD7q3jw7wbsBbtYnriK1KvYVbStk81jdNZ9ei/9d0m
         5zerqXb/eymHiNFUyOAEiSKK5nK8uLqZQ3lmEqVUp96Q5j7KfhIvVKHeE87yLDOijjnG
         qcbED7RhXu7HbU3iCkHO+TLeJqxmd6Y2HTzZ0hTmRP7gtE8to/gXJpsgL+IdB9Dix5gx
         qVL9McAAuLgYlY+NXuJz36813Kgul6RD3pq4WdYLn8izhmcpXM6GQUQ3tz7PnXvt+yTe
         uSfR9SX0LNQHdvvjk2JpNmRUcuu3MY6d+1ONb5nfY2awOE58RcAe3orefosJ64c+yF02
         aSIQ==
X-Received: by 10.202.204.198 with SMTP id c189mr3334290oig.81.1421619126157;
 Sun, 18 Jan 2015 14:12:06 -0800 (PST)
Received: by 10.202.86.200 with HTTP; Sun, 18 Jan 2015 14:11:45 -0800 (PST)
In-Reply-To: <102e322e68e78e39a7c227f3f3e102c@74d39fa044aa309eaea14b9f57fe79c>
X-Google-Sender-Auth: ugDMxVr1Ha-N6-tWtJjE_IogK4s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262605>

On Sun, Jan 18, 2015 at 2:49 AM, Kyle J. McKay <mackyle@gmail.com> wrote:
> * Here's some tests.  With "apply: make update_pre_post_images() sanity
>   check the given postlen" but not "apply: count the size of postimage
>   correctly" test 1/4 and 4/4 trigger the 'die("BUG: postlen...' but
>   test 2/4 and 3/4 do not although they fail because git apply generates
>   garbage.

Do the failing cases that do not trigger the new postlen check fail
because the original (mis)counting thinks (incorrectly) that the
rewritten result _should_ fit within the original postlen (hence we
allow an in-place rewrite by passing postlen=0 to the helper), but
in fact after rewriting postimage->len ends up being longer due to
the miscounting?
