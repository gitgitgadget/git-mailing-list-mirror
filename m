From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 13/18] revert: Introduce --reset to remove sequencer state
Date: Mon, 1 Aug 2011 23:22:01 +0530
Message-ID: <CALkWK0n+=wWBhhMHuxXj9Stz0fVT9Gy1V9EMh+nX9vmH6ngT3Q@mail.gmail.com>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
 <1311871951-3497-14-git-send-email-artagnon@gmail.com> <201107311601.43472.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 19:52:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnwfD-0004Ry-M4
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 19:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669Ab1HARwX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 13:52:23 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50174 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400Ab1HARwW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2011 13:52:22 -0400
Received: by wwe5 with SMTP id 5so5897716wwe.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=I0Ah/5ZRsBhYR7nLCFmHpwLyW5UTvlK1Ym3AbYp6Ltc=;
        b=Fn9fVd5ntooNMbPfmiekkKuzICh8x76Pg2mxkSitqxguJj1vD0zDaxExdO4nRCoiax
         BYmCH9Y4fUfV7RNEmCkDvS8yciSGV7kJis6qUTm6hiH/dqrGPTykSsq0z71L7liMYAE7
         tLe0kwEJGv2/nefNATdM0U2dNDJVte+rpOX6M=
Received: by 10.216.150.222 with SMTP id z72mr952235wej.109.1312221141085;
 Mon, 01 Aug 2011 10:52:21 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Mon, 1 Aug 2011 10:52:01 -0700 (PDT)
In-Reply-To: <201107311601.43472.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178365>

Hi Christian,

Christian Couder writes:
> On Thursday 28 July 2011 18:52:26 Ramkumar Ramachandra wrote:
>> @@ -765,17 +784,21 @@ static int pick_revisions(struct replay_opts *=
opts)
>>
>> =C2=A0 =C2=A0 =C2=A0 read_and_refresh_cache(opts);
>>
>> - =C2=A0 =C2=A0 walk_revs_populate_todo(&todo_list, opts);
>> - =C2=A0 =C2=A0 create_seq_dir();
>> - =C2=A0 =C2=A0 if (get_sha1("HEAD", sha1)) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (opts->action =3D=3D =
REVERT)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die(_("Can't revert as initial commit"));
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die(_("Can't cherry-pick=
 into empty head"));
>> - =C2=A0 =C2=A0 } else
>> + =C2=A0 =C2=A0 if (opts->subcommand =3D=3D REPLAY_RESET) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remove_sequencer_state(1=
);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>> + =C2=A0 =C2=A0 } else {
>
> Maybe you could remove this "else" so that the indentation level is r=
educed.

This was intentional, mainly for stylistic reasons.  See [1].

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Start a new cherry-pi=
ck/ revert sequence */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 walk_revs_populate_todo(=
&todo_list, opts);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 create_seq_dir();
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_sha1("HEAD", sha=
1)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (opts->action =3D=3D REVERT)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die(_("Can't revert as initial commit")=
);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die(_("Can't cherry-pick into empty head"));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 save_head(sha1_to_h=
ex(sha1));
>> - =C2=A0 =C2=A0 save_opts(opts);
>> - =C2=A0 =C2=A0 save_todo(todo_list, opts);
>
> It looks like this save_todo() was not necessary in the first place b=
ecause
> pick_commits() does a save_todo() before processing each commit.

=46ixed in the earlier patch.  Thanks!

[1]: http://thread.gmane.org/gmane.comp.version-control.git/177960

Thanks.

-- Ram
