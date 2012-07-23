From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Make sure to use Araxis' "compare" and not e.g. ImageMagick's
Date: Mon, 23 Jul 2012 23:09:29 +0200
Message-ID: <CAHGBnuOz94YR9wx_goL5YaWzPt5Z9c3gBB9CtyfcE40F5amrXw@mail.gmail.com>
References: <500CF8CE.90906@gmail.com>
	<500CF9D2.30102@gmail.com>
	<500CFB19.6010905@gmail.com>
	<7vmx2qmnfw.fsf@alter.siamese.dyndns.org>
	<500DA7F3.3000403@gmail.com>
	<7v4noykxvm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 23:09:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StPsl-00015Z-Hu
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 23:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849Ab2GWVJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 17:09:30 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:33456 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663Ab2GWVJa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 17:09:30 -0400
Received: by vcbfk26 with SMTP id fk26so5218931vcb.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 14:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5LzYKh64zpypbiG12Ym7+B+ESxvhqnCICAvcvdAqhHQ=;
        b=qaatQiF2x1svd9Sf0a5x7CdP1WUP437TZZM1uUgj0ajOxpqXk+c89rZ4lpHBX4PweG
         MhVi5FgSu4Or9Dt9zORlc+Co9YNF8W92gyzUgiL96ypBq9IC++FCN+Dm3UVvNkV84vKX
         9X4CiziN/4GZbYc2vtSUQqaR3+1oZ2SEjyNDFhV6cO7ERfbtXMRsTPwi7tDfB+Ui1ki+
         o8BzNuRKwqa3crPOI6/6JosTCdnbR/p9rp+qIBtdgy66kUjPWLV1EtrnoW7S7TsAD1de
         1FftLm4PN1K4V8r2kizcB61U3i+7aaLq4hUvMy/P1yHrSRG71Dfb+4Y1f290cW8DdLuu
         kEgw==
Received: by 10.221.12.14 with SMTP id pg14mr13788385vcb.21.1343077769294;
 Mon, 23 Jul 2012 14:09:29 -0700 (PDT)
Received: by 10.58.35.135 with HTTP; Mon, 23 Jul 2012 14:09:29 -0700 (PDT)
In-Reply-To: <7v4noykxvm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201983>

On Mon, Jul 23, 2012 at 10:47 PM, Junio C Hamano <gitster@pobox.com> wrote:

> For example, when the user tells it to install in "/home/ss/bin", if
> it installs its "compare" program in "/home/ss/bin/araxis/compare"
> without allowing the "/araxis/" part to be stripped away, the above
> heuristics is sufficiently safe.  Otherwise, it is not.

To the best of my knowledge, Araxis does not enforce any naming
convention for the path it gets installed in. That means the user may
indeed install the program in a path that does not contain "araxis". I
was aware of this when writing the patch, but should have probably
made it more clear in the commit message.

> It is unclear from your proposed commit log message what assurance
> do we have that it is installed under such a path and why the
> heuristics the patch implements is the sane way forward.

We have no such assurance. That's why you correctly call it a
heuristics after all: it may fail. Personally, I've valued the gain of
the patch to not list araxis as an available diff tool by "git
difftool --tool-help" when in fact just ImageMagick is in PATH higher
than the loss to support araxis installations that are in a path not
containung "araxis" but are in PATH.

Please feel free to ignore the patch if you feel the heuristics is not
sufficiently safe. I'm currently unable to come up with a safer
solution while maintaining portability, i.e. not use "which" or doing
rather laborious string parsing on the output of "type".

-- 
Sebastian Schuberth
