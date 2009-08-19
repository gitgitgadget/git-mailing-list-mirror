From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: ls-files -t broken? Or do I just not understand it?
Date: Wed, 19 Aug 2009 16:04:20 +0700
Message-ID: <fcaeb9bf0908190204h31bc839ai39972a251040d449@mail.gmail.com>
References: <20090819082423.GA18860@atjola.homenet> <vpqljlguqtn.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 19 11:04:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdh6A-0004SH-PY
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 11:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbZHSJEj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Aug 2009 05:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbZHSJEj
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 05:04:39 -0400
Received: from mail-yw0-f173.google.com ([209.85.211.173]:50470 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbZHSJEi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Aug 2009 05:04:38 -0400
Received: by ywh3 with SMTP id 3so6028716ywh.22
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 02:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=hN+lebQeScwQVxO3WlygZloh1vlUhMy1kZlsRxuxC/A=;
        b=KWf/vHgYYE/1gcq07ibKHQA9HzFIVy3szyU6QDSCWgq6qZJbRX7ETVjkZD4tfcKwt6
         +n034koqFzg5Zxyk4ejesXeLLG4rYVciSTOoiKbuH7EmZOjn6X0D8OTCJzTvryPHBJej
         AADGcL33XgW9Mkbf5FgOhHu+er1tYNJ0P/3Mo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dd+z8xcCZRyzrAz6IyBDjrzZzJqQFbRjnanfs6+5mdCeQm0pUaNX09RQTzcztxMlEN
         4jI6/JKfi567yhuHKqQkzxvYKDi9SFkL0nDjL4/dptDLC4cJDJDYvSQRLb7VOK8mq97J
         Er+s/u/sRLtrVwY6cAnAmruazcWEZD8Qh3Hlc=
Received: by 10.100.74.13 with SMTP id w13mr6661267ana.168.1250672680090; Wed, 
	19 Aug 2009 02:04:40 -0700 (PDT)
In-Reply-To: <vpqljlguqtn.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126522>

On Wed, Aug 19, 2009 at 3:54 PM, Matthieu Moy<Matthieu.Moy@imag.fr> wro=
te:
> Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>
>> Hi,
>>
>> ls-files -t seems to always show status H, even if the file was modi=
fied
>> or deleted, and thus gets shown by -m and -d respectively.
>
> That's not exactly "always", but I don't know whether it's the desire=
d
> behavior:
>
> /tmp/git$ git st
> # On branch master
> # Changed but not updated:
> # =C2=A0 (use "git add/rm <file>..." to update what will be committed=
)
> # =C2=A0 (use "git checkout -- <file>..." to discard changes in worki=
ng directory)
> #
> # =C2=A0 =C2=A0 =C2=A0 modified: =C2=A0 modified
> # =C2=A0 =C2=A0 =C2=A0 deleted: =C2=A0 =C2=A0removed
> #
> no changes added to commit (use "git add" and/or "git commit -a")
> /tmp/git$ git ls-files -t
> H modified
> H removed
> H unmodified
> /tmp/git$ git ls-files -t -m
> C modified
> C removed
> /tmp/git$ git ls-files -t -d
> R removed
> $ git ls-files -t -d -m
> C modified
> R removed
> C removed
>
> So, you get the C and R flags only when you request explicitely -m an=
d
> -d.

Let's see how it goes without "-t":

pclouds@dektop /tmp/i $ git ls-files
modified
removed
unmodified
pclouds@dektop /tmp/i $ git ls-files -m
modified
removed
pclouds@dektop /tmp/i $ git ls-files -d
removed
pclouds@dektop /tmp/i $ git ls-files -d -m
modified
removed
removed

I'd say it's expected behavior.
--=20
Duy
