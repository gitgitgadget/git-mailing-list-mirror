From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 44/47] Remove all logic from get_git_work_tree()
Date: Wed, 22 Dec 2010 14:22:30 +0700
Message-ID: <AANLkTikOOaKSf333UzawEgAf_=t-WBrWLu7tmiOrqO8V@mail.gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-45-git-send-email-pclouds@gmail.com> <7vpqsu6059.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 22 08:23:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVJ2Y-0006Qz-Ap
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 08:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007Ab0LVHXE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Dec 2010 02:23:04 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51568 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868Ab0LVHXC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Dec 2010 02:23:02 -0500
Received: by wwa36 with SMTP id 36so4985252wwa.1
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 23:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=+lgplXbwNySZGnSVkHb2hXyM+jr9dUf6sJKZmYyCkq4=;
        b=nhrL6jcRIz9Sa2EqGsLCTvGqaQSLoGOetXDEdIk54367dEZjXsohvBrNsi3cHq92Lj
         X6SZ4GFFflRyZGdx+tKCqaRPxKsoHgR5lQvqgG3aB9zY4pjtVse+ETr7hb0bVsGH/OZI
         Rvswy2ZjQZK4rX+2qwbL2+vX6xwrr189IG53I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qyOCOR/ltFbJ0HQWc30ujeq73mNjITT/JdFOYRHzZriw1ml8jiCwz4B5dosE0qInLD
         6l6+bYHTczCgOT7+5MtUlcaBSQqa7ZpJtqJb8WhDsUSxBfTE9WO+vpcdQp55FEWSa5nA
         5x3RPNILKWvIj4wli2cx7rPchoIn2wly5TlO4=
Received: by 10.216.30.144 with SMTP id k16mr530466wea.19.1293002580907; Tue,
 21 Dec 2010 23:23:00 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Tue, 21 Dec 2010 23:22:30 -0800 (PST)
In-Reply-To: <7vpqsu6059.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164074>

2010/12/22 Junio C Hamano <gitster@pobox.com>:
>> =C2=A0const char *get_git_work_tree(void)
>> =C2=A0{
>> - =C2=A0 =C2=A0 if (startup_info && !startup_info->setup_explicit) {
>> -...
>> - =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 return work_tree;
>> =C2=A0}
>
> Would it be a bug in the new set-up code if this function gets called=
 and
> work_tree is still NULL?
>
> There are quite a few callers that call get_git_work_tree() and expec=
t
> that it will always return a non NULL pointer. =C2=A0Perhaps we would=
 want an
> assertion here?
>

While the assertion sounds good, it does not work well. The old
function can return NULL in bare repos. is_bare_repository() and
is_inside_work_tree() expect NULL from get_git_work_tree() sometimes.

I'll see if I can move is_inside_work_tree() over environment.c (so
that both callers can access work_tree var directly) and have a clean
"make test". It does not look feasible though because of the static
variable inside_work_tree in setup.c.
--=20
Duy
