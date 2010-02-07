From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH] Add a test for a problem in "rebase --whitespace=fix"
Date: Sun, 7 Feb 2010 23:44:20 +0100
Message-ID: <6672d0161002071444lba0f751w3e7e33043e1ec2e8@mail.gmail.com>
References: <4B6E7564.7040109@gmail.com>
	 <7vtytsevsd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 23:45:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeFsN-0003Wp-Rw
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 23:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755044Ab0BGWoW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2010 17:44:22 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:41987 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414Ab0BGWoV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2010 17:44:21 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1208894eyd.19
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 14:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ij9Rxtst5fQegbbz8OBx56n3AmxGHZ55OuuDxgScbs4=;
        b=ECi4ihOAJx9uidbxG009qYtr8VjnwzZee4O3xipVVxfxbxQU7Rwaaen1ksI9PcxCb6
         UWWwJaf2zmy5G/Okamy+9rESmwQS9XGn9RrmxwrIhxl73JfGHzMYnh9Qjhi6+ZyFaPby
         zWH2YzekLSkwg8vQ0ichn2+cpWHJOyyw7Wz4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F9zk6fOZjL30BWxwmXKnYbr3lAm4AWYBIaKUr2gz0LRUiVWtUyxjTzGKz+iyadj9Tb
         jwwcKt+iwcmBYmrBYyy7+enEBp+y71/SngCOUq0U2rp3FmPCxwvgNPsHm0yXedlnFKxz
         4+KHIc3jclD7gQh3jxyzH/d9tlgKNEHtgwhTk=
Received: by 10.216.87.13 with SMTP id x13mr115483wee.12.1265582660113; Sun, 
	07 Feb 2010 14:44:20 -0800 (PST)
In-Reply-To: <7vtytsevsd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139261>

2010/2/7 Junio C Hamano <gitster@pobox.com>:

> First, is this a condition that we want to change the behaviour to
> "succeed" later?

Yes, assuming it is possible to fix.

> Imagine that the gap between abc and def block in your example is muc=
h
> larger to exceed the number of pre-context lines of your second patch
> (usually 3), and imagine you are the "git apply --whitespace=3Dfix" p=
rogram
> you have updated to "fix" the preceived problem. =C2=A0You know you e=
arlier
> might have stripped some blank lines at the EOF, but there is nothing=
 that
> tells you if you had only 3 blank lines, or you had even more. =C2=A0=
How many
> blank lines will you be adding back?

My original idea was to add back exactly the number of lines needed
so that the context lines would match. That can be calculated from
the line numbers of the last line of the pre-image and the line number
in the chunk and by scanning the chunk for blank context lines
(both at the beginning and end of chunk). Since the blanks lines
at the end will be stripped away anyway, I doesn't matter if I add
back fewer lines than were there originally.

Thinking a little more about it, if there is a chunk that starts
beyond the end of file, I could add the number of blanks lines
that is missing up to the beginning of the chunk plus the
number of lines in the chunk itself. That will also take
care of the case that the chunk deletes blanks lines.
(That will probably add too many blanks at the end,
but they will be stripped out again.)

That is my plan. Of course, since I have not attempted
to implement it yet, there could be fatal flaws in it.

Do you see any fatal flaws that I don't see?

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
