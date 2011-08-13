From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/6] revert: Allow mixed pick and revert instructions
Date: Sat, 13 Aug 2011 21:37:51 +0530
Message-ID: <CALkWK0=1cVNrHMvMqrEhFYcdV8FkETk8qT1i1oGUJxsWEH9Zww@mail.gmail.com>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
 <1313088705-32222-5-git-send-email-artagnon@gmail.com> <20110811201245.GH2277@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 13 18:08:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsGlE-0003dh-K5
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 18:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139Ab1HMQI2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Aug 2011 12:08:28 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60684 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab1HMQI1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2011 12:08:27 -0400
Received: by wyg24 with SMTP id 24so2716489wyg.19
        for <git@vger.kernel.org>; Sat, 13 Aug 2011 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=DDx3yNZsxRvVBBjKZxWGpU8mY+xNx781CJWp1NPFMiQ=;
        b=I8ofQajiEoyFpAjt1OgJM309+24kafDxwGI5YiGObq0lyOIjrf7YuBKpw3+6nDtAeK
         Y5m75gmHMwd60sfGjgaL7cHJbXzhdhP5RW0v6RFjwPv6HpM1yB+INPJd96BsXJSk4TsJ
         aI1I5G1fmo/Jwpsy0pWRU4FkH2QHc/3YxJco8=
Received: by 10.216.46.208 with SMTP id r58mr562696web.78.1313251691178; Sat,
 13 Aug 2011 09:08:11 -0700 (PDT)
Received: by 10.216.139.31 with HTTP; Sat, 13 Aug 2011 09:07:51 -0700 (PDT)
In-Reply-To: <20110811201245.GH2277@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179279>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Change the way the instruction parser works, allowing arbitrary
>> (action, operand) pairs to be parsed.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Parse the instruction list in .git/sequenc=
er/todo as a list
> =C2=A0 =C2=A0 =C2=A0 =C2=A0of (action, operand) pairs, instead of ass=
uming all instructions
> =C2=A0 =C2=A0 =C2=A0 =C2=A0use the same action.

=46ixed.  Thanks :)

>> @@ -517,7 +517,8 @@ static int do_pick_commit(struct commit *commit,=
 struct replay_opts *opts)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TRANSLATORS: The=
 first %s will be "revert" or
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"cherr=
y-pick", the second %s a SHA1 */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error(_("%s:=
 cannot parse parent commit %s"),
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 action_name(opts), sha1_to_hex(parent->object.sha1));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 action =3D=3D REPLAY_REVERT ? "revert" : "cherry-pick",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sha1_to_hex(parent->object.sha1));
>
> My first thought was "why stop using the helper function action_name"=
?
> But now I see that it previously came from "opts" (i.e., the command
> line) and now comes from the todo file.
>
> The command name there was never really important except when
> cherry-pick or revert is being called by a script, and the message
> indicates which command was having trouble parsing the commit. =C2=A0=
If I
> am using "git cherry-pick --continue" to continue after a failed
> revert, I suspect action_name(opts) ["cherry-pick: "] would actually =
be
> more sensible than the command name corresponding to the particular
> pick/revert line.

You're right.  Removed this hunk.

> Maybe something like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D strchrnul(p, '\n') - p;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len > 255)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D 255;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return error(_("Unrecognized action: %.*s"=
), (int) len, p);
>
> would do.

Excellent idea!  I fixed the buffer overflow message to do this too.
By the way, shouldn't error() do this?

> Could we can make this error message more clearly suggest that it's
> giving context to the error above it? =C2=A0For example, something va=
guely
> like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0error: unrecognized action: reset c78a78c9=
 Going back
> =C2=A0 =C2=A0 =C2=A0 =C2=A0error: on line 7

Good suggestion.  Fixed.

> Does a "cherry-pick --continue" in this scenario skip the first commi=
t
> in the todo list? =C2=A0Should it?

It shouldn't and it doesn't.  See how read_populate_opts and
read_populate_todo are called before the segment that drops the first
commit.

-- Ram
