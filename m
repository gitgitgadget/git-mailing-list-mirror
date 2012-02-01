From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] pack-objects: convert to use parse_options()
Date: Wed, 1 Feb 2012 21:49:50 +0700
Message-ID: <CACsJy8DoMTfTGK+r2yHrPMxm08ROGxVHKM_PFkKe5s-XX=GJhQ@mail.gmail.com>
References: <1328017702-14489-1-git-send-email-pclouds@gmail.com>
 <7v4nvb78om.fsf@alter.siamese.dyndns.org> <CACsJy8CZm96pVkavq_LvpX-MxdOtBw7XuwsQF61FJE8qk6ZZTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 15:50:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsbVz-0003Pe-J2
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 15:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106Ab2BAOuX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 09:50:23 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41527 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756377Ab2BAOuW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 09:50:22 -0500
Received: by bkcjm19 with SMTP id jm19so1102773bkc.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 06:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=OxK0Jvc6BILQ7EXJhUQhCNDwHl3zIdeWYO31KCsvV7U=;
        b=G2cu26Ol8cvv8CIR2R9R4+Q0larP4Vh+vDD4Ra1UTbk5Dh/6Dbxs6NFitQXvbDcA3C
         ec3xkBOIjswirDtSt+hoTNCT6K4yS/ucTz5QcEvLS3mLI41jHyN85VEnN/Ea+ZyE5Twv
         yxRznWYK2aY9VK0J93882gwv/HxjlIrjLkJvE=
Received: by 10.204.130.150 with SMTP id t22mr12691813bks.1.1328107821300;
 Wed, 01 Feb 2012 06:50:21 -0800 (PST)
Received: by 10.204.33.70 with HTTP; Wed, 1 Feb 2012 06:49:50 -0800 (PST)
In-Reply-To: <CACsJy8CZm96pVkavq_LvpX-MxdOtBw7XuwsQF61FJE8qk6ZZTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189514>

On Wed, Feb 1, 2012 at 9:30 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com=
> wrote:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Traditionally "pack-objects [options] b=
ase extra" failed;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * we would however want to take refs para=
meter that would
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * have been given to upstream rev-list ou=
rselves, which means
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * we somehow want to say what the base na=
me is. =C2=A0So the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * syntax would be:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 *
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * pack-objects [options] base <refs...>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 *
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * in other words, we would treat the firs=
t non-option as the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * base_name and send everything else to t=
he internal revision
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * walker.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>
> The last paragraph does not hold true anymore as far as I understand
> the code. IOW it drops everything in argv after base name. Looking
> back in history, the change was made by 8d1d8f8 (pack-objects: furthe=
r
> work on internal rev-list logic. - 2006-09-06). Nothing is mentioned
> why it drops the remaining of argv. I suspect this is a regression an=
d
> we should reinstate the behavior as the comment says.

Nope, false alarm. The comment was introduced in b5d97e6
(pack-objects: run rev-list equivalent internally. - 2006-09-04) and
the remaining of argv has been ignored ever since.
--=20
Duy
