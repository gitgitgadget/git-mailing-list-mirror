From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 14/18] revert: Introduce --reset to remove sequencer state
Date: Wed, 27 Jul 2011 15:42:24 +0530
Message-ID: <CALkWK0k7SvjJ8duNscnwjn4JOjSDqfHN1qH9rnoz5w8TjHgKgA@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-15-git-send-email-artagnon@gmail.com> <20110727051115.GI18470@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 12:12:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm16g-0006Ng-Mq
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 12:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab1G0KMs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jul 2011 06:12:48 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53190 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039Ab1G0KMq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 06:12:46 -0400
Received: by wwe5 with SMTP id 5so1247378wwe.1
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 03:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=N01xQyT7oh20qlkLkZzcoHqYy9Dp2h4ZCgWpxrH87Xg=;
        b=BueZ0WxysWK7ud+1JNaUafY4yaZpcbO/kO4O7iYi6sWrXLFQ4AJs6BMlg85/eypiOR
         0CrDZy/VS/30u0eKkoLzZyaaeJ3tiz9j/Q65J9d+j+GdzQFKaF9t5O6vYnGXYWvvM+ix
         et/ms8Mgic3/tZRERSxtTG1YGMnZa6LC4UHLs=
Received: by 10.216.155.134 with SMTP id j6mr6217643wek.81.1311761565360; Wed,
 27 Jul 2011 03:12:45 -0700 (PDT)
Received: by 10.216.70.16 with HTTP; Wed, 27 Jul 2011 03:12:24 -0700 (PDT)
In-Reply-To: <20110727051115.GI18470@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177960>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> --- /dev/null
>> +++ b/Documentation/sequencer.txt
>> @@ -0,0 +1,4 @@
>> +--reset::
>> + =C2=A0 =C2=A0 Forget about the current operation in progress. =C2=A0=
Can be used
>> + =C2=A0 =C2=A0 to clear the sequencer state after a failed cherry-p=
ick or
>> + =C2=A0 =C2=A0 revert.
>
> Probably worth mentioning that the index, HEAD, and worktree are left
> alone.

=46ixed, thanks.

>> +++ b/builtin/revert.c
> [...]
>> @@ -886,17 +906,22 @@ static int pick_revisions(struct replay_opts *=
opts)
> [...]
>> + =C2=A0 =C2=A0 if (opts->subcommand =3D=3D REPLAY_RESET) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remove_sequencer_state(1=
);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>> + =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Start a new cherry-pi=
ck/ revert sequence */
>
> Can un-indent by dropping the "else":

Actually this was intentional; if we un-indent this now, there'll be a
diff indenting it when '--reset' and '--continue' are introduced which
turns out to be especially ugly :)

>> --- a/t/t3510-cherry-pick-sequence.sh
>> +++ b/t/t3510-cherry-pick-sequence.sh
>> @@ -37,7 +37,7 @@ test_expect_success 'cherry-pick persists data on =
failure' '
>> =C2=A0 =C2=A0 =C2=A0 test_path_is_file .git/sequencer/head &&
>> =C2=A0 =C2=A0 =C2=A0 test_path_is_file .git/sequencer/todo &&
>> =C2=A0 =C2=A0 =C2=A0 test_path_is_file .git/sequencer/opts &&
>> - =C2=A0 =C2=A0 rm -rf .git/sequencer
>> + =C2=A0 =C2=A0 git cherry-pick --reset
>> =C2=A0'
>
> This is not about this patch, but ideally the cleanup would come at
> the beginning of the next test, so if one test fails it does not take
> down all the tests that come after it.

Good point.  Fixed all, thanks.

-- Ram
