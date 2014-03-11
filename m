From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] rebase: new option to post edit a squashed or fixed up commit
Date: Tue, 11 Mar 2014 17:01:55 +0700
Message-ID: <CACsJy8C4xs+EsXshR8ppb063uv=cBBB+evgaVaZXt+NATk6SJQ@mail.gmail.com>
References: <1394334737-17406-1-git-send-email-pclouds@gmail.com> <xmqqob1drg3b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 11:02:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNJW4-0003II-5U
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 11:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbaCKKC2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Mar 2014 06:02:28 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:45834 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbaCKKC1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Mar 2014 06:02:27 -0400
Received: by mail-qg0-f46.google.com with SMTP id e89so4200083qgf.5
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 03:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ZWk+Tso7ZrAsX/FtncVPGktRQk3FFFcUFWbg51YXs5g=;
        b=rh4jyzK9HZgSxaWfkdirhPLvtkfd+8figwOkZpR6ZUScnbfutle1lWM73HV84U/L3p
         cqDARYmf9f6GeeykgIsTJofc6BIb4zjhfHbTgHSOoFuCjydnK/ruV2ddbJmVODZaG6eA
         v7U+lI4YEDMCQtUEsTbSiLc+bGW9NLGe2ExHpVCwm64sowDqzJ7Ff/h/RR57VEjGk9Xl
         MYUxWGq1yjc/6YfouMyR2JLKa2B2xfJr3BO4VY2w4cbEfqgqcNWddSeiV0pZcBkbgXy0
         uMhcfwq8WvHpCtGZ+uJjhQpfLyrFZUT9AsJQ5gcxfveAJKqNlJEtON423vPVh9QgRTk0
         N3KA==
X-Received: by 10.224.112.6 with SMTP id u6mr1630547qap.78.1394532146737; Tue,
 11 Mar 2014 03:02:26 -0700 (PDT)
Received: by 10.96.215.102 with HTTP; Tue, 11 Mar 2014 03:01:55 -0700 (PDT)
In-Reply-To: <xmqqob1drg3b.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243851>

On Tue, Mar 11, 2014 at 2:47 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> After squashing or fixing up, you may want to have a final look at t=
he
>> commit, edit some more if needed or even do some testing. --postedit
>> enables that. This is (to me) a paranoid mode so either I enable it
>> for all squashes and fixups, or none. Hence a new option, not new to=
do
>> commands that give finer selection.
>
> If we were to adopt Michael's (?) idea of allowing flags to each
> insn in the insn sheet, would this restriction be easily lifted?
>
> That is, instead of saying "squash", you say "squash --stop" or
> something.

I think I still need something similar, otherwise I would need to
s/squash/squash --stop/ after "rebase -i --autosquash". --postedit
code could be simplified by generating "squash --stop" though.

>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index a1adae8..42061fc 100644
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -571,6 +571,11 @@ do_next () {
>>                       ;;
>>               esac
>>               record_in_rewritten $sha1
>> +             if test -n "$postedit"
>> +             then
>> +                     warn "Stopped at $sha1... $rest"
>> +                     exit_with_patch $sha1 0
>> +             fi
>>               ;;
>
> I would have expected that any new code would stop only at the last
> squash (or fixup) in a series of squashes, but this appears to stop
> even at an intermediate squashed result, which will not appear in
> the final history.  Am I misreading the patch (or misunderstanding
> the intent of the patch)?

Never thought of that case. Yes it should only stop at the last squash/=
fixup.
--=20
Duy
