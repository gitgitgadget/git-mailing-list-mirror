From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] blame: make sure that the last line ends in an LF
Date: Tue, 20 Oct 2009 08:15:26 -0500
Message-ID: <fabb9a1e0910200615x5d487cdk6f50e11c96f2cb6c@mail.gmail.com>
References: <1256007988-13321-1-git-send-email-srabbelier@gmail.com> 
	<7vbpk2sg6m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 15:15:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0EZ8-00061G-7d
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 15:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbZJTNPn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 09:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbZJTNPn
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 09:15:43 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:45552 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbZJTNPm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 09:15:42 -0400
Received: by ewy3 with SMTP id 3so4790428ewy.17
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 06:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=WW3KPSel4fs67v2lNT925DjSVVFaIDFakFF6bCXyJ2Q=;
        b=mRsXSLNcM7EaVG0L0F/wLpmB9WOtYWKXYBKucR8sh21lOmPwipWTkMOw//mqNpvBK7
         4dQiZV1tFJHRvKJgKcSq7Q7+2RnS8tvFxp8AqDjwUjs3bMM6YeHRrviVp5ov4KEWPvXM
         V8WImB0BIJ/6oV96M3Y9ZjA5SjCw4QyWhPf94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=MJFUOe9QV3OvhkNlMz2XvQ/8hOUMxspTFeXnD6XROUH6iPZHp1vTbbWV7njKixGaVG
         0oJRpx5pfgmLt6VvM8NnEziwWx/hQEHhhwAwQhmUT5Eln00cnaaIgNw2wfjn8xeFvVnV
         aARw8l1Sk7Ecw3glzp7VcOqs6fbx7t4RWwcUQ=
Received: by 10.216.87.79 with SMTP id x57mr2240200wee.83.1256044546106; Tue, 
	20 Oct 2009 06:15:46 -0700 (PDT)
In-Reply-To: <7vbpk2sg6m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130793>

Heya,

On Tue, Oct 20, 2009 at 02:00, Junio C Hamano <gitster@pobox.com> wrote=
:
> =A0(2) Do the right thing, by coming up with a notation to show that =
the
> =A0 =A0 final line is incomplete, perhaps similar to "\No newline ...=
"
> =A0 =A0 notation used by "diff".

What about 'git blame -p', can we just go about changing the format lik=
e that?

=46or purpose of the discussion below let's assume we squash in the fol=
lowing:

-- <8 --

diff --git a/builtin-blame.c b/builtin-blame.c
index dd16b22..cf492a0 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1606,7 +1606,7 @@ static void emit_porcelain(struct scoreboard
*sb, struct blame_entry *ent)
 	}

 	if (sb->final_buf_size && cp[-1] !=3D '\n')
-		putchar('\n');
+		printf("\n\\ No newline at end of file\n");
 }

 static void emit_other(struct scoreboard *sb, struct blame_entry *ent,=
 int opt)
@@ -1672,7 +1672,7 @@ static void emit_other(struct scoreboard *sb,
struct blame_entry *ent, int opt)
 	}

 	if (sb->final_buf_size && cp[-1] !=3D '\n')
-		putchar('\n');
+		printf("\n\\ No newline at end of file\n");
 }

 static void output(struct scoreboard *sb, int option)
--=20

-- <8 --

> Does the code assign blame
> correctly around the last line of the original blob?

Yes, it does, when there is no trailing newline an extra "\ No newline
at end of file" is printed, but the last line is still attributed
correctly.

> What if an older
> version ended with an incomplete line and a later version changed the=
 line
> (without adding the terminating LF)?

Nothing changes, the blame on that last line is attributed correctly
and the "\ No newline at end of file" is printed.

> What if a later version changed the
> line and added the terminating LF?

The trailing "\ No newline at end of file" is no longer printed and
the last line is correctly attributed to the commit that added the
trailing LF.

> What if a later version only added the
> terminating LF and did nothing else? =A0Are these three cases handled
> correctly?

Same as above.

> After thinking issues like the above, I read the patch and I see it d=
oes
> not take neither approach.  That makes me feel nervous.

Reading your reply I see that if you care about the presence (or
absence) of a trailing newline the current patch would be problematic,
as it makes it impossible to see in the blame output whether there was
a trailing newline or not.

> By tweaking only the output routine you _might_ be getting correct ou=
tput,
> but even then it looks to me like the end result is working correctly=
 not
> by design but by accident.  IOW, the patch may be better than nothing=
, but
> somehow it just feels like it is papering over the real issue than be=
ing a
> proper fix.
>
> Or am I worrying too much?

No, I think your concerns are valid, we should go with (2) and DTRT.
Does the updated patch address your concerns? If so I can send a new
version.

--=20
Cheers,

Sverre Rabbelier
