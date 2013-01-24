From: Ivan D Vasin <nisavid@gmail.com>
Subject: =?UTF-8?B?UmU6IGF1dG8gcGFja2luZyB3aXRoIHNpbXVsdGFuZW91cyBwdXNoZXM6ICJlcnJvcjogQw==?=
	=?UTF-8?B?b3VsZCBub3Qgc3RhdCAnb2JqZWN0cy9b4oCmXS9b4oCmXSci?=
Date: Wed, 23 Jan 2013 20:39:50 -0500
Message-ID: <CADcu=0jiEEOkWZXshLdMmOBYJt=SzHfJ39r_qo8GzjdY6BTRaA@mail.gmail.com>
References: <CADcu=0jCkNr6J_-iiKp00aSXHPf=+QV6oFvFHUZ_uc02JTaCbQ@mail.gmail.com>
 <7vbocffmpn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 02:45:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyBt0-0006iK-KI
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 02:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918Ab3AXBpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 20:45:30 -0500
Received: from mail-ob0-f181.google.com ([209.85.214.181]:58635 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892Ab3AXBp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 20:45:29 -0500
Received: by mail-ob0-f181.google.com with SMTP id wc18so3685373obb.26
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 17:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=trxgx1Yrs8YJmYjHdAZdxpJo/1fcF5SQfij3BCpZ1Ns=;
        b=CrJPjhz+3u6/ksyw+rrxX0bIe7NkorCiLhVPWRl108nHlDdBUNkL8RHjecO0H/Pmb5
         3X0EmbcbzObeB6Qx87fNwLVO8w4V7NYtS2XfKQuoT22T8ODmIMNf+cxAOi0GGKF+H9px
         9jtliMkcwWLrzZT4VMpW3U4n5uz9RJas/4VnSNfI4K9sGayP/IdX3m1vxxmFqJ52FG+N
         4bl9Y8bMcceppEA+Jst6Hd3tdQRsG8SuWwWIKeoe9unq4kJeswsn7WcofuzChi7eCwac
         zDfsAqjOhb6ceOpFj8tpqcXNsmz4ZPZoArLV5wDSQgOKRF/v/4IklK2696hPj7PBUqSr
         iGyQ==
X-Received: by 10.182.154.4 with SMTP id vk4mr163461obb.70.1358991928487; Wed,
 23 Jan 2013 17:45:28 -0800 (PST)
Received: by 10.114.63.44 with HTTP; Wed, 23 Jan 2013 17:39:50 -0800 (PST)
In-Reply-To: <7vbocffmpn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214387>

On Wed, Jan 23, 2013 at 7:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ivan D Vasin <nisavid@gmail.com> writes:
>
>> my suggestion is that an auto pack should lock the repository,
>> preventing at least other auto packs (and perhaps other operations)
>> ...
>>
>> ``git fsck`` is successful on both of our repos and on the bare repo
>> to which we pushed.
>
> Successful after you pushed, or before you pushed, or both?

both

>
> I suspect both.
>
> I do not think such a lock is necessary for correctness of the
> operation, but running two auto packing sumultaneously is wasteful,
> so it would help performance.  But that would produce a larger
> problem.  What if your modified auto-packer takes a lock and then
> dies without relinquishing the lock?  The repository will never be
> repacked after such an event forever?

perhaps the lock could contain the PID of the auto pack process.  if
that PID has gone away, the lock is ignored and replaced with a new
one.

that's what comes to my mind.  of course, there could be other ways to
handle this that i'm not thinking of.

in any case, the error messages, though spurious, are alarming to the
uninformed user.  it looks like Git is saying that there is actual
data loss, where in fact there is none.  if Git doesn't prevent these
messages from appearing (via locking behavior or otherwise), then it
should at least annotate them with a message that describes their
possibly spurious nature and perhaps instructs the user to verify
everything with ``git fsck``.
