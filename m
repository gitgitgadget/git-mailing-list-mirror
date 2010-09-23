From: Pat Notz <patnotz@gmail.com>
Subject: Re: [PATCHv4 1/4] commit: --fixup option for use with rebase --autosquash
Date: Thu, 23 Sep 2010 12:27:46 -0600
Message-ID: <AANLkTikUonhDU-_mq+ON2nRvHEnJszR5jW7siyeXDFLn@mail.gmail.com>
References: <1285262076-20134-1-git-send-email-patnotz@gmail.com>
 <1285262076-20134-2-git-send-email-patnotz@gmail.com> <7vsk10qr7p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 20:28:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyqWq-0005R5-7L
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 20:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756046Ab0IWS2J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 14:28:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65128 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab0IWS2I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 14:28:08 -0400
Received: by fxm3 with SMTP id 3so267178fxm.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 11:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=omuDuQGaRzs6O7yadUWsvMRgkVLnWPtJkDR74fDArkE=;
        b=KJQfACB3El6m4kLymlP2t4JSKYsQBTjtEag0J+U6DFXw7SdTATjLwlCgSGn8YKyTuO
         66T63X6Q2xkDe/4GJ13VUk4XnZXWQRLjrv0dmcReS7spuCFEERIMeT5cYb84gLpiKI45
         93iy4D8ngPnMj1MPG4/MuzW1K1XHQP+yNPNCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=G2wDkzzcNerIMMWcfZk1kL8gpokGl2IYI2t4l7SmY6UMtqiQuzyxQ72iMdO0fzzdmt
         SXjM6yb8EffwrWszV49TISW/SpoS5wfBQraZsOoHGyLJPvRo+DpKQaVR/B4QXsIquMKM
         olKl9Agq+7Kxf4sDfGdOjUoJVgThgWp4wBwqM=
Received: by 10.239.155.70 with SMTP id h6mr125552hbc.94.1285266486745; Thu,
 23 Sep 2010 11:28:06 -0700 (PDT)
Received: by 10.239.185.65 with HTTP; Thu, 23 Sep 2010 11:27:46 -0700 (PDT)
In-Reply-To: <7vsk10qr7p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156894>

On Thu, Sep 23, 2010 at 11:56 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> "Pat Notz" <patnotz@gmail.com> writes:
>
>> + =A0 =A0 } else if (fixup_message) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned char sha1[20];
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct commit *commit;
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct pretty_print_context ctx =3D {0};
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (get_sha1(fixup_message, sha1))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("could not lookup comm=
it %s", fixup_message);
>> + =A0 =A0 =A0 =A0 =A0 =A0 commit =3D lookup_commit_reference(sha1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!commit || parse_commit(commit))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("could not parse commi=
t %s", fixup_message);
>> + =A0 =A0 =A0 =A0 =A0 =A0 format_commit_message(commit, "fixup! %s\n=
\n", &sb, &ctx);
>> + =A0 =A0 =A0 =A0 =A0 =A0 hook_arg1 =3D "message";
>
>
> I notice that the above is a half-copy-and-paste from "if (use_messag=
e)"
> codepath that handles -c/-C. =A0A few issues to think about (i.e. not
> complaints; I haven't thought about them myself):
>
> =A0(1) Is it worth refactoring the original instead of copying;
>
> =A0(2) What happens/should happen when the original commit is encoded
> =A0 =A0 differently from the current commit encoding? =A0-c/-C codepa=
th takes
> =A0 =A0 pains to re-encode. =A0Should we do so somewhere in this code=
path, too?
>

Yes, this was the concern I expressed in the v1 series patch.  I'm
getting more comfortable with the code so I'll look into re-encoding
appropriately.

> =A0(3) If the answer to (2) is "Yes", notice that format_commit_messa=
ge()
> =A0 =A0 does not re-encode the commit log message ("log" output codep=
ath uses
> =A0 =A0 pretty.c::pretty_print_commit(), which reencodes for log outp=
ut
> =A0 =A0 encoding). =A0Maybe we need an option to tell format_commit_m=
essage()
> =A0 =A0 to do so?
>
> The last is not exactly an issue this patch alone should address, but=
 I
> thought I'd better mention it anyway.
>
> My knee-jerk answers to the above are:
>
> =A0(1) The first handful of lines in this new "if (fixup_message)" co=
deblock
> =A0 =A0 up to "die" might want to use a helper function shared with t=
he
> =A0 =A0 existing "if (use_message)" codepath;

Agreed.  I'll factor out the duplication.

>
> =A0(2) We probably want to re-encode to the log output encoding the s=
tring
> =A0 =A0 we receive from format_commit_message() in this codepath.

Will do.

>
> =A0(3) No need yet.
>
