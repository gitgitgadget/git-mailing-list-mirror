From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH 06/15] Automatically reuse sparse limiting arguments
 in revision walking
Date: Sun, 5 Sep 2010 11:58:08 +1000
Message-ID: <AANLkTik1E=7Uawq-fGXppac3ur-oohq104A5wEgxv8cL@mail.gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
	<1283645647-1891-7-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 03:58:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os4Ur-0005oW-BB
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 03:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659Ab0IEB6M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 21:58:12 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46660 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754608Ab0IEB6L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 21:58:11 -0400
Received: by wyf22 with SMTP id 22so1592307wyf.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 18:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Gel5/B/marbdOXY7n0+HczeJo0yEOWZpn8msatSEt5Q=;
        b=eu9ddB1MeZCfFR1nR5jQpBPB4B7ylis1rzoWSmOnxRaNDGRNfGEezCMg3lB3XRSVkS
         VGPIuQ01G4afcBZ8UnOgLs2VXxWb+UuRfiATVqaF34S8m6YOCR4X9/h9KZqAiaJtlDYa
         he4p+OkDfkDfKXEQcwU6Esmd9/FKB/cRGRVG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OztAdWKfm8kn9/pQ6oKC5/2AjwolVS5XKnNxE9JsgpttQUnd+H063Ip5ZgcYqKNoNB
         LxHCmxoHU8pWtOlfRubaCRVdtz97ujG1J8EtYKDK39N9Hc+//oB2BuPBZ70nQS1JRggN
         fW97HDbZXhj5fjuOt9r83Mk84qHxnu5lDnoX0=
Received: by 10.216.47.80 with SMTP id s58mr2338946web.15.1283651888816; Sat,
 04 Sep 2010 18:58:08 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Sat, 4 Sep 2010 18:58:08 -0700 (PDT)
In-Reply-To: <1283645647-1891-7-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155408>

On Sun, Sep 5, 2010 at 10:13 AM, Elijah Newren <newren@gmail.com> wrote=
:
> In a sparse repository, by automatically making use of sparse limits
> specified at clone time, we can avoid walking uninteresting commits a=
nd
> prevent access to missing trees and blobs. =C2=A0Note that this means=
 that if
> you created a sparse clone with
> =C2=A0git clone <repo> <dest_dir> -- PATH1 PATH2 PATH3 PATH4 PATH5
> then
> =C2=A0git log
> implicitly runs as though you had manually specified
> =C2=A0git log -- PATH1 PATH2 PATH3 PATH4 PATH5
> Similarly, running
> =C2=A0git diff
> implicitly runs as though you had manually specified
> =C2=A0git diff -- PATH1 PATH2 PATH3 PATH4 PATH5
>
> This is necessary for proper operation of git diff in a sparse clone =
to
> avoid accessing missing objects. =C2=A0In the case of a plain git log=
, this
> merely serves as an additional convenience, but for more complicated =
log
> operations (e.g. when passing -p or -S options) it becomes necessary.

I have a nicer approach here. Instead of modifying setup_revisions()
and similar functions, I update get_pathspec() to rewrite the
pathspecs from command line in narrow/shallow repos. get_pathspec()
currently does some form of rewriting already (prepending prefix).

So if you do "git log", get_pathspec() would return "git log -- PATH1
PATH2...". Will repost my series soon, or I can send that particular
patch to you.
--=20
Duy
