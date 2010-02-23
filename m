From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: Re: [PATCH] pull: fix 'git pull --all' when current branch is 
	tracking remote that is not last in the list of remotes
Date: Wed, 24 Feb 2010 02:44:28 +0300
Message-ID: <63cde7731002231544k4140d0d8u65e8c7250a8ff42c@mail.gmail.com>
References: <1266965731-4208-1-git-send-email-michael.lukashov@gmail.com>
	 <7vtyt75zdo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 00:44:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk4Qd-0004Jx-Ui
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 00:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754824Ab0BWXob convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 18:44:31 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:36274 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754772Ab0BWXoa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2010 18:44:30 -0500
Received: by wwf26 with SMTP id 26so1015167wwf.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 15:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CMX9BXotjgZDjNwSm4vYhKb/fLKsh6v9vIFYzdmWynY=;
        b=XNB0KmAgDDKrKSTl4vDP6RB8iw6cQ/RgY3ByTunbkqHnmV5mieTFx/7AGAIcYuOHGi
         dGp4oBMF1Xj0nz8k+mWTgF4ZVO7RqVqT5e6ONr+FS2QFwkIcA2wzhYW1AsAXeYWqDq7P
         92DHeW9h9/a3SUwKM0z1XGTgRlrY92iIqnzw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=I11KpLDzDpPTNqU67abwUHUC4NH80qaraM9QsJWJZVFRivCAEfhWQyXf6j2i5VWfsG
         9n3roXor0iyY9CCoftfz6mPU+SIDHcZbuVO6fTEw88xVcI6SzMi2FA01k6yulI4ygKDk
         TIGmLir3YGI7DslvgBT7txNqN8ki8T+ldf8S0=
Received: by 10.216.86.85 with SMTP id v63mr1642031wee.32.1266968668841; Tue, 
	23 Feb 2010 15:44:28 -0800 (PST)
In-Reply-To: <7vtyt75zdo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140875>

On Wed, Feb 24, 2010 at 2:02 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Michael Lukashov <michael.lukashov@gmail.com> writes:
>
>> diff --git a/git-pull.sh b/git-pull.sh
>> index 38331a8..fcde096 100755
>> --- a/git-pull.sh
>> +++ b/git-pull.sh
>> @@ -214,7 +214,11 @@ test true =3D "$rebase" && {
>> =C2=A0 =C2=A0 =C2=A0 done
>> =C2=A0}
>> =C2=A0orig_head=3D$(git rev-parse -q --verify HEAD)
>> -git fetch $verbosity --update-head-ok "$@" || exit 1
>> +if test -e "$GIT_DIR"/FETCH_HEAD
>> +then
>> + =C2=A0 =C2=A0 rm "$GIT_DIR"/FETCH_HEAD 2>/dev/null
>> +fi
>
> When is it sane to ignore an error from this "rm", especially after y=
ou
> made sure that it exists?
>

The file "$GIT_DIR"/FETCH_HEAD is rewritten
in subsequent call to 'git fetch', thus it is safe to ignore all errors=
=2E
