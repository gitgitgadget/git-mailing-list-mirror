From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] setup: do not create $X/gitdir unnecessarily when
 accessing git file $X
Date: Tue, 3 Nov 2015 06:48:31 +0100
Message-ID: <CACsJy8Csjgcv_L+TW9YPTs5V=T2XD+eqo1w1PO4jpfDoHLQKpQ@mail.gmail.com>
References: <xmqqwpu7klmu.fsf@gitster.mtv.corp.google.com> <1446491306-13493-1-git-send-email-pclouds@gmail.com>
 <20151102203507.GB10722@sigill.intra.peff.net> <xmqqtwp4dt17.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	rappazzo@gmail.com, kyle@kyleam.com,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 06:54:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtUYX-0005OH-70
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 06:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbbKCFtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 00:49:06 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34023 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbbKCFtD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 00:49:03 -0500
Received: by lfgh9 with SMTP id h9so5794030lfg.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 21:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=W7wn2SyHeI7vNGNa2hz5qcDDS/Vz5r39huYxMe+rbKk=;
        b=yuMfDcdm7Y8NlBUJG1QW0GFY4wWvlvVO2qr6qGmY+0DaYnlakxawEWGnOzW5ig7IMg
         P+CUx3F7ClP5Mwt+bsHl2EVDtf7lfKM6u54cVxHRTb4/YhiZoRIamvOowDfsunTUrTzO
         P3jnXO5dTe6yZVp7bi28cJ7Lo6A7KBxX5AZgQs2DIbSqspNVE8JLINWKhvfPgE4qTTjy
         j3XMue1NS5OTjYNGR3/xDh8LiMpq7EZ/ZvcmLvbv5VKzLeedLY3nF3sgCYIKye1PijyB
         ZfUppCYaLx6BwAFrkkejX94ywpkvOmC+jpdkIFC0rUJFkhtDw1H65b3DE26tj8bhAp8O
         eV4Q==
X-Received: by 10.25.24.195 with SMTP id 64mr8001623lfy.71.1446529741266; Mon,
 02 Nov 2015 21:49:01 -0800 (PST)
Received: by 10.112.255.229 with HTTP; Mon, 2 Nov 2015 21:48:31 -0800 (PST)
In-Reply-To: <xmqqtwp4dt17.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280749>

(resend)

On Mon, Nov 2, 2015 at 9:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> [2] I suspect this code should use write_file_gently(). What happens if
>>     I have a read-only linked checkout?

I can't hide anything from you guys can I? :) My first attempt was
move this update logic back to setup_..._gentle where it should
belong, but it got complicated because read_file_gently was buried too
deep and there was no easy way to get the information out.

I can try again, or..

>
> Or you may not be the owner of the repository, you think you are
> doing a read-only operation, and you silently end up creating a file
> that cannot be written by the repository owner?
>
> Honestly, I think this whole "just in case the user moved without
> telling us, we sneakily fix things without telling the user" should
> just go away.  This is not the first incidence of a tool trying to
> be overly clever and pretend to know better than the end user biting
> us, is it?

The whole prune strategy is a bit messy trying to cover all cases
while still keeping out of the user's way. Perhaps if we implement
"git worktree mv", or even "worktree fixup" so the user can do it
manually (back when the prune strategy commit was implemented, there
was no git-worktree), then we don't need this magic any more.

So, which way to go?

-- 
Duy
