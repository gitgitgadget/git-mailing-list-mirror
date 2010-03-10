From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Unknown index entry format 40000000
Date: Wed, 10 Mar 2010 19:10:19 +0700
Message-ID: <fcaeb9bf1003100410j15ebd863ta4a2b817b28ac0f6@mail.gmail.com>
References: <9EE6DBC4-B025-48A1-B475-433DE5918F39@ee.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Benedikt Andreas Koeppel <bkoeppel@ee.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Mar 10 13:40:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpLDJ-0007cu-3c
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 13:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954Ab0CJMkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 07:40:32 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38384 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728Ab0CJMka (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 07:40:30 -0500
Received: by gwb15 with SMTP id 15so4132946gwb.19
        for <git@vger.kernel.org>; Wed, 10 Mar 2010 04:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=n54NrWI9SKgoqMe1WIXAahBCSV0auq958yBNvSiriLc=;
        b=Y6/x3XdQn9ChPqMCkVs4kxFFxljT8/g5v6BV4InR33QNU0Z62jEfuKG1DXokROxy8T
         OAVsDl9xx84FiSXYA1d5/YC0eh7kLGCjhMd/RULWtsomGMQ0hf9AdV44Jn4ohyYi17wj
         +8uO+zVz/shBJK3n68bOrcIXZOxhhn/y+AtA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=gynWYv1qnd/7/FAEWQlBV6Xla2aoescwY2qmeWbAVtwOlrQ5YcGxx6pmllZijNKauZ
         M0FZK4boxaMwwCFF6Vyb3TXqce2TxrEh+jRGGx8Y7kebVugIuhsSdKBG/UwL5ZtL34KI
         N7xox+2kfE5uA75LpLmYuNw8iGyRE6XulJLKY=
Received: by 10.101.202.12 with SMTP id e12mr2278016anq.132.1268223020041; 
	Wed, 10 Mar 2010 04:10:20 -0800 (PST)
In-Reply-To: <9EE6DBC4-B025-48A1-B475-433DE5918F39@ee.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141882>

On 3/10/10, Benedikt Andreas Koeppel <bkoeppel@ee.ethz.ch> wrote:
> Hello,
>
>  I've set core.sparseCheckout true and added a .git/info/sparse-checkout file:
>  *
>  !source/crn/
>  !source/maemo-beagle/
>  !source/maemo-kernel/
>  !source/u-boot/
>
>  After that, I did
>  git co -- .
>  git reset --hard HEAD
>
>  Now, I want to do
>  git pull
>  but I get an error:
>
>  beninb:git beni$ git pull -v
>  From gmuasch:ife-maemo
>   = [up to date]      master     -> origin/master
>  fatal: Unknown index entry format 40000000
>
>  I have git version 1.7.0.2, Mac OS X 10.6.2 on HFS+ case-*in*sensitive.
>
>  I found that this error comes from read-cache.c, line 1235. What does this error message mean? How can I make my repo working again?

It means git does not understand flag 0x40000000. Git 1.7.0.2 should
understand that bit. I can only guess that "git pull" is from older
version, or it ran a git command from older build. Do you have two
versions of git on that machine?

You can turn off sparse checkout. That would remove all 0x4000000
flags, which makes the index compatible with old versions again:

cp .git/info/sparse-checkout sparse-checkout.saved
echo '*' > .git/info/sparse-checkout
git checkout

If it does not work, removing the index (.git/index) would do the trick.
-- 
Duy
