From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 39/48] merge-recursive: Fix rename/rename(1to2) resolution
 for virtual merge base
Date: Mon, 8 Aug 2011 16:58:20 -0600
Message-ID: <CABPp-BEM6G4E7mf6280S6vdT-2UDDiKdfXtYS451s--YYO9wGA@mail.gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
	<1307518278-23814-40-git-send-email-newren@gmail.com>
	<7vhb6aqdw7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 00:58:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqYmA-0001iE-Q2
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 00:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153Ab1HHW6X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 18:58:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51042 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab1HHW6W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2011 18:58:22 -0400
Received: by fxh19 with SMTP id 19so5838833fxh.19
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 15:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=SKYosIh5VbkwNiX6C/yB2c3XLnN7CnCtIVuIBK1ycW4=;
        b=XOsMXNhCqQFqkGdHw6qpeH/NMXlBi1o7A3zgm81uaEYOpiY6C0bb1rlOKCbNEZFiXU
         PS0OZNiVuWyq+mNJzugl6YgA2t+R6h11jcEVM1lYk6sJswDQEU6ULXX/B5NLqF/72HoX
         oxu7iiD++uZvFOVAok85Nk3IbJ3CRdYVD0GlI=
Received: by 10.223.160.131 with SMTP id n3mr8158418fax.111.1312844300903;
 Mon, 08 Aug 2011 15:58:20 -0700 (PDT)
Received: by 10.223.123.13 with HTTP; Mon, 8 Aug 2011 15:58:20 -0700 (PDT)
In-Reply-To: <7vhb6aqdw7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179002>

On Mon, Jul 25, 2011 at 2:55 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Elijah Newren <newren@gmail.com> writes:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_file(o, 0, mfi.sh=
a, mfi.mode, src);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remove_file_from_cache(r=
en1_dst);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remove_file_from_cache(r=
en2_dst);
>
> ... the use of "src" here is taking a "middle ground" and punting on
> resolving the conflicting opinions of both branches for the outer mer=
ge to
> resolve. I think that is a sensible thing to do.
>
> The rename destinations of both branches are removed. What happens if
> ren1_dst (the path one branch wanted to rename src to) were added by =
the
> other branch (which wanted to rename src to ren2_dst), causing rename=
/add
> conflict between branches (i.e. not the one you worry about in the ab=
ove
> FIXME which is about one branch renaming src to ren1_dst while adding=
 an
> unrelated content to src)?

You found another bug; this time one that was already present in git
rather than having been introduced by my series (the
remove_file_from_cache() calls were already present, I just moved them
around a little bit).  I have a testcase that exposes this new bug
now.

Good catch.  :-)
