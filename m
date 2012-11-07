From: Shawn Pearce <spearce@spearce.org>
Subject: Re: What about SHA-1 collisions?
Date: Wed, 7 Nov 2012 07:42:55 -0800
Message-ID: <CAJo=hJtF2+Z1BDQnysB7hk2MM336iEUMHd3zSLCm14yvw1_-wg@mail.gmail.com>
References: <20121106202643.GF28437@raven.wolf.lan> <loom.20121106T223000-502@post.gmane.org>
 <20121106220938.GH28437@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Josef Wolf <jw@raven.inka.de>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 16:43:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TW7mx-0000ib-9c
	for gcvg-git-2@plane.gmane.org; Wed, 07 Nov 2012 16:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034Ab2KGPnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2012 10:43:17 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:53610 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab2KGPnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2012 10:43:16 -0500
Received: by mail-qa0-f53.google.com with SMTP id k31so544123qat.19
        for <git@vger.kernel.org>; Wed, 07 Nov 2012 07:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=HuCqlNDlPHJ8KB09dMaFH9TI9DZUtQwpQ1aObA6yB5Q=;
        b=SjivMUVfU2UAolejPsjdhx/iwWxkkNTjP2xeC0aLL1k84KcrYHdZlM4Mj7KasKdviX
         zFncY6qtnghbokEaxjD3KSR7tabjSgvgj7b0OtvRVAN7OlqMQ0ehZ9AeK3Pq4qCRHO60
         0sOS6H2O7Gw4wqMkRvSQu6/9pBjWSwPEVqeeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:x-gm-message-state;
        bh=HuCqlNDlPHJ8KB09dMaFH9TI9DZUtQwpQ1aObA6yB5Q=;
        b=akguoNnEUZtdbOgyMaLaExL+rb53LpsnqMMkE0C62hmXfpqSg784XsIO8go/jqYI1+
         jUVsZD1PPOGVv8MnzT1zdDj4DIQbgZfTdjaLvklZWzBOPyL0l1e2QCKrXW/3I2EM3PtR
         VHoPBJM43FqjQkXDX1hn54BIV42U+7HwuFIHgbxU92VHCbHVQd6Oqu5kjBJzk5hRT4io
         KTTfndtVkt5ipg0QWBLbopWcG9rOJoQj3nNN+kUUXpEIFA+NPA2cSPG1P0dKaXSltZc7
         EVlkzacV/wGYLj0CQUvuKPO91smTzyJSXBx+1Lk2Ad1C3+h3M36g4aFbevVEJ2wQLkWF
         ic5w==
Received: by 10.49.96.162 with SMTP id dt2mr8463412qeb.48.1352302995466; Wed,
 07 Nov 2012 07:43:15 -0800 (PST)
Received: by 10.49.60.198 with HTTP; Wed, 7 Nov 2012 07:42:55 -0800 (PST)
In-Reply-To: <20121106220938.GH28437@raven.wolf.lan>
X-Gm-Message-State: ALoCoQn+Qagpm7+BVr1ZGkHpgXK5ONSXIoY9bQqByaKb2stloiarh6tBAz5dEoX9kAso/OL7jS7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209134>

On Tue, Nov 6, 2012 at 2:09 PM, Josef Wolf <jw@raven.inka.de> wrote:
>
> On Tue, Nov 06, 2012 at 09:41:29PM +0000, John McKown wrote:
> > Josef Wolf <jw <at> raven.inka.de> writes:
> > > Just for curiosity: what would happen if such a collision would occur within
> > > one repository?
>
> > In a sense, this cannot happen.
>
> In the scenario you described, contents of this version of file "b" are lost
> and replaced by the contents of file "a". So file "b" is broken.
>
> What happens when files "a" and "b" are added into different repositories?
> File "a" is added to repos "A", and file "b" is added to repos "B". Now it
> depends from which repository you fetch the collided blob first. If you fetch
> it from "A", file "b" will be broken. If you fetch first from "B", your "a"
> will be broken.
>
> It becomes even more interesting, if some commit or tree object would have
> the same SHA1 as some other object. I guess, in such a case the repository
> would be completely hosed?

When exchanging objects over the network, Git compares byte-for-byte
any object that one side sent that the other side already has, and
complains loudly when there is a collision detected. This only works
if the sender includes the "wrong" content for the named object. Git
also does assume the SHA-1 is unique and that it is not always
necessary to transmit the object. In these cases you would not be able
to detect the collision, because there isn't one. Your repository
would simply be using the wrong content for a file. Presumably one
would notice your build doesn't work anymore and investigate why.
