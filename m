From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH 12/12] Add git-check-ignore sub-command
Date: Tue, 16 Oct 2012 07:13:46 -0700
Message-ID: <CAOkDyE9g6rNiv7nnTu2i34dbn_z7r5SmhDuxief7iEQLVxtO5g@mail.gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
	<1350282486-4646-1-git-send-email-pclouds@gmail.com>
	<1350282486-4646-12-git-send-email-pclouds@gmail.com>
	<7vlif7v03r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 16:14:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO7uB-00053u-KV
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 16:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285Ab2JPONs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2012 10:13:48 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45088 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775Ab2JPONr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2012 10:13:47 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so3030646bkc.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 07:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/lF++HMntv1ej8IYAANxl88omyDRZXJOKAyaF1eFB2o=;
        b=EdpVr7PIcPaOeVoUwqbEB4Oe2GF7pVRhDfhubQox4O8aRYdO6fE9tKBYQV/QSLVDgW
         Nvl/X8dHL1Pv+v032xsCgGyvdAR0z1pO0cqsvDq7jviRAKq4Wp8e44x9NG3yFzGQLIYU
         p8tg3zHDMFRh4Ru4WxOfO8fY3Ok9NGlKaDRZ8X4hNedwQJG6wgnbvxxHY60PVHJZYxFl
         YQ0mP1mpM25xt7g2FL6zFpuxJ89CrI7Uvm6GKBe3PeKCKZGijh8hVAKpZHI1MiohNzl2
         fgQTZ3lzUMTLc3/TqFTOTrbLCpyGoAhODcYEB2YvRclhTGzNouCU5wBvUHHoz+bd65Nz
         1IoQ==
Received: by 10.204.4.129 with SMTP id 1mr4276223bkr.58.1350396826679; Tue, 16
 Oct 2012 07:13:46 -0700 (PDT)
Received: by 10.204.15.133 with HTTP; Tue, 16 Oct 2012 07:13:46 -0700 (PDT)
In-Reply-To: <7vlif7v03r.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: SiUtsxihh8OdTakaWuHFTHxfg9E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207831>

On Mon, Oct 15, 2012 at 3:31 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> +For each pathname given via the command-line or from a file via
>> +`--stdin`, this command will list the first exclude pattern found (=
if
>> +any) which explicitly excludes or includes that pathname.  Note tha=
t
>> +within any given exclude file, later patterns take precedence over
>> +earlier ones, so any matching pattern which this command outputs ma=
y
>> +not be the one you would immediately expect.
>
> "The first exclude pattern" is very misleading, isn't it?

I don't think so, because of the second sentence.

> For example, with these in $GIT_DIR/info/exclude, I would get:
>
>         $ cat -n .git/info/exclude
>           1 *~
>           2 Makefile~
>         $ git check-ignore -v Makefile~
>         .git/info/exclude:2:Makefile~   Makefile~
>
> which is the correct result (the last one in a single source decides
> the fate of the path), but it hardly is "first one found" and the
> matching pattern in the output would not be something unexpected for
> the users, either.
>
> The reason it is "the first one found" is because the implementation
> arranges the loop in such a way that it can stop early when it finds
> a match---it simply checks matches from the end of the source.
>
> But that is not visible to end-users,

Correct; that's precisely why I wrote the second sentence which
explicitly explains this.

> and they will find the above description just wrong, no?

It's not wrong AFAICS, but suggestions for rewording this more clearly
are of course welcome.  Maybe s/immediately/intuitively/ ?

>> +OUTPUT
>> +------
>> +
>> +By default, any of the given pathnames which match an ignore patter=
n
>> +will be output, one per line.  If no pattern matches a given path,
>> +nothing will be output for that path; this means that path will not=
 be
>> +ignored.
>> +
>> +If `--verbose` is specified, the output is a series of lines of the=
 form:
>> +
>> +<source> <COLON> <linenum> <COLON> <pattern> <HT> <pathname>
>> +
>> +<pathname> is the path of a file being queried, <pattern> is the
>> +matching pattern, <source> is the pattern's source file, and <linen=
um>
>> +is the line number of the pattern within that source.  If the patte=
rn
>> +contained a `!` prefix or `/` suffix, it will be preserved in the
>> +output.  <source> will be an absolute path when referring to the fi=
le
>> +configured by `core.excludesfile`, or relative to the repository ro=
ot
>> +when referring to `.git/info/exclude` or a per-directory exclude fi=
le.
>> +
>> +If `-z` is specified, the output is a series of lines of the form:
>> +
>
> Hmph... the remainder of the paragraph seems to have been chopped off=
=2E

Yes, an earlier review also caught this but I have not had time to fix
it yet, sorry :-/
