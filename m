From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] builtin-commit: add --cached to operate only on index
Date: Tue, 27 Nov 2007 19:12:30 +0100
Message-ID: <81b0412b0711271012v67f1058fj8c0de8e511543d4e@mail.gmail.com>
References: <81b0412b0711270254i58be4d2fi5021767d99fcb753@mail.gmail.com>
	 <474C0105.3010908@viscovery.net>
	 <81b0412b0711270448s6534a849u86bcb161d4d7b3fe@mail.gmail.com>
	 <7vfxyrd2x2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <krh@redhat.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 19:13:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix4vs-0005z9-4d
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 19:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756361AbXK0SMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 13:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756678AbXK0SMe
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 13:12:34 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:46544 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756361AbXK0SMd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 13:12:33 -0500
Received: by wr-out-0506.google.com with SMTP id c49so950240wra
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 10:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=mrUOilNBBihxsFtHSvFT/u9Ryb4DbaEuHXukKw2F/O0=;
        b=IgbY3czUZtdDktorc1uM/YxBY4Hlj004CtNv89HnXhlkgwjS5DkJEszWLddsgKsxd9XhOEisFtxxbmFRqjDGTUAP8T8Rviri0nT3FOlSo016oK5phbJ+2xCJ1FosB+lUo/+oSkJd5G9leiuF/i+cBpDL8d3mjG2jFQGxmcMIQQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DGVHxJcmU3PE/s544YO46jpTYKX4p3krXvK2sMKEaHd7DqEldysJTRRgt7EeWrI9nUjRNdJdWNDL6zgVsJYlD7poyx7kkpkDx96nfBGiy+GPvdHTgcGj2Vo/iYMvTWl5oJnv9QvRDFCrFF758PegQc5GjTq6xemyeYU15pYUEqM=
Received: by 10.78.155.4 with SMTP id c4mr4646794hue.1196187150279;
        Tue, 27 Nov 2007 10:12:30 -0800 (PST)
Received: by 10.78.120.4 with HTTP; Tue, 27 Nov 2007 10:12:30 -0800 (PST)
In-Reply-To: <7vfxyrd2x2.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66250>

On 27/11/2007, Junio C Hamano <gitster@pobox.com> wrote:
> I am sympathetic to the _cause_, but I do not think the option --cached
> is a good match for this change.  As Hannes points out, as-is commit is
> the default, and --cached to other commands mean "work only with index
> not work tree", not "short-circuit for systems with slow lstat(3)".

I don't just mean to avoid lstat. I'm trying to avoid _any_
interaction with the thing unless absolutely needed.

>  * The option "--cached" is a wrong thing to have the user say and is
>    not what you want anyway. You want "no status list in the commit log
>    template";

That is not what I meant to say. I do want status list in commit message.
I don't want anything except git-diff-index --name-status --cached HEAD in it.
No untracked files whatsoever.

And, as I said, I also just want to commit the index _exactly_ as it is.
No checking for files changed after they were updated in the index
intended. I think that whatever the index holds is perfect (except it's
no different from HEAD) and I want commit it now.

>  * Skip run_status() and replace with "diff-index --cached HEAD" (or "is
>    the index empty?") when the user instructs so;

Right. Is it not what happens with the patch?
