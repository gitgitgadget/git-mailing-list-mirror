From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] remote: improve sorting of "configure for git push" list
Date: Sun, 22 Mar 2009 10:47:07 -0400
Message-ID: <76718490903220747p74cf3704vbbbc085c28a105b2@mail.gmail.com>
References: <20090319200308.GB17028@coredump.intra.peff.net>
	 <20090322085920.GA5201@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 22 15:48:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlOyg-00008M-H1
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 15:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148AbZCVOrM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2009 10:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754100AbZCVOrL
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 10:47:11 -0400
Received: from mail-gx0-f208.google.com ([209.85.217.208]:45234 "EHLO
	mail-gx0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941AbZCVOrK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2009 10:47:10 -0400
Received: by gxk4 with SMTP id 4so4686622gxk.13
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 07:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PKCjFbKsZxzvVBdxcwn6GlnzamAvcqwOGahAP1O4gvc=;
        b=UBV4MEo8DimXn3scgwNvah13brjxT2epD78BZM/LsId2PhwfPyvDe17zXSaVQFRLwU
         ODAX498zgvIbgDFTQbltR0Q7Q8GecN7XA+qwetk3z8QkSu9ibGiOap0Kke22qC0TfvaV
         TACUFdOGS1yc0lGQ8fJhKK82hoOb5muXDtsos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F9zxezx2dqKGFtk5EfoRuyRvg/PZb/Fpsoo4Ba0WheCN3BQHJuYKRNQetWtXOH286X
         pVXz7GSJgb7qAdk2Tqo8O/95S7T+TOSfGI9Nt5RptAJLsVvpi0nGJk/D4EesjC3+FC5M
         tJwzgT+uQ+bSd269JqskpDMjoOZefn0ahXVEU=
Received: by 10.151.110.9 with SMTP id n9mr10823293ybm.215.1237733227559; Sun, 
	22 Mar 2009 07:47:07 -0700 (PDT)
In-Reply-To: <20090322085920.GA5201@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114143>

On Sun, Mar 22, 2009 at 4:59 AM, Jeff King <peff@peff.net> wrote:
> The data structure used to store this list is a string_list
> of sources with the destination in the util member. The
> current code just sorts on the source; if a single source is
> pushed to two different destination refs at a remote, then
> the order in which they are printed is non-deterministic.
>
> This patch implements a comparison using both fields.
> Besides being a little nicer on the eyes, giving a stable
> sort prevents false negatives in the test suite when
> comparing output.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The discussion of the proper interface to the one-line wrapper to qso=
rt
> didn't really resolve anything. It seems that the constraints of C ma=
ke
> a nice wrapper a little painful, so let's just use a bare qsort. Once
> again, I really don't care what it looks like, so feel free to mark i=
t
> up if you prefer differently; I just want it off my todo list, and to
> let JSixt run his tests in peace.
>
> I did have one somewhat sick thought for an API: have string_list's
> cmp_items (or an alternate cmp_items_with_util) treat a non-NULL util
> member as a pointer to a string, and use it as a secondary key in the
> sort. It works here because the first member of the push_info struct =
is
> the secondary key. =C2=A0But I think it is a bit too subtle for my ta=
ste.

Ack. There is one thing I wonder though. Is this even a sane config?
It's accepted, but is that intentional or just an accident? Would
anyone notice if the push parsing were changed to only accept a single
dest for a given source branch?

Thanks for the patch Jeff.

j.
